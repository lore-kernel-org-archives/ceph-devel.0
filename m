From: Andrew Milkowski <andrewmilkowski@gmail.com>
Subject: Compile errors on Mac OS X
Date: Sat, 30 Jan 2010 09:26:11 -0500
Message-ID: <82d7a2d21001300626k4d9efc6el6dd162f19b4110e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0823449062051206747=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

--===============0823449062051206747==
Content-Type: multipart/alternative; boundary=000e0cd6f1caa27b1c047e628834

--000e0cd6f1caa27b1c047e628834
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hey there

Using latest git I launch following sequence to assemble ceph binaries:

export CPPFLAGS=3D"-I/opt/local/src/boost/boost_1_41_0/build/include
-I/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Headers"
./autogen.sh
./configure --prefix=3D/opt/src/local/ceph/trunk/build --with-fuse
--with-hadoop
make
make install

----------------

Received following series of compilation errors: (attaching entire make
output) at the end of this email

endian.h believe can be substituted in the Apple env, but Spinlock.h errors
appear to be non-trivial porting issues

(btw. goal is to evaluate ceph with hypertable and use Mac in non productio=
n
environment, was able to build hypertable on Mac OS X and run with no
problems)


Thanks



bash-3.2$ sudo ./build.sh
libtoolize: putting auxiliary files in `.'.
libtoolize: copying file `./ltmain.sh'
libtoolize: Consider adding `AC_CONFIG_MACRO_DIR([m4])' to configure.ac and
libtoolize: rerunning libtoolize, to keep the correct libtool macros
in-tree.
libtoolize: Consider adding `-I m4' to ACLOCAL_AMFLAGS in Makefile.am.
libtoolize: `AC_PROG_RANLIB' is rendered obsolete by `LT_INIT'
checking build system type... x86_64-apple-darwin10.2.0
checking host system type... x86_64-apple-darwin10.2.0
checking target system type... x86_64-apple-darwin10.2.0
checking for a BSD-compatible install... /opt/local/bin/ginstall -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /opt/local/bin/gmkdir -p
checking for gawk... no
checking for mawk... no
checking for nawk... no
checking for awk... awk
checking whether make sets $(MAKE)... yes
checking for style of include used by make... GNU
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking dependency style of gcc... gcc3
checking whether gcc and cc understand -c and -o together... yes
checking for a sed that does not truncate output... /usr/bin/sed
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for fgrep... /usr/bin/grep -F
checking for ld used by gcc... /usr/libexec/gcc/i686-apple-darwin10/4.2.1/l=
d
checking if the linker (/usr/libexec/gcc/i686-apple-darwin10/4.2.1/ld) is
GNU ld... no
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm
checking the name lister (/usr/bin/nm) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 196608
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+=3D"... yes
checking for /usr/libexec/gcc/i686-apple-darwin10/4.2.1/ld option to reload
object files... -r
checking for objdump... no
checking how to recognize dependent libraries... pass_all
checking for ar... ar
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /usr/bin/nm output from gcc object... ok
checking for dsymutil... dsymutil
checking for nmedit... nmedit
checking for lipo... lipo
checking for otool... otool
checking for otool64... no
checking for -single_module linker flag... yes
checking for -exported_symbols_list linker flag... yes
checking how to run the C preprocessor... gcc -E
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
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fno-common -DPIC
checking if gcc PIC flag -fno-common -DPIC works... yes
checking if gcc static flag -static works... no
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker
(/usr/libexec/gcc/i686-apple-darwin10/4.2.1/ld) supports shared libraries..=
.
yes
checking dynamic linker characteristics... darwin10.2.0 dyld
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for g++... g++
checking whether we are using the GNU C++ compiler... yes
checking whether g++ accepts -g... yes
checking dependency style of g++... gcc3
checking whether we are using the GNU C++ compiler... (cached) yes
checking whether g++ accepts -g... (cached) yes
checking dependency style of g++... (cached) gcc3
checking how to run the C++ preprocessor... g++ -E
checking for ld used by g++... /usr/libexec/gcc/i686-apple-darwin10/4.2.1/l=
d
checking if the linker (/usr/libexec/gcc/i686-apple-darwin10/4.2.1/ld) is
GNU ld... no
checking whether the g++ linker
(/usr/libexec/gcc/i686-apple-darwin10/4.2.1/ld) supports shared libraries..=
.
yes
checking for g++ option to produce PIC... -fno-common -DPIC
checking if g++ PIC flag -fno-common -DPIC works... yes
checking if g++ static flag -static works... no
checking if g++ supports -c -o file.o... yes
checking if g++ supports -c -o file.o... (cached) yes
checking whether the g++ linker
(/usr/libexec/gcc/i686-apple-darwin10/4.2.1/ld) supports shared libraries..=
.
yes
checking dynamic linker characteristics... darwin10.2.0 dyld
checking how to hardcode library paths into programs... immediate
checking whether make sets $(MAKE)... (cached) yes
checking for pow in -lm... yes
checking for pthread_create in -lpthread... yes
checking for FCGX_Init in -lfcgi... yes
checking for XML_Parse in -lexpat... yes
checking for fuse_main in -lfuse... yes
checking jni.h usability... yes
checking jni.h presence... yes
checking for jni.h... yes
checking for dirent.h that defines DIR... yes
checking for library containing opendir... none required
checking for ANSI C header files... (cached) yes
checking for sys/wait.h that is POSIX.1 compatible... yes
checking boost/spirit.hpp usability... yes
checking boost/spirit.hpp presence... yes
checking for boost/spirit.hpp... yes
checking histedit.h usability... yes
checking histedit.h presence... yes
checking for histedit.h... yes
checking openssl/md5.h usability... yes
checking openssl/md5.h presence... yes
checking for openssl/md5.h... yes
checking sys/xattr.h usability... yes
checking sys/xattr.h presence... yes
checking for sys/xattr.h... yes
checking arpa/inet.h usability... yes
checking arpa/inet.h presence... yes
checking for arpa/inet.h... yes
checking netdb.h usability... yes
checking netdb.h presence... yes
checking for netdb.h... yes
checking netinet/in.h usability... yes
checking netinet/in.h presence... yes
checking for netinet/in.h... yes
checking sys/file.h usability... yes
checking sys/file.h presence... yes
checking for sys/file.h... yes
checking sys/ioctl.h usability... yes
checking sys/ioctl.h presence... yes
checking for sys/ioctl.h... yes
checking sys/mount.h usability... yes
checking sys/mount.h presence... yes
checking for sys/mount.h... yes
checking sys/param.h usability... yes
checking sys/param.h presence... yes
checking for sys/param.h... yes
checking sys/socket.h usability... yes
checking sys/socket.h presence... yes
checking for sys/socket.h... yes
checking sys/statvfs.h usability... yes
checking sys/statvfs.h presence... yes
checking for sys/statvfs.h... yes
checking sys/time.h usability... yes
checking sys/time.h presence... yes
checking for sys/time.h... yes
checking sys/vfs.h usability... no
checking sys/vfs.h presence... no
checking for sys/vfs.h... no
checking syslog.h usability... yes
checking syslog.h presence... yes
checking for syslog.h... yes
checking utime.h usability... yes
checking utime.h presence... yes
checking for utime.h... yes
configure: creating ./config.status
config.status: creating Makefile
config.status: creating src/Makefile
config.status: creating man/Makefile
config.status: creating ceph.spec
config.status: creating src/acconfig.h
config.status: src/acconfig.h is unchanged
config.status: executing depfiles commands
config.status: executing libtool commands
checking dependency style of gcc... (cached) gcc3
checking dependency style of g++... (cached) gcc3
Making all in src
g++ -I. -fPIC -shared -g -o libcls_crypto.so -lcrypto cls_crypto.cc
In file included from include/types.h:22,
                 from cls_crypto.cc:12:
include/byteorder.h:10:20: error: endian.h: No such file or directory
In file included from include/types.h:52,
                 from cls_crypto.cc:12:
include/assert.h:4:22: error: features.h: No such file or directory
include/assert.h:19:42: error: missing binary operator before token "("
include/assert.h:30:42: error: missing binary operator before token "("
In file included from include/atomic.h:43,
                 from include/buffer.h:56,
                 from include/cstring.h:12,
                 from include/nstring.h:8,
                 from include/object.h:29,
                 from include/types.h:53,
                 from cls_crypto.cc:12:
./common/Spinlock.h:31: error: =91pthread_spinlock_t=92 does not name a typ=
e
./common/Spinlock.h: In constructor =91Spinlock::Spinlock(const char*, bool=
,
bool)=92:
./common/Spinlock.h:61: error: =91_s=92 was not declared in this scope
./common/Spinlock.h:61: error: =91pthread_spin_init=92 was not declared in =
this
scope
./common/Spinlock.h: In destructor =91Spinlock::~Spinlock()=92:
./common/Spinlock.h:66: error: =91_s=92 was not declared in this scope
./common/Spinlock.h:66: error: =91pthread_spin_destroy=92 was not declared =
in
this scope
./common/Spinlock.h: In member function =91bool Spinlock::try_lock()=92:
./common/Spinlock.h:74: error: =91_s=92 was not declared in this scope
./common/Spinlock.h:74: error: =91pthread_spin_trylock=92 was not declared =
in
this scope
./common/Spinlock.h: In member function =91void Spinlock::lock()=92:
./common/Spinlock.h:84: error: =91_s=92 was not declared in this scope
./common/Spinlock.h:84: error: =91pthread_spin_lock=92 was not declared in =
this
scope
./common/Spinlock.h: In member function =91void Spinlock::unlock()=92:
./common/Spinlock.h:93: error: =91_s=92 was not declared in this scope
./common/Spinlock.h:93: error: =91pthread_spin_unlock=92 was not declared i=
n
this scope
make[1]: *** [libcls_crypto.so] Error 1
make: *** [all-recursive] Error 1
Making install in src
g++ -I. -fPIC -shared -g -o libcls_crypto.so -lcrypto cls_crypto.cc
In file included from include/types.h:22,
                 from cls_crypto.cc:12:
include/byteorder.h:10:20: error: endian.h: No such file or directory
In file included from include/types.h:52,
                 from cls_crypto.cc:12:
include/assert.h:4:22: error: features.h: No such file or directory
include/assert.h:19:42: error: missing binary operator before token "("
include/assert.h:30:42: error: missing binary operator before token "("
In file included from include/atomic.h:43,
                 from include/buffer.h:56,
                 from include/cstring.h:12,
                 from include/nstring.h:8,
                 from include/object.h:29,
                 from include/types.h:53,
                 from cls_crypto.cc:12:
./common/Spinlock.h:31: error: =91pthread_spinlock_t=92 does not name a typ=
e
./common/Spinlock.h: In constructor =91Spinlock::Spinlock(const char*, bool=
,
bool)=92:
./common/Spinlock.h:61: error: =91_s=92 was not declared in this scope
./common/Spinlock.h:61: error: =91pthread_spin_init=92 was not declared in =
this
scope
./common/Spinlock.h: In destructor =91Spinlock::~Spinlock()=92:
./common/Spinlock.h:66: error: =91_s=92 was not declared in this scope
./common/Spinlock.h:66: error: =91pthread_spin_destroy=92 was not declared =
in
this scope
./common/Spinlock.h: In member function =91bool Spinlock::try_lock()=92:
./common/Spinlock.h:74: error: =91_s=92 was not declared in this scope
./common/Spinlock.h:74: error: =91pthread_spin_trylock=92 was not declared =
in
this scope
./common/Spinlock.h: In member function =91void Spinlock::lock()=92:
./common/Spinlock.h:84: error: =91_s=92 was not declared in this scope
./common/Spinlock.h:84: error: =91pthread_spin_lock=92 was not declared in =
this
scope
./common/Spinlock.h: In member function =91void Spinlock::unlock()=92:
./common/Spinlock.h:93: error: =91_s=92 was not declared in this scope
./common/Spinlock.h:93: error: =91pthread_spin_unlock=92 was not declared i=
n
this scope
make[1]: *** [libcls_crypto.so] Error 1
make: *** [install-recursive] Error 1
bash-3.2$

--000e0cd6f1caa27b1c047e628834
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hey there=A0<div><div><br></div><div>Using latest git I launch following se=
quence to assemble ceph binaries:</div><div><br></div><div><div>export CPPF=
LAGS=3D&quot;-I/opt/local/src/boost/boost_1_41_0/build/include -I/System/Li=
brary/Frameworks/JavaVM.framework/Versions/1.6.0/Headers&quot;</div>
<div>./autogen.sh</div><div>./configure --prefix=3D/opt/src/local/ceph/trun=
k/build --with-fuse --with-hadoop</div><div>make</div><div>make install</di=
v><div><br></div><div>----------------</div><div><br></div><div>Received fo=
llowing series of compilation errors: (attaching entire make output) at the=
 end of this email</div>
<div><br></div><div>endian.h believe can be substituted in the Apple env, b=
ut Spinlock.h errors appear to be non-trivial porting issues</div><div>=A0<=
/div><div>(btw. goal is to evaluate ceph with hypertable and use Mac in non=
 production environment, was able to build hypertable on Mac OS X and run w=
ith no problems)</div>
<div><br></div><div><br></div><div>Thanks=A0</div><div><br></div><div><br><=
/div><div><br></div><div><div>bash-3.2$ sudo ./build.sh</div><div>libtooliz=
e: putting auxiliary files in `.&#39;.</div><div>libtoolize: copying file `=
./ltmain.sh&#39;</div>
<div>libtoolize: Consider adding `AC_CONFIG_MACRO_DIR([m4])&#39; to <a href=
=3D"http://configure.ac">configure.ac</a> and</div><div>libtoolize: rerunni=
ng libtoolize, to keep the correct libtool macros in-tree.</div><div>libtoo=
lize: Consider adding `-I m4&#39; to ACLOCAL_AMFLAGS in Makefile.am.</div>
<div>libtoolize: `AC_PROG_RANLIB&#39; is rendered obsolete by `LT_INIT&#39;=
</div><div>checking build system type... x86_64-apple-darwin10.2.0</div><di=
v>checking host system type... x86_64-apple-darwin10.2.0</div><div>checking=
 target system type... x86_64-apple-darwin10.2.0</div>
<div>checking for a BSD-compatible install... /opt/local/bin/ginstall -c</d=
iv><div>checking whether build environment is sane... yes</div><div>checkin=
g for a thread-safe mkdir -p... /opt/local/bin/gmkdir -p</div><div>checking=
 for gawk... no</div>
<div>checking for mawk... no</div><div>checking for nawk... no</div><div>ch=
ecking for awk... awk</div><div>checking whether make sets $(MAKE)... yes</=
div><div>checking for style of include used by make... GNU</div><div>checki=
ng for gcc... gcc</div>
<div>checking whether the C compiler works... yes</div><div>checking for C =
compiler default output file name... a.out</div><div>checking for suffix of=
 executables...=A0</div><div>checking whether we are cross compiling... no<=
/div>
<div>checking for suffix of object files... o</div><div>checking whether we=
 are using the GNU C compiler... yes</div><div>checking whether gcc accepts=
 -g... yes</div><div>checking for gcc option to accept ISO C89... none need=
ed</div>
<div>checking dependency style of gcc... gcc3</div><div>checking whether gc=
c and cc understand -c and -o together... yes</div><div>checking for a sed =
that does not truncate output... /usr/bin/sed</div><div>checking for grep t=
hat handles long lines and -e... /usr/bin/grep</div>
<div>checking for egrep... /usr/bin/grep -E</div><div>checking for fgrep...=
 /usr/bin/grep -F</div><div>checking for ld used by gcc... /usr/libexec/gcc=
/i686-apple-darwin10/4.2.1/ld</div><div>checking if the linker (/usr/libexe=
c/gcc/i686-apple-darwin10/4.2.1/ld) is GNU ld... no</div>
<div>checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm</di=
v><div>checking the name lister (/usr/bin/nm) interface... BSD nm</div><div=
>checking whether ln -s works... yes</div><div>checking the maximum length =
of command line arguments... 196608</div>
<div>checking whether the shell understands some XSI constructs... yes</div=
><div>checking whether the shell understands &quot;+=3D&quot;... yes</div><=
div>checking for /usr/libexec/gcc/i686-apple-darwin10/4.2.1/ld option to re=
load object files... -r</div>
<div>checking for objdump... no</div><div>checking how to recognize depende=
nt libraries... pass_all</div><div>checking for ar... ar</div><div>checking=
 for strip... strip</div><div>checking for ranlib... ranlib</div><div>check=
ing command to parse /usr/bin/nm output from gcc object... ok</div>
<div>checking for dsymutil... dsymutil</div><div>checking for nmedit... nme=
dit</div><div>checking for lipo... lipo</div><div>checking for otool... oto=
ol</div><div>checking for otool64... no</div><div>checking for -single_modu=
le linker flag... yes</div>
<div>checking for -exported_symbols_list linker flag... yes</div><div>check=
ing how to run the C preprocessor... gcc -E</div><div>checking for ANSI C h=
eader files... yes</div><div>checking for sys/types.h... yes</div><div>
checking for sys/stat.h... yes</div><div>checking for stdlib.h... yes</div>=
<div>checking for string.h... yes</div><div>checking for memory.h... yes</d=
iv><div>checking for strings.h... yes</div><div>checking for inttypes.h... =
yes</div>
<div>checking for stdint.h... yes</div><div>checking for unistd.h... yes</d=
iv><div>checking for dlfcn.h... yes</div><div>checking for objdir... .libs<=
/div><div>checking if gcc supports -fno-rtti -fno-exceptions... no</div>
<div>checking for gcc option to produce PIC... -fno-common -DPIC</div><div>=
checking if gcc PIC flag -fno-common -DPIC works... yes</div><div>checking =
if gcc static flag -static works... no</div><div>checking if gcc supports -=
c -o file.o... yes</div>
<div>checking if gcc supports -c -o file.o... (cached) yes</div><div>checki=
ng whether the gcc linker (/usr/libexec/gcc/i686-apple-darwin10/4.2.1/ld) s=
upports shared libraries... yes</div><div>checking dynamic linker character=
istics... darwin10.2.0 dyld</div>
<div>checking how to hardcode library paths into programs... immediate</div=
><div>checking whether stripping libraries is possible... yes</div><div>che=
cking if libtool supports shared libraries... yes</div><div>checking whethe=
r to build shared libraries... yes</div>
<div>checking whether to build static libraries... yes</div><div>checking f=
or g++... g++</div><div>checking whether we are using the GNU C++ compiler.=
.. yes</div><div>checking whether g++ accepts -g... yes</div><div>checking =
dependency style of g++... gcc3</div>
<div>checking whether we are using the GNU C++ compiler... (cached) yes</di=
v><div>checking whether g++ accepts -g... (cached) yes</div><div>checking d=
ependency style of g++... (cached) gcc3</div><div>checking how to run the C=
++ preprocessor... g++ -E</div>
<div>checking for ld used by g++... /usr/libexec/gcc/i686-apple-darwin10/4.=
2.1/ld</div><div>checking if the linker (/usr/libexec/gcc/i686-apple-darwin=
10/4.2.1/ld) is GNU ld... no</div><div>checking whether the g++ linker (/us=
r/libexec/gcc/i686-apple-darwin10/4.2.1/ld) supports shared libraries... ye=
s</div>
<div>checking for g++ option to produce PIC... -fno-common -DPIC</div><div>=
checking if g++ PIC flag -fno-common -DPIC works... yes</div><div>checking =
if g++ static flag -static works... no</div><div>checking if g++ supports -=
c -o file.o... yes</div>
<div>checking if g++ supports -c -o file.o... (cached) yes</div><div>checki=
ng whether the g++ linker (/usr/libexec/gcc/i686-apple-darwin10/4.2.1/ld) s=
upports shared libraries... yes</div><div>checking dynamic linker character=
istics... darwin10.2.0 dyld</div>
<div>checking how to hardcode library paths into programs... immediate</div=
><div>checking whether make sets $(MAKE)... (cached) yes</div><div>checking=
 for pow in -lm... yes</div><div>checking for pthread_create in -lpthread..=
. yes</div>
<div>checking for FCGX_Init in -lfcgi... yes</div><div>checking for XML_Par=
se in -lexpat... yes</div><div>checking for fuse_main in -lfuse... yes</div=
><div>checking jni.h usability... yes</div><div>checking jni.h presence... =
yes</div>
<div>checking for jni.h... yes</div><div>checking for dirent.h that defines=
 DIR... yes</div><div>checking for library containing opendir... none requi=
red</div><div>checking for ANSI C header files... (cached) yes</div><div>
checking for sys/wait.h that is POSIX.1 compatible... yes</div><div>checkin=
g boost/spirit.hpp usability... yes</div><div>checking boost/spirit.hpp pre=
sence... yes</div><div>checking for boost/spirit.hpp... yes</div><div>check=
ing histedit.h usability... yes</div>
<div>checking histedit.h presence... yes</div><div>checking for histedit.h.=
.. yes</div><div>checking openssl/md5.h usability... yes</div><div>checking=
 openssl/md5.h presence... yes</div><div>checking for openssl/md5.h... yes<=
/div>
<div>checking sys/xattr.h usability... yes</div><div>checking sys/xattr.h p=
resence... yes</div><div>checking for sys/xattr.h... yes</div><div>checking=
 arpa/inet.h usability... yes</div><div>checking arpa/inet.h presence... ye=
s</div>
<div>checking for arpa/inet.h... yes</div><div>checking netdb.h usability..=
. yes</div><div>checking netdb.h presence... yes</div><div>checking for net=
db.h... yes</div><div>checking netinet/in.h usability... yes</div><div>
checking netinet/in.h presence... yes</div><div>checking for netinet/in.h..=
. yes</div><div>checking sys/file.h usability... yes</div><div>checking sys=
/file.h presence... yes</div><div>checking for sys/file.h... yes</div><div>
checking sys/ioctl.h usability... yes</div><div>checking sys/ioctl.h presen=
ce... yes</div><div>checking for sys/ioctl.h... yes</div><div>checking sys/=
mount.h usability... yes</div><div>checking sys/mount.h presence... yes</di=
v>
<div>checking for sys/mount.h... yes</div><div>checking sys/param.h usabili=
ty... yes</div><div>checking sys/param.h presence... yes</div><div>checking=
 for sys/param.h... yes</div><div>checking sys/socket.h usability... yes</d=
iv>
<div>checking sys/socket.h presence... yes</div><div>checking for sys/socke=
t.h... yes</div><div>checking sys/statvfs.h usability... yes</div><div>chec=
king sys/statvfs.h presence... yes</div><div>checking for sys/statvfs.h... =
yes</div>
<div>checking sys/time.h usability... yes</div><div>checking sys/time.h pre=
sence... yes</div><div>checking for sys/time.h... yes</div><div>checking sy=
s/vfs.h usability... no</div><div>checking sys/vfs.h presence... no</div>
<div>checking for sys/vfs.h... no</div><div>checking syslog.h usability... =
yes</div><div>checking syslog.h presence... yes</div><div>checking for sysl=
og.h... yes</div><div>checking utime.h usability... yes</div><div>checking =
utime.h presence... yes</div>
<div>checking for utime.h... yes</div><div>configure: creating ./config.sta=
tus</div><div>config.status: creating Makefile</div><div>config.status: cre=
ating src/Makefile</div><div>config.status: creating man/Makefile</div>
<div>config.status: creating ceph.spec</div><div>config.status: creating sr=
c/acconfig.h</div><div>config.status: src/acconfig.h is unchanged</div><div=
>config.status: executing depfiles commands</div><div>config.status: execut=
ing libtool commands</div>
<div>checking dependency style of gcc... (cached) gcc3</div><div>checking d=
ependency style of g++... (cached) gcc3</div><div>Making all in src</div><d=
iv>g++ -I. -fPIC -shared -g -o libcls_crypto.so -lcrypto cls_crypto.cc</div=
>
<div>In file included from include/types.h:22,</div><div>=A0=A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 from cls_crypto.cc:12:</div><div>include/byteorder.h:10:20=
: error: endian.h: No such file or directory</div><div>In file included fro=
m include/types.h:52,</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from cls_crypto.cc:12:</div><div>in=
clude/assert.h:4:22: error: features.h: No such file or directory</div><div=
>include/assert.h:19:42: error: missing binary operator before token &quot;=
(&quot;</div><div>
include/assert.h:30:42: error: missing binary operator before token &quot;(=
&quot;</div><div>In file included from include/atomic.h:43,</div><div>=A0=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/buffer.h:56,</div><div>=A0=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/cstring.h:12,</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/nstring.h:8,</div><div=
>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/object.h:29,</div><div>=A0=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/types.h:53,</div><div>=A0=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 from cls_crypto.cc:12:</div><div>./common/Spinl=
ock.h:31: error: =91pthread_spinlock_t=92 does not name a type</div>
<div>./common/Spinlock.h: In constructor =91Spinlock::Spinlock(const char*,=
 bool, bool)=92:</div><div>./common/Spinlock.h:61: error: =91_s=92 was not =
declared in this scope</div><div>./common/Spinlock.h:61: error: =91pthread_=
spin_init=92 was not declared in this scope</div>
<div>./common/Spinlock.h: In destructor =91Spinlock::~Spinlock()=92:</div><=
div>./common/Spinlock.h:66: error: =91_s=92 was not declared in this scope<=
/div><div>./common/Spinlock.h:66: error: =91pthread_spin_destroy=92 was not=
 declared in this scope</div>
<div>./common/Spinlock.h: In member function =91bool Spinlock::try_lock()=
=92:</div><div>./common/Spinlock.h:74: error: =91_s=92 was not declared in =
this scope</div><div>./common/Spinlock.h:74: error: =91pthread_spin_trylock=
=92 was not declared in this scope</div>
<div>./common/Spinlock.h: In member function =91void Spinlock::lock()=92:</=
div><div>./common/Spinlock.h:84: error: =91_s=92 was not declared in this s=
cope</div><div>./common/Spinlock.h:84: error: =91pthread_spin_lock=92 was n=
ot declared in this scope</div>
<div>./common/Spinlock.h: In member function =91void Spinlock::unlock()=92:=
</div><div>./common/Spinlock.h:93: error: =91_s=92 was not declared in this=
 scope</div><div>./common/Spinlock.h:93: error: =91pthread_spin_unlock=92 w=
as not declared in this scope</div>
<div>make[1]: *** [libcls_crypto.so] Error 1</div><div>make: *** [all-recur=
sive] Error 1</div><div>Making install in src</div><div>g++ -I. -fPIC -shar=
ed -g -o libcls_crypto.so -lcrypto cls_crypto.cc</div><div>In file included=
 from include/types.h:22,</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from cls_crypto.cc:12:</div><div>in=
clude/byteorder.h:10:20: error: endian.h: No such file or directory</div><d=
iv>In file included from include/types.h:52,</div><div>=A0=A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 from cls_crypto.cc:12:</div>
<div>include/assert.h:4:22: error: features.h: No such file or directory</d=
iv><div>include/assert.h:19:42: error: missing binary operator before token=
 &quot;(&quot;</div><div>include/assert.h:30:42: error: missing binary oper=
ator before token &quot;(&quot;</div>
<div>In file included from include/atomic.h:43,</div><div>=A0=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 from include/buffer.h:56,</div><div>=A0=A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 from include/cstring.h:12,</div><div>=A0=A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 from include/nstring.h:8,</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 from include/object.h:29,</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/types.h:53,</div><div>=
=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from cls_crypto.cc:12:</div><div>./commo=
n/Spinlock.h:31: error: =91pthread_spinlock_t=92 does not name a type</div>=
<div>./common/Spinlock.h: In constructor =91Spinlock::Spinlock(const char*,=
 bool, bool)=92:</div>
<div>./common/Spinlock.h:61: error: =91_s=92 was not declared in this scope=
</div><div>./common/Spinlock.h:61: error: =91pthread_spin_init=92 was not d=
eclared in this scope</div><div>./common/Spinlock.h: In destructor =91Spinl=
ock::~Spinlock()=92:</div>
<div>./common/Spinlock.h:66: error: =91_s=92 was not declared in this scope=
</div><div>./common/Spinlock.h:66: error: =91pthread_spin_destroy=92 was no=
t declared in this scope</div><div>./common/Spinlock.h: In member function =
=91bool Spinlock::try_lock()=92:</div>
<div>./common/Spinlock.h:74: error: =91_s=92 was not declared in this scope=
</div><div>./common/Spinlock.h:74: error: =91pthread_spin_trylock=92 was no=
t declared in this scope</div><div>./common/Spinlock.h: In member function =
=91void Spinlock::lock()=92:</div>
<div>./common/Spinlock.h:84: error: =91_s=92 was not declared in this scope=
</div><div>./common/Spinlock.h:84: error: =91pthread_spin_lock=92 was not d=
eclared in this scope</div><div>./common/Spinlock.h: In member function =91=
void Spinlock::unlock()=92:</div>
<div>./common/Spinlock.h:93: error: =91_s=92 was not declared in this scope=
</div><div>./common/Spinlock.h:93: error: =91pthread_spin_unlock=92 was not=
 declared in this scope</div><div>make[1]: *** [libcls_crypto.so] Error 1</=
div>
<div>make: *** [install-recursive] Error 1</div><div>bash-3.2$=A0</div><div=
><br></div></div><div>=A0=A0 =A0 =A0 =A0 =A0=A0</div><div><br></div></div><=
div><br></div></div>

--000e0cd6f1caa27b1c047e628834--


--===============0823449062051206747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
--===============0823449062051206747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============0823449062051206747==--
