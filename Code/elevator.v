module elevator(input wire [4:0] buttons , reg clk);

    reg [2:0] dst, current_floor = 3'b000;
    reg [2:0] pending1 , pending2, pending3;
    reg [2:0] i = 0;
    reg direction; //up = 1, down = 0
    reg movement; //move = 1 , stop = 0
    reg [4:0] in_sensor = 5'b00000;
    reg [4:0] out_sensor = 5'b00000;

    always @(posedge clk) begin
        if(dst === 3'bxxx)
            movement = 0;
        
        if(direction == 1 && movement == 1)begin
            in_sensor[current_floor] = 0;
            out_sensor[current_floor] = 1;
            out_sensor[current_floor - 1] = 0;
            current_floor = current_floor + 1;
            in_sensor[current_floor] = 1;
            out_sensor[current_floor] = 0;
        end
        else if(direction == 0 && movement == 1) begin
            in_sensor[current_floor] = 0;
            out_sensor[current_floor] = 1;
            out_sensor[current_floor + 1] = 0;
            current_floor = current_floor - 1;
            in_sensor[current_floor] = 1;
            out_sensor[current_floor] = 0;
        end

        if(buttons[current_floor] == 1 && movement == 1)begin
            movement = 0;
            out_sensor[current_floor] = 1;
            in_sensor[current_floor] = 1;
            #100;
            if(current_floor == dst)begin
                dst = pending1;
                pending1 = pending2;
                pending2 = pending3; 
                pending3 = 3'bx;    //set new destination and change the waiting list
                if(current_floor < dst)
                    direction = 1;
                else
                    direction = 0;  //set new direction base on new dest
            end
            else if(current_floor == pending1)begin //delete pending1
                pending1 = pending2;
                pending2 = pending3; 
                pending3 = 3'bx;
            end
            else if(current_floor == pending2) begin //delete pending2
                pending2 = pending3; 
                pending3 = 3'bx;
            end
        end
        else if(dst !==  3'bxxx) begin
            movement = 1;
        end
        $monitor($time , " current floor is: %d"  , current_floor);
    end

    always @(buttons)begin
        for(i = 0;i < 5; i = i +1)begin
            if(buttons[i] == 1 && (dst !== i) && (current_floor != i)
                && (pending1 !== i) && (pending2 !== i))begin
                if(dst === 3'bx) begin
                    dst = i;
                    if(current_floor < dst)
                        direction = 1;
                    else
                        direction = 0;
                end
                else begin
                    if(direction == 1 && ((current_floor > i ) || (i > dst)))begin
                        if(pending1 === 3'bx) begin
                            pending1 = i;
                        end
                        else begin
                            if(pending2 === 3'bx)
                                pending2 = i;
                            else 
                                pending3 = i;
                        end
                    end
                    else if(direction == 0 && ((dst > i ) || (i > current_floor)))begin
                        if(pending1 === 3'bx)
                            pending1 = i;
                        else begin
                            if(pending2 === 3'bx)
                                pending2 = i;
                            else 
                                pending3 = i;
                        end
                    end
                end
            end
        end
    end

endmodule

