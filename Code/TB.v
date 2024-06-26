module Tb();

reg [4:0] buttons;
reg clk;
elevator e (buttons , clk);

initial clk = 0;
always #25 clk = ~clk;

initial begin
    //****test1****
    // buttons[0] = 0;
    // buttons[1] = 0;
    // buttons[2] = 0;
    // buttons[3] = 0;
    // buttons[4] = 1;
    // #20
    // buttons[0] = 0;
    // buttons[1] = 0;
    // buttons[2] = 0;
    // buttons[3] = 1;
    // buttons[4] = 1;
    // #20
    // buttons[0] = 0;
    // buttons[1] = 0;
    // buttons[2] = 1;
    // buttons[3] = 1;
    // buttons[4] = 1;
    // #200
    // buttons[1] = 1;
    // #50
    // buttons[0] = 1;
    // #1200
    // $stop;


    //****test2****
    buttons[0] = 0;
    buttons[1] = 1;
    buttons[2] = 0;
    buttons[3] = 0;
    buttons[4] = 0;
    #50
    buttons[4] = 1;
    #50
    buttons[0] = 1;
    #20
    buttons[1] = 0;
    buttons[2] = 1;
    #830
    buttons[1] = 1;
    buttons[2] = 0;
    buttons[4] = 0;
    #200
    $stop;

end

endmodule

