From: Sage Weil <sage@newdream.net>
Subject: Re: Filesystems for ceph
Date: Wed, 27 Jul 2011 21:39:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107272136110.29447@cobra.newdream.net>
References: <CAO47_-8nD4XLgBP9+nDxasO548ZXcTzMm3M+P=ewdQR3EwoqUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54855 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab1G1Efl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2011 00:35:41 -0400
In-Reply-To: <CAO47_-8nD4XLgBP9+nDxasO548ZXcTzMm3M+P=ewdQR3EwoqUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Wed, 27 Jul 2011, Christian Brunner wrote:
> We are having quite some problems with the underlying filesystem for
> the cosd's and I would like to hear about other experiences. Here is
> what we have gone through so far:
> 
> btrfs with 2.6.38:
> 
> - good performance
> - frequently hitting of various BUG_ON conditions
> 
> btrfs with 2.6.39:
> 
> - big performance problems after a few days uptime
> - occasionally hitting BUG_ON conditions
> 
> btrfs with 3.0:
> 
> - big performance problems after a few days uptime
> - occasionally hitting a deadlock in the btrfs filesystem (cosd is in D-state)

You might try 3.0 + the latest stuff Chris just sent to Linus (at least 
for the D-state problem).  I'm eager to see whether the latencytop info 
you sent is helpful for the rest.

FWIW we're running 2.6.38+ at the moment.  We get some warnings with the 
orphan code (fixed in .39), but it's otherwise been reasonably stable.  

sage
