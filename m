From: Sam Lang <sam.lang@inktank.com>
Subject: Re: [ceph-commit] [ceph/ceph] e6a154: osx: compile on OSX
Date: Mon, 10 Dec 2012 07:11:44 -1000
Message-ID: <50C617D0.30005@inktank.com>
References: <50c4cd4dabe04_4126fc8af02216d@sh2.rs.github.com.mail> <4685D39E3A8A4352B08C753D91FC4A5A@inktank.com> <sfid-H20121209-182244-+035.50-1@marduk.tchpc.tcd.ie> <CA+Hcz5-z4=aYGaTb3tU28B0Qanb=a+iR+yq_RKqc9EVsJZ-GAQ@mail.gmail.com> (sfid-H20121209-182244-+035.50-1@marduk.tchpc.tcd.ie) <C29C365E-91F0-46D8-8559-99BF78E0B098@tchpc.tcd.ie> <alpine.DEB.2.00.1212100901110.17288@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:37714 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab2LJRLt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 12:11:49 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so10255300ieb.31
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 09:11:49 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212100901110.17288@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Jimmy Tang <jtang@tchpc.tcd.ie>, Noah Watkins <noah.watkins@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On 12/10/2012 07:01 AM, Sage Weil wrote:
> On Mon, 10 Dec 2012, Jimmy Tang wrote:
>>
>> On 9 Dec 2012, at 18:22, Noah Watkins wrote:
>>
>>> On Sun, Dec 9, 2012 at 10:05 AM, Gregory Farnum <greg@inktank.com> wrote:
>>>> Oooh, very nice! Do you have a list of the dependencies that you actually needed to install?
>>>
>>> I can put that together. They were boost, gperf, fuse4x, cryptopp. I
>>> think that might have been it.
>>>
>>
>> Is libaio really needed to build ceph-fuse? I use macports on my system
>> and the last time I tried to make a change set to let ceph/ceph-fuse
>> build on my laptop failed as I didn't have libaio, though I could just
>> write a port for it.
>
> libaio is only used by ceph-osd.  Not needed by fuse.

An alternative on OSX could be aio-lite: 
https://trac.mcs.anl.gov/projects/aio-lite

It might perform better on linux as well because of the request 
serialization there, although that library was implemented a few years 
ago, and the linux implementation may have improved significantly since 
then.  It also wouldn't be hard to do something similar with ceph thread 
structures instead of depending on an external library like this one.

-sam

>
> sage
>
>
>>
>>>> Apart from breaking this up into smaller patches, we'll also want to reformat some of it. Rather than sticking an #if APPLE on top of every spin lock, we should have utility functions that do this for us. ;)
>>>
>>> Definitely. OSX has spinlock implementations for user space, but it's
>>> going to take some reading. For example, spinlocks in Ceph are
>>> initialized for shared memory, rather than the default private. It
>>> isn't clear from documentation what the semantics are of OSX
>>> spinlocks, nor is it clear if the shared memory attribute is needed.
>>>
>>>> Also, we should be able to find libatomic_ops for OS X (its parent project works under OS X), and we can use that to construct a spin lock if we think it'll be useful. I'm not too sure how effective its muteness are at spinlock-y workloads.
>>>
>>> This patch set uses the OSX atomic inc/dec ops, rather than spinlocks.
>>>
>>> Another fun fact:
>>>
>>> msg/Pipe.cc and common/pipe.c are compiled into libcommon_la-Pipe.o
>>> and libcommon_la-pipe.o, but HFS+ is case-insensitive by default.
>>> Result is duplicate symbols. That took a while to figure out :P
>>>
>>
>> good catch, that might explain why my last look at ceph on osx failed so miserably.
>>
>>
>> Jimmy.
>>
>> --
>> Senior Software Engineer, Digital Repository of Ireland (DRI)
>> Trinity Centre for High Performance Computing,
>> Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
>> http://www.tchpc.tcd.ie/ | jtang@tchpc.tcd.ie
>> Tel: +353-1-896-3847
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

