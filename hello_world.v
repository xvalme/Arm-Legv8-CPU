//This is a comment

module hello_world;

initial begin
    $display ("A");

    wire [1:0] //2 bit wire
    #100 $display ("B");
    #10 $finish;
end 

endmodule