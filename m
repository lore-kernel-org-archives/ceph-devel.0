From: Sage Weil <sage@inktank.com>
Subject: Re: ceph next branch: error creating empty object store in /srv/osd.10:
 (22) Invalid argument
Date: Fri, 15 Jun 2012 09:29:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206150927040.4551@cobra.newdream.net>
References: <4FD9D187.8030601@profihost.ag> <4FD9D366.3060305@profihost.ag>
 <Pine.LNX.4.64.1206141315390.23137@cobra.newdream.net> <4FDACD26.4030803@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50032 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261Ab2FOQ3j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 12:29:39 -0400
In-Reply-To: <4FDACD26.4030803@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 15 Jun 2012, Stefan Priebe - Profihost AG wrote:
> Am 14.06.2012 22:17, schrieb Sage Weil:
> > On Thu, 14 Jun 2012, Stefan Priebe - Profihost AG wrote:
> > Is it possible that the osd journal you configured is a file in the osd
> > data directory that doesn't already exist
> Sure is this wrong?
> [osd]
>         osd journal = /journal/osd.$id.journal
>         osd journal size = 1000
> 
> and the /journal dir is empty.
> 
> >, and you didn't specify the 'osd
> > journal size' option in ceph.conf?
> no it is - see above

Hmm, ok, so it's not that then.

> > The change here is that ceph-osd --mkfs no longer wipes out previous data,
> > so that's now your job.
> ah OK ;-) didn't know that.
> 
> > But it only creates the journal file when the
> > size is specified, otherwise it needs to already be present...
> It wasn't present but the size was set. Strangely the error occours but it
> still creates the file... ?!

It sure is.

Can you reproduce with 'debug filestore = 20' and attach the log to this 
bug?

	http://tracker.newdream.net/issues/2595

Thanks!
sage
