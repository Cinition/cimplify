const Manifest = @This();

const std = @import("std");
const xlsxio = @import("xlsxio");

allocator: std.mem.Allocator = undefined,

pub const ManifestInit = struct {
    allocator: std.mem.Allocator,
};

pub fn init(settings: ManifestInit) Manifest {
    return .{
        .allocator = settings.allocator,
    };
}

pub fn parseManifest(self: *Manifest, manifestFile: []const u8) !void {
    var reader = try xlsxio.Reader.open(self.allocator, manifestFile);
    defer reader.close();

    var sheet = try reader.openSheet(null, .{});
    defer sheet.close();

    while (sheet.nextRow()) {
        while (sheet.nextCell()) |cell| {
            std.debug.print("{s}\t", .{cell});
            xlsxio.free(cell);
        }
        std.debug.print("\n", .{});
    }
}

pub fn deinit(self: *Manifest) void {
    _ = self;
}
