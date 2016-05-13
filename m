From: Shehbaz Jaffer <shehbazjaffer007@gmail.com>
Subject: Re: [GSOC] Bluestore SMR Support
Date: Fri, 13 May 2016 00:07:25 -0400
Message-ID: <CAPLK-i_uUjhZkN0PasY+f7ufG8_amxeuE-dtqdyAKQtP8ueQGg@mail.gmail.com>
References: <CAPLK-i_BhD9fDFPucg9N6RW8F7N-sfmz81fa_YzOf3Hi+TWkXg@mail.gmail.com>
	<alpine.DEB.2.11.1604240848580.8831@cpach.fuggernut.com>
	<CAPLK-i83V8EsaotfM3CVWfyFJYMQvFaD0B3ofLBN=4TVFDr4+Q@mail.gmail.com>
	<alpine.DEB.2.11.1604251321280.25990@cpach.fuggernut.com>
	<CAPLK-i8AoAWNDbGrBVewFR=dQqB3Z=y_9Cab5F4jDoF3NJ-rwQ@mail.gmail.com>
	<BN3PR02MB12063D84EB4598ABBCB55FE8E8620@BN3PR02MB1206.namprd02.prod.outlook.com>
	<CAPLK-i8TBKTZitbWLvMAwyVLVpCj12GL41ZB_eoMvHKitd3QGg@mail.gmail.com>
	<alpine.DEB.2.11.1605101105170.15518@cpach.fuggernut.com>
	<CAPLK-i_N7yseOVndAdCELTzTTrpBQ05aXb4SRKX_P2Lgng2yuQ@mail.gmail.com>
	<alpine.DEB.2.11.1605110844530.15518@cpach.fuggernut.com>
	<CAPLK-i_gqbieDJ2ESUgi_t9hU-hwts2dfnCJhYg9Ug_uyepNEw@mail.gmail.com>
	<alpine.DEB.2.11.1605120825260.23446@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36428 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbcEMEH0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2016 00:07:26 -0400
Received: by mail-yw0-f170.google.com with SMTP id o66so104312111ywc.3
        for <ceph-devel@vger.kernel.org>; Thu, 12 May 2016 21:07:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605120825260.23446@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Allen Samuels <allen.samuels@sandisk.com>, ceph-devel@vger.kernel.org

Hi Sage,

> Does zbc it describe the region/size of the drive that is random access too?

Yes, Here is a summary of the drive:

Size of Disk : 8 TB
Total number of Zones : 29,809.  each zone size = 256 MB
Conventional zones : 16 GB (64 zones, located at the very start LBA of
the disk). We can do random writes on these zones.
Write-preferred zones : rest of the disk

Optimal number of open sequential write preferred zones: 128 (we can
do 128 multi-threaded writes here)
Optimal number of non-sequentially written sequential write preferred
zones: 8 (maximum non-sequential zones that could be written randomly
to get optimal performance)

> What are the failed tests 010 and 011 about?

The tests correspond to reporting zones in SCSI device. There seems to
be a problem with ASCQ (Additional Sense Code Qualifier) checks for
the SCSI device. Since the drive is ATA, it probably does not abide by
SCSI interface. I am not 100 percent sure, so I have raised an issue
with libzbc here:
https://github.com/hgst/libzbc/issues/16


On Thu, May 12, 2016 at 8:29 AM, Sage Weil <sweil@redhat.com> wrote:
>
> On Thu, 12 May 2016, Shehbaz Jaffer wrote:
> > Hi Sage,
> >
> > > Hmm, good question.  My assumption was that even a drive-managed drive
> > > would expose the zone layout via libzbc, such that we can control IO
> > > to avoid any remapping machinery in the drive.
> >
> > A drive managed SMR drive will not expose Zone information to Host,
> > so libzbc would have failed to run ZBC/ZAC commands. However the drive
> > that has been shipped is fortunately not drive managed, but host aware!
>
> Ah, perfect!
>
> > > Does libzbc recognize the drive?
> >
> > Yes!
> > I am able to detect zones and run libzbc tests on these drives.
> > If we do random writes or do not abide by zone
> > rules, the writes will be serialized internally which works to our
> > advantage.
> >
> > This is what one of the zbc_info command from libzbc gives me:
> >
> > $ sudo zbc_info /dev/sg1
> > Device /dev/sg1: ATA ST8000AS0022-1WL SN01
> >     ATA ZAC interface, Host-aware disk model
> >     15628053168 logical blocks of 512 B
> >     1953506646 physical blocks of 4096 B
> >     8001.563 GB capacity
>
> Yay!  Does zbc it describe the region/size of the drive that is random
> access too?
>
> > A detailed version of libzbc tests can be viewed here:
> > http://tracker.ceph.com/projects/ceph/wiki/BlueStore_SMR_Support_GSOC_2016_
> > Progress_Report
>
> What are the failed tests 010 and 011 about?
>
> > I can successfully query zones, the current write pointer, zone size,
> > offset and so on.  In terms of next steps, I am running into some
> > permission issues with Ceph setup,  and I am working on resolving them.
>
> Ping any of us in #ceph-devel with any questions.
>
> > I am also following a commit by Ramesh (Sandisk) for bitmap allocator.
> > Once the setup is done, I think I will first run the Bluestore stupid
> > allocator and do some performance benchmarks. Then I can explore how we
> > can make things better. Please let me know if this approach sounds good.
>
> Yep, that sounds good!
> sage




-- 
Shehbaz Jaffer
First Year Graduate Student
Sir Edward S Rogers Sr Department of Electrical and Computer Engineering
University of Toronto
