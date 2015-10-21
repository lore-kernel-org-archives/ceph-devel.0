From: Martin Millnert <martin@millnert.se>
Subject: Re: newstore direction
Date: Wed, 21 Oct 2015 23:20:25 +0200
Message-ID: <1445462425.24939.21.camel@millnert.se>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
	 <56268886.7010806@redhat.com>
	 <7334B4281E425749B85E08CF7EC6F8534383DD15@SACMBXIP03.sdcorp.global.sandisk.com>
	 <562775DD.8050304@redhat.com> <56279DD3.4020901@redhat.com>
	 <5627B471.1040602@redhat.com> <5627E96E.6090706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([185.19.66.196]:55153 "EHLO mail.millnert.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528AbbJUVU3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 Oct 2015 17:20:29 -0400
In-Reply-To: <5627E96E.6090706@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Ric Wheeler <rwheeler@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Adding 2c

On Wed, 2015-10-21 at 14:37 -0500, Mark Nelson wrote:
> My thought is that there is some inflection point where the userland 
> kvstore/block approach is going to be less work, for everyone I think, 
> than trying to quickly discover, understand, fix, and push upstream 
> patches that sometimes only really benefit us.  I don't know if we've 
> truly hit that that point, but it's tough for me to find flaws with 
> Sage's argument.

Regarding the userland / kernel land aspect of the topic, there are
further aspects AFAIK not yet addressed in the thread:
In the networking world, there's been development on memory mapped
(multiple approaches exist) userland networking, which for packet
management has the benefit of - for very, very specific applications of
networking code - avoiding e.g. per-packet context switches etc, and
streamlining processor cache management performance. People have gone as
far as removing CPU cores from CPU scheduler to completely dedicate them
to the networking task at hand (cache optimizations). There are various
latency/throughput (bulking) optimizations applicable, but at the end of
the day, it's about keeping the CPU bus busy with "revenue" bus traffic.

Granted, storage IO operations may be much heavier in cycle counts for
context switches to ever appear as a problem in themselves, certainly
for slower SSDs and HDDs. However, when going for truly high performance
IO, *every* hurdle in the data path counts toward the total latency.
(And really, high performance random IO characteristics approaches the
networking, per-packet handling characteristics).  Now, I'm not really
suggesting memory-mapping a storage device to user space, not at all,
but having better control over the data path for a very specific use
case, reduces dependency on the code that works as best as possible for
the general case, and allows for very purpose-built code, to address a
narrow set of requirements. ("Ceph storage cluster backend" isn't a
typical FS use case.) It also decouples dependencies on users i.e.
waiting for the next distro release before being able to take up the
benefits of improvements to the storage code.

A random google came up with related data on where "doing something way
different" /can/ have significant benefits:
http://phunq.net/pipermail/tux3/2015-April/002147.html 

I (FWIW) certainly agree there is merit to the idea.
The scientific approach here could perhaps be to simply enumerate all
corner cases of "generic FS" that actually are cause for the experienced
issues, and assess probability of them being solved (and if so when).
That *could* improve chances of approaching consensus which wouldn't
hurt I suppose?

BR,
Martin

