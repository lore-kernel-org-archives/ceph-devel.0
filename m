From: Sage Weil <sage@inktank.com>
Subject: Re: handling fs errors
Date: Tue, 22 Jan 2013 15:09:19 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301221508310.17154@cobra.newdream.net>
References: <alpine.DEB.2.00.1301212200031.29915@cobra.newdream.net> <50FEDA79.2090203@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40070 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab3AVXJT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 18:09:19 -0500
In-Reply-To: <50FEDA79.2090203@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Cc: ceph-devel@vger.kernel.org

On Tue, 22 Jan 2013, Dimitri Maziuk wrote:
> On 01/22/2013 12:05 AM, Sage Weil wrote:
> > We observed an interesting situation over the weekend.  The XFS volume 
> > ceph-osd locked up (hung in xfs_ilock) for somewhere between 2 and 4 
> > minutes.
> ...
> 
> FWIW I see this often enough on cheap sata drives: they've a failure
> mode that makes sata driver timeout, reset the link, resend the command,
> rinse, lather, repeat. (You usually get "slow to respond, please be
> patient" and/or "resetting link" in syslog & console.) It's at the low
> enough level to freeze the whole system for minutes.

Excellent point, I'd forgotten about that.

This task is queued up for this sprint, by the way, and marked for 
backport to bobtail.

	http://tracker.newdream.net/issues/3888

Thanks-
sage

