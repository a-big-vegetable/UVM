`ifndef MY_DRIVER_SV
`define MY_DRIVER_SV

class my_driver extends uvm_driver#(my_transaction);
    `uvm_component_utils(my_driver)//宏展开后会强行插入type_id即他的create(),get_type()
    function new(string name = "my_driver",uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual my_if vif;
    virtual function void build_phase(uvm_phase phase);//同一个阶段实例化一个phase,方便计数，当然计数的用的不是bulid_phase
        super.build_phase(phase);
        if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))//第一个参数+第二个参数就是完整的路径
            `uvm_fatal("my_driver","virtual interface must be set for vif")//触发时会直接调用$finish
    endfunction

    extern virtual task main_phase(uvm_phase phase);
    extern task one_pkt(my_transaction tr);

endclass

task my_driver::main_phase(uvm_phase phase);//传入参数phase,为了能调用raise_objection
    my_transaction tr;
    phase.raise_objection(this);
    vif.valid <= 0;//这里不用像v一样要在always里赋值，仿真不需要这样，像C一样执行到这里就会操作它
    vif.data <= 8'b0;//但还是用<=,这样保证了在时钟跳变的边界上遵循那个队列原则，塞入末端，不会和DUT产生读写竞争
    while(!vif.rst_n) begin
        @(posedge vif.clk);
    end
        for(int i = 0 ;i < 2; i++) begin
            tr = new("tr");
            assert(tr.randomize() with {pload.size() == 200;});
            one_pkt(tr);
        end
        repeat(5)@(posedge vif.clk);
        phase.drop_objection(this);
endtask

task my_driver::one_pkt(my_transaction tr);
    // 使用临时变量来保护 tr 不被破坏，非常重要！！！，不然monitor还怎么抓取数据呢
//    bit [47:0] tmp_data;
//    tmp_data = tr.dmac;
//    for(int i = 0; i < 6; i++) begin
//       data_q.push_back(tmp_data[7:0]);
//       tmp_data = (tmp_data >> 8);
//    end
//    //push smac to data_q
//    tmp_data = tr.smac;
//    for(int i = 0; i < 6; i++) begin
//       data_q.push_back(tmp_data[7:0]);
//       tmp_data = (tmp_data >> 8);
//    end
//    //push ether_type to data_q
//    tmp_data = tr.ether_type;
//    for(int i = 0; i < 2; i++) begin
//       data_q.push_back(tmp_data[7:0]);
//       tmp_data = (tmp_data >> 8);
//    end
//    //push payload to data_q
//    for(int i = 0; i < tr.pload.size(); i++) begin
//       data_q.push_back(tr.pload[i]);
//    end
//    //push crc to data_q
//    tmp_data = tr.crc;
//    for(int i = 0; i < 4; i++) begin
//       data_q.push_back(tmp_data[7:0]);
//       tmp_data = (tmp_data >> 8);
//    end
    bit [7:0]  data_q[$];
    int data_size;

    data_size = tr.pack_bytes(data_q)//默认高位字节在前，低位字节在后
    `uvm_info("my_driver", "begin to driver one pkt", UVM_LOW);

    repeat(3) @(posedge vif.clk);

    for( int i = 0 ; i < data_size ; i++) begin
        @(posedge vif.clk);
        vif.valid <= 1'b1;
        vif.data  <= data_q[i];
    end

    @(posedge vif.clk);
    vif.valid <= 1'b0;
    `uvm_info("my_driver", "end driver one pkt", UVM_LOW);
endtask
`endif