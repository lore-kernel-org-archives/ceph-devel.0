From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rbd tool changed format? (breaks compatibility)
Date: Fri, 16 Nov 2012 09:14:52 -0800
Message-ID: <50A6748C.7040303@inktank.com>
References: <50A64F6A.8010505@grnet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63663 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab2KPRPA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 12:15:00 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so1989994pad.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Nov 2012 09:14:59 -0800 (PST)
In-Reply-To: <50A64F6A.8010505@grnet.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Constantinos Venetsanopoulos <cven@grnet.gr>
Cc: ceph-devel@vger.kernel.org, synnefo-devel@googlegroups.com

On 11/16/2012 06:36 AM, Constantinos Venetsanopoulos wrote:
> Hello ceph team,
>
> As you may already know, our team in GRNET is building a complete open
> source cloud platform called Synnefo [1], which already powers our
> production public cloud service ~okeanos [2].
>
> Synnefo is using Google Ganeti for the low level VM management part [3].
> As of Jan 2012, we have merged to upstream Ganeti support for VM disks
> on RADOS [4].
>
> Today we received some feedback, that other people trying to run Ganeti
> with RADOS get an error because probably the output of the 'rbd
> showmapped' command has changed.
>
> I'd like to ask if indeed the output format of the rbd tool has changed.
> More specifically:
>
> 1. Does the 'rbd showmapped' command still returns just the headers if
> no device is mapped?

No

> 2. Has the separator between the 'rbd showmapped' columns changed
> from \t to ""?

Yes, this is in the release notes for 0.54 
(http://ceph.com/docs/master/release-notes/#v0-54).

> I don't have the latest rbd tool setup (but rather
> ceph-common=0.48.1argonaut-1~bpo60+1), so I can't test it right now,
> but I see this commit:
>
> https://github.com/ceph/ceph/commit/bed55369a96c2651f513b8c9b1a7bb92fb87550a

Yeah, that's the commit that changed it.

> How stable can we consider rbd tool's output format?
> This is something we want to run in production environment. Using the
> tool rather than the library makes things much simpler.

Generally it won't change much, but I don't think it should be
considered entirely unchanging. We'll add it to the release notes when
the output does change. We'll probably switch other commands to use
TextTable too, with the same results as with showmapped and lock list.
We could send a message to the mailing list when the output changes as
well, so you can prepare for a future release.

Perhaps we should add a --format json|plain option so you don't have to
rely on particular formatting, you just parse the json. This would
match existing usage by many 'ceph ...' commands, and be easier
for scripts to use in general.

Josh
