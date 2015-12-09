From: Sage Weil <sweil@redhat.com>
Subject: Re: new OSD re-using old OSD id fails to boot
Date: Wed, 9 Dec 2015 06:00:06 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512090555030.12816@cobra.newdream.net>
References: <5663158D.1010302@dachary.org> <56678036.5050909@redhat.com> <alpine.DEB.2.00.1512081838240.25269@cobra.newdream.net> <CABF_e-FC7TGFw9=_zEB2-GX=3EOcoX-oc6=L=NPbuipBRo+atg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56792 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754924AbbLIOAK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 Dec 2015 09:00:10 -0500
In-Reply-To: <CABF_e-FC7TGFw9=_zEB2-GX=3EOcoX-oc6=L=NPbuipBRo+atg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>
Cc: David Zafman <dzafman@redhat.com>, Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 9 Dec 2015, Wei-Chung Cheng wrote:
> Hi Loic,
> 
> I try to reproduce this problem on my CentOS7.
> I can not do the same issue.
> This is my version:
> ceph version 10.0.0-928-g8eb0ed1 (8eb0ed1dcda9ee6180a06ee6a4415b112090c534)
> Would you describe more detail?
> 
> 
> Hi David, Sage,
> 
> In most of time, when we found the osd failure, the OSD is already in
> `out` state.
> It could not avoid the redundant data movement unless we could set the
> osd noout when failure.
> Is it right? (Means if OSD go into `out` state, it will make some
> redundant data movement)
> 
> Could we try the traditional spare behavior? (Set some disks backup
> and auto replace the broken device?)
> 
> That can replace the failure osd before it go into the `out` state.
> Or we could always set the osd noout?

I don't think there is a problem with 'out' if the osd id is reused and 
the crush position remains the same.  And I expect usually the OSD will be 
replaced by a disk with a similar size.  If the replacement is smaller (or 
0--removed entirely) then you get double-movement, but if it's the same or 
larger I think it's fine.

The sequence would be something like

 up + in
 down + in 
 5-10 minutes go by
 down + out    (marked out by monitor)
  new replicas uniformly distributed across cluster
 days go by
 disk removed
 new disk inserted
 ceph-disk recreate ... recreates osd dir w/ the same id, new uuid
 on startup, osd adjusts crush weight (maybe.. usually by a smallish amount) 
 up + in
  replicas migrate back to new device

sage

