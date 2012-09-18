From: Sage Weil <sage@inktank.com>
Subject: Re: How are you using Ceph?
Date: Tue, 18 Sep 2012 09:20:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209180916470.10642@cobra.newdream.net>
References: <CAHb+bZ+x3NxLBYWb-dt8CD4x4Zzud9Cqp90ug-vS=hC-O-f4wg@mail.gmail.com> <5057BAD0.8080201@smart-weblications.de> <CANLRBox_=RgEq=wOS9S8B-WxUtKvST1biyQu_8+-vXcc5kSw-A@mail.gmail.com> <alpine.DEB.2.00.1209171925270.1944@cobra.newdream.net>
 <50585F9A.7030301@smart-weblications.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59140 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab2IRQU3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Sep 2012 12:20:29 -0400
In-Reply-To: <50585F9A.7030301@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Smart Weblications GmbH - Florian Wiessner <f.wiessner@smart-weblications.de>
Cc: Tren Blackburn <tren@eotnetworks.com>, Ross Turk <ross@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 18 Sep 2012, Smart Weblications GmbH - Florian Wiessner wrote:
> Am 18.09.2012 04:32, schrieb Sage Weil:
> > On Mon, 17 Sep 2012, Tren Blackburn wrote:
> >> On Mon, Sep 17, 2012 at 5:05 PM, Smart Weblications GmbH - Florian
> >> Wiessner <f.wiessner@smart-weblications.de> wrote:
> >>>
> >>> Hi,
> >>>
> >>> i use ceph to provide storage via rbd for our virtualization cluster delivering
> >>> KVM based high availability Virtual Machines to my customers. I also use it
> >>> as rbd device with ocfs2 on top of it for a 4 node webserver cluster as shared
> >>> storage - i do this, because unfortunatelly cephfs is not ready yet ;)
> >>>
> >> Hi Florian;
> >>
> >> When you say "cephfs is not ready yet", what parts about it are not
> >> ready? There are vague rumblings about that in general, but I'd love
> >> to see specific issues. I understand multiple *active* mds's are not
> >> supported, but what other issues are you aware of?
> > 
> > Inktank is not yet supporting it because we do not have the QA in place 
> > and general hardening that will make us feel comfortable recommending it 
> > for customers.  That said, it works pretty well for most workloads.  In 
> > particular, if you stay away from the snapshots and multi-mds, you should 
> > be quite stable.
> > 
> > The engineering team here is about to do a bit of a pivot and refocus on 
> > the file system now that the object store and RBD are in pretty good 
> > shape.  That will mean both core fs/mds stability and features as well as 
> > integration efforts (NFS/CIFS/Hadoop).
> > 
> > 'Ready' is in the eye of the beholder.  There are a few people using the 
> > fs successfully in production, but not too many.
> > 
> 
> I tried it using multiple mds, because without multiple mds there is no
> redundancy and the single mds will be SPOF. I noticed things like empty

Just to clarify: by multi-mds I mean multiple *active* ceph-mds daemons.  
By default if you start a bunch of them they are just standby, ready to 
take over in the event of a failure.

> directories which could not be deleted. It said directory not empty, but it was
> empty and could not be deleted. I also noticed kernel panic on 3.2 kernels using
> kernel ceph client, or crashes with ceph-fuse. It is somewhat unstable so that i
> always had to reboot a node after a while of usage for various reasons
> (ceph-fuse crashed and messed up fuse, kernel panic using kernel ceph client,
> unable to delete files/dirs, no fsck for fixing things).
> 
> Last time i tried was simple untarring kernel tree in cephfs mountpoint - a new
> created cephfs and after 10 minutes there where errors like unable to delete
> dirs etc. Since i do not know how to reset/reformat only the cephfs part
> (without touching rbd!), i stopped testing for now. The last time i tried it i
> lost data - the data was not important and i had backups, but i was feeling
> uncomfortable now with using cephfs...

This is disconcerting.  If it is something you are able to reproduce, 
sharing those steps with us would be very helpful.

> I also did not have tried btrfs with ceph since 11/2011 again, because of losing
> data after reboots when btrfs dies, the btrfs was unmountable and there was no
> fsck so i only could reformat and wait for ceph to rebuild. After a
> powerfailure, no btrfs partitions survived and i lost all test data :/
> 
> 
> So i think the first thing to be done to cephfs would be to integrate some sort
> of fsck and the ability to format only cephfs without losing other rbd
> images/data o rados data...

FWIW it is already possible to create a new fs without touching other 
pools with the command

	ceph newfs <new metadata pool id> <new data pool id>

where the pool ids are the numeric ids (ceph osd dump | grep ^pool) for 
new, empty rados pools.

sage

> 
> 
> 
> -- 
> 
> Mit freundlichen Gr??en,
> 
> Florian Wiessner
> 
> Smart Weblications GmbH
> Martinsberger Str. 1
> D-95119 Naila
> 
> fon.: +49 9282 9638 200
> fax.: +49 9282 9638 205
> 24/7: +49 900 144 000 00 - 0,99 EUR/Min*
> http://www.smart-weblications.de
> 
> --
> Sitz der Gesellschaft: Naila
> Gesch?ftsf?hrer: Florian Wiessner
> HRB-Nr.: HRB 3840 Amtsgericht Hof
> *aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
> 
> 
