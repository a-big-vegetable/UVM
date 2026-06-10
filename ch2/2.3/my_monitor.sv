`ifndef MY_MONITOR_SV
`define MY_MONITOR_SV

class my_monitor extends uvm_monitor;
    virtual my_if vif;//这个virtual是用来和top_tb实例化的接口连接上的
    `uvm_component_utils(my_monitor)
    function new(string name = "my_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
            `uvm_fatal("my_monitor","virtual interface must be set for vif!!!")
    endfunction

    extern virtual task main_phase(uvm_phase phase);
    extern task collect_one_pkt(my_transaction tr);
endclass

task my_monitor::main_phase(uvm_phase phase);
    my_transaction tr;
    while (1) begin
        tr = new("tr");
        collect_one_pkt(tr);
    end
endtask

task my_monitor::collect_one_pkt(my_transaction tr);
    bit [7:0] data_q[$];//队列，完美结合了动态数组和链表的优点
    int psize;
    while(1) begin
        @(posedge vif.clk);
        if(vif.valid) break;
    end

    `uvm_info("my_monitor","begin to collect one pkt",UVM_LOW);
    while(vif.valid) begin
        data_q.push_back(vif.data);
        @(posedge vif.clk);//这个@(posedge clk)要写在后面，只要遇到@阻塞，就算刚刚发生了时钟跳变，也要严肃等待下一个时钟跳变，这么写是为了能记录第一个数据
    end
    //pop dmac
    for(int i = 0; i < 6 ; i++) begin
        tr.dmac = {tr.dmac[39:0],data_q.pop_front()};
    end

    for(int j = 0 ; j < 6 ; j++) begin
        tr.smac = {tr.smac[39:0],data_q.pop_front()};
    end

    for(int i = 0 ; i < 2 ; i++) begin
        tr.ether_type = {tr.ether_type[7:0],data_q.pop_front()};
    end

    psize = data_q.size() - 4;
    tr.pload = new[psize];//这里刚才有语法错误
    for(int i= 0 ; i < psize ; i++)begin
        tr.pload[i] = data_q.pop_front();
    end

    for(int i = 0 ; i < 4 ; i++) begin
        tr.crc={tr.crc[23:0],data_q.pop_front()};
    end
    `uvm_info("my_monitor","end collect one pkt,printf it:",UVM_LOW); 
    tr.my_print();
endtask
`endif



