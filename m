From: Sage Weil <sage@inktank.com>
Subject: Re: branches
Date: Fri, 18 Jan 2013 10:32:25 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301181031130.8622@cobra.newdream.net>
References: <alpine.DEB.2.00.1301081038580.30467@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47768 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab3ARScZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 13:32:25 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 97ACC80079
	for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 10:32:25 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7232A80079
	for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 10:32:25 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301081038580.30467@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I went ahead and made this change last week.

Just a remind, the new world order is:

> master
>  - active development
> next
>  - frozen for next release
>  - bug fixes only
>  - regularly merged back into master
> last
>  - last release (instead of 'testing')
>  - packages at /debian-testing and /debian-last, /rpm-testing, /rpm-last
> bobtail
>  - bobtail backport series 0.56.x
>  - packages at /debian-bobtail (and /debian, until cuttlefish), 
>    /rpm-bobtail, /rpm
> argonaut
>  - argonaut backport series 0.48.x
>  - packages at /debian-argonaut

sage
