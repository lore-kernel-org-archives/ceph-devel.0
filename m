From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: rados bench single instance vs. multiple instances
Date: Mon, 11 May 2015 16:27:12 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9166440926@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF916643E836@SATLEXDAG01.amd.com>
 <5550BB51.2000301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0118.outbound.protection.outlook.com ([65.55.169.118]:10387
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752422AbbEKQnU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 12:43:20 -0400
In-Reply-To: <5550BB51.2000301@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

It's a beefy client with 32 cores.  Less than 1% of the total CPU used on the
client side. in the single rados case.  And on the OSD node side, only 25% of
the cpu being used, and disks and network are not at their limits

-- Tom


> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Monday, May 11, 2015 9:23 AM
> To: Deneau, Tom; ceph-devel
> Subject: Re: rados bench single instance vs. multiple instances
> 
> 
> 
> On 05/11/2015 09:18 AM, Deneau, Tom wrote:
> > I have noticed the following while running rados bench seq read tests
> > with a 40M object size
> >
> >      single rados bench, 4 concurrent ops,                     bandwidth =
> 190 MB/s
> >      4 copies of rados bench, 1 concurrent op each,  aggregate
> > bandwidth = 310 MB/s
> >
> > and in fact the single rados bench seems limited to 190, no matter how many
> concurrent ops.
> 
> What's your CPU utilization like?
> 
> >
> > I don't see this kind of behavior with a 4M object size.
> >
> > (The above are with caches dropped on the osd targets)
> >
> > It doesn't seem to be related to the total number of bytes being
> > processed by the single because if I don't drop the caches, both the
> > single rados bench and the 4-copy rados bench get much higher numbers
> > (600 vs. 900) but still the single rados bench appears limited, no matter
> how many concurrent ops are used.
> >
> > Is there kind of throttling going on by design here?
> 
> Nope, probably just client side inefficiency, especially if you are running
> on slower cores.  It's one of the reasons we tooled support for multiple
> concurrent copies of rados bench into cbt.
> 
> Mark
> 
> >
> > -- Tom Deneau, AMD
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
