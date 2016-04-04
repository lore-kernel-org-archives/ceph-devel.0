From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: hackathon recap
Date: Mon, 4 Apr 2016 13:38:12 -0400 (EDT)
Message-ID: <368859258.3719263.1459791492611.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1604040951240.19675@cpach.fuggernut.com> <CACJqLybuo97ho=NhDri-f5UxuPKw+-0ZTgs0=A=Orp1Yr=4C8A@mail.gmail.com> <alpine.DEB.2.11.1604041119580.19675@cpach.fuggernut.com> <CACJqLyZJx9xbqHsFn4CP3-8w=JBZ8i4fXN3LpYwbF51O=hjbHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:56756 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbcDDRiO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2016 13:38:14 -0400
In-Reply-To: <CACJqLyZJx9xbqHsFn4CP3-8w=JBZ8i4fXN3LpYwbF51O=hjbHw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

Hi,

----- Original Message -----
> From: "Haomai Wang" <haomaiwang@gmail.com>
> To: "Sage Weil" <sweil@redhat.com>
> Cc: ceph-devel@vger.kernel.org
> Sent: Monday, April 4, 2016 11:30:54 AM
> Subject: Re: hackathon recap
> 
> On Mon, Apr 4, 2016 at 11:25 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Mon, 4 Apr 2016, Haomai Wang wrote:
> >> > - Multi-stream SSDs and GC control APIs
> >> >
> >> > Jianjian presented about new APIs to contorl when the SSD is doing
> >> > garbage
> >> > collection (stop, start, start but suspend on IO) and streams to
> >> > segregate
> >> > writes into different erase blocks.
> >>
> >> Where these new apis from? for specified vendor?
> >
> > They are working their way through the standards bodies (for NVMe and
> > SAS/SATA?).  The are probably available in some form from specific
> > vendors (Samsung) now?
> >
> >> > - DPDK and SPDK
> >> >
> >> > We spent a lot of time going over some background about what DPDK and
> >> > SPDK
> >> > do and don't do.  Takeaways/questions include
> >> >
> >> >  - Which TCP stack are we using with Haomai's DPDK AsyncMessenger
> >> > integration?  Should we support multiple options?
> >>
> >> yes, it will be a backend of AsyncMessenger. Just like impled options:
> >> ms type = async
> >> ms async transport type = dpdk
> >> ms dpdk host ipv4 addr = 10.253.102.119
> >> ms dpdk gateway ipv4 addr = 10.253.102.1
> >> ms dpdk netmask ipv4 addr = 255.255.255.0
> >>
> >> these options will enable dpdk backend.
> >>
> >> Current, I don't find any problem between kernel tcp/ip stack with
> >> dpdk userspace tcp/ip. Even passed test_msgr which injects lots of
> >> errors.
> >
> > Which userspace tcp/ip stack is it?  Seastar?  ODP?
> 
> main part from seastar

In ganesha upstream, there is interest in other stacks (mtcp, odp), and they have different capabilities and integration options.  Eventually, we'll want to flex this.

> 
> >
> >> >  - How much benefit should we expect?  Current estimate (based on
> >> > SanDisk's numbers) were that each op consumes around 250us of CPU time,
> >> > about 80 of that is actual IO time on an NVMe device, and the max time
> >> > we're likely to cut from bypassing the kernel block stack is on the
> >> > order
> >> > of 20-30us.  Successful users of DPDK/SPDK benefit mostly from
> >> > restructuring the rest of the stack to avoid legacy threading models.

Thats true.  Those reoganizations are critical in general.

> >>
> >> From now, because of some known bottlenecks need to solve. The most
> >> advantage is combining dpdk and spdk which actually make
> >> spdk(userspace nvme driver) effective. Because spdk still use poll
> >> mode and require physical address while queuing io request. Without
> >> dpdk, we always need to alloc a physical address aware memory and do
> >> copy. With dpdk as network stack, we could use memory from NIC to SSD.
> >> Thanks to the dpdk mbuf design, dpdk stack permit a lots of inflight
> >> mbuf and alloc new memory if hungry.
> >


-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
