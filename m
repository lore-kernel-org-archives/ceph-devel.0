From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: question for the new ceph-osd key/value backend
Date: Wed, 11 Dec 2013 07:52:40 -0600
Message-ID: <52A86E28.8070006@inktank.com>
References: <A9F57F2ABA6BB2469F01E127557C6C9B10E7BEDD@SHSMSX104.ccr.corp.intel.com> <alpine.DEB.2.00.1312102155520.19333@cobra.newdream.net> <A9F57F2ABA6BB2469F01E127557C6C9B10E7C197@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:52123 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab3LKNwd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 08:52:33 -0500
Received: by mail-ie0-f170.google.com with SMTP id qd12so11002586ieb.15
        for <ceph-devel@vger.kernel.org>; Wed, 11 Dec 2013 05:52:33 -0800 (PST)
In-Reply-To: <A9F57F2ABA6BB2469F01E127557C6C9B10E7C197@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Duan, Jiangang" <jiangang.duan@intel.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/11/2013 12:59 AM, Duan, Jiangang wrote:
> Thanks. I in general think to find one implementation suitable for al=
l usage models (small vs. big, cold vs. hot) is very difficult. So I li=
ke the idea of "a backend that lets you plug in a next-gen backend bene=
ath it - " -
> K/V may be a good way to handle many small objects than XFS - however=
 I am not sure if levelDB is the right choice (consider it is good for =
write than read) and also not sure K/V this will benefit RBD workload o=
r not (consider all 4MB object size).
> Will think more about this and talk with you again.

I have been very interested in this topic recently and have been doing=20
some benchmarking with basho's leveldb, hyperdex, and stock leveldb=20
implementations.  Each has certain advantages (usually related to=20
whatever they advertise, ie crc32 for basho, etc), but all seem to have=
=20
poor sync read/write performance, both sequential and random.  I want t=
o=20
take a look at rocksdb to see how it compares as well.

This whole area is very interesting as there are obvious tradeoffs=20
regarding how we do things now vs what we potentially could do down the=
=20
road.  Being able to eliminate POSIX entirely behind the scenes would=20
obviously be nice for a lot of reasons.

Mark

>
> -jiangang
>
> -----Original Message-----
> From: Sage Weil [mailto:sage@inktank.com]
> Sent: Wednesday, December 11, 2013 2:09 PM
> To: Duan, Jiangang
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: question for the new ceph-osd key/value backend
>
> Hi Jiangang,
>
> On Wed, 11 Dec 2013, Duan, Jiangang wrote:
>> Sage,
>>
>> I have some questions regarding to the key/value backend work.
>>
>> What is the motivation to work on this? (or what is the problem we
>> want to solve?)
>> 1) to use the new interface thus we can bypass all the OS layer thus=
 get a short latency?
>
> That is one part.  The current strategy of layering on top of a file =
system and using a write-ahead journal makes sense given the existing l=
inux fs building blocks, but is far from an optimal solution for many w=
orkloads.  A k/v interface based on something leveldb probably performs=
 much better for many small-object use-cases.  Also, a k/v backend can =
take advatange of emerging non-block storage interfaces like NVMKV, Kin=
etic, new libraries like rocksdb, etc.
>
>> 2) or to leverage some new primitive e.g. the atomic write thus to s=
implify the code writing?
>
> That too.  Basically, we are currently doing a lot of work to get wha=
t we need out of posix, and are paying the price.
>
>> There are several different possibilities to use future NVM technolo=
gy
>> - NVM.FILE, NVM.BLOCK, PM.XXX
>> http://snia.org/sites/default/files/NVMProgrammingModel_v1r10DRAFT.p=
df
>> Even for openNVM thing - there are other usage model than k/v.
>>
>> Do you have any typical usage model for this?
>
> I wasn't familiar with these; thanks for the reference!  Of these, NV=
M.FILE seems the most interesting (it maps most closely to an object).
> I am predisposed to skepticism when it comes to these sorts of standa=
rds/API docs that precede an actual implementation, but it is encourgag=
ing to see some effort here towards a common interface.
>
> In the end, we want to support generic Ceph workloads.  These range f=
rom rbd block and file type workloads (objects are stripes of files, wi=
th random bytes rewritten) to omap type workloads (like rgw bucket indi=
ces that are purely key/value).
>
> I think the first wins would be:
>
> 1- a backend that more efficiently handles rgw bucket index workloads
> 2- a backend that is more efficient for rgw in general (i.e., immutab=
le
> objects)
> 3- a backend that can handle more general purpose workloads (like rbd=
 and
> cephfs)
>
> and separately,
>
> 4- a backend that lets you plug in a next-gen backend beneath it, lik=
e NVMKV and speedy flash.
>
> sage
>
>
>
>>
>> -jiangang
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> From: Sage Weil <sage <at> inktank.com>
>> Subject: new ceph-osd key/value backend
>> Newsgroups: gmane.comp.file-systems.ceph.devel
>> Date: 2013-11-09 10:09:52 GMT (4 weeks, 3 days, 16 hours and 39
>> minutes ago) I've written up a blueprint with a rough sketch of how =
to
>> take advantage of alternative storage interfaces.  I am very happy t=
o
>> see that several f them have emerged over the past year or two:
>>
>>   - fusionio's KVMKV is a key/value interface for their flash produc=
ts
>>   - seagate's kinetic is a key/value interface for their new
>> ethernet-based drive
>>
>> Also, leveldb is pretty great for many workloads when run on a
>> tranditional disk/fs.
>>
>> The good news is a lot of the existing work that went into support
>> omap looks to be reusable here.  Some new functionality and
>> refactoring is needed, though, particularly when it comes to storing
>> object data (the file-like bag of bytes portion) as key/value pairs.
>>
>> The blueprint is here:
>>
>>
>> http://wiki.ceph.com/01Planning/02Blueprints/Firefly/osd%3A_new_key%=
2F
>> %2Fvalue_backend
>>
>> N?????r??y??????X???v???)?{.n?????z?]z????ay?=1D????j ??f???h?????=1E=
?w???
> ???j:+v???w???????? ????zZ+???????j"????i
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=EF=BF=BDf=EF=BF=BD=
=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=EF=BF=
=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=07=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=
=BD=EF=BF=BD!tml=3D
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
