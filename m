From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Compile errors on Mac OS X
Date: Tue, 2 Feb 2010 00:35:19 -0800
Message-ID: <a37615151002020035l1d5e9e54u93bc67437a61a116@mail.gmail.com>
References: <82d7a2d21001300626k4d9efc6el6dd162f19b4110e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <82d7a2d21001300626k4d9efc6el6dd162f19b4110e6@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Andrew Milkowski <andrewmilkowski@gmail.com>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Yeah, there's some work to be done in order to get it compiling an
running on OS X. Specifically there is currently a coupling between
the osds and btrfs. However, we're working on removing this
dependency, so that will be solved in the (hopefully) near future.
As for the pthread spinlocks, I guess this mechanism could be replaced
with pthread mutexes at the cost of performance. The simplest would be
to replace all pthread_spinlock_* with pthread_mutex_* in
common/Spinlock.h and see how it compiles. Something along the line
of:

diff --git a/src/common/Spinlock.h b/src/common/Spinlock.h
index 95598a3..0fc6fb7 100644
--- a/src/common/Spinlock.h
+++ b/src/common/Spinlock.h
@@ -28,7 +28,7 @@ private:
   bool lockdep;
   bool backtrace;  // gather backtrace on lock acquisition

-  pthread_spinlock_t _s;
+  pthread_mutex_t _s;
   int nlock;

   // don't allow copying.
@@ -58,12 +58,12 @@ private:
 public:
   Spinlock(const char *n, bool ld=3Dtrue, bool bt=3Dfalse) :
     name(n), id(-1), lockdep(ld), backtrace(bt), nlock(0) {
-    pthread_spin_init(&_s, 0);
+    pthread_mutex_init(&_s, 0);
     if (lockdep && g_lockdep) _register();
   }
   ~Spinlock() {
     assert(nlock =3D=3D 0);
-    pthread_spin_destroy(&_s);
+    pthread_mutex_destroy(&_s);
   }

   bool is_locked() {
...

Another way would be to just replace the use of Spinlock with Mutex at
the caller, and probably have it automatically configurable, depending
on the build target.

Yehuda

On Sat, Jan 30, 2010 at 6:26 AM, Andrew Milkowski
<andrewmilkowski@gmail.com> wrote:
>
> Hey there
> Using latest git I launch following sequence to assemble ceph binaries:
> export CPPFLAGS=3D"-I/opt/local/src/boost/boost_1_41_0/build/include -I/S=
ystem/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Headers"
> ./autogen.sh
> ./configure --prefix=3D/opt/src/local/ceph/trunk/build --with-fuse --with=
-hadoop
> make
> make install
> ----------------
> Received following series of compilation errors: (attaching entire make o=
utput) at the end of this email
> endian.h believe can be substituted in the Apple env, but Spinlock.h erro=
rs appear to be non-trivial porting issues
>
> (btw. goal is to evaluate ceph with hypertable and use Mac in non product=
ion environment, was able to build hypertable on Mac OS X and run with no p=
roblems)
>
> Thanks
>
>
> bash-3.2$ sudo ./build.sh
> libtoolize: putting auxiliary files in `.'.
> libtoolize: copying file `./ltmain.sh'
> libtoolize: Consider adding `AC_CONFIG_MACRO_DIR([m4])' to configure.ac a=
nd
> libtoolize: rerunning libtoolize, to keep the correct libtool macros in-t=
ree.
> libtoolize: Consider adding `-I m4' to ACLOCAL_AMFLAGS in Makefile.am.
> libtoolize: `AC_PROG_RANLIB' is rendered obsolete by `LT_INIT'
> checking build system type... x86_64-apple-darwin10.2.0
> checking host system type... x86_64-apple-darwin10.2.0
> checking target system type... x86_64-apple-darwin10.2.0
> checking for a BSD-compatible install... /opt/local/bin/ginstall -c
> checking whether build environment is sane... yes
> checking for a thread-safe mkdir -p... /opt/local/bin/gmkdir -p
> checking for gawk... no
> checking for mawk... no
> checking for nawk... no
> checking for awk... awk
> checking whether make sets $(MAKE)... yes
> checking for style of include used by make... GNU
> checking for gcc... gcc
> checking whether the C compiler works... yes
> checking for C compiler default output file name... a.out
> checking for suffix of executables...
> checking whether we are cross compiling... no
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether gcc accepts -g... yes
> checking for gcc option to accept ISO C89... none needed
> checking dependency style of gcc... gcc3
> checking whether gcc and cc understand -c and -o together... yes
> checking for a sed that does not truncate output... /usr/bin/sed
> checking for grep that handles long lines and -e... /usr/bin/grep
> checking for egrep... /usr/bin/grep -E
> checking for fgrep... /usr/bin/grep -F
> checking for ld used by gcc... /usr/libexec/gcc/i686-apple-darwin10/4.2.1=
/ld
> checking if the linker (/usr/libexec/gcc/i686-apple-darwin10/4.2.1/ld) is=
 GNU ld... no
> checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm
> checking the name lister (/usr/bin/nm) interface... BSD nm
> checking whether ln -s works... yes
> checking the maximum length of command line arguments... 196608
> checking whether the shell understands some XSI constructs... yes
> checking whether the shell understands "+=3D"... yes
> checking for /usr/libexec/gcc/i686-apple-darwin10/4.2.1/ld option to relo=
ad object files... -r
> checking for objdump... no
> checking how to recognize dependent libraries... pass_all
> checking for ar... ar
> checking for strip... strip
> checking for ranlib... ranlib
> checking command to parse /usr/bin/nm output from gcc object... ok
> checking for dsymutil... dsymutil
> checking for nmedit... nmedit
> checking for lipo... lipo
> checking for otool... otool
> checking for otool64... no
> checking for -single_module linker flag... yes
> checking for -exported_symbols_list linker flag... yes
> checking how to run the C preprocessor... gcc -E
> checking for ANSI C header files... yes
> checking for sys/types.h... yes
> checking for sys/stat.h... yes
> checking for stdlib.h... yes
> checking for string.h... yes
> checking for memory.h... yes
> checking for strings.h... yes
> checking for inttypes.h... yes
> checking for stdint.h... yes
> checking for unistd.h... yes
> checking for dlfcn.h... yes
> checking for objdir... .libs
> checking if gcc supports -fno-rtti -fno-exceptions... no
> checking for gcc option to produce PIC... -fno-common -DPIC
> checking if gcc PIC flag -fno-common -DPIC works... yes
> checking if gcc static flag -static works... no
> checking if gcc supports -c -o file.o... yes
> checking if gcc supports -c -o file.o... (cached) yes
> checking whether the gcc linker (/usr/libexec/gcc/i686-apple-darwin10/4.2=
.1/ld) supports shared libraries... yes
> checking dynamic linker characteristics... darwin10.2.0 dyld
> checking how to hardcode library paths into programs... immediate
> checking whether stripping libraries is possible... yes
> checking if libtool supports shared libraries... yes
> checking whether to build shared libraries... yes
> checking whether to build static libraries... yes
> checking for g++... g++
> checking whether we are using the GNU C++ compiler... yes
> checking whether g++ accepts -g... yes
> checking dependency style of g++... gcc3
> checking whether we are using the GNU C++ compiler... (cached) yes
> checking whether g++ accepts -g... (cached) yes
> checking dependency style of g++... (cached) gcc3
> checking how to run the C++ preprocessor... g++ -E
> checking for ld used by g++... /usr/libexec/gcc/i686-apple-darwin10/4.2.1=
/ld
> checking if the linker (/usr/libexec/gcc/i686-apple-darwin10/4.2.1/ld) is=
 GNU ld... no
> checking whether the g++ linker (/usr/libexec/gcc/i686-apple-darwin10/4.2=
.1/ld) supports shared libraries... yes
> checking for g++ option to produce PIC... -fno-common -DPIC
> checking if g++ PIC flag -fno-common -DPIC works... yes
> checking if g++ static flag -static works... no
> checking if g++ supports -c -o file.o... yes
> checking if g++ supports -c -o file.o... (cached) yes
> checking whether the g++ linker (/usr/libexec/gcc/i686-apple-darwin10/4.2=
.1/ld) supports shared libraries... yes
> checking dynamic linker characteristics... darwin10.2.0 dyld
> checking how to hardcode library paths into programs... immediate
> checking whether make sets $(MAKE)... (cached) yes
> checking for pow in -lm... yes
> checking for pthread_create in -lpthread... yes
> checking for FCGX_Init in -lfcgi... yes
> checking for XML_Parse in -lexpat... yes
> checking for fuse_main in -lfuse... yes
> checking jni.h usability... yes
> checking jni.h presence... yes
> checking for jni.h... yes
> checking for dirent.h that defines DIR... yes
> checking for library containing opendir... none required
> checking for ANSI C header files... (cached) yes
> checking for sys/wait.h that is POSIX.1 compatible... yes
> checking boost/spirit.hpp usability... yes
> checking boost/spirit.hpp presence... yes
> checking for boost/spirit.hpp... yes
> checking histedit.h usability... yes
> checking histedit.h presence... yes
> checking for histedit.h... yes
> checking openssl/md5.h usability... yes
> checking openssl/md5.h presence... yes
> checking for openssl/md5.h... yes
> checking sys/xattr.h usability... yes
> checking sys/xattr.h presence... yes
> checking for sys/xattr.h... yes
> checking arpa/inet.h usability... yes
> checking arpa/inet.h presence... yes
> checking for arpa/inet.h... yes
> checking netdb.h usability... yes
> checking netdb.h presence... yes
> checking for netdb.h... yes
> checking netinet/in.h usability... yes
> checking netinet/in.h presence... yes
> checking for netinet/in.h... yes
> checking sys/file.h usability... yes
> checking sys/file.h presence... yes
> checking for sys/file.h... yes
> checking sys/ioctl.h usability... yes
> checking sys/ioctl.h presence... yes
> checking for sys/ioctl.h... yes
> checking sys/mount.h usability... yes
> checking sys/mount.h presence... yes
> checking for sys/mount.h... yes
> checking sys/param.h usability... yes
> checking sys/param.h presence... yes
> checking for sys/param.h... yes
> checking sys/socket.h usability... yes
> checking sys/socket.h presence... yes
> checking for sys/socket.h... yes
> checking sys/statvfs.h usability... yes
> checking sys/statvfs.h presence... yes
> checking for sys/statvfs.h... yes
> checking sys/time.h usability... yes
> checking sys/time.h presence... yes
> checking for sys/time.h... yes
> checking sys/vfs.h usability... no
> checking sys/vfs.h presence... no
> checking for sys/vfs.h... no
> checking syslog.h usability... yes
> checking syslog.h presence... yes
> checking for syslog.h... yes
> checking utime.h usability... yes
> checking utime.h presence... yes
> checking for utime.h... yes
> configure: creating ./config.status
> config.status: creating Makefile
> config.status: creating src/Makefile
> config.status: creating man/Makefile
> config.status: creating ceph.spec
> config.status: creating src/acconfig.h
> config.status: src/acconfig.h is unchanged
> config.status: executing depfiles commands
> config.status: executing libtool commands
> checking dependency style of gcc... (cached) gcc3
> checking dependency style of g++... (cached) gcc3
> Making all in src
> g++ -I. -fPIC -shared -g -o libcls_crypto.so -lcrypto cls_crypto.cc
> In file included from include/types.h:22,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from cls_crypto.cc:12:
> include/byteorder.h:10:20: error: endian.h: No such file or directory
> In file included from include/types.h:52,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from cls_crypto.cc:12:
> include/assert.h:4:22: error: features.h: No such file or directory
> include/assert.h:19:42: error: missing binary operator before token "("
> include/assert.h:30:42: error: missing binary operator before token "("
> In file included from include/atomic.h:43,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/buffer.h:56,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/cstring.h:12,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/nstring.h:8,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/object.h:29,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/types.h:53,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from cls_crypto.cc:12:
> ./common/Spinlock.h:31: error: =91pthread_spinlock_t=92 does not name a t=
ype
> ./common/Spinlock.h: In constructor =91Spinlock::Spinlock(const char*, bo=
ol, bool)=92:
> ./common/Spinlock.h:61: error: =91_s=92 was not declared in this scope
> ./common/Spinlock.h:61: error: =91pthread_spin_init=92 was not declared i=
n this scope
> ./common/Spinlock.h: In destructor =91Spinlock::~Spinlock()=92:
> ./common/Spinlock.h:66: error: =91_s=92 was not declared in this scope
> ./common/Spinlock.h:66: error: =91pthread_spin_destroy=92 was not declare=
d in this scope
> ./common/Spinlock.h: In member function =91bool Spinlock::try_lock()=92:
> ./common/Spinlock.h:74: error: =91_s=92 was not declared in this scope
> ./common/Spinlock.h:74: error: =91pthread_spin_trylock=92 was not declare=
d in this scope
> ./common/Spinlock.h: In member function =91void Spinlock::lock()=92:
> ./common/Spinlock.h:84: error: =91_s=92 was not declared in this scope
> ./common/Spinlock.h:84: error: =91pthread_spin_lock=92 was not declared i=
n this scope
> ./common/Spinlock.h: In member function =91void Spinlock::unlock()=92:
> ./common/Spinlock.h:93: error: =91_s=92 was not declared in this scope
> ./common/Spinlock.h:93: error: =91pthread_spin_unlock=92 was not declared=
 in this scope
> make[1]: *** [libcls_crypto.so] Error 1
> make: *** [all-recursive] Error 1
> Making install in src
> g++ -I. -fPIC -shared -g -o libcls_crypto.so -lcrypto cls_crypto.cc
> In file included from include/types.h:22,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from cls_crypto.cc:12:
> include/byteorder.h:10:20: error: endian.h: No such file or directory
> In file included from include/types.h:52,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from cls_crypto.cc:12:
> include/assert.h:4:22: error: features.h: No such file or directory
> include/assert.h:19:42: error: missing binary operator before token "("
> include/assert.h:30:42: error: missing binary operator before token "("
> In file included from include/atomic.h:43,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/buffer.h:56,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/cstring.h:12,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/nstring.h:8,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/object.h:29,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/types.h:53,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from cls_crypto.cc:12:
> ./common/Spinlock.h:31: error: =91pthread_spinlock_t=92 does not name a t=
ype
> ./common/Spinlock.h: In constructor =91Spinlock::Spinlock(const char*, bo=
ol, bool)=92:
> ./common/Spinlock.h:61: error: =91_s=92 was not declared in this scope
> ./common/Spinlock.h:61: error: =91pthread_spin_init=92 was not declared i=
n this scope
> ./common/Spinlock.h: In destructor =91Spinlock::~Spinlock()=92:
> ./common/Spinlock.h:66: error: =91_s=92 was not declared in this scope
> ./common/Spinlock.h:66: error: =91pthread_spin_destroy=92 was not declare=
d in this scope
> ./common/Spinlock.h: In member function =91bool Spinlock::try_lock()=92:
> ./common/Spinlock.h:74: error: =91_s=92 was not declared in this scope
> ./common/Spinlock.h:74: error: =91pthread_spin_trylock=92 was not declare=
d in this scope
> ./common/Spinlock.h: In member function =91void Spinlock::lock()=92:
> ./common/Spinlock.h:84: error: =91_s=92 was not declared in this scope
> ./common/Spinlock.h:84: error: =91pthread_spin_lock=92 was not declared i=
n this scope
> ./common/Spinlock.h: In member function =91void Spinlock::unlock()=92:
> ./common/Spinlock.h:93: error: =91_s=92 was not declared in this scope
> ./common/Spinlock.h:93: error: =91pthread_spin_unlock=92 was not declared=
 in this scope
> make[1]: *** [libcls_crypto.so] Error 1
> make: *** [install-recursive] Error 1
> bash-3.2$
>
>
>
> -------------------------------------------------------------------------=
-----
> The Planet: dedicated and managed hosting, cloud storage, colocation
> Stay online with enterprise data centers and the best network in the busi=
ness
> Choose flexible plans and management services without long-term contracts
> Personal 24x7 support from experience hosting pros just a phone call away.
> http://p.sf.net/sfu/theplanet-com
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel
>

---------------------------------------------------------------------------=
---
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the busine=
ss
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
