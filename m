From: Sage Weil <sweil@redhat.com>
Subject: Re: new OSD re-using old OSD id fails to boot
Date: Wed, 9 Dec 2015 12:08:30 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512091207200.25269@cobra.newdream.net>
References: <5663158D.1010302@dachary.org> <56678036.5050909@redhat.com> <alpine.DEB.2.00.1512081838240.25269@cobra.newdream.net> <CABF_e-FC7TGFw9=_zEB2-GX=3EOcoX-oc6=L=NPbuipBRo+atg@mail.gmail.com> <56688726.5000609@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38786 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbbLIUId (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 Dec 2015 15:08:33 -0500
In-Reply-To: <56688726.5000609@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>, Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 9 Dec 2015, David Zafman wrote:
> On 12/9/15 2:39 AM, Wei-Chung Cheng wrote:
> > Hi Loic,
> > 
> > I try to reproduce this problem on my CentOS7.
> > I can not do the same issue.
> > This is my version:
> > ceph version 10.0.0-928-g8eb0ed1 (8eb0ed1dcda9ee6180a06ee6a4415b112090c534)
> > Would you describe more detail?
> > 
> > 
> > Hi David, Sage,
> > 
> > In most of time, when we found the osd failure, the OSD is already in
> > `out` state.
> > It could not avoid the redundant data movement unless we could set the
> > osd noout when failure.
> > Is it right? (Means if OSD go into `out` state, it will make some
> > redundant data movement)
> Yes, one case would be that during the 5 minute down window of an OSD disk
> failure, the noout flag can be set if a spare disk is available.  Another
> scenario would be a bad SMART status or noticing EIO errors from a disk
> prompting a replacement.  So if a spare disk is already installed or you have
> hot swappable drives, it would be nice to replace the drive and let recovery
> copy back all the data that should be there.  Using noout would be critical to
> this effort.
> 
> I don't understand why Sage suggests below that a down+out phase would be
> required during the replacement.

Hmm, I wasn't thinking about a hot spare scenario.  We've always assumed 
that there is no point to hot spares--you may as well have them 
participating in the cluster, doing useful work, and let the failure 
rebalance distributed across all disks (and not hammer the replacement).

sage


> > 
> > Could we try the traditional spare behavior? (Set some disks backup
> > and auto replace the broken device?)
> > 
> > That can replace the failure osd before it go into the `out` state.
> > Or we could always set the osd noout?
> > 
> > In fact, I think these is a different problems between David and Loic.
> > (these two problems are the same import :p
> > 
> > If you have any problems, feel free to let me know.
> > 
> > thanks!!
> > vicente
> > 
> > 
> > 2015-12-09 10:50 GMT+08:00 Sage Weil <sweil@redhat.com>:
> > > On Tue, 8 Dec 2015, David Zafman wrote:
> > > > Remember I really think we want a disk replacement feature that would
> > > > retain
> > > > the OSD id so that it avoids unnecessary data movement.  See tracker
> > > > http://tracker.ceph.com/issues/13732
> > > Yeah, I totally agree.  We just need to form an opinion on how... probably
> > > starting with the user experience.  Ideally we'd go from up + in to down +
> > > in to down + out, then pull the drive and replace, and then initialize a
> Here ^^^^^^^^^^^^
> > > new OSD with the same id... and journal partition.  Something like
> > > 
> > >    ceph-disk recreate id=N uuid=U <osd device path>
> > > 
> > > I.e., it could use the uuid (which the cluster has in the OSDMap) to find
> > > (and re-use) the journal device.
> > > 
> > > For a journal failure it'd probably be different.. but maybe not?
> > > 
> > > Any other ideas?
> > > 
> > > sage
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
