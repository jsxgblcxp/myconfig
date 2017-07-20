import file_work 
import ffmpeg_process 
import sql_work
import network 
import str_work 

import os 


def test_file_work():
        tmp_file_type = "ppp" 
        tmp_file_name = "1231312312312sdf.%s" % tmp_file_type
        print( "tmp file name is %s \n"  % tmp_file_name )
        os.system(" > %s" % tmp_file_name )
        os.system( "ls -l %s "  % tmp_file_name )
        file_work.rm_if_isfile( tmp_file_name )
        os.system( "ls -l %s "  % tmp_file_name )
        os.system(" > %s" % tmp_file_name )
        os.system( "ls -l %s "  % tmp_file_name )
        file_work.rm_if_is_the_type_of_file( tmp_file_name, tmp_file_type ) 
        os.system( "ls -l %s "  % tmp_file_name )

def test_ffmpeg():
        os.system( "./ffmpeg -i 1.ts" )
        ffmpeg_process.ts_to_wav( "1.ts" , "1.wav" )
        os.system( "./ffmpeg -i 1.wav" )

        print( ffmpeg_process.get_file_duration( "1.ts" ) )


def network_test():
        return 
        print network.url_req( "http://www.baidu.com" ,timeout_sec = 1 , post_str = "" )
        print( "--------------" )
        print network.url_req( "http://www.b1aidu.com" ,timeout_sec = 1 , post_str = "" )
        print( "--------------" )
        print network.get_file_url( "http://wx.live.tvmining.com/approve/live?channel=ZheJiangHD&type=ipsd" )
        print( "--------------" )
        print network.get_file_url( "http://w1x.live.tvmining.com/approve/live?channel=ZheJiangHD&type=ipsd" )
        print( "--------------" )
        tmp_file_name = "tmp.m3u8"
        file_work.rm_if_isfile( tmp_file_name )
        print network.download( "http://wx.live.tvmining.com/approve/live?channel=ZheJiangHD&type=ipsd" , tmp_file_name )
        os.system( "cat %s " % tmp_file_name )
        print( "--------------" )
        print network.download( "http://w1x.live.tvmining.com/approve/live?channel=ZheJiangHD&type=ipsd" , "tmp.m3u8" )
        print( "--------------" )
        print( network.get_vod_addr( "BTV1" , "http://10.0.30.36/ad_task_sys/VasManage/Index/get_vas_config" ) )
        print( "--------------" )
        print( network.get_vod_addr( "BTVXXXX" , "http://10.0.30.36/ad_task_sys/VasManage/Index/get_vas_config" ) )
        print( "--------------" )
        print( network.get_vod_addr( "BTVXXXX" , "http://10.0.30.116/ad_task_sys/VasManage/Index/get_vas_config" ) )
        print( "--------------" )

def sql_test():
        sql_work.run_sql_cmd( "xx" ,  "10.0.30.111" , "root" , "13132" , "xx" , port = 3306 )
        sql_work.run_sql_and_fetch( "xx" ,  "10.0.30.111" , "root" , "13132" , "xx" , port = 3306 )
        #network_test()
def str_test():
        print( str_work.get_time_in_ts_file( "1.ts" ) )
        print( str_work.get_ts_file_ch( "../SiChuanTVHD_512000_20170605_11062664710794_29751520.ts" ) )

#test_file_work()
#test_ffmpeg()
#sql_test()
str_test()
print "over"
