From: eugene lin <linyouqing7@gmail.com>
Subject: phprados make error
Date: Wed, 21 Sep 2011 11:06:17 +0800
Message-ID: <CADSLUZmOS=FyMM5T3EcCzmmcOVX865OUU33yzjJMSK_--J_R2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f180.google.com ([74.125.82.180]:60424 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab1IUDGT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2011 23:06:19 -0400
Received: by wyj26 with SMTP id 26so1754179wyj.11
        for <ceph-devel@vger.kernel.org>; Tue, 20 Sep 2011 20:06:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi , all

I install ceph-0.33 all in one virtual machine - fedora 14
+2.6.40.3-0.fc15.i686.PAE,
and sccussful execute "radso --help"
when I want install phprados and make it meets some problems.

#cd phprados
# phpize
+++++++++++++++++++++++++++++++++++++++++++
[root@monitor2 phprados]# ./configure
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for a sed that does not truncate output... /bin/sed
checking for cc... cc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether cc accepts -g... yes
checking for cc option to accept ISO C89... none needed
checking how to run the C preprocessor... cc -E
checking for icc... no
checking for suncc... no
checking whether cc understands -c and -o together... yes
checking for system library directory... lib
checking if compiler supports -R... no
checking if compiler supports -Wl,-rpath,... yes
checking build system type... i686-pc-linux-gnu
checking host system type... i686-pc-linux-gnu
checking target system type... i686-pc-linux-gnu
checking for PHP prefix... /usr
checking for PHP includes... -I/usr/include/php
-I/usr/include/php/main -I/usr/include/php/TSRM
-I/usr/include/php/Zend -I/usr/include/php/ext
-I/usr/include/php/ext/date/lib
checking for PHP extension directory... /usr/lib/php/modules
checking for PHP installed headers prefix... /usr/include/php
checking if debug is enabled... no
checking if zts is enabled... no
checking for re2c... no
configure: WARNING: You will need re2c 0.13.4 or later if you want to
regenerate PHP parsers.
checking for gawk... gawk
checking Enable the rados extension... yes, shared
checking for RADOS files (librados.hpp)... found in /usr/local
checking for libatomic-ops files (atomic_ops.h)... found in /usr/local
checking for libSSL files (crypto.h)... found in /usr
checking for g++... g++
checking whether we are using the GNU C++ compiler... yes
checking whether g++ accepts -g... yes
checking how to run the C++ preprocessor... g++ -E
checking how to print strings... printf
checking for a sed that does not truncate output... (cached) /bin/sed
checking for fgrep... /bin/grep -F
checking for ld used by cc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
checking the name lister (/usr/bin/nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+="... yes
checking how to convert i686-pc-linux-gnu file names to
i686-pc-linux-gnu format... func_convert_file_noop
checking how to convert i686-pc-linux-gnu file names to toolchain
format... func_convert_file_noop
checking for /usr/bin/ld option to reload object files... -r
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for ar... ar
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking for gawk... (cached) gawk
checking command to parse /usr/bin/nm -B output from cc object... ok
checking for sysroot... no
checking for mt... no
checking if : is a manifest tool... no
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if cc supports -fno-rtti -fno-exceptions... no
checking for cc option to produce PIC... -fPIC -DPIC
checking if cc PIC flag -fPIC -DPIC works... yes
checking if cc static flag -static works... yes
checking if cc supports -c -o file.o... yes
checking if cc supports -c -o file.o... (cached) yes
checking whether the cc linker (/usr/bin/ld) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
checking how to run the C++ preprocessor... g++ -E
checking for ld used by g++... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking whether the g++ linker (/usr/bin/ld) supports shared libraries... yes
checking for g++ option to produce PIC... -fPIC -DPIC
checking if g++ PIC flag -fPIC -DPIC works... yes
checking if g++ static flag -static works... no
checking if g++ supports -c -o file.o... yes
checking if g++ supports -c -o file.o... (cached) yes
checking whether the g++ linker (/usr/bin/ld) supports shared libraries... yes
checking dynamic linker characteristics... (cached) GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
configure: creating ./config.status
config.status: creating config.h
config.status: config.h is unchanged
config.status: executing libtool commands

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
[root@monitor2 phprados]# make
/bin/sh /usr/src/lyq/phprados/libtool --mode=compile g++  -I.
-I/usr/src/lyq/phprados -DPHP_ATOM_INC -I/usr/src/lyq/phprados/include
-I/usr/src/lyq/phprados/main -I/usr/src/lyq/phprados
-I/usr/include/php -I/usr/include/php/main -I/usr/include/php/TSRM
-I/usr/include/php/Zend -I/usr/include/php/ext
-I/usr/include/php/ext/date/lib -I/usr/local/include  -DHAVE_CONFIG_H
-g -O2   -c /usr/src/lyq/phprados/rados.cc -o rados.lo
libtool: compile:  g++ -I. -I/usr/src/lyq/phprados -DPHP_ATOM_INC
-I/usr/src/lyq/phprados/include -I/usr/src/lyq/phprados/main
-I/usr/src/lyq/phprados -I/usr/include/php -I/usr/include/php/main
-I/usr/include/php/TSRM -I/usr/include/php/Zend -I/usr/include/php/ext
-I/usr/include/php/ext/date/lib -I/usr/local/include -DHAVE_CONFIG_H
-g -O2 -c /usr/src/lyq/phprados/rados.cc  -fPIC -DPIC -o .libs/rados.o
In file included from /usr/src/lyq/phprados/rados.cc:19:0:
/usr/src/lyq/phprados/php_rados.h:21:5: error: 'pool_t' does not name a type
/usr/src/lyq/phprados/php_rados.h:25:5: error: 'ListCtx' in 'class
librados::Rados' does not name a type
/usr/src/lyq/phprados/rados.cc: In constructor 'rados_object::rados_object()':
/usr/src/lyq/phprados/rados.cc:38:18: warning: passing NULL to
non-pointer argument 1 of 'std::vector<_Tp,
_Alloc>::vector(std::vector<_Tp, _Alloc>::size_type, const
value_type&, const allocator_type&) [with _Tp = const char*, _Alloc =
std::allocator<const char*>, std::vector<_Tp, _Alloc>::size_type =
unsigned int, std::vector<_Tp, _Alloc>::value_type = const char*,
std::vector<_Tp, _Alloc>::allocator_type = std::allocator<const
char*>]' [-Wconversion-null]
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados___construct(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:355:72: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_initialize(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:371:20: error: 'class librados::Rados'
has no member named 'initialize'
/usr/src/lyq/phprados/rados.cc:372:101: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_open_pool(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:383:5: error: 'pool_t' was not declared
in this scope
/usr/src/lyq/phprados/rados.cc:383:12: error: expected ';' before 'pool'
/usr/src/lyq/phprados/rados.cc:389:81: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:394:111: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:403:105: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:407:15: error: 'class librados::Rados'
has no member named 'open_pool'
/usr/src/lyq/phprados/rados.cc:407:33: error: 'pool' was not declared
in this scope
/usr/src/lyq/phprados/rados.cc:408:115: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:413:13: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc:413:20: error: 'pool' was not declared
in this scope
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_close_pool(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:422:69: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:426:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:431:15: error: 'class librados::Rados'
has no member named 'close_pool'
/usr/src/lyq/phprados/rados.cc:431:34: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_create_pool(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:445:103: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:450:111: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:457:15: error: 'class librados::Rados'
has no member named 'create_pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_delete_pool(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:469:69: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:473:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:478:15: error: 'class librados::Rados'
has no member named 'delete_pool'
/usr/src/lyq/phprados/rados.cc:478:35: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_lookup_pool(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:490:81: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:495:111: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:503:19: error: 'class librados::Rados'
has no member named 'lookup_pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_change_pool_auid(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:519:77: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:523:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:528:16: error: 'class librados::Rados'
has no member named 'change_pool_auid'
/usr/src/lyq/phprados/rados.cc:528:41: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_list_pools(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:542:15: error: 'class librados::Rados'
has no member named 'list_pools'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_get_pool_stats(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:558:69: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_get_fs_stats(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:610:5: error: 'statfs_t' was not
declared in this scope
/usr/src/lyq/phprados/rados.cc:610:14: error: expected ';' before 'stats'
/usr/src/lyq/phprados/rados.cc:615:15: error: 'class librados::Rados'
has no member named 'get_fs_stats'
/usr/src/lyq/phprados/rados.cc:615:28: error: 'stats' was not declared
in this scope
/usr/src/lyq/phprados/rados.cc:620:5: error: 'stats' was not declared
in this scope
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_snap_create(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:633:96: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:637:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:642:16: error: 'class librados::Rados'
has no member named 'snap_create'
/usr/src/lyq/phprados/rados.cc:642:36: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_snap_remove(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:656:96: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:660:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:665:16: error: 'class librados::Rados'
has no member named 'snap_remove'
/usr/src/lyq/phprados/rados.cc:665:36: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_snap_list(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:678:69: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:682:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:687:16: error: 'class librados::Rados'
has no member named 'snap_list'
/usr/src/lyq/phprados/rados.cc:687:34: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_snap_get_name(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:705:86: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:709:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:715:16: error: 'class librados::Rados'
has no member named 'snap_get_name'
/usr/src/lyq/phprados/rados.cc:715:38: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_snap_get_stamp(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:729:86: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:733:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:739:16: error: 'class librados::Rados'
has no member named 'snap_get_stamp'
/usr/src/lyq/phprados/rados.cc:739:39: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_snap_lookup(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:756:96: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:760:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:766:16: error: 'class librados::Rados'
has no member named 'snap_lookup'
/usr/src/lyq/phprados/rados.cc:766:36: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_snap_rollback_object(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:780:113: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:784:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:789:16: error: 'class librados::Rados'
has no member named 'snap_rollback_object'
/usr/src/lyq/phprados/rados.cc:789:45: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_list_objects(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:798:5: error: 'ListCtx' is not a member
of 'librados::Rados'
/usr/src/lyq/phprados/rados.cc:798:20: error: expected ';' before 'ctx'
/usr/src/lyq/phprados/rados.cc:803:69: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:807:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:815:12: error: 'class librados::Rados'
has no member named 'list_objects_open'
/usr/src/lyq/phprados/rados.cc:815:38: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc:815:45: error: 'ctx' was not declared
in this scope
/usr/src/lyq/phprados/rados.cc:818:20: error: 'class librados::Rados'
has no member named 'list_objects_more'
/usr/src/lyq/phprados/rados.cc:826:12: error: 'class librados::Rados'
has no member named 'list_objects_close'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_list_objects_open(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:831:5: error: 'ListCtx' is not a member
of 'librados::Rados'
/usr/src/lyq/phprados/rados.cc:831:20: error: expected ';' before 'ctx'
/usr/src/lyq/phprados/rados.cc:836:69: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:840:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:848:12: error: 'class librados::Rados'
has no member named 'list_objects_open'
/usr/src/lyq/phprados/rados.cc:848:38: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc:848:45: error: 'ctx' was not declared
in this scope
/usr/src/lyq/phprados/rados.cc:851:16: error: 'php_rados_listctx' has
no member named 'ctx'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_list_objects_more(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:862:82: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:867:133: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:871:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:881:20: error: 'class librados::Rados'
has no member named 'list_objects_more'
/usr/src/lyq/phprados/rados.cc:881:49: error: 'php_rados_listctx' has
no member named 'ctx'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_list_objects_close(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:896:68: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:900:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:906:12: error: 'class librados::Rados'
has no member named 'list_objects_close'
/usr/src/lyq/phprados/rados.cc:906:42: error: 'php_rados_listctx' has
no member named 'ctx'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_create(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:918:100: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:922:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:928:16: error: 'class librados::Rados'
has no member named 'create'
/usr/src/lyq/phprados/rados.cc:928:31: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_remove(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:942:86: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:946:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:952:16: error: 'class librados::Rados'
has no member named 'remove'
/usr/src/lyq/phprados/rados.cc:952:31: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void zim_Rados_stat(int,
zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:968:86: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:972:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:980:16: error: 'class librados::Rados'
has no member named 'stat'
/usr/src/lyq/phprados/rados.cc:980:29: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_write_full(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:999:105: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1003:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1011:16: error: 'class librados::Rados'
has no member named 'write_full'
/usr/src/lyq/phprados/rados.cc:1011:35: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void zim_Rados_write(int,
zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:1027:116: warning: deprecated
conversion from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1031:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1039:16: error: 'class librados::Rados'
has no member named 'write'
/usr/src/lyq/phprados/rados.cc:1039:30: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void zim_Rados_read(int,
zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:1054:105: warning: deprecated
conversion from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1059:110: warning: deprecated
conversion from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1063:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1069:16: error: 'class librados::Rados'
has no member named 'read'
/usr/src/lyq/phprados/rados.cc:1069:29: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_read_full(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:1086:86: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1090:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1096:16: error: 'class librados::Rados'
has no member named 'stat'
/usr/src/lyq/phprados/rados.cc:1096:29: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc:1100:16: error: 'class librados::Rados'
has no member named 'read'
/usr/src/lyq/phprados/rados.cc:1100:29: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void zim_Rados_trunc(int,
zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:1115:94: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1120:118: warning: deprecated
conversion from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1124:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1130:16: error: 'class librados::Rados'
has no member named 'trunc'
/usr/src/lyq/phprados/rados.cc:1130:30: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_getxattr(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:1143:107: warning: deprecated
conversion from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1147:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1153:16: error: 'class librados::Rados'
has no member named 'getxattr'
/usr/src/lyq/phprados/rados.cc:1153:33: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_setxattr(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:1173:126: warning: deprecated
conversion from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1177:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1185:16: error: 'class librados::Rados'
has no member named 'setxattr'
/usr/src/lyq/phprados/rados.cc:1185:33: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc: In function 'void
zim_Rados_getxattrs(int, zval*, zval**, zval*, int)':
/usr/src/lyq/phprados/rados.cc:1198:86: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1202:5: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1208:16: error: 'class librados::Rados'
has no member named 'getxattrs'
/usr/src/lyq/phprados/rados.cc:1208:34: error: 'php_rados_pool' has no
member named 'pool'
/usr/src/lyq/phprados/rados.cc:1217:21: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc: In function 'int zm_startup_rados(int, int)':
/usr/src/lyq/phprados/rados.cc:1226:105: warning: deprecated
conversion from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1227:111: warning: deprecated
conversion from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc:1239:111: warning: deprecated
conversion from string constant to 'char*' [-Wwrite-strings]
/usr/src/lyq/phprados/rados.cc: At global scope:
/usr/src/lyq/phprados/rados.cc:1274:1: warning: deprecated conversion
from string constant to 'char*' [-Wwrite-strings]
make: *** [rados.lo] Error 1
