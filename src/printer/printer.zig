const Printer = @This();

pub fn init() Printer {
    return .{};
}

pub fn deinit(self: *Printer) void {
    _ = self;
}
