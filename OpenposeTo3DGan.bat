@echo off
rem --- 
rem ---  OpenPose �� json�f�[�^���� 3D�f�[�^�ɕϊ�
rem ---  https://nico-opendata.jp/ja/casestudy/3dpose_gan/index.html���g�p
rem --- 

rem ---  �J�����g�f�B���N�g�������s��ɕύX
cd /d %~dp0

rem ---  ��͌���JSON�f�B���N�g���p�X
echo Openpose�̉�͌��ʂ�JSON�f�B���N�g���̃t���p�X����͂��ĉ������B
echo ���̐ݒ�͔��p�p�����̂ݐݒ�\�ŁA�K�{���ڂł��B
set OPENPOSE_JSON=
set /P OPENPOSE_JSON=����͌���JSON�f�B���N�g���p�X: 
rem echo OPENPOSE_JSON�F%OPENPOSE_JSON%

IF /I "%OPENPOSE_JSON%" EQU "" (
    ECHO ��͌���JSON�f�B���N�g���p�X���ݒ肳��Ă��Ȃ����߁A�����𒆒f���܂��B
    EXIT /B
)

rem ---  3d-pose-baseline-vmd��͌���JSON�f�B���N�g���p�X
echo 3d-pose-baseline-vmd�̉�͌��ʃf�B���N�g���̐�΃p�X����͂��ĉ������B(3d_{���s����}_idx00)
echo ���̐ݒ�͔��p�p�����̂ݐݒ�\�ŁA�K�{���ڂł��B
set TARGET_DIR=
set /P TARGET_DIR=��3d-pose-baseline-vmd ��͌��ʃf�B���N�g���p�X: 
rem echo TARGET_DIR�F%TARGET_DIR%

IF /I "%TARGET_DIR%" EQU "" (
    ECHO 3D��͌��ʃf�B���N�g���p�X���ݒ肳��Ă��Ȃ����߁A�����𒆒f���܂��B
    EXIT /B
)

rem ---  �f���ɉf���Ă���ő�l��

echo --------------
echo �f���̉�͌��ʂ̂����A���Ԗڂ̐l������͂��邩1�n�܂�œ��͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A1�l�ڂ̉�͂ɂȂ�܂��B
set PERSON_IDX=1
set /P PERSON_IDX="����͑Ώېl��INDEX: "

rem --echo PERSON_IDX: %PERSON_IDX%


rem ---  �ڍ׃��O�L��

echo --------------
echo �ڍׂȃ��O���o�����Ayes �� no ����͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A�ʏ탍�O�ƃ��[�V�����̃A�j���[�V����GIF���o�͂��܂��B
echo �ڍ׃��O�̏ꍇ�A�e�t���[�����Ƃ̃f�o�b�O�摜���ǉ��o�͂���܂��B�i���̕����Ԃ�������܂��j
echo warn �Ǝw�肷��ƁA�A�j���[�V����GIF���o�͂��܂���B�i���̕������ł��j
set VERBOSE=2
set IS_DEBUG=no
set /P IS_DEBUG="���ڍ׃��O[yes/no/warn]: "

IF /I "%IS_DEBUG%" EQU "yes" (
    set VERBOSE=3
)

IF /I "%IS_DEBUG%" EQU "warn" (
    set VERBOSE=1
)

rem ---  python ���s
python bin/3dpose_gan_json.py --lift_model train/gen_epoch_500.npz --model2d openpose/pose_iter_440000.caffemodel --proto2d openpose/openpose_pose_coco.prototxt --input %OPENPOSE_JSON%  --person_idx %PERSON_IDX% --base-target %TARGET_DIR% --verbose %VERBOSE%


