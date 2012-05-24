From: Greg Farnum <greg@inktank.com>
Subject: Re: how to free space from rados bench comman?
Date: Thu, 24 May 2012 11:14:11 -0700
Message-ID: <907FC3D6C9504834A33A73C3D83D6E3F@inktank.com>
References: <4FBDDCAE.7040709@profihost.ag> <4FBDE314.7030305@widodh.nl>
 <4FBDE57F.9010409@profihost.ag> <4FBDEFB0.3030700@widodh.nl>
 <4FBDF691.3070601@profihost.ag>
 <986F41761DD1467EA38C8C853CFE8160@inktank.com>
 <4FBE7885.6080200@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933458Ab2EXSOP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 14:14:15 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so593608pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 11:14:15 -0700 (PDT)
In-Reply-To: <4FBE7885.6080200@inktank.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Thursday, May 24, 2012 at 11:05 AM, Josh Durgin wrote:
> Why not have the read benchmark write data itself, and then benchmark
> reading? Then both read and write benchmarks can clean up after
> themselves.
> 
> It's a bit odd to have the read benchmark depend on you running a write
> benchmark first.
> 
> Josh 
We've talked about that and decided we didn't like it. I think it was about being able to repeat large read benchmarks without having to wait for all the data to get written out first, and also (although this was never implemented) being able to implement random read benchmarks and things in ways that allowed you to make the cache cold first.
Which is not to say that changing it is a bad idea; I could be talked into that or somebody else could do it. :)
-Greg

