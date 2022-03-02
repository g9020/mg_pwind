# mg\_pwind

Access to OS libraries (e.g. the cryptography library) from **YottaDB** code.

Chris Munt <cmunt@mgateway.com>  
1 March 2022, M/Gateway Developments Ltd [http://www.mgateway.com](http://www.mgateway.com)

* Current Release: Version: 1.3; Revision 5.
* [Release Notes](#RelNotes) can be found at the end of this document.

Contents

* [Overview](#Overview")
* [Pre-requisites](#PreReq")
* [Installing mg\_pwind](#Install)
* [Invocation of mg\_pwind functions](#DBFunctions)
* [Cryptographic functions](#DBCrypto)
* [Accessing InterSystems databases](#DBISC)
* [Access to InterSystems classes](#DBClasses)
* [Access to InterSystems Transactions](#DBTXP)
* [For the future](#Future)
* [License](#License)


## <a name="Overview"></a> Overview 

The **YottaDB** *Process Window* (**mg\_pwind**) library is an Open Source solution to provide easy access to functionality contained in external shared libraries.

The **mg\_pwind** library provides access to the cryptographic functions commonly used in web application development. To provide this functionality, **mg_pwind** makes use of the **OpenSSL** cryptography library: **libcrypto.so**.

## <a name="PreReq"></a> Pre-requisites

The OpenSSL libraries:

       https://www.openssl.org/

These libraries are pre-installed on most Linux systems.  In order to build **mg_pwind.so** the **OpenSSL** development files will need to be installed.  For example:

       apt-get install libssl-dev

## <a name="Install"></a> Installing mg\_pwind

Working in the **/src** directory of the distribution, edit the following two files to reflect the layout of your **YottaDB** installation.  The instructions given here assume a standard 'out of the box' installation of **YottaDB** (version 1.30) deployed in the following location:

       /usr/local/lib/yottadb/r130

Assuming that you will install **mg\_pwind** in this directory, first edit the following line in **Makefile** to reflect this installation location:

       MGYDBDIR=/usr/local/lib/yottadb/r130

Now edit the top line of the **YottaDB** interface file **mg\_pwind.xc** to give the full name and path to the **mg\_pwind.so** library:

       /usr/local/lib/yottadb/r130/mg_pwind.so
 
Finally, build and install the **mg\_pwind** library:

       make
       make install

You should now see the **mg\_pwind** library and its associated interface file installed in the **YottaDB** directory:

       /usr/local/lib/yottadb/r130/mg_pwind.so
       /usr/local/lib/yottadb/r130/mg_pwind.xc


## <a name="DBFunctions"> Invocation of mg\_pwind functions

Before invoking **mg\pwind** functions the following environment variable (**ydb\_xc\_pwind**) must be set before starting **YottaDB** processes:

       export ydb_xc_pwind=/usr/local/lib/yottadb/r130/mg_pwind.xc

Of course, modify the path to suit your own installation.

When calling **mg\_pwind** functions be sure to pass output variables by reference (i.e. preceded by a period character).

### Get the version of the mg\_pwind library

       set status=$&pwind.version(.<version>)
      
Example:

       set status=$&pwind.version(.vers)
       write !,"version: ",vers

### Get the last error message

Some of the **mg\_pwind** functions will return an **error** variable.  Success of the operation is indicated by this variable being returned as an empty string ("").  All functions will return a status code which will be returned as zero if the function completes successfully.  If the function call is not successful then a non-zero status code will be returned, a M exception will be thrown and the corresponding error message may be retrieved by the **error** function.  

       set status=$&pwind.error(.<error>)
      
Example:

             new $ztrap set $ztrap="zgoto "_$zlevel_":error"
             set status=$&pwind.sslversion(.vers)
             write !,"SSL version: ",vers
             quit
       error ; error
             set status=$&pwind.error(.error)
             write !,"error: ",error
             quit


## <a name="DBCrypto"> Cryptographic functions

Some functions in this section include a **mode** flag.  Set this flag as follows:

* mode=0: The default.  Return the raw hash or HMAC value.
* mode=1: Return the hash or HMAC value as B64 encoded.
* mode=2: Return the hash or HMAC value as a string of HEX values.

### Specifying the location of the OpenSSL libraries

It will not be necessary to use this function for most systems as the **libcrypto.so** library is usually readily available from the OS known directories for shared libraries.  However, if you need to specify an alternative location for the **libcrypto.so** library then use this function to specify the name and full path. 

       set status=$&pwind.cryptlibrary(<cryptlibrary>)
      
Example:

       set status=$&pwind.cryptlibrary("/unusual/location/libcrypto.so")

### Get the version of the OpenSSL libraries

       set status=$&pwind.sslversion(.<version>)
      
Example:

       set status=$&pwind.sslversion(.vers)
       write !,"SSL version: ",vers

### Generate SHA1 hash

       set status=$&pwind.sha1(<data>, <mode>, .<hash>)
      
Example:

       set status=$&pwind.sha1("my data",2,.hash)
       write !,"SHA1 hash: ",hash


### Generate SHA256 hash

       set status=$&pwind.sha256(<data>, <mode>, .<hash>)
      
Example:

       set status=$&pwind.sha256("my data",2,.hash)
       write !,"SHA256 hash: ",hash

### Generate SHA512 hash

       set status=$&pwind.sha512(<data>, <mode>, .<hash>)
      
Example:

       set status=$&pwind.sha512("my data",2,.hash)
       write !,"SHA512 hash: ",hash

### Generate MD5 hash

       set status=$&pwind.md5(<data>, <mode>, .<hash>)
      
Example:

       set status=$&pwind.md5("my data",2,.hash)
       write !,"MD5 hash: ",hash

### Generate SHA1 HMAC

       set status=$&pwind.hmacsha1(<key>, <data>, <mode>, .<hmac>)
      
Example:

       set status=$&pwind.hmacsha1("my key","my data",2,.hmac)
       write !,"SHA1 HMAC: ",hmac

### Generate SHA256 HMAC

       set status=$&pwind.hmacsha256(<key>, <data>, <mode>, .<hmac>)
      
Example:

       set status=$&pwind.hmacsha256("my key","my data",2,.hmac)
       write !,"SHA256 HMAC: ",hmac

### Generate SHA512 HMAC

       set status=$&pwind.hmacsha512(<key>, <data>, <mode>, .<hmac>)
      
Example:

       set status=$&pwind.hmacsha512("my key","my data",2,.hmac)
       write !,"SHA512 HMAC: ",hmac

### Generate MD5 HMAC

       set status=$&pwind.hmacmd5(<key>, <data>, <mode>, .<hmac>)
      
Example:

       set status=$&pwind.hmacmd5("my key","my data",2,.hmac)
       write !,"MD5 HMAC: ",hmac

### B64 encode

       set status=$&pwind.encodeb64(<data>, .<b64>)
      
Example:

       set status=$&pwind.encodeb64("my data",.b64)
       write !,"B64 encode: ",b64

### B64 decode

       set status=$&pwind.decodeb64(<b64>, .<data>)
      
Example:

       set status=$&pwind.decodeb64(b64,.data)
       write !,"B64 decode: ",data

### Generate CRC32 checksum

       set status=$&pwind.crc32(<data>, .<crc32>)
      
Example:

       set status=$&pwind.crc32("my data",.crc32)
       write !,"CRC32: ",crc32


## <a name="DBISC"> Accessing InterSystems databases

This section describes an experimental approach to accessing data held in InterSystems databases (Cache, Ensemble and IRIS).  Two connectivity modes are supported:

* High-performance in-process access to a local InterSystems database using the Cache/IRIS API.
* Network based access to a local or remote InterSystems databases via the network.

### Opening a connecting to the database

       set status=$&pwind.dbopen(<dbtype>, <path>, <host>, <port>, <username>, <password>, <namespace>)

* **dbtype** should be set to either Cache or IRIS as appropriate.
* For API-based connectivity, specify the **path** and leave **host** and **port** empty.
* For Network-based connectivity, leave the **path** empty and specify the **host** and **port** on which the **%zmgsi** superserver is listening.


Example using the API:

       set status=$&pwind.dbopen("Cache","/opt/cache20181/mgr","","","_SYSTEM","SYS","USER")

Example using the network:

       set status=$&pwind.dbopen("Cache","","localhost",7041,"_SYSTEM","SYS","USER")

### Closing a connecting to the database

       set status=$&pwind.dbclose()

Example:

       set status=$&pwind.dbclose()

### Set a global record

       set status=$&pwind.dbset(<data>, <global>, <key ...>)

Example:

       set status=$&pwind.dbset("my data record", "^MyGlobal", "my key")

This is equivalent to:

       set ^MyGlobal("my key")="my data record"

### Get a global record

       set status=$&pwind.dbget(.<data>, <global>, <key ...>)

Example:

       set status=$&pwind.dbget(.data, "^MyGlobal", "my key")

This is equivalent to:

       set data=$get(^MyGlobal("my key"))

### Delete a global record

       set status=$&pwind.dbkill(<global>, <key ...>)

Example:

       set status=$&pwind.dbkill("^MyGlobal", "my key")

This is equivalent to:

       kill ^MyGlobal("my key")

### Get next global key record

       set status=$&pwind.dborder(.<nkey>, <global>, <key ...>)

Example:

       set status=$&pwind.dborder(.nkey, "^MyGlobal", "")

This is equivalent to:

       set nkey=$order(^MyGlobal(""))

### Get next global key record and associated data

       set status=$&pwind.dborderdata(.<nkey>, .<data>, <global>, <key ...>)

Example:

       set status=$&pwind.dborderdata(.nkey,.data,"^MyGlobal", "")

This is equivalent to:

       set data="",nkey=$order(^MyGlobal("")) if nkey'="" set data=$get(^MyGlobal(nkey))

### Get previous global key record

       set status=$&pwind.dbprevious(.<pkey>, <global>, <key ...>)

Example:

       set status=$&pwind.dbprevious(.pkey, "^MyGlobal", "")

This is equivalent to:

       set pkey=$order(^MyGlobal(""),-1)

### Get previous global key record and associated data

       set status=$&pwind.dbpreviousdata(.<nkey>, .<data>, <global>, <key ...>)

Example:

       set status=$&pwind.dbpreviousdata(.nkey,.data,"^MyGlobal", "")

This is equivalent to:

       set data="",nkey=$order(^MyGlobal(""),-1) if nkey'="" set data=$get(^MyGlobal(nkey))

### Increment and return the value of a global node

       set status=$&pwind.dbincrement(.<result>, <increment>, <global>, <key ...>)

Example:

       set status=$&pwind.dbincrement(.result,0.5,"^MyGlobal", 1)

This is equivalent to:

       set result=$increment(^MyGlobal(1),0.5)

### Lock a global node

       set status=$&pwind.dblock(.<result>, <timeout>, <global>, <key ...>)

* The time-out value should be specified in seconds.  Set to -1 for no time-out.
* **result** is set to 1 to indicate success or 0 for time-out.

Example:

       set status=$&pwind.dblock(.result,-1,"^MyGlobal", 1)

This is equivalent to:

       Lock +^MyGlobal(1)


### Unlock a global node

       set status=$&pwind.dbunlock(<global>, <key ...>)

Example:

       set status=$&pwind.undblock("^MyGlobal", 1)

This is equivalent to:

       Lock -^MyGlobal(1)

### Invoke an InterSystems function

* Note: Recommend that functions are accessed over network-based connectivity (for now).

       set status=$&pwind.dbfunction(.<result>, <function>, <arguments ...>)

Example:

       set status=$&pwind.dbfunction(.result, "function^MyRoutine", "a", "b")

This is equivalent to:

       set result=$$function^MyRoutine("a","b")

### A complete but simple example

       ; Open a new connection to a local Cache database
       set status=$&pwind.dbopen("Cache","/opt/cache20181/mgr","","","_SYSTEM","SYS","USER")
       ; Kill a global
       set status=$&pwind.dbkill("^MyGlobal")
       ; Set up some new records
       for n=1:1:10 set status=$&pwind.dbset("record "_n_" ("_$zh_")","^MyGlobal",n)
       ; Now read them all back (in order)
       set key="" for  set status=$&pwind.dborder(.key,"^MyGlobal",key) quit:key=""  set status=$&pwind.dbget(.data,"^MyGlobal",key) write !,key," = ",data
       ; Read them all back (in reverse order)
       set key="" for  set status=$&pwind.dbprevious(.key,"^MyGlobal",key) quit:key=""  set status=$&pwind.dbget(.data,"^MyGlobal",key) write !,key," = ",data
       ; close the database connection
       set status=$&pwind.dbclose()

## <a name="DBClasses"> Access to InterSystems classes

To illustrate these methods, the following simple class will be used:

       Class User.customer Extends %Persistent
       {
          Property number As %Integer;
          Property name As %String;
          ClassMethod MyClassMethod(x As %Integer) As %Integer
          {
             // do some work
             Quit result
          }
          Method MyMethod(x As %Integer) As %Integer
          {
             // do some work
             Quit result
          }
       }

### Invoke a ClassMethod

* Note: Recommend that classes are accessed over network-based connectivity (for now).

       set status=$&pwind.dbclassmethod(.<result>, <class_name>, <method_name>, <arguments ...>)

Example:

       set status=$&pwind.dbclassmethod(.result,"User.customer","MyClassMethod",3)

### Open a specific instance of a Class

Example (using instance/record #1):

       set status=$&pwind.dbclassmethod(.oref,"User.customer","%OpenId", 1)

### Get a property

       set status=$&pwind.dbgetproperty(.<data>, <object_reference>, <property_name>)

Example:

       set status=$&pwind.dbgetproperty(.name,oref,"name")

### Set a property

       set status=$&pwind.dbsetproperty(<data>, <object_reference>, <property_name>)

Example:

       set status=$&pwind.dbsetproperty(name,oref,"name")

### Invoke a Method

       set status=$&pwind.dbmethod(.<result>, <object_reference>, <method_name>), <arguments ...>)

Example:

       set status=$&pwind.dbmethod(.result,oref,"MyMethod",3)

### Close an instance

       set status=$&pwind.dbcloseinstance(<object_reference>)

Example:

       set status=$&pwind.dbcloseinstance(oref)


## <a name="DBTXP"> Access to InterSystems Transactions

### Start a Transaction

       set status=$&pwind.dbtstart()

This is equivalent to:

       TStart

### Return the Transaction Level

       set status=$&pwind.dbtlevel(.<tlevel>)

Example:

       set status=$&pwind.dbtlevel(.tlevel)

This is equivalent to:

       set tlevel=$TLevel

### Commit a Transaction

       set status=$&pwind.dbtcommit()

This is equivalent to:

       TCommit

### Rollback a Transaction

       set status=$&pwind.dbtrollback()

This is equivalent to:

       TRollback

## <a name="Future"></a> For the future

Further functions (and access to other OS libraries) will be added to **mg\_pwind** as required.


## <a name="License"></a> License

Copyright (c) 2018-2022 M/Gateway Developments Ltd,
Surrey UK.                                                      
All rights reserved.
 
http://www.mgateway.com                                                  
Email: cmunt@mgateway.com
 
 
Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.      


## <a name="RelNotes"></a>Release Notes

### v1.0.1 (5 March 2021)

* Initial Release

### v1.2.2 (23 March 2021)

* Introduce experimental network I/O layer.

### v1.3.3 (15 February 2022)

* Introduce experimental access to InterSystems databases.

### v1.3.4 (18 February 2022)

* Introduce experimental access to InterSystems classes.

### v1.3.5 (1 March 2022)

* Introduce access to the InterSystems Global Lock command.
* Introduce access to InterSystems Transactions.
* Introduce a function to gracefully close InterSystems Object References.
	* set status=$&pwind.dbclosinstance(oref)