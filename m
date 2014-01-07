From: Yaron Haviv <yaronh@mellanox.com>
Subject: RE: Ceph Messaging on Accelio (libxio) RDMA
Date: Tue, 7 Jan 2014 20:25:20 +0000
Message-ID: <DD06A08C9A04024C8B0D8A63110C7E14A289D693@MTRDAG01.mtl.com>
References: <1902512897.238.1386812020862.JavaMail.root@thunderbeast.private.linuxbox.com>
	<1D2558BD-5FB5-455B-A8BF-87D9A634698C@ornl.gov>
	<DD06A08C9A04024C8B0D8A63110C7E14A289D5CA@MTRDAG01.mtl.com>
 <CABBk=J9JKndT44ZM-8Xv=CPkXZnOhnorHUWuSg7K0f7N5Qy-iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:35769 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753379AbaAGUZb convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 7 Jan 2014 15:25:31 -0500
In-Reply-To: <CABBk=J9JKndT44ZM-8Xv=CPkXZnOhnorHUWuSg7K0f7N5Qy-iA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "Atchley, Scott" <atchleyes@ornl.gov>, "Matt W. Benjamin" <matt@cohortfs.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Eyal Salomon <esalomon@mellanox.com>

> -----Original Message-----
> From: Yehuda Sadeh [mailto:yehuda@inktank.com]
> Sent: Tuesday, January 07, 2014 10:17 PM
> To: Yaron Haviv
> Cc: Atchley, Scott; Matt W. Benjamin; Sage Weil; ceph-devel; Eyal Salomon
> Subject: Re: Ceph Messaging on Accelio (libxio) RDMA
> 
> On Tue, Jan 7, 2014 at 11:52 AM, Yaron Haviv <yaronh@mellanox.com>
> wrote:
> > [[YH]]
> >
> > Accelio is an open source, vendor and transport neutral, works over
> > any RDMA device, and the TCP transport is progress It has different focus
> than CCI, CCI seems similar to our MXM library used for
> MPI/SHMEM/PGAS/..
> > While Accelio is Enterprise messaging and RPC focused, its goal is to
> > maximize performance in a noisy event driven environment And have end
> to end transaction reliability, including dealing with extreme failure cases,
> task cancelation and retransmission, multipath, data-integrity ..
> > It has C/C++/Java bindings, and Python in progress
> 
> I don't know if it has been covered (wasn't following this thread closely). The
> Accelio licensing is problematic. It's dual licensed (GPLv2, modified BSD which
> requires retaining the copyright clause), both licenses are compatible with
> ceph, however, both will add restrictions to the ceph distribution which we
> want to avoid.
> 
> Yehuda
>
[[YH]] 
Yehuda,

Let's take it offline to understand the concerns, the license is identical to the OFED (RDMA Verbs) library AFAIK  
If we need to make modifications to make it less restrictive we are open to it 

Yaron
 
> 
> >
> > We have noticed that most of our partners and OpenSource efforts
> > repeat the same mistakes, duplicate a lot of code, and end up with
> > partial functionality So we decided to write a common layer that deal
> > with all the new age transport challenges, and taking into account our
> > experience Can read the details in:
> > http://www.accelio.org/wp-
> content/themes/pyramid_child/pdf/WP_Accelio_
> > OpenSource_IO_Message_and_RPC_Acceleration_Library.pdf
> >
> > Accelio is now used by Tier1/2 storage and database vendors, and
> > integrate into few OpenSource Storage/DB/NoSQL/NewSQL projects One
> > open example is Hadoop
> >
