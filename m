From: Sage Weil <sage@newdream.net>
Subject: Re: Criteria behind disk scrubbing policy
Date: Wed, 9 Mar 2016 13:48:59 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603091348310.14377@cpach.fuggernut.com>
References: <CAKiXLjenBAB76AJ9qirL5Ff_GDz6E3sGXUie90xrsqydUqFVTw@mail.gmail.com> <alpine.DEB.2.11.1603090857080.14377@cpach.fuggernut.com> <CFA14F8E-3B3C-4594-BEB5-19C68983E377@ucsc.edu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1550890162-1457549342=:14377"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42245 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbcCIStV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2016 13:49:21 -0500
In-Reply-To: <CFA14F8E-3B3C-4594-BEB5-19C68983E377@ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vero Estrada Galinanes <veg@ucsc.edu>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1550890162-1457549342=:14377
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 9 Mar 2016, Vero Estrada Galinanes wrote:
> Hi Sage,
> Thanks for your answers
> > 
> > In Ceph clusters disks are generally never powered down.  It sounds like 
> > Schwarz et al were studying a different type of storage system.  In our 
> > case, it's all about how quickly you discover a defect and repair around 
> > it.
> 
> Indeed, he was studying archival storage. I’m interested in both system 
> types.
>
> > We do let you change the scrub intervals on a per-pool basis as well (see 
> > pool_opts in osd/osd_types.h), so you can adjust the policy based on both 
> > the pool type (replicated vs erasure coded) or the importance of the data 
> > it contains.
> > 
> 
> That setting is exactly what I was expecting ceph should have. Do you 
> have any study done about choosing scrub intervals policy on 
> replicated/erasured pools?

Nope!  I think this would be very interesting for users.

sage
--8323329-1550890162-1457549342=:14377--
