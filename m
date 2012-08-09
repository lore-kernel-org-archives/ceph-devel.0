From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Re: Errors compiling ceph argonaut
Date: Thu, 09 Aug 2012 13:09:23 -0600
Message-ID: <5023B68302000099000E7696@collaborate.seakr.com>
References: <501A832A02000099000E6EDB@collaborate.seakr.com>
 <50216B22.7050209@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:47860 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759212Ab2HITJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:2:1>);
	Thu, 9 Aug 2012 15:09:26 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q79J8GgP020819
	for <ceph-devel@vger.kernel.org>; Thu, 9 Aug 2012 13:08:17 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 6BB4744CE5
	for <ceph-devel@vger.kernel.org>; Thu,  9 Aug 2012 13:09:25 -0600 (MDT)
In-Reply-To: <50216B22.7050209@inktank.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

>>> On 2012/08/07 at 13:23, Josh Durgin <josh.durgin@inktank.com> wrote: 
> 
> It looks like this might be src/include/types.h including sys/types.h 
> and src/include/rbd_types.h, which is including linux/types.h.
> 
> Does adding ifdefs to src/include/types.h so it includes linux/types.h 
> on linux work?
> 

I enabled GCC verbose mode and I get the following output...maybe someone can spot something...

  CXX    librbd_la-cls_rbd_client.lo
Using built-in specs.
Target: x86_64-redhat-linux
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-libgcj-multifile --enable-languages=c,c++,objc,obj-c++,java,fortran,ada --enable-java-awt=gtk --disable-dssi --disable-plugin --with-java-home=/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre --with-cpu=generic --host=x86_64-redhat-linux
Thread model: posix
gcc version 4.1.2 20080704 (Red Hat 4.1.2-52)
 /usr/libexec/gcc/x86_64-redhat-linux/4.1.2/cc1plus -quiet -v -I. -MD .libs/librbd_la-cls_rbd_client.d -MF .deps/librbd_la-cls_rbd_client.Tpo -MP -MT librbd_la-cls_rbd_client.lo -MQ .libs/librbd_la-cls_rbd_client.o -D_GNU_SOURCE -DHAVE_CONFIG_H -D__CEPH__ -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS -D_GNU_SOURCE -DCEPH_LIBDIR="/usr/local/lib" -DPIC librbd/cls_rbd_client.cc -quiet -dumpbase cls_rbd_client.cc -mtune=generic -auxbase-strip .libs/librbd_la-cls_rbd_client.o -g -O2 -Wall -Winit-self -Wpointer-arith -Wnon-virtual-dtor -Wno-invalid-offsetof -Wstrict-null-sentinel -version -fno-strict-aliasing -fPIC -o /tmp/ccaA79WL.s
ignoring nonexistent directory "/usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../x86_64-redhat-linux/include"
#include "..." search starts here:
#include <...> search starts here:
 .
 /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2
 /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2/x86_64-redhat-linux
 /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2/backward
 /usr/local/include
 /usr/lib/gcc/x86_64-redhat-linux/4.1.2/include
 /usr/include
End of search list.
GNU C++ version 4.1.2 20080704 (Red Hat 4.1.2-52) (x86_64-redhat-linux)
	compiled by GNU C version 4.1.2 20080704 (Red Hat 4.1.2-52).
GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
Compiler executable checksum: 9850d5c14c968e608f9414a15e0e39d2
/usr/include/sys/types.h:46: error: conflicting declaration 'typedef __loff_t loff_t'
/usr/include/linux/types.h:30: error: 'loff_t' has a previous declaration as 'typedef __kernel_loff_t loff_t'
/usr/include/sys/types.h:62: error: conflicting declaration 'typedef __dev_t dev_t'
/usr/include/linux/types.h:13: error: 'dev_t' has a previous declaration as 'typedef __kernel_dev_t dev_t'
/usr/include/time.h:105: error: conflicting declaration 'typedef void* timer_t'
/usr/include/linux/types.h:22: error: 'timer_t' has a previous declaration as 'typedef __kernel_timer_t timer_t'
/usr/include/sys/types.h:198: error: conflicting declaration 'typedef long int int64_t'
/usr/include/linux/types.h:98: error: 'int64_t' has a previous declaration as 'typedef __s64 int64_t'
/usr/include/sys/types.h:204: error: conflicting declaration 'typedef long unsigned int u_int64_t'
/usr/include/linux/types.h:97: error: 'u_int64_t' has a previous declaration as 'typedef __u64 u_int64_t'
/usr/include/sys/select.h:78: error: conflicting declaration 'typedef struct fd_set fd_set'
/usr/include/linux/types.h:12: error: 'fd_set' has a previous declaration as 'typedef struct __kernel_fd_set fd_set'
/usr/include/sys/types.h:248: error: conflicting declaration 'typedef __blkcnt64_t blkcnt_t'
/usr/include/linux/types.h:114: error: 'blkcnt_t' has a previous declaration as 'typedef long unsigned int blkcnt_t'
/usr/include/stdint.h:56: error: conflicting declaration 'typedef long unsigned int uint64_t'
/usr/include/linux/types.h:96: error: 'uint64_t' has a previous declaration as 'typedef __u64 uint64_t'
make[3]: *** [librbd_la-cls_rbd_client.lo] Error 1
make[3]: Leaving directory `/root/ceph-0.48argonaut/src'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/root/ceph-0.48argonaut/src'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/root/ceph-0.48argonaut/src'
make: *** [all-recursive] Error 1


--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
