From: Sage Weil <sage@newdream.net>
Subject: Re: Refuse OSD removal if still up or acting for PG
Date: Wed, 23 Mar 2016 18:18:56 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603231815540.9950@cpach.fuggernut.com>
References: <246396009.130901.1458769575985.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38630 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbcCWWTK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2016 18:19:10 -0400
In-Reply-To: <246396009.130901.1458769575985.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "wido@42on.com" <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 23 Mar 2016, wido@42on.com wrote:
> Hi,
> 
> This week I got a call to recover a Ceph cluster where somebody ran 
> 'ceph osd rm X' for OSDs which were still holding PGs.
> 
> He removed multiple OSDs and together they were all the replicas forma 
> certain PG.
> 
> This raised the question: Should we refuse a rm for a OSD which is still 
> up or acting for a PG?
> 
> If not, what would the use-case be for removing a OSD from the OSDMap 
> when it is still up or acting?
> 
> I would say that recovery/backfill has to be finished before we allow an 
> OSD to be removed.

This seems reasonable, as longa  there is a --yes-i-really-mean-it flagt  
to force it.

There are several options, though:

1- OSD must not be up.  Probably doesn't protect from much.
2- OSD must not be in the up set for any OSD.  This will prevent you from 
removing just one replica of a PG.
3- OSD must not be the only up OSD (or, must not bring up set to < 
min_size).

Neither of these really tell you which OSDs the PG is stored on, though.  
The mon doesn't actually know that--only the primary does.  Either we can 
try to cram that info into pg_stat_t, or we can accept that we can't make 
a precise condition and instead just settle on something simple.  Like 1 & 
2?

sage
