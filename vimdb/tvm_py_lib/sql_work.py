import MySQLdb
import traceback
from sys import stderr

def run_sql_cmd( mysql_cmd ,  host , user , pwd , db , port = 3306  , args = []  ):
        run_sql_and_fetch( mysql_cmd , host , user , pwd , db , port = 3306 ,args = args )

def run_sql_and_fetch( mysql_cmd , host , user , pwd , db , port = 3306 ,args = [] ):
        print ( mysql_cmd , host , user , pwd , db , port  ,args  )
        try:
                conn=MySQLdb.connect( host = host ,
                                      user = user ,
                                      passwd = pwd ,
                                      db = db ,
                                      port = port ,
                                      charset = "UTF8")
                return _sql_run_process( conn , mysql_cmd , args )
        except MySQLdb.Error,e:
                print >> stderr , "error-->" ,  e
                traceback.print_stack()
                return []


def run_sql_cmd_( mysql_cmd , host , cfg_file , db , port = 3306 ,args = [] ):
        run_sql_and_fetch_( mysql_cmd , host , cfg_file, db  , port , args )

def run_sql_and_fetch_( mysql_cmd , host , cfg_file , db  , port = 3306 ,args = [] ):
        try:
                conn=MySQLdb.connect( host=host ,
                                      db = db ,
                                      read_default_file=cfg_file )
                return _sql_run_process( conn , mysql_cmd , args )
        except MySQLdb.Error,e:
                print >> stderr , "error-->" ,  e
                traceback.print_stack()
                return []

def _sql_run_process( conn , mysql_cmd , args = [] ):
        try:
                cur=conn.cursor()
                res = cur.execute( mysql_cmd ,args )
                result = cur.fetchmany( res )
                cur.close()
                conn.commit()
                conn.close()
                return result
        except MySQLdb.Error,e:
                print >> stderr , "error-->" ,  e
                traceback.print_stack()
                return []
