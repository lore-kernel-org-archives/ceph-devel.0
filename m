From: huangjun <hjwsm1989@gmail.com>
Subject: Re: [ceph-users] compile error on centos 5.9
Date: Mon, 05 Aug 2013 17:51:27 +0800
Message-ID: <51FF759F.1060502@gmail.com>
References: <51FF1100.2000004@gmail.com> <alpine.DEB.2.00.1308042100330.5645@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:46793 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab3HEJvh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Aug 2013 05:51:37 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so3147862pbb.24
        for <ceph-devel@vger.kernel.org>; Mon, 05 Aug 2013 02:51:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1308042100330.5645@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, mark.nelson@inktank.com

=E4=BA=8E 2013/8/5 12:03, Sage Weil =E5=86=99=E9=81=93:
> [Moving to ceph-devel]
>
> On Mon, 5 Aug 2013, huangjun wrote:
>> hi,all
>> i compiled ceph 0.61.3 on centos 5.9,the "sh autogen.sh" and
>> "./configure " is ok, but when i "make", an error occurs, the err lo=
g:
>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2=
/bits/concurrence.h:
>> In function ?int rados::cls::lock::lock(librados::IoCtx*, const
>> std::string&, const std::string&, ClsLockType, const std::string&, c=
onst
>> std::string&, const std::string&, const utime_t&, uint8_t)?:
>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2=
/bits/concurrence.h:83:
>> error: ?class __gnu_cxx::lock? is not a function,
>> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
>> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
>> std::string&, ClsLockType, const std::string&, const std::string&, c=
onst
>> std::string&, const utime_t&, uint8_t)?
>> cls/lock/cls_lock_client.cc:62: error: in call to ?lock?
>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2=
/bits/concurrence.h:
>> In member function ?void
>> rados::cls::lock::Lock::lock_shared(librados::ObjectWriteOperation*)=
?:
>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2=
/bits/concurrence.h:83:
>> error: ?class __gnu_cxx::lock? is not a function,
>> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
>> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
>> std::string&, ClsLockType, const std::string&, const std::string&, c=
onst
>> std::string&, const utime_t&, uint8_t)?
>> cls/lock/cls_lock_client.cc:181: error: in call to ?lock?
>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2=
/bits/concurrence.h:
>> In member function ?int
>> rados::cls::lock::Lock::lock_shared(librados::IoCtx*, const std::str=
ing&)?:
>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2=
/bits/concurrence.h:83:
>> error: ?class __gnu_cxx::lock? is not a function,
>> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
>> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
>> std::string&, ClsLockType, const std::string&, const std::string&, c=
onst
>> std::string&, const utime_t&, uint8_t)?
>> cls/lock/cls_lock_client.cc:187: error: in call to ?lock?
>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2=
/bits/concurrence.h:
>> In member function ?void
>> rados::cls::lock::Lock::lock_exclusive(librados::ObjectWriteOperatio=
n*)?:
>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2=
/bits/concurrence.h:83:
>> error: ?class __gnu_cxx::lock? is not a function,
>> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
>> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
>> std::string&, ClsLockType, const std::string&, const std::string&, c=
onst
>> std::string&, const utime_t&, uint8_t)?
>> cls/lock/cls_lock_client.cc:193: error: in call to ?lock?
>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2=
/bits/concurrence.h:
>> In member function ?int
>> rados::cls::lock::Lock::lock_exclusive(librados::IoCtx*, const
>> std::string&)?:
>> /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2=
/bits/concurrence.h:83:
>> error: ?class __gnu_cxx::lock? is not a function,
>> cls/lock/cls_lock_client.cc:59: error: conflict with ?int
>> rados::cls::lock::lock(librados::IoCtx*, const std::string&, const
>> std::string&, ClsLockType, const std::string&, const std::string&, c=
onst
>> std::string&, const utime_t&, uint8_t)?
>> cls/lock/cls_lock_client.cc:199: error: in call to ?lock?
>> make[3]: *** [cls_lock_client.o] Error 1
>>
>> the gcc version is 4.1.2, does this make a difference?
> I suspect so.  Mark Nelson successfully built on RHEL5 a while back b=
ut
> needed to use a newer gcc.
>
>> what should i do if i want to use ceph-fuse client on centos 5.9? mu=
st
>> compile the ceph? or just compile the ceph-fuse code?
> Right.. you only need the ceph-fuse code.  'make ceph-fuse' may do th=
e
> trick.  Otherwise, you'll need to just strip out the osd stuff from
> Makefile.am.
>
> Either way, let us know how it goes, as others would benefit from thi=
s as
> well!
>
> Thanks-
> sage
unfortunatly, i installed gcc4.4.7 and recompiled source code, but=20
failed again:

/usr/include/sys/types.h:46: error: conflicting declaration =E2=80=98ty=
pedef=20
__loff_t loff_t=E2=80=99
/usr/include/linux/types.h:30: error: =E2=80=98loff_t=E2=80=99 has a pr=
evious=20
declaration as =E2=80=98typedef __kernel_loff_t loff_t=E2=80=99
/usr/include/sys/types.h:62: error: conflicting declaration =E2=80=98ty=
pedef=20
__dev_t dev_t=E2=80=99
/usr/include/linux/types.h:13: error: =E2=80=98dev_t=E2=80=99 has a pre=
vious declaration=20
as =E2=80=98typedef __kernel_dev_t dev_t=E2=80=99
In file included from /usr/include/sys/types.h:133,
from /usr/include/stdlib.h:438,
from ./include/buffer.h:29,
from mds/Capability.h:19,
from mds/Capability.cc:15:
/usr/include/time.h:105: error: conflicting declaration =E2=80=98typede=
f void*=20
timer_t=E2=80=99
/usr/include/linux/types.h:22: error: =E2=80=98timer_t=E2=80=99 has a p=
revious=20
declaration as =E2=80=98typedef __kernel_timer_t timer_t=E2=80=99
In file included from /usr/include/stdlib.h:438,
from ./include/buffer.h:29,
from mds/Capability.h:19,
from mds/Capability.cc:15:
/usr/include/sys/types.h:198: error: conflicting declaration =E2=80=98t=
ypedef=20
long int int64_t=E2=80=99
/usr/include/linux/types.h:98: error: =E2=80=98int64_t=E2=80=99 has a p=
revious=20
declaration as =E2=80=98typedef __s64 int64_t=E2=80=99
/usr/include/sys/types.h:204: error: conflicting declaration =E2=80=98t=
ypedef=20
long unsigned int u_int64_t=E2=80=99
/usr/include/linux/types.h:97: error: =E2=80=98u_int64_t=E2=80=99 has a=
 previous=20
declaration as =E2=80=98typedef __u64 u_int64_t=E2=80=99
In file included from /usr/include/sys/types.h:220,
from /usr/include/stdlib.h:438,
from ./include/buffer.h:29,
from mds/Capability.h:19,
from mds/Capability.cc:15:
/usr/include/sys/select.h:78: error: conflicting declaration =E2=80=98t=
ypedef=20
struct fd_set fd_set=E2=80=99
/usr/include/linux/types.h:12: error: =E2=80=98fd_set=E2=80=99 has a pr=
evious=20
declaration as =E2=80=98typedef struct __kernel_fd_set fd_set=E2=80=99
In file included from /usr/include/stdlib.h:438,
from ./include/buffer.h:29,
from mds/Capability.h:19,
from mds/Capability.cc:15:
/usr/include/sys/types.h:248: error: conflicting declaration =E2=80=98t=
ypedef=20
__blkcnt64_t blkcnt_t=E2=80=99
/usr/include/linux/types.h:114: error: =E2=80=98blkcnt_t=E2=80=99 has a=
 previous=20
declaration as =E2=80=98typedef long unsigned int blkcnt_t=E2=80=99
In file included from ./include/buffer.h:48,
from mds/Capability.h:19,
from mds/Capability.cc:15:
/usr/include/stdint.h:56: error: conflicting declaration =E2=80=98typed=
ef long=20
unsigned int uint64_t=E2=80=99
/usr/include/linux/types.h:96: error: =E2=80=98uint64_t=E2=80=99 has a =
previous=20
declaration as =E2=80=98typedef __u64 uint64_t=E2=80=99
In file included from mds/Capability.h:24,
from mds/Capability.cc:15:
mds/mdstypes.h: In member function =E2=80=98size_t=20
__gnu_cxx::hash<vinodeno_t>::operator()(const vinodeno_t&) const=E2=80=99=
:
mds/mdstypes.h:252: error: no match for call to =E2=80=98(__gnu_cxx::ha=
sh<long=20
long unsigned int>) (const snapid_t&)=E2=80=99
mds/mdstypes.h: In member function =E2=80=98void=20
dentry_key_t::encode(ceph::bufferlist&) const=E2=80=99:
mds/mdstypes.h:531: warning: format =E2=80=98%lx=E2=80=99 expects type =
=E2=80=98long unsigned=20
int=E2=80=99, but argument 4 has type =E2=80=98uint64_t=E2=80=99
mds/mdstypes.h:531: warning: format =E2=80=98%lx=E2=80=99 expects type =
=E2=80=98long unsigned=20
int=E2=80=99, but argument 4 has type =E2=80=98uint64_t=E2=80=99
mds/mdstypes.h: In member function =E2=80=98size_t=20
__gnu_cxx::hash<metareqid_t>::operator()(const metareqid_t&) const=E2=80=
=99:
mds/mdstypes.h:673: error: no match for call to =E2=80=98(__gnu_cxx::ha=
sh<long=20
long unsigned int>) (int64_t)=E2=80=99
mds/mdstypes.h:673: error: no match for call to =E2=80=98(__gnu_cxx::ha=
sh<long=20
long unsigned int>) (int)=E2=80=99
mds/mdstypes.h:673: error: no match for call to =E2=80=98(__gnu_cxx::ha=
sh<long=20
long unsigned int>) (const uint64_t&)=E2=80=99
make[3]: *** [Capability.o] Error 1

Mark, do you have meet this problem before, and would you like to share=
=20
your experiences on centos 5?

thanks!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
