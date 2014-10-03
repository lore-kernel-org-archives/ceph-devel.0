From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Regarding key/value interface
Date: Fri, 3 Oct 2014 16:05:07 +0000
Message-ID: <7334B4281E425749B85E08CF7EC6F8532AED91C0@SACMBXIP01.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2784F809@SACMBXIP02.sdcorp.global.sandisk.com>
 <CACJqLyZkY8UNqCkSnvXbPGfqB-mdvc9StHZPOqMeWg5Z8vDymA@mail.gmail.com>
 <C226B0AB34511445928D9882AA519F6005EB60FD@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1410030759130.31126@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0054.outbound.protection.outlook.com ([65.55.169.54]:49472
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753020AbaJCQUo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Oct 2014 12:20:44 -0400
In-Reply-To: <alpine.DEB.2.00.1410030759130.31126@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Varada Kari <Varada.Kari@sandisk.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

What would be good is a set of best-practices so that if you need to move the media to another location (logical or physical, i.e., different slot, different address, different server, etc.) that all of the needed support files travel along together. Some seat belts for this would be a really good thing. 

Allen Samuels
Chief Software Architect, Emerging Storage Solutions 

951 SanDisk Drive, Milpitas, CA 95035
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Friday, October 03, 2014 8:03 AM
To: Varada Kari
Cc: Haomai Wang; Somnath Roy; ceph-devel
Subject: RE: Regarding key/value interface

On Fri, 3 Oct 2014, Varada Kari wrote:
> I am not sure, if Rocksdb/LevelDB can work on a raw device. When I 
> looked at code they were doing write to mount point/directory.

Yeah.  But as Somnath points outs others will take a raw device..

I think the main challenge there will be that there is some miscellaneous stuff that Ceph stashes in those directories to bootstrap OSDs.  Mainly there's the keyring and a 'done' file.  Probably we should add a small file that simply names the backend so that the OSD can start up with an existing store despite a change in ceph.conf.

Somnath, I don't think this is particularly problematic, though.  The dir can remain and contain a symlink to the raw device.

If we want to have hot-swappability, maybe it's possible to carve off a tiny partition on the device?  If that doesn't work, we'll have to get more creative (like teach ceph-disk how to interact with the raw device :/).

sage




> 
> Varada
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org 
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Haomai Wang
> Sent: Friday, October 03, 2014 10:55 AM
> To: Somnath Roy
> Cc: Sage Weil (sweil@redhat.com); ceph-devel
> Subject: Re: Regarding key/value interface
> 
> Correctly, maybe we can move these super metadata to backend!
> 
> On Fri, Oct 3, 2014 at 6:47 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> > Hi Sage/Haomai,
> >
> > I was going through the key/value store implementation and have one basic question regarding the way it is designed.
> >
> > I think key/value interface is assuming there will be a filesystem on top of the device . I saw in mount you are accessing files like superblock/fsid. So, for example, /var/lib/ceph/osd/ceph-0 should be a filesystem path, right ?
> > If so, this may not be the case always as there are key/value stores which can work on the raw device. In that case, these files (superblock/fsid) also need to go in the key/value db.
> >
> > Let me know if I am missing anything.
> >
> > Thanks & Regards
> > Somnath
> >
> >
> >
> > ________________________________
> >
> > PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> >
> 
> 
> 
> --
> Best Regards,
> 
> Wheat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> N?????r??y??????X???v???)?{.n?????z?]z????ay?????j ??f???h??????w???
???j:+v???w???????? ????zZ+???????j"????i
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
