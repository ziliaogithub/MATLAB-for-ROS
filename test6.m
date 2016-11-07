%% ������
clear, close all ; clc;

%% ros�l�b�g���[�N�ւ̐ڑ�
%ros master���N�����Ă���IP�A�h���X
rosinit('192.168.10.16');

%% Node�̍쐬
node1 = robotics.ros.Node('pub1');
node2 = robotics.ros.Node('sub1');
node3 = robotics.ros.Node('pub2');

%% publisher�̒�`
pub = robotics.ros.Publisher(node1, '/int_a', 'std_msgs/Int16');
msg_a = rosmessage(pub);

%% rate�̐ݒ�
r = robotics.Rate(1);

%% publish
msg_a.Data = 5;
send(pub,msg_a);
x=sprintf('pubData = %d',msg_a.Data);

%% subscriber�̒�`
pub =robotics.ros.Subscriber(node2,'/int_a');
global sub_a
pub.NewMessageFcn = @pub_a_Callback;

%% �擾�f�[�^�̓��o��
sub_a = sub_a + 1;

%% ros�l�b�g���[�N�ւ̐ڑ�������
rosshutdown;

%% callback�֐����`
function pub_a_Callback(~,msg)
global sub_a
sub_a = rosmessage('std_msgs/Int16');
sub_a = msg.Data;
end
