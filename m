From: Sam Lang <sam.lang@inktank.com>
Subject: Re: ceph stability
Date: Thu, 20 Dec 2012 05:20:50 -1000
Message-ID: <50D32CD2.7040309@inktank.com>
References: <CAD5ewrosrMWD3jxznaMhab=VTL4VzQ7savVk42KDe374VSSzbA@mail.gmail.com> <alpine.DEB.2.00.1212190738370.13122@cobra.newdream.net> <CAD5ewrpM1W+pei4n7+0WBF6fyhdcbq7SkrgQjnCeZZwiBwK7rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:61410 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab2LTPUy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Dec 2012 10:20:54 -0500
Received: by mail-pb0-f43.google.com with SMTP id um15so2061159pbc.16
        for <ceph-devel@vger.kernel.org>; Thu, 20 Dec 2012 07:20:54 -0800 (PST)
In-Reply-To: <CAD5ewrpM1W+pei4n7+0WBF6fyhdcbq7SkrgQjnCeZZwiBwK7rg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Hlynovskiy <roman.hlynovskiy@gmail.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 12/19/2012 10:02 PM, Roman Hlynovskiy wrote:
> Hello Sage,
>
> Yes, I can easily reproduce it.
>
> how can I open a bug on the tracker? I can't find the link for this.
> log is ready to be uploaded.

Hi Roman,

The bug tracker is at:  http://tracker.newdream.net/

Once you've created an account, you can jump to the project 'fs' through 
the scroll down bar on the right, and then click on the 'New Issue' tab.

-sam

> this is pure kernel client mount. my kernel on the client is
> 3.2.0-0.bpo.3-686-pae
>
> 2012/12/19 Sage Weil <sage@inktank.com>:
>> On Wed, 19 Dec 2012, Roman Hlynovskiy wrote:
>>> My second problem - I have 2 systems which mount ceph. Whenever I
>>> mount ceph on any other system it usually mounts but get stuck on
>>> stat* operations (i.e. simple ls -al will hang with read( from the
>>> ceph-mounted directory for ages). This kind of client stuck also
>>> affects two working clients. they also start to stuck on the stat*
>>> even after shutdown of the third client. so usually umount/mount or
>>> even reboot for existing clients solves the issue)
>>
>> If this is something you can easily reproduce, can you please run with
>>
>> [mds]
>>          debug mds = 20
>>          debug ms = 1
>>
>> in your ceph.conf and attach the resulting mds log to a bug in the
>> tracker?  We've seen this sort of thing in the past, but not recently.
>>
>> Is this the kernel client mount?  What version of the client (kernel) are
>> you running?
>>
>> Thanks!
>> sage
>>
>>
>>
>
>
>

