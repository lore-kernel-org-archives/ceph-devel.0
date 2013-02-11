From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] snapshot, clone and mount a VM-Image
Date: Mon, 11 Feb 2013 06:28:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302110624370.5429@cobra.newdream.net>
References: <5118C6BF.70207@risc-software.at> <5118FA0D.606@42on.com> <5118FB31.6020902@risc-software.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35675 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660Ab3BKO2x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 09:28:53 -0500
In-Reply-To: <5118FB31.6020902@risc-software.at>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Cc: ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

On Mon, 11 Feb 2013, Wolfgang Hennerbichler wrote:
> 
> 
> On 02/11/2013 03:02 PM, Wido den Hollander wrote:
> 
> > You are looking at a way to "extract" the snapshot, correct?
> 
> No.
> 
> > Why would
> > you want to mount it and backup the files?
> 
> because then I can do things like incremental backups. There will be a
> ceph cluster at an ISP soon, who hosts various services on various VMs,
> and it is important that the mailspool for example is backed up
> efficiently, because it's huge and the number of files is also high.

Note that an alternative way to approach incremental backups is at the 
block device level.  We plan to implement an incremental backup function 
for the relative change between two snapshots (or a snapshot and the 
head).  It's O(n) the size of the device vs the number of files, but 
should be more efficient for all but the most sparse of images.  The 
implementation should be simple; the challenge is mostly around the 
incremental file format, probably.

That doesn't help you now, but would be a relatively self-contained piece 
of functionality for someone to contribute to RBD.  This isn't a top 
priority yet, so it will be a while before the inktank devs can get to it.

sage


> 
> > Couldn't you better handle this in the Virtual Machine itself?
> 
> not really. open, changing files, a lot of virtual machines that one
> needs to take care of, and so on.
> 
> > If you want to backup the virtual machines to an extern location you
> > could use either "rbd" or "qemu-img" to get the snapshot out of the Ceph
> > cluster:
> > 
> > $ rbd export --snap <snapshot> <image name> <destination>
> > 
> > Or use qemu-img
> > 
> > $ qemu-img convert -f raw -O qcow2 -s <snapshot> rbd:rbd/<image>
> > <image>.qcow2
> > 
> > You then get files which you can backup externally.
> > 
> > Would that work?
> 
> sure, but this is a very inefficient way of backing things up, because
> one would back up on block level. I want to back up on filesystem level.
> 
> > Wido
> > 
> >> thanks a lot for you answers
> >> Wolfgang
> >>
> > 
> > 
> 
> 
> -- 
> DI (FH) Wolfgang Hennerbichler
> Software Development
> Unit Advanced Computing Technologies
> RISC Software GmbH
> A company of the Johannes Kepler University Linz
> 
> IT-Center
> Softwarepark 35
> 4232 Hagenberg
> Austria
> 
> Phone: +43 7236 3343 245
> Fax: +43 7236 3343 250
> wolfgang.hennerbichler@risc-software.at
> http://www.risc-software.at
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
