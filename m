From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 1/2] rbd: use the higher level librbd instead of just
 librados
Date: Fri, 8 Apr 2011 09:43:34 +0100
Message-ID: <20110408084334.GA28360@stefanha-thinkpad.localdomain>
References: <6f9466b6098b5159aca9c789f9fce45f409e684f.1301354138.git.josh.durgin@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6f9466b6098b5159aca9c789f9fce45f409e684f.1301354138.git.josh.durgin@dreamhost.com>
Sender: kvm-owner@vger.kernel.org
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@hq.newdream.net>
List-Id: ceph-devel.vger.kernel.org

On Mon, Mar 28, 2011 at 04:15:57PM -0700, Josh Durgin wrote:
> librbd stacks on top of librados to provide access
> to rbd images.
> 
> Using librbd simplifies the qemu code, and allows
> qemu to use new versions of the rbd format
> with few (if any) changes.
> 
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> Signed-off-by: Yehuda Sadeh <yehuda@hq.newdream.net>
> ---
>  block/rbd.c       |  785 +++++++++++++++--------------------------------------
>  block/rbd_types.h |   71 -----
>  configure         |   33 +--
>  3 files changed, 221 insertions(+), 668 deletions(-)
>  delete mode 100644 block/rbd_types.h

Hi Josh,
I have applied your patches onto qemu.git/master and am running
ceph.git/master.

Unfortunately qemu-iotests fails for me.


Test 016 seems to hang in qemu-io -g -c write -P 66 128M 512
rbd:rbd/t.raw.  I can reproduce this consistently.  Here is the
backtrace of the hung process (not consuming CPU, probably deadlocked):

Thread 9 (Thread 0x7f9ded6d6700 (LWP 26049)):
#0  0x00007f9def41d16c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#1  0x00007f9dee676d9a in Wait (this=0x2723950) at ./common/Cond.h:46
#2  SimpleMessenger::dispatch_entry (this=0x2723950) at msg/SimpleMessenger.cc:362
#3  0x00007f9dee66180c in SimpleMessenger::DispatchThread::entry (this=<value optimized out>) at msg/SimpleMessenger.h:533
#4  0x00007f9def4188ba in start_thread () from /lib/libpthread.so.0
#5  0x00007f9dee14d02d in clone () from /lib/libc.so.6
#6  0x0000000000000000 in ?? ()

Thread 8 (Thread 0x7f9deced5700 (LWP 26050)):
#0  0x00007f9def41d16c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#1  0x00007f9dee674fab in Wait (this=0x2723950) at ./common/Cond.h:46
#2  SimpleMessenger::reaper_entry (this=0x2723950) at msg/SimpleMessenger.cc:2251
#3  0x00007f9dee6617ac in SimpleMessenger::ReaperThread::entry (this=0x2723d80) at msg/SimpleMessenger.h:485
#4  0x00007f9def4188ba in start_thread () from /lib/libpthread.so.0
#5  0x00007f9dee14d02d in clone () from /lib/libc.so.6
#6  0x0000000000000000 in ?? ()

Thread 7 (Thread 0x7f9dec6d4700 (LWP 26051)):
#0  0x00007f9def41d4d9 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#1  0x00007f9dee72187a in WaitUntil (this=0x2722c00) at common/Cond.h:60
#2  SafeTimer::timer_thread (this=0x2722c00) at common/Timer.cc:110
#3  0x00007f9dee722d7d in SafeTimerThread::entry (this=<value optimized out>) at common/Timer.cc:38
#4  0x00007f9def4188ba in start_thread () from /lib/libpthread.so.0
#5  0x00007f9dee14d02d in clone () from /lib/libc.so.6
#6  0x0000000000000000 in ?? ()

Thread 6 (Thread 0x7f9df07ea700 (LWP 26052)):
#0  0x00007f9def41d16c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#1  0x00007f9dee67cae1 in Wait (this=0x2729890) at ./common/Cond.h:46
#2  SimpleMessenger::Pipe::writer (this=0x2729890) at msg/SimpleMessenger.cc:1746
#3  0x00007f9dee66187d in SimpleMessenger::Pipe::Writer::entry (this=<value optimized out>) at msg/SimpleMessenger.h:204
#4  0x00007f9def4188ba in start_thread () from /lib/libpthread.so.0
#5  0x00007f9dee14d02d in clone () from /lib/libc.so.6
#6  0x0000000000000000 in ?? ()

Thread 5 (Thread 0x7f9debed3700 (LWP 26055)):
#0  0x00007f9dee142113 in poll () from /lib/libc.so.6
#1  0x00007f9dee66d599 in tcp_read_wait (sd=<value optimized out>, timeout=<value optimized out>) at msg/tcp.cc:48
#2  0x00007f9dee66e89b in tcp_read (sd=3, buf=<value optimized out>, len=1, timeout=900000) at msg/tcp.cc:25
#3  0x00007f9dee67ffd2 in SimpleMessenger::Pipe::reader (this=0x2729890) at msg/SimpleMessenger.cc:1539
#4  0x00007f9dee66185d in SimpleMessenger::Pipe::Reader::entry (this=<value optimized out>) at msg/SimpleMessenger.h:196
#5  0x00007f9def4188ba in start_thread () from /lib/libpthread.so.0
#6  0x00007f9dee14d02d in clone () from /lib/libc.so.6
#7  0x0000000000000000 in ?? ()

Thread 4 (Thread 0x7f9debdd2700 (LWP 26056)):
#0  0x00007f9def41d4d9 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#1  0x00007f9dee72187a in WaitUntil (this=0x2722e58) at common/Cond.h:60
#2  SafeTimer::timer_thread (this=0x2722e58) at common/Timer.cc:110
#3  0x00007f9dee722d7d in SafeTimerThread::entry (this=<value optimized out>) at common/Timer.cc:38
#4  0x00007f9def4188ba in start_thread () from /lib/libpthread.so.0
#5  0x00007f9dee14d02d in clone () from /lib/libc.so.6
#6  0x0000000000000000 in ?? ()

Thread 3 (Thread 0x7f9deb2ce700 (LWP 26306)):
#0  0x00007f9def41d16c in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#1  0x00007f9dee67cae1 in Wait (this=0x272f090) at ./common/Cond.h:46
#2  SimpleMessenger::Pipe::writer (this=0x272f090) at msg/SimpleMessenger.cc:1746
#3  0x00007f9dee66187d in SimpleMessenger::Pipe::Writer::entry (this=<value optimized out>) at msg/SimpleMessenger.h:204
#4  0x00007f9def4188ba in start_thread () from /lib/libpthread.so.0
#5  0x00007f9dee14d02d in clone () from /lib/libc.so.6
#6  0x0000000000000000 in ?? ()

Thread 2 (Thread 0x7f9deb3cf700 (LWP 26309)):
#0  0x00007f9dee142113 in poll () from /lib/libc.so.6
#1  0x00007f9dee66d599 in tcp_read_wait (sd=<value optimized out>, timeout=<value optimized out>) at msg/tcp.cc:48
#2  0x00007f9dee66e89b in tcp_read (sd=4, buf=<value optimized out>, len=1, timeout=900000) at msg/tcp.cc:25
#3  0x00007f9dee67ffd2 in SimpleMessenger::Pipe::reader (this=0x272f090) at msg/SimpleMessenger.cc:1539
#4  0x00007f9dee66185d in SimpleMessenger::Pipe::Reader::entry (this=<value optimized out>) at msg/SimpleMessenger.h:196
#5  0x00007f9def4188ba in start_thread () from /lib/libpthread.so.0
#6  0x00007f9dee14d02d in clone () from /lib/libc.so.6
#7  0x0000000000000000 in ?? ()

Thread 1 (Thread 0x7f9df07ec720 (LWP 26046)):
#0  0x00007f9dee1468d3 in select () from /lib/libc.so.6
#1  0x0000000000413668 in qemu_aio_wait () at aio.c:193
#2  0x0000000000412015 in bdrv_write_em (bs=0x2721ab0, sector_num=262144, buf=0x272ca00 'B' <repeats 200 times>..., nb_sectors=1) at block.c:2690
#3  0x0000000000405ce4 in do_write (argc=<value optimized out>, argv=<value optimized out>) at qemu-io.c:191
#4  write_f (argc=<value optimized out>, argv=<value optimized out>) at qemu-io.c:733
#5  0x0000000000407629 in command_loop () at cmd.c:188
#6  0x0000000000406c64 in main (argc=<value optimized out>, argv=0x7fff16116c48) at qemu-io.c:1821


Test 008 failed with an assertion but succeeded when run again.  I think
this is a race condition:

--- 008.out     2010-12-07 16:18:18.762829295 +0000
+++ 008.out.bad 2011-04-08 08:18:31.562761417 +0100
@@ -2,8 +2,31 @@
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
  
   == reading whole image ==
   -read 134217728/134217728 bytes at offset 0
   -128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
   +common/Mutex.h: In function 'void Mutex::Lock(bool)', in thread '0x7f263e057720'
   +common/Mutex.h: 118: FAILED assert(r == 0)
   + ceph version 0.25-577-gd941422 (commit:d94142221153ec985c699ad69c3925136f3a30de)
   + 1: (librbd::aio_read(librbd::ImageCtx*, unsigned long, unsigned long, char*, librbd::AioCompletion*)+0x726) [0x7f263c248db6]
   + 2: /home/stefanha/qemu/qemu-io() [0x435e7d]
   + 3: /home/stefanha/qemu/qemu-io() [0x435f70]
   + 4: /home/stefanha/qemu/qemu-io() [0x411d4c]
   + ceph version 0.25-577-gd941422 (commit:d94142221153ec985c699ad69c3925136f3a30de)
   + 1: (librbd::aio_read(librbd::ImageCtx*, unsigned long, unsigned long, char*, librbd::AioCompletion*)+0x726) [0x7f263c248db6]
   + 2: /home/stefanha/qemu/qemu-io() [0x435e7d]
   + 3: /home/stefanha/qemu/qemu-io() [0x435f70]
   + 4: /home/stefanha/qemu/qemu-io() [0x411d4c]
   +terminate called after throwing an instance of 'ceph::FailedAssertion'
   +common/Mutex.h: In function 'void Mutex::Lock(bool)', in thread '0x7f263e057720'
   +common/Mutex.h: 118: FAILED assert(r == 0)
   + ceph version 0.25-577-gd941422 (commit:d94142221153ec985c699ad69c3925136f3a30de)
   + 1: (librbd::aio_read(librbd::ImageCtx*, unsigned long, unsigned long, char*, librbd::AioCompletion*)+0x726) [0x7f263c248db6]
   + 2: /home/stefanha/qemu/qemu-io() [0x435e7d]
   + 3: /home/stefanha/qemu/qemu-io() [0x435f70]
   + 4: /home/stefanha/qemu/qemu-io() [0x411d4c]
   + ceph version 0.25-577-gd941422 (commit:d94142221153ec985c699ad69c3925136f3a30de)
   + 1: (librbd::aio_read(librbd::ImageCtx*, unsigned long, unsigned long, char*, librbd::AioCompletion*)+0x726) [0x7f263c248db6]
   + 2: /home/stefanha/qemu/qemu-io() [0x435e7d]
   + 3: /home/stefanha/qemu/qemu-io() [0x435f70]
   + 4: /home/stefanha/qemu/qemu-io() [0x411d4c]


Do you have a chance to look into this?  Please let me know if you need more
information.

I run like this:

$ cd qemu-iotests
$ ln -s ~/ceph/src/ceph.conf .
$ LD_LIBRARY_PATH=/home/stefanha/ceph/src/.libs PATH=~/qemu/x86_64-softmmu/:~/qemu:~/ceph/src:$PATH TEST_DIR=rbd ./check -rbd

I've also temporarily hacked qemu-iotests/common.config to accept rbd pool
names:

diff --git a/common.config b/common.config
index bdd0530..c4c2eb6 100644
--- a/common.config
+++ b/common.config
@@ -102,14 +102,14 @@ export QEMU_IO="$QEMU_IO_PROG $QEMU_IO_OPTIONS"
 
 [ -f /etc/qemu-iotest.config ]       && . /etc/qemu-iotest.config
 
-if [ ! -e "$TEST_DIR" ]; then
+if [ -z "$TEST_DIR" ]; then
     TEST_DIR=`pwd`/scratch
 fi
 
-if [ ! -d "$TEST_DIR" ]; then
-    echo "common.config: Error: \$TEST_DIR ($TEST_DIR) is not a directory"
-    exit 1
-fi
+#if [ ! -d "$TEST_DIR" ]; then
+#    echo "common.config: Error: \$TEST_DIR ($TEST_DIR) is not a directory"
+#    exit 1
+#fi
 
 _readlink()
 {
