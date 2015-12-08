From: Sage Weil <sage@newdream.net>
Subject: Re: problem about pgmeta object?
Date: Tue, 8 Dec 2015 05:37:29 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512080536300.19170@cobra.newdream.net>
References: <CALZt5jx2bQKK6yE=bTu96CD=OE7uVGTagfqirHsXh5bNbS2t=w@mail.gmail.com> <alpine.DEB.2.00.1511180511420.7964@cobra.newdream.net> <CALZt5jzpGn1koOwK2PZ2w6xj-UPibc2B60HU-f1ZayFNDSy3EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60286 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756432AbbLHNha (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Dec 2015 08:37:30 -0500
In-Reply-To: <CALZt5jzpGn1koOwK2PZ2w6xj-UPibc2B60HU-f1ZayFNDSy3EQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 8 Dec 2015, Ning Yao wrote:
> Umm, it seems that MemStore requires in memory meta object to keep the
> attributes. So it is not a direct way to remove the pg_meta object
> backend storage. Any suggestions?
> I think we can just skip the pg_meta operation in FileStore api based
> on the value of hoid.pgmeta(), not a generic strategy for all
> backends.

Yeah--a FileStore hack makes more sense, as other backends probably 
won't have the same inefficiency that FileStore does.

Can you summarize the strategy, though?  We want to avoid doing anything 
to weird to FileStore at this point unless there is a big performance win.

sage
