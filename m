From: Sage Weil <sage@inktank.com>
Subject: Re: ceph stability
Date: Wed, 19 Dec 2012 07:40:50 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212190738370.13122@cobra.newdream.net>
References: <CAD5ewrosrMWD3jxznaMhab=VTL4VzQ7savVk42KDe374VSSzbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37856 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab2LSPkv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 10:40:51 -0500
In-Reply-To: <CAD5ewrosrMWD3jxznaMhab=VTL4VzQ7savVk42KDe374VSSzbA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Hlynovskiy <roman.hlynovskiy@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 19 Dec 2012, Roman Hlynovskiy wrote:
> My second problem - I have 2 systems which mount ceph. Whenever I
> mount ceph on any other system it usually mounts but get stuck on
> stat* operations (i.e. simple ls -al will hang with read( from the
> ceph-mounted directory for ages). This kind of client stuck also
> affects two working clients. they also start to stuck on the stat*
> even after shutdown of the third client. so usually umount/mount or
> even reboot for existing clients solves the issue)

If this is something you can easily reproduce, can you please run with

[mds]
	debug mds = 20
	debug ms = 1

in your ceph.conf and attach the resulting mds log to a bug in the 
tracker?  We've seen this sort of thing in the past, but not recently.

Is this the kernel client mount?  What version of the client (kernel) are 
you running?

Thanks!
sage



