��" >� :G!���	D ��   >26Ú">���:6� ̎�G͊" 
DIRECT PROGRAMMER INTERFACE MENU  (<...> INDICATES OPTIONAL PARAMETER)

 P<address>...PROGRAM PROM WITH VERIFY
 W<address>...PROGRAM PROM IN 16 BYTE BLOCKS
 R<address>...READ PROM, DISPLAYS HEX
 S<address>...SEE ASCII, DISPLAYS ASCII
 T<address>...TEST PROM, CHECKS FOR ALL "FF"
 Q............QUERY PROGRAMMER, DISPLAYS TYPE
 H............HELP (REPRINT THIS MENU)
 X............RETURN TO MAIN MENU
 ^C...........EXIT TO CP/M

END COMMANDS WITH CR, TYPE SPACE TO ABORT COMMAND
TYPE CR TO CONTINUE READ OR SEE COMMANDS
 
PROM PROGRAMMER UTILITY V1.5  (<...> INDICATES OPTIONAL PARAMETER)

 Q......................QUERY   PROM TYPE
 R......................READ    PROM (BUFFER <- PROM)
 P......................PROGRAM PROM (BUFFER -> PROM)
 T......................TEST    PROM FOR (FF)
 L <D:>FILENAME<.HEX>...LOAD    BUFFER FROM DISK FILE
 S <D:>FILENAME<.HEX>...SAVE    BUFFER TO   DISK FILE
 F......................FILL    BUFFER WITH FF
 D <OFFSET>.............DISPLAY BUFFER IN HEX & ASCII
 H......................HELP (REDISPLAY THIS MENU)
 X......................GO TO DIRECT INTERFACE MENU
 ^C.....................RETURN TO CP/M
 END COMMANDS WITH CR, TYPE SPACE TO ABORT
 TYPE CR TO CONTINUE AN AUTO STOP COMMAND
 1!  " :@2"͉æ!A���>�@�2�N�E>Á��S�)�Hʐ�Xʖ��  �ʜ� ʡ�@�2��S�@�2�S�Ä��7�æ> Á>Á!U���>�@�2ʽô>�@�2�����>:�����ʽ� ʽ��  �)��T�D�R��P��	�L���S�!�F�T�Dʚ�Q���Hʦ�X�7�!,��ïCommand not implemented ͥ��!x���Y��ï!�>T�@�2> �@�2��?�i!��i
Testing PROM
 PROM not erased PROM erased �ʥ���!����ïCommand aborted ͥ��ï�!(��>Q�@�2> �@�2�$�0��1��2��3���!?�!D�!I�!N�02"�����Programmer set up for  2716 2732 2764 27128 ͥ�͉!f��ïLocal buffer filled with 0FFH data � @! s#x���l	|�?W}��_>2k	!	��z�w{�w> �! �> �~#�w���> ���~#�	����z��¯:k	=2k	°�� 	� ʯ�ʥ� 	� �	��>.�
       0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F   0123456789ABCDEF
  ��l	!   À	��z	��� ��	��)�Rڞ	))))�o�z	!�	���ï
 Enter hex values only ��z	ͥ���> 22!�
��ͥ�!�
��>W�@�2> �@�2�
�?ʅ
��	!� :"��
)=�
DM:W:_�� ʀ
>�z�w{�w> �! �~#͛�2�2> �@�2�^
�?ʚ
�P
�?
�x��
z2{2�!�
�����	>�@�2ʎ
Å
�!�
��ï�Å
Programming PROM
 Programming aborted Programming completed Insert PROM in socket & type CR to start (SPACE to abort)   ͥ���> 22!�
��ͥ�!���>R�@�2> �@�2!� :"��Y)=�PDM:W:_>�z�w{�w! ��� ���2> �@�2�w�>��� �w�2�RO�2�R�w#�w��2x��cz2{2�!���2����(����>�@�2���!��ïReading PROM
 Read aborted Read completed �v�7�q$!L�f�.!Q��͋$ͮ�!_��ïSaving File
 Save Complete Command not yet implemented
 �;��!  @>:�� y��|��}�����~��#°��͉>��>
��z�>:���͉͉͉͉͉���G�͉�!  @~��#z�����v�7�q$!L�?�.!\��͍$ͼ�!k��ï!C��ï�!y��ïError opening HEX file
 Loading file
 Load complete Must give file name �;�%����:�2�L2���L22u�L22t�L2������:���2�L2���L2�L2�L2!~��5�L*�W#"���h!���!���Checksum Error
 !  > 2u2t����W#�0!-~�H�#~�E�#~�X��h�!�w�����G�! �!t^#V�}�o|�gp����  >ͥ��!L$�̓:-� �!�- ~#�HEX22!L"�ʱ� �9���!ڱ�ұ������������!������)*w#"�!5��>*w:!��:!���*+6 "!4>�> �>����ñ��ů2D20"H�� � �� ������O�=���ů2D202J"H�� � ��� ���ª�� ���ʨ�� ���ʨ�ê�=�����>��:J��:��� � �� �����ɯ=����O*H:J_<2J q����$�:����������>�2#:#=�62#:J���**H_ ~2K�{2J��6$�O��>���������d�q�� ����������d�q�� ����ɯ2J*H�� :$=���}: _� ��G#~+�:~##�)�@�ڜx> ¢��	~�.�������!���)#­�����	 �	�#í��!��#�������<>.,:=;*?[]/~#�������>�>
�>�����������_� �����a��{��_����� ���������_� ��������0��:�e���A��G?�����O������OG���̀��ͭ����͒��ͭ�����ͤ��ͭ�@����0�:���                                                                         