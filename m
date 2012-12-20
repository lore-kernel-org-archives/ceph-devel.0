From: Roman Hlynovskiy <roman.hlynovskiy@gmail.com>
Subject: Re: ceph stability
Date: Thu, 20 Dec 2012 14:02:11 +0600
Message-ID: <CAD5ewrpM1W+pei4n7+0WBF6fyhdcbq7SkrgQjnCeZZwiBwK7rg@mail.gmail.com>
References: <CAD5ewrosrMWD3jxznaMhab=VTL4VzQ7savVk42KDe374VSSzbA@mail.gmail.com>
	<alpine.DEB.2.00.1212190738370.13122@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:45321 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab2LTICM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Dec 2012 03:02:12 -0500
Received: by mail-qa0-f48.google.com with SMTP id l8so2284933qaq.0
        for <ceph-devel@vger.kernel.org>; Thu, 20 Dec 2012 00:02:11 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212190738370.13122@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hello Sage,

Yes, I can easily reproduce it.

how can I open a bug on the tracker? I can't find the link for this.
log is ready to be uploaded.
this is pure kernel client mount. my kernel on the client is
3.2.0-0.bpo.3-686-pae

2012/12/19 Sage Weil <sage@inktank.com>:
> On Wed, 19 Dec 2012, Roman Hlynovskiy wrote:
>> My second problem - I have 2 systems which mount ceph. Whenever I
>> mount ceph on any other system it usually mounts but get stuck on
>> stat* operations (i.e. simple ls -al will hang with read( from the
>> ceph-mounted directory for ages). This kind of client stuck also
>> affects two working clients. they also start to stuck on the stat*
>> even after shutdown of the third client. so usually umount/mount or
>> even reboot for existing clients solves the issue)
>
> If this is something you can easily reproduce, can you please run with
>
> [mds]
>         debug mds = 20
>         debug ms = 1
>
> in your ceph.conf and attach the resulting mds log to a bug in the
> tracker?  We've seen this sort of thing in the past, but not recently.
>
> Is this the kernel client mount?  What version of the client (kernel) are
> you running?
>
> Thanks!
> sage
>
>
>



-- 
...WBR, Roman Hlynovskiy
