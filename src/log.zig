const Log = @This();

pub fn init() Log {
    return .{};
}

pub fn deinit(self: *Log) void {
    _ = self;
}
