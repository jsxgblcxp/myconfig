import os
from sys import stderr
import traceback

def rm_if_isfile( file_name ):
        print >> stderr , "try to remove" + file_name
        if os.path.isfile( file_name ) :
                os.remove( file_name )

def rm_if_is_the_type_of_file( file_name , file_type ):
        try :
                if file_type == file_name.split( "." )[ -1 ] :
                        rm_if_isfile( file_name )
        except Exception , e :
                return 

def write_to_file( data , file_name ):
        fd = open( file_name  , "w" )
        fd.write( data )
        fd.close()

def file_get_contents( file_name ):
        if not os.path.isfile( file_name ) :
                return ""
        fd =  open( file_name  , "r" )
        ret = fd.read()
        fd.close()
        return ret
