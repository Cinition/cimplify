const Input = @This();

pub fn init() Input {
    return .{};
}

pub fn deinit(self: *Input) void {
    _ = self;
}
