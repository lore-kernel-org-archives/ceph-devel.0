From: huangjun <hjwsm1989@gmail.com>
Subject: Re: [ceph-users] compile error on centos 5.9
Date: Tue, 06 Aug 2013 22:58:11 +0800
Message-ID: <52010F03.7060806@gmail.com>
References: <51FF1100.2000004@gmail.com> <alpine.DEB.2.00.1308042100330.5645@cobra.newdream.net> <51FF759F.1060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36254 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075Ab3HFO6X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Aug 2013 10:58:23 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so387807pde.23
        for <ceph-devel@vger.kernel.org>; Tue, 06 Aug 2013 07:58:22 -0700 (PDT)
In-Reply-To: <51FF759F.1060502@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, mark.nelson@inktank.com, Nick Couchman <Nick.Couchman@seakr.com>

=E4=BA=8E 2013/8/5 17:51, huangjun =E5=86=99=E9=81=93:
> =E4=BA=8E 2013/8/5 12:03, Sage Weil =E5=86=99=E9=81=93:
>> [Moving to ceph-devel]
>>
>> On Mon, 5 Aug 2013, huangjun wrote:
>>> hi,all
>>> i compiled ceph 0.61.3 on centos 5.9,the "sh autogen.sh" and
>>> "./configure " is ok, but when i "make", an error occurs, the err l=
og:
>>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.=
2/bits/concurrence.h:=20
>>>
>>> In function ?int rados::cls::lock::lock(librados::IoCtx*, const
>>> std::string&, const std::string&, ClsLockType, const std::string&,=20
>>> const
>>> std::string&, const std::string&, const utime_t&, uint8_t)?:
>>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.=
2/bits/concurrence.h:83:=20
>>>
>>> error: ?class __gnu_cxx::lock? is not a function,
>>> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
>>> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
>>> std::string&, ClsLockType, const std::string&, const std::string&,=20
>>> const
>>> std::string&, const utime_t&, uint8_t)?
>>> cls/lock/cls_lock_client.cc:62: error: in call to ?lock?
>>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.=
2/bits/concurrence.h:=20
>>>
>>> In member function ?void
>>> rados::cls::lock::Lock::lock_shared(librados::ObjectWriteOperation*=
)?:
>>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.=
2/bits/concurrence.h:83:=20
>>>
>>> error: ?class __gnu_cxx::lock? is not a function,
>>> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
>>> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
>>> std::string&, ClsLockType, const std::string&, const std::string&,=20
>>> const
>>> std::string&, const utime_t&, uint8_t)?
>>> cls/lock/cls_lock_client.cc:181: error: in call to ?lock?
>>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.=
2/bits/concurrence.h:=20
>>>
>>> In member function ?int
>>> rados::cls::lock::Lock::lock_shared(librados::IoCtx*, const=20
>>> std::string&)?:
>>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.=
2/bits/concurrence.h:83:=20
>>>
>>> error: ?class __gnu_cxx::lock? is not a function,
>>> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
>>> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
>>> std::string&, ClsLockType, const std::string&, const std::string&,=20
>>> const
>>> std::string&, const utime_t&, uint8_t)?
>>> cls/lock/cls_lock_client.cc:187: error: in call to ?lock?
>>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.=
2/bits/concurrence.h:=20
>>>
>>> In member function ?void
>>> rados::cls::lock::Lock::lock_exclusive(librados::ObjectWriteOperati=
on*)?:=20
>>>
>>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.=
2/bits/concurrence.h:83:=20
>>>
>>> error: ?class __gnu_cxx::lock? is not a function,
>>> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
>>> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
>>> std::string&, ClsLockType, const std::string&, const std::string&,=20
>>> const
>>> std::string&, const utime_t&, uint8_t)?
>>> cls/lock/cls_lock_client.cc:193: error: in call to ?lock?
>>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.=
2/bits/concurrence.h:=20
>>>
>>> In member function ?int
>>> rados::cls::lock::Lock::lock_exclusive(librados::IoCtx*, const
>>> std::string&)?:
>>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.=
2/bits/concurrence.h:83:=20
>>>
>>> error: ?class __gnu_cxx::lock? is not a function,
>>> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
>>> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
>>> std::string&, ClsLockType, const std::string&, const std::string&,=20
>>> const
>>> std::string&, const utime_t&, uint8_t)?
>>> cls/lock/cls_lock_client.cc:199: error: in call to ?lock?
>>> make[3]: *** [cls_lock_client.o] Error 1
>>>
>>> the gcc version is 4.1.2, does this make a difference?
>> I suspect so.  Mark Nelson successfully built on RHEL5 a while back =
but
>> needed to use a newer gcc.
>>
>>> what should i do if i want to use ceph-fuse client on centos 5.9? m=
ust
>>> compile the ceph? or just compile the ceph-fuse code?
>> Right.. you only need the ceph-fuse code.  'make ceph-fuse' may do t=
he
>> trick.  Otherwise, you'll need to just strip out the osd stuff from
>> Makefile.am.
>>
>> Either way, let us know how it goes, as others would benefit from=20
>> this as
>> well!
>>
>> Thanks-
>> sage
> unfortunatly, i installed gcc4.4.7 and recompiled source code, but=20
> failed again:
>
> /usr/include/sys/types.h:46: error: conflicting declaration =E2=80=98=
typedef=20
> __loff_t loff_t=E2=80=99
> /usr/include/linux/types.h:30: error: =E2=80=98loff_t=E2=80=99 has a =
previous=20
> declaration as =E2=80=98typedef __kernel_loff_t loff_t=E2=80=99
> /usr/include/sys/types.h:62: error: conflicting declaration =E2=80=98=
typedef=20
> __dev_t dev_t=E2=80=99
> /usr/include/linux/types.h:13: error: =E2=80=98dev_t=E2=80=99 has a p=
revious=20
> declaration as =E2=80=98typedef __kernel_dev_t dev_t=E2=80=99
> In file included from /usr/include/sys/types.h:133,
> from /usr/include/stdlib.h:438,
> from ./include/buffer.h:29,
> from mds/Capability.h:19,
> from mds/Capability.cc:15:
> /usr/include/time.h:105: error: conflicting declaration =E2=80=98type=
def void*=20
> timer_t=E2=80=99
> /usr/include/linux/types.h:22: error: =E2=80=98timer_t=E2=80=99 has a=
 previous=20
> declaration as =E2=80=98typedef __kernel_timer_t timer_t=E2=80=99
> In file included from /usr/include/stdlib.h:438,
> from ./include/buffer.h:29,
> from mds/Capability.h:19,
> from mds/Capability.cc:15:
> /usr/include/sys/types.h:198: error: conflicting declaration =E2=80=98=
typedef=20
> long int int64_t=E2=80=99
> /usr/include/linux/types.h:98: error: =E2=80=98int64_t=E2=80=99 has a=
 previous=20
> declaration as =E2=80=98typedef __s64 int64_t=E2=80=99
> /usr/include/sys/types.h:204: error: conflicting declaration =E2=80=98=
typedef=20
> long unsigned int u_int64_t=E2=80=99
> /usr/include/linux/types.h:97: error: =E2=80=98u_int64_t=E2=80=99 has=
 a previous=20
> declaration as =E2=80=98typedef __u64 u_int64_t=E2=80=99
> In file included from /usr/include/sys/types.h:220,
> from /usr/include/stdlib.h:438,
> from ./include/buffer.h:29,
> from mds/Capability.h:19,
> from mds/Capability.cc:15:
> /usr/include/sys/select.h:78: error: conflicting declaration =E2=80=98=
typedef=20
> struct fd_set fd_set=E2=80=99
> /usr/include/linux/types.h:12: error: =E2=80=98fd_set=E2=80=99 has a =
previous=20
> declaration as =E2=80=98typedef struct __kernel_fd_set fd_set=E2=80=99
> In file included from /usr/include/stdlib.h:438,
> from ./include/buffer.h:29,
> from mds/Capability.h:19,
> from mds/Capability.cc:15:
> /usr/include/sys/types.h:248: error: conflicting declaration =E2=80=98=
typedef=20
> __blkcnt64_t blkcnt_t=E2=80=99
> /usr/include/linux/types.h:114: error: =E2=80=98blkcnt_t=E2=80=99 has=
 a previous=20
> declaration as =E2=80=98typedef long unsigned int blkcnt_t=E2=80=99
> In file included from ./include/buffer.h:48,
> from mds/Capability.h:19,
> from mds/Capability.cc:15:
> /usr/include/stdint.h:56: error: conflicting declaration =E2=80=98typ=
edef long=20
> unsigned int uint64_t=E2=80=99
> /usr/include/linux/types.h:96: error: =E2=80=98uint64_t=E2=80=99 has =
a previous=20
> declaration as =E2=80=98typedef __u64 uint64_t=E2=80=99
> In file included from mds/Capability.h:24,
> from mds/Capability.cc:15:
> mds/mdstypes.h: In member function =E2=80=98size_t=20
> __gnu_cxx::hash<vinodeno_t>::operator()(const vinodeno_t&) const=E2=80=
=99:
> mds/mdstypes.h:252: error: no match for call to =E2=80=98(__gnu_cxx::=
hash<long=20
> long unsigned int>) (const snapid_t&)=E2=80=99
> mds/mdstypes.h: In member function =E2=80=98void=20
> dentry_key_t::encode(ceph::bufferlist&) const=E2=80=99:
> mds/mdstypes.h:531: warning: format =E2=80=98%lx=E2=80=99 expects typ=
e =E2=80=98long unsigned=20
> int=E2=80=99, but argument 4 has type =E2=80=98uint64_t=E2=80=99
> mds/mdstypes.h:531: warning: format =E2=80=98%lx=E2=80=99 expects typ=
e =E2=80=98long unsigned=20
> int=E2=80=99, but argument 4 has type =E2=80=98uint64_t=E2=80=99
> mds/mdstypes.h: In member function =E2=80=98size_t=20
> __gnu_cxx::hash<metareqid_t>::operator()(const metareqid_t&) const=E2=
=80=99:
> mds/mdstypes.h:673: error: no match for call to =E2=80=98(__gnu_cxx::=
hash<long=20
> long unsigned int>) (int64_t)=E2=80=99
> mds/mdstypes.h:673: error: no match for call to =E2=80=98(__gnu_cxx::=
hash<long=20
> long unsigned int>) (int)=E2=80=99
> mds/mdstypes.h:673: error: no match for call to =E2=80=98(__gnu_cxx::=
hash<long=20
> long unsigned int>) (const uint64_t&)=E2=80=99
> make[3]: *** [Capability.o] Error 1
>
> Mark, do you have meet this problem before, and would you like to=20
> share your experiences on centos 5?
>
> thanks!
hi,all
today,i have make the ceph compiled successfully on centos 5.9.
there are two points to take care of so far:
1)install the required packages
   ***boost1.41***
    a) download the epel package on website:=20
http://dl.fedoraproject.org/pub/epel/5/x86_64/
    b) rpm -Uvh epel-release*rpm
    c) yum install boost141*
   ***automake,aclocal(1.11.1)***
     wget http://ftp.gnu.org/gnu/automake/automake-1.11.1.tar.gz
     tar xzvf automake-1.11.1.tar.gz
     cd automake-1.11.1
     ./configure
     make -j4
     make install
   ***gcc44***
     yum install gcc44*
     export CC=3D/usr/bin/gcc44
     export CXX=3D/usr/bin/g++44
   ***other packages***
     yum install libtool autoconf autoheader autoreconf e2fsprogs-devel=
=20
keyutils-libs-devel fuse-devel fuse nss-devel nss libxml2-devel=20
sharutils java-devel expat expat-devel cryptopp cryptopp-devel=20
libatomic_ops-devel gperftools-libs gperftools-devel libaio libaio-deve=
l
     wget=20
http://pkgs.repoforge.org/libedit/libedit-20090923-3.0_1.el5.rf.x86_64.=
rpm
     wget=20
http://pkgs.repoforge.org/libedit/libedit-devel-20090923-3.0_1.el5.rf.x=
86_64.rpm
     wget=20
http://pkgs.repoforge.org/snappy/snappy-devel-1.0.5-1.el5.rf.x86_64.rpm
     wget http://pkgs.repoforge.org/snappy/snappy-1.0.5-1.el5.rf.x86_64=
=2Erpm
2)change the include order in src/include/buffer.h
diff --git a/src/include/buffer.h b/src/include/buffer.h
index 99c1985..d485c3f 100644
--- a/src/include/buffer.h
+++ b/src/include/buffer.h
@@ -16,17 +16,19 @@
  #define CEPH_BUFFER_H

  #if defined(__linux__)
+#include <stdlib.h>
  #include <linux/types.h>
  #elif defined(__FreeBSD__)
  #include <sys/types.h>
  #include "include/inttypes.h"
+#include <stdlib.h>
  #endif

  #ifndef _XOPEN_SOURCE
  # define _XOPEN_SOURCE 600
  #endif

-#include <stdlib.h>
+//#include <stdlib.h>
  #include <stdio.h>

  #ifdef DARWIN

ps: does this has effect on other modules?

then you can compile ceph on centos5 by "sh autogen && ./configure &&=20
make -j4 && make install"
welcome to check it!

thanks!
huangjun
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
