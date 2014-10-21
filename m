From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] RADOS pool snaps and RBD
Date: Tue, 21 Oct 2014 15:46:03 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410211540430.29946@cobra.newdream.net>
References: <BD99EB262C32654EBEA452C5D5ED37C202A916A076@ST-SRV-05.silicontower.lan> <alpine.DEB.2.00.1410202035160.13498@cobra.newdream.net> <BD99EB262C32654EBEA452C5D5ED37C202A916FA53@ST-SRV-05.silicontower.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32948 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933394AbaJUWqE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Oct 2014 18:46:04 -0400
In-Reply-To: <BD99EB262C32654EBEA452C5D5ED37C202A916FA53@ST-SRV-05.silicontower.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xavier Trilla <xavier.trilla@silicontower.net>
Cc: ceph-devel@vger.kernel.org

Hi Xavier,

[Moving this to ceph-devel]

On Tue, 21 Oct 2014, Xavier Trilla wrote:
> Hi Sage,
> 
> Yes, I know about rbd diff, but the motivation behind this was to be 
> able to dump an entire RBD pool via RADOS to another cluster, as our 
> primary cluster uses quite expensive SSD storage and we would like to 
> avoid constantly keeping one snapshot for every RBD image.
> 
> The idea would be to use the mtime of an object to determine if it 
> changed after the last backup. If it changed we just dump it to the 
> backup cluster. I understand it would consume more space than rbd 
> snapshot diff as we would dump the whole object, not just the new data, 
> but on the other side the space would be only wasted on the destination 
> cluster, which uses cheap rotational disks. I think it could be a good 
> idea, let's say it would be a sort of RADOS level incremental backup for 
> RBD pools.
> 
> So far, we found a way to do it, the only issue is that data would 
> change during the dump as RBD images are in use, and that's why we 
> wanted to use rados pool snapshots, but considering pool snapshots and 
> RBD snapshots are mutually exclusive it could be a problem.

Right.  For RBD you need to snapshot each image independently.

> After playing a little bit with RBD snapshots I realized we could use 
> RBD snapshots instead of rados pool snapshots to get a consistent copy 
> of an image, but I don't find a way to retrieve the original object 
> after the RBD snapshot using rados command.

Yeah, the CLI command won't do it.  You need to use the C, C++, or Python 
API directly.  Basically, you need to map the data object back to the RBD 
header (which you can do by looking for the rbd_header object with the 
same fingerprint as the data block) to get the list of snaps for that 
image.  You use that to construct a snap context to read the right snap...

...but, that is all done for you by librbd.  Just (using the C/C++/Python 
librbd bindings) list the images in the pool, and for each image open a 
handle for the right snapshot, and export that way.  It will probably even 
perform better since the IO load is spread across the cluster instead of 
traversing each PG in order...

sage


 > 
> As I understand RBD uses RADOS object snapshots to provide snapshots for 
> RBD images. For example:
> 
> RADOS object, part of an RBD image before the snapshot (output of rados 
> listsnaps <object_name>:
> 
> rbd_data.170856ea75e60.0000000000000003:
> cloneid snaps   size    overlap
> head    -       4194304
> 
> And after some writes have been done to some of the blocks contained into this object: 
> 
> rbd_data.170856ea75e60.0000000000000003:
> cloneid snaps   size    overlap
> 8       8       4194304 [0~3145728,3149824~1044480]
> head    -       4194304
> 
> And again after the RBD snapshot has been deleted:
> 
> rbd_data.170856ea75e60.0000000000000003:
> cloneid snaps   size    overlap
> head    -       4194304
> 
> So, if I would need a way to retrieve the "head" (which, and maybe I'm totally wrong, I understand should be the original object before the snapshot) to dump it to another ceph cluster ( Preferably using a command line tool, as I'm trying to prototype something using shell script).
> 
> How RBD works (rbd_directory, rbd_header, omap values, etc...) seems 
> pretty clear, but it seems RBD is using some kind of rados object level 
> snapshots and I could not find documentation about that feature.
> 
> Thanks!
> 
> Saludos cordiales,
> Xavier Trilla P.
> Silicon Hosting
> 
> ?Sab?as que ahora en SiliconHosting 
> resolvemos tus dudas t?cnicas gratis?
> 
> M?s informaci?n en: siliconhosting.com/qa/
> 
> 
> -----Mensaje original-----
> De: Sage Weil [mailto:sage@newdream.net] 
> Enviado el: martes, 21 de octubre de 2014 5:45
> Para: Xavier Trilla
> CC: ceph-users@lists.ceph.com
> Asunto: Re: [ceph-users] RADOS pool snaps and RBD
> 
> On Mon, 20 Oct 2014, Xavier Trilla wrote:
> > Hi,
> > 
> > It seems Ceph doesn't allow rados pool snapshots on RBD pools which have or had RBD snapshots. They only work on RBD pools which never had a RBD snapshot. 
> > 
> > So, basically this works:
> > 
> > rados mkpool test-pool 1024 1024 replicated rbd -p test-pool create 
> > --size=102400 test-image ceph osd pool mksnap test-pool rados-snap
> > 
> > But this doesn't:
> > 
> > rados mkpool test-pool 1024 1024 replicated rbd -p test-pool create 
> > --size=102400 test-image rbd -p test-pool snap create 
> > test-image@rbd-snap ceph osd pool mksnap test-pool rados-snap
> > 
> > And we get the following error message:
> > 
> > Error EINVAL: pool test-pool is in unmanaged snaps mode
> > 
> > I've been checking the source code and it seems to be the expecte behavior, but I did not manage to find any information regarding "unmanaged snaps mode". Also I did not find any information about RBD snapshots and pool snapshots being mutually exclusive. And even deleting all the RBD snapshots in a pool doesn't enable RADOS snapshots again. 
> > 
> > So, I have a couple of questions:
> > 
> > - Are RBD and RADOS snapshots mutually exclusive?
> 
> Xinxin already mentioned this, but to confirm, yes.
> 
> > - What does mean "unmanaged snaps mode" message?
> 
> It means the librados user is manaing its own snapshot metadata.  I this case, that's RBD; it stores information about what snapshots apply to what images in the RBD header object.
> 
> > - Is there any way to revert a pool status to allow RADOS pool snapshots after all RBD snapshots are removed? 
> 
> No.
> 
> > We are designing a quite interesting way to perform incremental 
> > backups of RBD pools managed by OpenStack Cinder. The idea is to do 
> > the incremental backup at a RADOS level, basically using the mtime 
> > property of the object and comparing it against the time we did the 
> > last backup / pool snapshot. That way it should be really easy to find 
> > modified objects transferring only them, making the implementation of 
> > a DR solution easier.. But the issue explained here would be a big 
> > problem, as the backup solution would stop working if just one user 
> > creates a RBD snapshot on the pool (For example using Cinder Backup).
> 
> This is already possible using the diff-export and diff-import functions of RBD on a per-image granularity.  I think the only thing it doesn't provide is the ability to build a consistency group of lots of images and snapshot them together.
> 
> Note also that listing all objects to find the changed ones is not very efficient.  The export-diff function is currnetly also not very efficient (it enumerates image objects), but the 'object map' changes that Jason is working on for RBD will fix this and make it quite fast.
> 
> sage
> 
> 
> 
> > 
> > I hope somebody could give us more information about this "unmanaged 
> > snaps mode" or point us to a way to revert this behavior once all RBD 
> > snapshots have been removed from a pool.
> > 
> > Thanks!
> > 
> > Saludos cordiales,
> > Xavier Trilla P.
> > Silicon Hosting
> > 
> > ?Sab?as que ahora en SiliconHosting
> > resolvemos tus dudas t?cnicas gratis?
> > 
> > M?s informaci?n en: siliconhosting.com/qa/
> > 
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > 
> > 
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
