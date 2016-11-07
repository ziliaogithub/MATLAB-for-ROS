%% 初期化
clear, close all ; clc;

%% rosネットワークへの接続
%ros masterが起動しているIPアドレス
rosinit('192.168.10.16');

%% Nodeの作成
node1 = robotics.ros.Node('pub1');
node2 = robotics.ros.Node('sub1');
node3 = robotics.ros.Node('pub2');

%% publisherの定義
pub = robotics.ros.Publisher(node1, '/int_a', 'std_msgs/Int16');
msg_a = rosmessage(pub);

%% rateの設定
r = robotics.Rate(1);

%% publish
msg_a.Data = 5;
send(pub,msg_a);
x=sprintf('pubData = %d',msg_a.Data);

%% subscriberの定義
pub =robotics.ros.Subscriber(node2,'/int_a');
global sub_a
pub.NewMessageFcn = @pub_a_Callback;

%% 取得データの入出力
sub_a = sub_a + 1;

%% rosネットワークへの接続を解除
rosshutdown;

%% callback関数を定義
function pub_a_Callback(~,msg)
global sub_a
sub_a = rosmessage('std_msgs/Int16');
sub_a = msg.Data;
end
