jrom network import req_once
import socket
import time
import struct 
import extraction
import wave

def convertdata(fp):
        feat=""
        row = struct.pack('I',fp[0])
        feat += row[0]+row[1]+row[2]+row[3]
        feat_total = fp[0]*10
        for i in range(1,feat_total+1):
                row = struct.pack('i',fp[i])
                feat+=row[0]+row[1]+row[2]+row[3]
        return feat

def mk_pkt_header( feat_len  , cmd = "" , ch = "" ):
        crc=0
        seqno=12
        desc = cmd +( 16-len(cmd))*chr(0)
        channel = ch + ( 32-len(ch))*chr(0)
        current_tm=int(time.time())
        return  struct.pack('c3xiii16s32si','M',seqno,feat_len+4,crc,desc,channel,current_tm)

def mk_pkt_ft( wave_data ):
        fp = extraction.gen( wave_data, len( wave_data ))
        if  not fp :
                return "nothing"
        feat = convertdata(fp)
        return feat

def req_data_create( wav_file_name ,  cmd = "" , ch = "") :
        wav_file = wave.open( wav_file_name ) # file get contents here
        wav_data = wav_file.readframes( wav_file.getnframes() )
        wav_file.close() 
        feat = mk_pkt_ft( wav_data )
        return mk_pkt_header( len( feat ),  cmd = cmd , ch = ch  ) + feat

def req_data_create_from_data( wav_data ,  cmd = "" , ch = "") :
        feat = mk_pkt_ft( wav_data )
        return mk_pkt_header( len( feat ),  cmd = cmd , ch = ch  ) + feat

def _wav_file_work( wav_file_name  , host , port , cmd = "" ,ch  = "" ): # this is not an interface
        req_data = req_data_create( wav_file_name , cmd , ch  )
        if "nothing" == req_data :
                return "err" ,  "req_data_create fail " + wav_file_name
        return req_once( req_data , host, port )

def _wav_data_work( wave_data , host , port , cmd = "" ,ch  = "" ): # this is not an interface
        req_data = req_data_create_from_data( wave_data , cmd , ch  )
        if "nothing" == req_data :
                return "err" ,  "req_data_create fail " + wav_file_name
        return req_once( req_data , host, port )

def wav_file_check( wav_file_name  , host , port):
        return _wav_file_work(  wav_file_name  , host , port )

def wav_feat_add( wav_file_name  , host , port , ad_id ):
        return _wav_file_work(  wav_file_name  , host , port,  cmd = "add" ,  ch = ad_id )

def wav_data_check( wave_data  , host , port ):
        return _wav_data_work(  wave_data  , host , port )

def sound_files_check():
        pass
