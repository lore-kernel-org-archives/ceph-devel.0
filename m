From: Sage Weil <sage@newdream.net>
Subject: Re: looks like a bug
Date: Tue, 19 Jul 2011 08:49:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107190848360.24443@cobra.newdream.net>
References: <4E254135.70603@ufm.su> <Pine.LNX.4.64.1107190729150.5656@cobra.newdream.net>
 <4E259728.8050908@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52708 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab1GSPp7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2011 11:45:59 -0400
In-Reply-To: <4E259728.8050908@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Tue, 19 Jul 2011, Fyodor Ustinov wrote:
> On 07/19/2011 05:31 PM, Sage Weil wrote:
> > Hi Fyodor,
> > 
> > Which commits are you running on the server and client side?  There was a
> > bad protocol version number in master branch for several days (fixed now),
> > and some open intent stuff in ceph-client.git that wasn't quite right a
> > bit further back.
> > 
> > thanks-
> > sage
> 
> If I do not specify the version it means that I'm using the latest available
> official version for ubuntu from your aptitude repository.

Okay, I found the problem (file mode calculation when O_APPEND is 
present).  There is a fix pushed to the stable branch of ceph.git (for 
mds) and to the for-linus branch of the kernel ceph-client.git.  You need 
both to behave.

What workload turned this up?

Thanks-
sage
