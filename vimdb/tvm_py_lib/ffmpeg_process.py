import random
import sys
import os
from sys import stderr
import traceback


def ffmpeg_file_check():# just exit seems to forceful ,is here another way a?
        if not os.path.isfile( "ffmpeg" ) :
                sys.stderr.write( "please put ffmpeg  to your WORK DIR" )
                exit(-1)

def ts_to_wav( ts_file_name  ,  wav_file_name ):
        ffmpeg_file_check() 
        if not os.path.isfile( ts_file_name ) :
                return 
        cmd = "./ffmpeg -i %s  -loglevel quiet  -ac 1 -ar 8000 -f wav -y %s   > /dev/null 2>&1" % ( ts_file_name ,  wav_file_name )
        os.system( cmd )

def split_ts_into_wav( ts_file_name  , gap , each_length  , duration = -1 ,suffix = "")  :
        ffmpeg_file_check() 
        if not os.path.isfile( ts_file_name ) :
                return []
        if -1 == duration :
                duration = get_file_duration( ts_file_name )
        if -1 == duration :
                return []
        piece_list = []
        random_prefix = random.randint( 0 , 111111 )
        for i in range( int(  round( duration ) ) - each_length + 1  ) :
                new_file_name = "%s_%d_%d.wav" %( suffix ,  random_prefix  ,  i )
                piece_list.append( new_file_name )
                cmd = "./ffmpeg -i %s  -loglevel  quiet -ss %.2d:%.2d:%.2d -t %.2d:%.2d:%.2d -ac 1 -ar 8000 -f wav -y %s   > /dev/null 2>&1" % ( ts_file_name ,  
                                                                                                         i / 3600 ,
                                                                                                         i % 3600 / 60 ,
                                                                                                         i % 60 ,
                                                                                                         each_length / 3600 ,
                                                                                                         each_length % 3600 / 60 ,
                                                                                                         each_length % 60 ,
                                                                                                         new_file_name )
                os.system( cmd )
        return piece_list

def get_file_duration( file_name ):
        try : 
                ffmpeg_file_check()
                time_str = os.popen( "./ffmpeg -i %s 2>&1 | grep Duration  " % file_name ).read().split( " " )[ 3 ].split( "," )[ 0 ]
                hour = int(  time_str.split( ":" )[ 0 ] )
                minute = int(  time_str.split( ":" )[ 1 ] )
                sec =  float(  time_str.split( ":" )[ 2 ] )
                return hour * 3600 + minute * 60 + sec
        except Exception , e :
                print >> stderr , "error-->" ,  e
                traceback.print_stack()
                return  -1

def cut_file( file_name , new_file_name , st ,duration ):
        ffmpeg_file_check() 
        cmd = "./ffmpeg -i %s  -loglevel  quiet -ss %.2d:%.2d:%.2d -t %.2d:%.2d:%.2d -y -acodec copy -vn  %s   > /dev/null 2>&1" % ( file_name ,  
                                                                                                 st / 3600 ,
                                                                                                 st % 3600 / 60 ,
                                                                                                 st % 60 ,
                                                                                                 duration / 3600 ,
                                                                                                 duration % 3600 / 60 ,
                                                                                                 duration % 60 ,
                                                                                                 new_file_name )
        os.system(cmd)
