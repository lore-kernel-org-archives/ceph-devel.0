From: Wido den Hollander <wido@42on.com>
Subject: Re: Refuse OSD removal if still up or acting for PG
Date: Thu, 24 Mar 2016 13:37:45 +0100 (CET)
Message-ID: <328557674.1607.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
References: <246396009.130901.1458769575985.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
 <alpine.DEB.2.11.1603231815540.9950@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:44962 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbcCXMhw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 08:37:52 -0400
In-Reply-To: <alpine.DEB.2.11.1603231815540.9950@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


> Op 23 maart 2016 om 23:18 schreef Sage Weil <sage@newdream.net>:
> 
> 
> On Wed, 23 Mar 2016, wido@42on.com wrote:
> > Hi,
> > 
> > This week I got a call to recover a Ceph cluster where somebody ran 
> > 'ceph osd rm X' for OSDs which were still holding PGs.
> > 
> > He removed multiple OSDs and together they were all the replicas forma 
> > certain PG.
> > 
> > This raised the question: Should we refuse a rm for a OSD which is still 
> > up or acting for a PG?
> > 
> > If not, what would the use-case be for removing a OSD from the OSDMap 
> > when it is still up or acting?
> > 
> > I would say that recovery/backfill has to be finished before we allow an 
> > OSD to be removed.
> 
> This seems reasonable, as longa  there is a --yes-i-really-mean-it flagt  
> to force it.
> 
> There are several options, though:
> 
> 1- OSD must not be up.  Probably doesn't protect from much.
> 2- OSD must not be in the up set for any OSD.  This will prevent you from 
> removing just one replica of a PG.

I think you mean: "OSD must not be in the up set for any PG" ?

> 3- OSD must not be the only up OSD (or, must not bring up set to < 
> min_size).
> 
> Neither of these really tell you which OSDs the PG is stored on, though. 

Sure, but it protects you from doing stupid things. Like happened in this case.
I had to use ceph-object-store to recover the PG and inject it again.

> The mon doesn't actually know that--only the primary does.  Either we can 
> try to cram that info into pg_stat_t, or we can accept that we can't make 
> a precise condition and instead just settle on something simple.  Like 1 & 
> 2?

Doesn't the mon know? The PG map contains allmost all the information. A
iteration through the monmap where you check if the OSD is in the "up" set for
any of the PGs would be enough, right?

In this case the replication level was set to 2 where the user thought it was
set to 3. So he thought it was safe to remove 2 machines at once and remove the
OSDs as well. Again, user error, but let's protect users from destroying their
data as much as possible.

Wido

> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
