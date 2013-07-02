From: Nathan O'Sullivan <nathan@mammoth.com.au>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Tue, 02 Jul 2013 13:32:08 +1000
Message-ID: <51D249B8.4020301@mammoth.com.au>
References: <51C3FEF0.7030709@mammoth.com.au> <CAF6-1L7xdHCOPmLTghdsMnbna=Y95uy3g9nv=pMmRG5kEKvhCw@mail.gmail.com> <CAF6-1L4sFuoHieM2+6h_+dDYFOF0pf00jC_nVBUs=4oNPm9Rcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bris.mammothmedia.com.au ([203.39.17.199]:46974 "EHLO
	mail1.bris.mammothmedia.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751560Ab3GBDbs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jul 2013 23:31:48 -0400
In-Reply-To: <CAF6-1L4sFuoHieM2+6h_+dDYFOF0pf00jC_nVBUs=4oNPm9Rcg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

I've installed debug symbols, perhaps that will give a better idea what 
is going on?

#0  __GI___libc_free (mem=0x7f5160650000) at malloc.c:2970
#1  0x00007f515f3ac84b in ~raw_posix_aligned (this=0x7f513c418f20, 
__in_chrg=<optimised out>) at common/buffer.cc:152
#2  ceph::buffer::raw_posix_aligned::~raw_posix_aligned (this=<optimised 
out>, __in_chrg=<optimised out>) at common/buffer.cc:155
#3  0x00007f515f3a7f6e in ceph::buffer::ptr::release 
(this=0x7f513801d600) at common/buffer.cc:328
#4  0x00007f515ee721c7 in ~ptr (this=0x7f513801d600, 
__in_chrg=<optimised out>) at ./include/buffer.h:159
#5  destroy (__p=0x7f513801d600, this=<optimised out>) at 
/usr/include/c++/4.6/ext/new_allocator.h:118
#6  std::_List_base<ceph::buffer::ptr, std::allocator<ceph::buffer::ptr> 
 >::_M_clear (this=0x15e3908) at /usr/include/c++/4.6/bits/list.tcc:78
#7  0x00007f515eea9ffe in ~_List_base (this=0x15e3908, 
__in_chrg=<optimised out>) at /usr/include/c++/4.6/bits/stl_list.h:372
#8  ~list (this=0x15e3908, __in_chrg=<optimised out>) at 
/usr/include/c++/4.6/bits/stl_list.h:429
#9  ~list (this=0x15e3908, __in_chrg=<optimised out>) at 
./include/buffer.h:304
#10 ~BufferHead (this=0x15e38c0, __in_chrg=<optimised out>) at 
osdc/ObjectCacher.h:84
#11 ObjectCacher::trim (this=0x1594a00, max_bytes=33554432, max_ob=42) 
at osdc/ObjectCacher.cc:949
#12 0x00007f515eeb8e60 in ObjectCacher::_readx (this=<optimised out>, 
rd=0x15f1f70, oset=0x1595110, onfinish=0x1591280, external_call=false) 
at osdc/ObjectCacher.cc:1240
#13 0x00007f515eebe620 in ObjectCacher::C_RetryRead::finish 
(this=0x15c3c30, r=<optimised out>) at osdc/ObjectCacher.h:554
#14 0x00007f515ee7381a in Context::complete (this=0x15c3c30, 
r=<optimised out>) at ./include/Context.h:41
#15 0x00007f515eeb9f65 in finish_contexts (cct=0x155cc30, finished=..., 
result=0) at ./include/Context.h:78
#16 0x00007f515eeaf705 in ObjectCacher::bh_read_finish (this=<optimised 
out>, poolid=<optimised out>, oid=..., start=983040, length=131072, 
bl=..., r=0, trust_enoent=true)
     at osdc/ObjectCacher.cc:773
#17 0x00007f515eebd32f in ObjectCacher::C_ReadFinish::finish 
(this=0x15ced30, r=0) at osdc/ObjectCacher.h:478
#18 0x00007f515ee7381a in Context::complete (this=0x15ced30, 
r=<optimised out>) at ./include/Context.h:41
#19 0x00007f515eea41f5 in librbd::C_Request::finish (this=0x159dfd0, 
r=0) at librbd/LibrbdWriteback.cc:55
#20 0x00007f515eea2c14 in librbd::context_cb (c=<optimised out>, 
arg=<optimised out>) at librbd/LibrbdWriteback.cc:35
#21 0x00007f515f21056d in librados::C_AioComplete::finish 
(this=<optimised out>, r=<optimised out>) at 
./librados/AioCompletionImpl.h:171
#22 0x00007f515f27cb00 in Finisher::finisher_thread_entry 
(this=0x1576d98) at common/Finisher.cc:56
#23 0x00007f515e113e9a in start_thread (arg=0x7f5158a87700) at 
pthread_create.c:308
#24 0x00007f515eb89ccd in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:112
#25 0x0000000000000000 in ?? ()



On 1/07/2013 7:57 PM, Sylvain Munaut wrote:
> Hi again,
>
>>> However when rbd cache is enabled with:
>>> [client]
>>> rbd_cache = true
>>>
>>> the tapdisk process crashes if I do this in the domU:
>>> dd if=/dev/xvda bs=1M > /dev/null
> I tested this locally and couldn't reproduce the issue.
>
> Doing reads doesn't do anything bad AFAICT.
> Doing writes OTOH seems to leak memory (or at least use much more
> memory than the configured cache size).
>
> I also rechecked the code and I don't see anything wrong with it.
> AFAICT with or without cache shouldn't change anything so the issue
> might be in librbd itself.
>
> Cheers,
>
>      Sylvain

