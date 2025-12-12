const std = @import("std");
const Manifest = @import("manifest.zig");
//const Printer = @import("printer.zig");
//const Input = @import("input/input.zig");
const Settings = @import("settings.zig");
const Log = @import("log.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var settings: Settings = .init(gpa.allocator());
    defer settings.deinit();
    try settings.parseSettings();

    std.log.debug("{s}\n", .{settings.values.manifestPath});

    var log: Log = .init();
    defer log.deinit();
    //log.write("test");

    var manifest: Manifest = .init(.{
        .allocator = gpa.allocator(),
    });
    defer manifest.deinit();

    try manifest.parseManifest(settings.values.manifestPath);

    //var printer: Printer = .init();
    //defer printer.deinit();

    //var input: Input = .init();
    //defer input.deinit();

    //printer.PrintOut("./", .pdf);
}
