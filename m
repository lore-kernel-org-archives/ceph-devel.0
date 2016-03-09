From: Sage Weil <sage@newdream.net>
Subject: Re: Criteria behind disk scrubbing policy
Date: Wed, 9 Mar 2016 09:00:23 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603090857080.14377@cpach.fuggernut.com>
References: <CAKiXLjenBAB76AJ9qirL5Ff_GDz6E3sGXUie90xrsqydUqFVTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-166274277-1457532026=:14377"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39506 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbcCIOAq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2016 09:00:46 -0500
In-Reply-To: <CAKiXLjenBAB76AJ9qirL5Ff_GDz6E3sGXUie90xrsqydUqFVTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Veronica Estrada Galinanes <veg@ucsc.edu>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-166274277-1457532026=:14377
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Veronica,

On Wed, 9 Mar 2016, Veronica Estrada Galinanes wrote:
> From ceph website: "Deep scrubbing (weekly) reads the data and uses
> checksums to ensure data integrity.”
> 
> 1. Why do you use "weekly" deep scrubbing? How many times a year one disk
> is scrubbed on average in a Ceph cluster? Schwartz* used three times per
> year. “Interestingly, we did not observe a further decrease in data loss as
> we increased the scrubbing frequency from three to eleven times per year;
> rather, a slight increase in data loss was noticed. This phenomenon comes
> from the POH (power-on-hour) effect on drive reliability. Aggressive
> scrubbing requires more power cycles, adversely affecting drive reliability.
> "

In Ceph clusters disks are generally never powered down.  It sounds like 
Schwarz et al were studying a different type of storage system.  In our 
case, it's all about how quickly you discover a defect and repair around 
it.
 
> 2. Do you have different scrubbing policies according to the redundancy
> method? For example, more scrubs when using replication rather than erasure
> coding?

We do let you change the scrub intervals on a per-pool basis as well (see 
pool_opts in osd/osd_types.h), so you can adjust the policy based on both 
the pool type (replicated vs erasure coded) or the importance of the data 
it contains.

sage
--8323329-166274277-1457532026=:14377--
