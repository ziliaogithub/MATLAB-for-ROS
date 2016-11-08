%% 初期化
clear, close all ; clc;

%% rosネットワークへの接続
%ros masterが起動しているIPアドレス
rosinit('192.168.10.14');

%% Nodeの作成
node1 = robotics.ros.Node('pub1');
node2 = robotics.ros.Node('subpub1');
node3 = robotics.ros.Node('sub1');

%% publisherの定義
pub1 = robotics.ros.Publisher(node1, '/int_a', 'std_msgs/Int16');
msg_a = rosmessage(pub1);

%% publish1
msg_a.Data = 5;
send(pub1,msg_a);
x=sprintf('pubData = %d',msg_a.Data);

%% subscriberの定義
sub1 =robotics.ros.Subscriber(node2,'/int_a');
global sub_a
sub1.NewMessageFcn = @pub_a_Callback1;

%% 取得データの入出力
msg_b = rosmessage('std_msgs/Int16');
msg_b.Data = sub_a + 1;

%% publish2
pub2 = robotics.ros.Publisher(node2, '/int_b', 'std_msgs/Int16');
send(pub2,msg_b);

%% subscribe
sub2 =robotics.ros.Subscriber(node3,'/int_b');
global sub_b
sub2.NewMessageFcn = @pub_a_Callback2;

%% ROSネットワークへの接続を解除
rosshutdown;

%% callback関数を定義
function pub_a_Callback1(~,msg)
global sub_a
sub_a = rosmessage('std_msgs/Int16');
sub_a = msg.Data;
end
function pub_a_Callback2(~,msg)
global sub_b
sub_b = rosmessage('std_msgs/Int16');
sub_b = msg.Data;
end
