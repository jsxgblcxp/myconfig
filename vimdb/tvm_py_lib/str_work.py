from time import mktime
from time import time
import datetime
import traceback
from datetime import datetime  
from sys import stderr

def get_ts_filename_from_url( url ):
        try :
                res = url.split( "/" )[ -1 ]
        except :
                res = "NONAME00.ts"
        return res

def mk_vod_url( ip , stream_type , channel_name , start_time , end_time ) :
        end_time = max( start_time  + 10 , end_time )
        return "http://" + ip + "/approve/vod?type=" + stream_type + "&channel=" + channel_name + "&starttime="+ str( start_time  )+"&endtime=" + str( end_time ) 

def mk_live_url( ip , stream_type , channel_name ) :
        return "http://" + ip + "/approve/live?type=" + stream_type + "&channel=" + channel_name

def get_time_in_ts_url( ts_file_url ) :
        try :
                ts_file_name = get_ts_filename_from_url( ts_file_url )
                return get_time_in_ts_file( ts_file_name )
        except :
                return  -1

def mktime_from_str( date_str , str_form ):
	d = datetime.strptime( date_str  , str_form )
        return  mktime( d.timetuple() )

def get_time_in_ts_file( ts_file_name ) :
        try :
                file_date = ts_file_name.split( "_" )[ 2 ] + " " + ts_file_name.split( "_" )[ 3 ][ 0: 6 ]
                return  mktime_from_str( file_date ,  '%Y%m%d %H%M%S' )
        except Exception , err:
                print >> stderr , "error-->" ,  err
                traceback.print_stack()
                return -1

def date_str_to_timkestamp( time_str ):
        return  mktime_from_str( time_str , '%Y-%m-%d %H:%M:%S' )

def timestamp_to_date( timestamp , fmt = "%Y-%m-%d %H:%M:%S"):
        return datetime.fromtimestamp( timestamp ).strftime( fmt )

def get_ts_file_ch( ts_file_path ):
        try :
                return ts_file_path.split( "/" )[ -1 ].split( "_" )[ 0 ]
        except Exception , err:
                print >> stderr , "err ts file path --> %s " % ts_file_path
                traceback.print_stack()
                return ""
