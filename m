From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: How does EC pools support thousands of xattrs (XFS) but no
 omaps?
Date: Tue, 17 May 2016 09:52:18 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605170950410.30956@cpach.fuggernut.com>
References: <CAOu2ZZUT8hqUmatSWTX7RxzhS1oo_5R0NmZ49+k0D91QPHTOjQ@mail.gmail.com> <CAOu2ZZXBYeCUGhz5RpePsP6CVvh0r2d+FJHT7iHHt=RxuEPznA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60381 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbcEQNwI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2016 09:52:08 -0400
In-Reply-To: <CAOu2ZZXBYeCUGhz5RpePsP6CVvh0r2d+FJHT7iHHt=RxuEPznA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chandan Kumar Singh <chandan.kr.singh@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 17 May 2016, Chandan Kumar Singh wrote:
> Hi
> 
> While migrating to EC pools, I came to know that it does not support
> omaps but it allows thousands of xattrs (XFS). Are these xattrs being
> stored in a key-value store or in XFS file system?

They are stored in XFS, until there are more than a handful, after which 
point they get stored in leveldb.  But they are *also* stored in every pg 
log event that modifies the object, so you should definitely not (ab)use 
xattrs the way you would use omap and expect the system to behave/perform!
They are meant to be small and few.

sage
