From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: XioMessenger (RDMA) Performance results
Date: Tue, 18 Mar 2014 20:30:26 -0400 (EDT)
Message-ID: <74022714.160.1395189026235.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <CAPYLRzjR6hfDCa1-5=SZi2J0Rh52u0=BKr2Q45PoYraPYQVC5A@mail.gmail.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3426 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756119AbaCSAaf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Mar 2014 20:30:35 -0400
In-Reply-To: <CAPYLRzjR6hfDCa1-5=SZi2J0Rh52u0=BKr2Q45PoYraPYQVC5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>, Eyal Salomon <esalomon@mellanox.com>, Yaron Haviv <yaronh@mellanox.com>

Hi Greg,

----- "Gregory Farnum" <greg@inktank.com> wrote:

> On Tue, Mar 18, 2014 at 1:05 PM, Yaron Haviv <yaronh@mellanox.com>
> wrote:
> > Im happy to share test results we run in the lab with Matt's latest
> XioMessenger code which implements Ceph messaging over Accelio RDMA
> library
> > Results look pretty encouraging, demonstrating a * 20x * performance
> boost
> 
> Very nice! I'm excited. :)
> What did you use to generate these numbers?

The two workload sets are created using the simple_client/simple_server vs
xio_client/xio_server client/server pairs, on...one of the latest XioMessenger
branches.  Eyal, was it xio-rados-exp or xio-rados-exp-noreg?

I -think- it would be xio-rados-exp.  The new stuff from us (including a couple
of librados fixups by Marcus and myself) is on xio-rados-exp-noreg.

> 
> > Below is a table comparing XioMessenger (RDMA) with SimpleMessanger
> (TCP) and various interconnects (56G InfiniBand and 40GbE/RoCE)
> > Note that we tested with CRC on/off, in RDMA there is no need for
> software CRC, its done by the hardware
> > Tests below use a single communication thread, using more threads
> would produce higher performance (on 64KB IO the Link/PCIe is
> saturated with RDMA using a single thread)
> >
> > Matt has some more small IO optimizations in the pipe, and we hope
> to share perf results using librados soon, I assume they will be disk
> bound
> >
> > protocol        CRC     msg depth       IO size Msg/sec bandwidth
> (MB/s)        CPU % server    CPU% client
> > eth     crc     50      4K                16,262        64      100%
>    100%
> > eth     no_crc  50      4K                15,637        61      100%
>    100%
> 
> Are these numbers correct? no_crc is slower?
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com

These numbers were from Mellanox, so I defer to Eyal.  I have seen
some inconsistency with crc vs no_crc in informal runs, myself.

> 
> > eth     crc     50      64K                 5,960       373     93% 
>    100%
> > eth     no_crc  50      64K                 7,678       480     93% 
>    100%
> > ipoib   no_crc  50      4K                16,003        63      100%
>    100%
> > ipoib   no_crc  50      64K                 7,375       461     93% 
>    100%
> >
> > IB      no_crc  50      4K              334,088         1305    98% 
>    98%
> > IB      no_crc  50      64K               95,078        5942    98% 
>    98%
> >
> > roce    no_crc  50      4K              332,388         1298    95% 
>    100%
> > roce    no_crc  50      64K               69,445        4340    91% 
>    87%
> >
> > roce    crc     50      4K              172,756         675     97% 
>    100%
> > roce    crc     50      64K               19,657        1229    100%
>    48%
> >
> > Regards, Yaron
> >

Regards,

Matt

-- 
Matt Benjamin
CohortFS, LLC.
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
