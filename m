From: Sage Weil <sweil@redhat.com>
Subject: Re: [GSOC] Bluestore SMR Support
Date: Thu, 12 May 2016 08:29:46 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605120825260.23446@cpach.fuggernut.com>
References: <CAPLK-i_BhD9fDFPucg9N6RW8F7N-sfmz81fa_YzOf3Hi+TWkXg@mail.gmail.com> <alpine.DEB.2.11.1604240848580.8831@cpach.fuggernut.com> <CAPLK-i83V8EsaotfM3CVWfyFJYMQvFaD0B3ofLBN=4TVFDr4+Q@mail.gmail.com> <alpine.DEB.2.11.1604251321280.25990@cpach.fuggernut.com>
 <CAPLK-i8AoAWNDbGrBVewFR=dQqB3Z=y_9Cab5F4jDoF3NJ-rwQ@mail.gmail.com> <BN3PR02MB12063D84EB4598ABBCB55FE8E8620@BN3PR02MB1206.namprd02.prod.outlook.com> <CAPLK-i8TBKTZitbWLvMAwyVLVpCj12GL41ZB_eoMvHKitd3QGg@mail.gmail.com> <alpine.DEB.2.11.1605101105170.15518@cpach.fuggernut.com>
 <CAPLK-i_N7yseOVndAdCELTzTTrpBQ05aXb4SRKX_P2Lgng2yuQ@mail.gmail.com> <alpine.DEB.2.11.1605110844530.15518@cpach.fuggernut.com> <CAPLK-i_gqbieDJ2ESUgi_t9hU-hwts2dfnCJhYg9Ug_uyepNEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1064200188-1463056189=:23446"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44575 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932121AbcELM3e (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 May 2016 08:29:34 -0400
In-Reply-To: <CAPLK-i_gqbieDJ2ESUgi_t9hU-hwts2dfnCJhYg9Ug_uyepNEw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shehbaz Jaffer <shehbazjaffer007@gmail.com>
Cc: Allen Samuels <allen.samuels@sandisk.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1064200188-1463056189=:23446
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 12 May 2016, Shehbaz Jaffer wrote:
> Hi Sage,
> 
> > Hmm, good question.  My assumption was that even a drive-managed drive 
> > would expose the zone layout via libzbc, such that we can control IO 
> > to avoid any remapping machinery in the drive.  
> 
> A drive managed SMR drive will not expose Zone information to Host, 
> so libzbc would have failed to run ZBC/ZAC commands. However the drive
> that has been shipped is fortunately not drive managed, but host aware!

Ah, perfect!

> > Does libzbc recognize the drive?
> 
> Yes!
> I am able to detect zones and run libzbc tests on these drives. 
> If we do random writes or do not abide by zone 
> rules, the writes will be serialized internally which works to our
> advantage.
> 
> This is what one of the zbc_info command from libzbc gives me:
> 
> $ sudo zbc_info /dev/sg1
> Device /dev/sg1: ATA ST8000AS0022-1WL SN01 
>     ATA ZAC interface, Host-aware disk model
>     15628053168 logical blocks of 512 B
>     1953506646 physical blocks of 4096 B
>     8001.563 GB capacity

Yay!  Does zbc it describe the region/size of the drive that is random 
access too?

> A detailed version of libzbc tests can be viewed here: 
> http://tracker.ceph.com/projects/ceph/wiki/BlueStore_SMR_Support_GSOC_2016_
> Progress_Report

What are the failed tests 010 and 011 about?

> I can successfully query zones, the current write pointer, zone size, 
> offset and so on.  In terms of next steps, I am running into some 
> permission issues with Ceph setup,  and I am working on resolving them.

Ping any of us in #ceph-devel with any questions.

> I am also following a commit by Ramesh (Sandisk) for bitmap allocator.  
> Once the setup is done, I think I will first run the Bluestore stupid 
> allocator and do some performance benchmarks. Then I can explore how we 
> can make things better. Please let me know if this approach sounds good.

Yep, that sounds good!
sage
--8323329-1064200188-1463056189=:23446--
