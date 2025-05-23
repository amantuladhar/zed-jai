#import "Basic"()(MEMORY_DEBUGGER=true);
#import "String";
POSIX :: #import "POSIX";
System :: #import "System";

Event :: struct {}
Value :: struct {
    id: s32;
    name: string;
}

Process_Type :: enum {
    PARENT;
    CHILD;
};

Process_Type_Specified :: enum #specified {
    PARENT :: 1;
    CHILD :: 2;
}

Process_Flag :: enum_flags {
    PARENT;
    CHILD;
};

Custom_Logger_Data :: struct {
    process_type: Process_Type;
    pid: s32;
};

BUF_CONSTANT :: 1024;
BUF_C2 : s32 : 1024;
BAD_VAR :: 100;
BAD_VAR_2 : s32 = 100;

proc_ret :: (n: s32, k: *void, l: *Value, m: Value, o: Process_Flag, x: .. Any) -> s32 {
    return 10 + n;
}

custom_logger :: (message: string, data: *void, info: Log_Info) {
    mark := get_temporary_storage_mark();
    defer   set_temporary_storage_mark(mark);
    using logger_data := cast(*Custom_Logger_Data, data);
    msg := tprint("[%:%] %\n", process_type, pid, message);
    write_string(msg);
}
main :: () {
    defer { report_memory_leaks(); }
    foo := 100;
    bar :: 100;
    baz := foo + bar / 100;
    print("---  %", BUF_C2 + BUF_CONSTANT);

    ev := Event.{};
    ev1 : Event = .{};
    str1 := "Hello, world!";
    v2 := Value.{ id = 1, name = "one"};
    v1 := Value.{1, "one"};

    proc_ret(1, null, null, v1, .PARENT);
    proc_ret(1, null, null, v1, Process_Flag.PARENT);

    logger_data := Custom_Logger_Data.{ .PARENT, POSIX.getpid() };
    context.logger_data = *logger_data;
    context.logger = custom_logger;

    if foo > 100 print("foo > 100\n");
    if foo < 100 { print("foo < 100\n"); }
    else print("foo < 100 else");
    if foo < 100 { print("foo < 100\n"); }
    else if foo < 98 print("foo < 100 else");
    if (bar > 100) print("asdf");
    else print("bar asdf 100");
    if bar < 100 then print("if then");
    else print("else then");

    for 0..10  print("for loop");
    for 0..10  {print("for loop");}
    for i: 0..10 print("%\n", i);

    arr: [10]s32;
    for arr print("%=%\n", it_index, it);
    for x: arr print("%=%\n", it_index, x);

    arr2: [..]s32;
    array_add(*arr2, 42);
    for arr2 print("arr2 %=%\n", it_index, it);

    while foo < 100 {
        print("while loop");
        foo += 1;
        if foo > 100 {
            break;
        }
        if foo <  100 continue;
    }

    x12 : Process_Type = Process_Type.PARENT;

    if x12 == {
        case .PARENT;
        case .CHILD;
    }
    x13 := 100;
    if x13 == {
        case 1; #through;
        case 2;
        case;
    }
 }
