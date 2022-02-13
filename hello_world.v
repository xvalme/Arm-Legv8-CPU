//This is a comment

module hello_world();

wire [2:0] a;
reg potato;

initial begin

    $display ("B");
    $display("A");
    #100 $display ("B");
    #10 $finish;

end 

endmodule