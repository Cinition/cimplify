const std = @import("std");

const Settings = @This();

values: JsonValues,
allocator: std.mem.Allocator = undefined,

pub const JsonValues = struct {
    manifestPath: []const u8,
};

pub fn init(allocator: std.mem.Allocator) Settings {
    return .{ .values = .{ .manifestPath = "" }, .allocator = allocator };
}

pub fn deinit(self: *Settings) void {
    self.allocator.free(self.values.manifestPath);
}

pub fn parseSettings(self: *Settings) !void {
    const inputDir = try std.fs.cwd().openDir("config", .{});
    const data = try inputDir.readFileAlloc(self.allocator, "settings.json", 15360);
    defer self.allocator.free(data);

    const json = try std.json.parseFromSlice(JsonValues, self.allocator, data, .{ .allocate = .alloc_always });
    defer json.deinit();

    self.values.manifestPath = try self.allocator.dupe(u8, json.value.manifestPath);
}
