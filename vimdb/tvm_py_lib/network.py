import urllib2
import json
import urllib
import socket
import os
from sys import stderr
import traceback

def url_req( url ,timeout_sec = 10 , post_str = "" ):
        try :
                req = urllib2.Request( url )
                if post_str == "" :
                        rsp = urllib2.urlopen( req , timeout = timeout_sec )
                else :
                        rsp = urllib2.urlopen( req , timeout = timeout_sec ,data = post_str )
                return rsp.read()
        except Exception  as err:
                print >> stderr , "error-->" ,  err
                traceback.print_stack()
                return ""

def url_req_post( url , post_data ,timeout_sec = 10 ):
        return  url_req( url , timeout_sec , urllib.urlencode( post_data ) )

def get_file_url( req_url ):                                 
        tmp_file_name = str( os.getpid() ) + ".txt"          
        try :                                                
                urllib.urlretrieve(req_url, tmp_file_name);          
                result = []                                  
                rsp = open( tmp_file_name , "r" )            
                for content in rsp.read().split( "\n" ) :    
                        if content[ 0:4 ] == 'http' :        
                                result.append( content )     
		os.remove(  tmp_file_name )
                return result                                
        except Exception as err:                             
                print >> stderr , "error-->" ,  err
                traceback.print_stack()
                return []                                    

def download( url , file_name ):
        try  :
                rsp_data = url_req( url )#here may be gzip type. try another
                if len( rsp_data ) < 1 :
                        return False
                output_file = open( file_name , "w" )
                output_file.write( rsp_data )
                output_file.close()
                return True
        except Exception  as err:
                print >> stderr , "error-->" ,  err
                traceback.print_stack()
                return False

def req_once( req_data , host , port ):
        try :
                sock = socket.socket( socket.AF_INET, socket.SOCK_STREAM )
                sock.settimeout( 3 )
                sock.connect((host, port))
                sent_len = 0
                while sent_len < len( req_data ) :
                        ret = sock.send( req_data[ sent_len : len( req_data )  ] )
                        sent_len += ret
                result = ""
                tmp = "--"
                while  "" != tmp :
                        tmp = sock.recv( 10000 )
                        result += tmp
                        if len( tmp ) < 10000 :
                                 break
                sock.close()
                return "ok" ,  result
        except Exception ,e  :
                return "error" , e

def get_vod_addr( ch , cfg_url ):
        try :
                f = urllib2.urlopen( cfg_url )
                data_list = json.load(f)
                ansi_data_list = []
                for data in  data_list:
                        if ch == data[ u"channel" ] :
                                return data[ "voide_address" ]
                return  ""
        except  Exception , e :
                print >> stderr , "error-->" ,  e
                traceback.print_stack()
                return ""
