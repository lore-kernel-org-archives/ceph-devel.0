From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Adding compression/checksum support for bluestore.
Date: Thu, 31 Mar 2016 16:32:52 +0000
Message-ID: <CY1PR0201MB1897E7C6A58679883F375F60E8990@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
 <56FD4FEC.4060000@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0064.outbound.protection.outlook.com ([207.46.100.64]:47136
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752260AbcCaQdA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 12:33:00 -0400
In-Reply-To: <56FD4FEC.4060000@mirantis.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> Sent: Thursday, March 31, 2016 9:27 AM
> To: Sage Weil <sage@newdream.net>; Allen Samuels
> <Allen.Samuels@sandisk.com>
> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> Subject: Re: Adding compression/checksum support for bluestore.
> 
> 
> 
> On 31.03.2016 1:15, Sage Weil wrote:
> > On Wed, 30 Mar 2016, Allen Samuels wrote:
> >> [snip]
> >>
> >> Time to talk about checksums.
> >>
> >> First let's divide the world into checksums for data and checksums
> >> for metadata -- and defer the discussion about checksums for metadata
> >> (important, but one at a time...)
> >>
> >> I believe it's a requirement that when checksums are enabled that
> >> 100% of data reads must be validated against their corresponding
> checksum.
> >> This leads you to conclude that you must store a checksum for each
> >> independently readable piece of data.
> > I'm just worried about the size of metadata if we have 4k checksums
> > but have to read big extents anyway; cheaper to store a 4 byte
> > checksum for each compressed blob.
> 
> But do we really need to store checksums as metadata?
> What's about pre(post)fixing 4K-4(?) blob with the checksum and store this
> pair to the disk.
> IMO we always need checksum values along with blob data thus let's store
> and read them together.
> This immediately eliminates the question about the granularity and
> corresponding overhead...
> 
> Have I missed something?
> 

If you store them inline with the data then nothing lines up on boundaries that the HW designers expect and you end up doing things like extra-copying of every data buffer. This will kill performance.

If you store them in a separate place (not in metadata, not contiguous to data) then you'll have a full extra I/O that might even move the head (yikes!). Plus you'll have to deal with the RMW of these tiny things.

Putting them in the metadata is really the only viable option.
