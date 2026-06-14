`ifndef MY_MONITOR_SV
`define MY_MONITOR_SV

class my_monitor extends uvm_monitor;
    virtual my_if vif;//这个virtual是用来和top_tb实例化的接口连接上的
    uvm_analysis_port #(my_transaction) ap;

    `uvm_component_utils(my_monitor)
    function new(string name = "my_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
            `uvm_fatal("my_monitor","virtual interface must be set for vif!!!")
        ap = new("ap", this);
    endfunction

    extern virtual task main_phase(uvm_phase phase);
    extern task collect_one_pkt(my_transaction tr);
endclass

task my_monitor::main_phase(uvm_phase phase);
    my_transaction tr;
    while (1) begin
        tr = new("tr");
        collect_one_pkt(tr);
        ap.write(tr);
    end
endtask

task my_monitor::collect_one_pkt(my_transaction tr);
//    bit [7:0] data_q[$];//队列，完美结合了动态数组和链表的优点
    int data_size;
    byte unsigned data_q[$];//在UVM里最好用这一种软件思维定义的方式，也代表了八位无符号数
    byte unsigned data_array[];
    while(1) begin
        @(posedge vif.clk);
        if(vif.valid) break;
    end

    `uvm_info("my_monitor","begin to collect one pkt",UVM_LOW);
    while(vif.valid) begin
        data_q.push_back(vif.data);
        @(posedge vif.clk);//这个@(posedge clk)要写在后面，只要遇到@阻塞，就算刚刚发生了时钟跳变，也要严肃等待下一个时钟跳变，这么写是为了能记录第一个数据
    end
    
    data_size = data_q[].szie();
    data_array = new(data_szie);//new的时候不带[]
    for(int i = 0 ; i < data_size ; i++)begin
        data_array[i] = data_q[i];
    end
    tr.pload = new(data_q[].szie() - 18);//pload定义好后unpack_bytes到数组的时候才不会乱
    data_size = tr.unpack_bytes(data_array) / 8;//unpack_bytes()里面必须要是动态数组，不能是队列，所以要这么麻烦的转换一下
    `uvm_info("my_monitor","end collect one pkt,printf it:",UVM_LOW); 
    tr.print();
//    //pop dmac (driver sends LSB first, so use {new, old[MAX:8]} to reconstruct correctly)
//    for(int i = 0; i < 6 ; i++) begin
//        tr.dmac = {data_q.pop_front(), tr.dmac[47:8]};
//    end
//
//    for(int j = 0 ; j < 6 ; j++) begin
//        tr.smac = {data_q.pop_front(), tr.smac[47:8]};
//    end
//
//    for(int i = 0 ; i < 2 ; i++) begin
//        tr.ether_type = {data_q.pop_front(), tr.ether_type[15:8]};
//    end
//
//    psize = data_q.size() - 4;
//    tr.pload = new[psize];//这里刚才有语法错误
//    for(int i= 0 ; i < psize ; i++)begin
//        tr.pload[i] = data_q.pop_front();
//    end
//
//    for(int i = 0 ; i < 4 ; i++) begin
//        tr.crc = {data_q.pop_front(), tr.crc[31:8]};
//    end
endtask
`endif



