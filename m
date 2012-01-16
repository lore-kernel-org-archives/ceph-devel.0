From: Sage Weil <sage@newdream.net>
Subject: Re: Assertion in v0.40 - os/FileStore.cc: 2438: FAILED assert(0 ==
 "unexpected error")
Date: Sun, 15 Jan 2012 22:14:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201152206140.27571@cobra.newdream.net>
References: <4F1193DE.7040202@tuxadero.com> <Pine.LNX.4.64.1201141835180.21391@cobra.newdream.net>
 <4F12BAF9.4040301@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53700 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab2APGOi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jan 2012 01:14:38 -0500
In-Reply-To: <4F12BAF9.4040301@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

On Sun, 15 Jan 2012, Martin Mailand wrote:
> Hi Sage,
> that's exactly what I did, the first two crashes are in this log,
> unfortunately there was no debug level set.

Whoops, right.. the (old) replay messages above confused me.  

There are a couple possibilities here.  One is that the recovery code went 
in the wrong order.  I'm a bit skeptical, though, and even if it did, this 
was mostly just rewritten in wip-backfill for 0.41, so I don't think it's 
worth debugging.  We have some tools to hammer on then snapshot + 
recovery code, but they aren't in the regular qa rotation yet.

More likely is that the SnapSet notion of clone_overlap got out of sync 
with the actual clones.  To check that, we need a dump of the xattrs on 
the _head object.  File sizes and attrs for the clones would help too.

Are the _2 clone objects on other replicas 4MB or 23 bytes?

Is this keeping your cluster down?  If so, you can work around the problem 
by making the _2 clone object 4MB so that reply will succeed.  Just be
aware that that rbd image's content will be corrupted.  :/

sage


> 
> http://85.214.49.87/ceph/osd.0.full.log.bz2
> 
> -martin
> 
> 
> 
> Am 15.01.2012 03:45, schrieb Sage Weil:
> > Hi Martin-
> > 
> > On Sat, 14 Jan 2012, Martin Mailand wrote:
> > 
> > > Hi
> > > one of four OSD died during the update to v0.40 with an Assertion
> > > os/FileStore.cc: 2438: FAILED assert(0 == "unexpected error")
> > > Even after a complete shutdown of the cluster an a new start with all OSD
> > > at
> > > the same version, this osd did not start.
> > > 
> > > The OSD Log it attached.
> > 
> > It's trying to replay a transaction that appears to be invalid because the
> > .2 clone is smaller than it thinks.  Is this the first time the OSD
> > crashed, or did it crash once, and you cranked up logs and generated
> > this one?  If you have the previous log, that would be helpful... it
> > should have a similar tranasction dump but a different stack trace.
> > 
> > Also, are any of the 6 patches on top of 0.40 related to the filestore or
> > osd?
> > 
> > Thanks!
> > sage
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
