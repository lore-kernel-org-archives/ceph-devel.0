From: Sage Weil <sweil@redhat.com>
Subject: Re: 25G RDMA networking thoughts???
Date: Tue, 8 Nov 2016 21:45:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611082144360.29278@piezo.us.to>
References: <acbd757e-d360-4e37-bc26-60eb9d6ec162.james.liu@alibaba-inc.com>,alpine.DEB.2.11.1611082116420.29278@piezo.us.to <16962d43-7f03-4e92-9eee-b3f4ab80408c.james.liu@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1366109801-1478641529=:29278"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753831AbcKHVpa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 8 Nov 2016 16:45:30 -0500
In-Reply-To: <16962d43-7f03-4e92-9eee-b3f4ab80408c.james.liu@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>
Cc: Haomai Wang <haomai@xsky.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1366109801-1478641529=:29278
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 9 Nov 2016, LIU, Fei wrote:
> Hi Sage，
>    Yes, Totally understood.  25G RDMA network for Ceph cluster is built for
> interal test. Xio messenger and Async messenger(But it can only support
> infiniband,right) are going to be two options. We are carefully evaluate
> both of these two options. But the most important goal in the end is to see
> how bluestore works with rdma to bring down the total latency for workload
> like OLTP.  
> 
> Hi Haomai,
>    Would you mind let us know when the async messenger is going to support
> ethernet if not support yet?

The default async backend is PosixStack which is all TCP-based.  (And 
async is now the default messenger in kraken.)

sage

> 
>    Regards,
>    James
>       ------------------------------------------------------------------
> From:Sage Weil <sweil@redhat.com>
> Time:2016 Nov 8 (Tue) 13:19
> To:James <james.liu@alibaba-inc.com>
> Subject:Re: 25G RDMA networking thoughts???
> 
> [adding ceph-devel]
> 
> On Wed, 9 Nov 2016, LIU, Fei wrote:
> > Hi Sage,
> >    I was wondering do you have any thoughts of 25G RDMA networking
> > construction besides of xio-messenger/async?  Is there any guidance to bu
> ild
> > 25G RDMA netowrk to better control the whole Ceph cluster latency?
> 
> The only RDMA options right now are XioMessenger and AsyncMessenger's new 
> RDMA backend. Both are experimental, but we'd be very interested in 
> hearing about your experience.
> 
> I wouldn't assume that latency is network-related, though.  More often 
> than not we're finding it's the OSD backend or the OSD request internals 
> (e.g., request scheduling or peering) that's the culprit...
> 
> sage
> 
> 
> 
> 
--8323329-1366109801-1478641529=:29278--
