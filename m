From: Sage Weil <sage@inktank.com>
Subject: Re: Current OSD weight vs. target weight
Date: Thu, 17 Jan 2013 09:32:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301170927560.12717@cobra.newdream.net>
References: <50F81FB1.2060909@de-punkt.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33568 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab3AQRcq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 12:32:46 -0500
In-Reply-To: <50F81FB1.2060909@de-punkt.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christopher Kunz <chrislist@de-punkt.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 17 Jan 2013, Christopher Kunz wrote:
> Hi,
> 
> if run during a user-issued reweight (i.e. "ceph osd crush reweight x
> y"), "ceph osd tree" shows the target weight of an OSD. Is there a way
> to see the *current* weight of the OSD?
> 
> We would like to be able to approximate the amount of rollback necessary
> per OSD if we need to cancel a larger reweight at some point. This seems
> impossible, though, without knowing the current weight.
> 
> Any hints how to do this?

There are two things you have: the previous weight (before you changed it,
if you remember), and what you see from 'df'.  The latter is found in the 
tail end of the 'ceph pg dump' output.

The thing to keep in mind, though, is that rolling back doesn't generally 
let you capture partial rebalance progress.  If you change the weight of a 
node from 1 to .8, wait for about half of the data to move, and then 
change it to .9, half will be remapped back to the original location, but 
it is a different random subset of the data.. which mean that 1/4 will 
have been moved and be in the right place, 1/4 will have moved but have to 
move back, 1/4 will not have moved but still need to move, and 1/4 will 
have not moved and not need to.

So in the end, that "half-way point" is similar to the point of no return: 
it's just as much work to go back as it is to finish.  If you are going to 
correct mid-stream, I would try to do so quickly, and probably just go 
back to the original weight instead of something in-between.

sage


> 
> Regards,
> 
> --ck
> 
> -- 
> filoo GmbH
> Dr. Christopher Kunz
> 
> E-Mail: chris@filoo.de
> Tel.: (+49) 0 52 41 8 67 30 -18
> Fax: (+49) 0 52 41 / 8 67 30 -20
> 
> Please sign & encrypt mail wherever possible, my key:
> C882 8ED1 7DD1 9011 C088 EA50 5CFA 2EEB 397A CAC1
> 
> Moltkestra?e 25a
> 33330 G?tersloh
> 
> HRB4355, AG G?tersloh
> Gesch?ftsf?hrer: S.Grewing, J.Rehp?hler, Dr. C.Kunz
> 
> Filoo im Web: http://www.filoo.de/
> Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
> Werden Sie unser Fan auf Facebook: http://facebook.com/filoogmbh
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
