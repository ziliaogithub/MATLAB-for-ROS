%% ������
clear, close all ; clc;

%% ros�l�b�g���[�N�ւ̐ڑ�
rosinit('192.168.1.183')

%% Node�̍쐬
node1 = robotics.ros.Node('calcu');

%% subscriber�̒�`
sub1 =robotics.ros.Subscriber(node1,'/int_a','std_msgs/Int16',@pub_a_Callback1);
sub2 =robotics.ros.Subscriber(node1,'/int_ab','matlab_test/adder',@pub_a_Callback2);
global sum
global diff

%% publisher�̒�`
pub1 = robotics.ros.Publisher(node1, '/add', 'std_msgs/Int16');
msg1 = rosmessage(pub1);
pub2 = robotics.ros.Publisher(node1, '/diff','std_msgs/Int16');
msg2 = rosmessage(pub2);

%% rate�̒�`
r = robotics.Rate(1);

%% publish
for i=1:100;
    msg1.Data = sum;
    msg2.Data = diff;
    send(pub1,msg1);
    send(pub2,msg2)
    waitfor(r);
end

%% ROS�l�b�g���[�N�ւ̐ڑ�������
rosshutdown;

%% callback�֐���`
function pub_a_Callback1(~,msg)
    global sub_a
    sub_a = msg.Data;
end
function pub_a_Callback2(~,msg)
    global sub_a
    global sub_b
    global sub_c
    global sum
    global diff
    sub_b = msg.A;
    sub_c = msg.B;
    sum =sub_a+sub_b+sub_c;
    diff=sub_b+sub_c-sub_a;
    
end
