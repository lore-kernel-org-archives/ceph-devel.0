From: Sage Weil <sweil@redhat.com>
Subject: Re: v0.80.8 and librbd performance
Date: Tue, 3 Mar 2015 16:32:22 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1503031632000.25972@cobra.newdream.net>
References: <alpine.DEB.2.00.1503031512270.25972@cobra.newdream.net> <1425427272.9631.15.camel@daevel.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1683050595-1425429143=:25972"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46461 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754482AbbCDAc3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 Mar 2015 19:32:29 -0500
In-Reply-To: <1425427272.9631.15.camel@daevel.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1683050595-1425429143=:25972
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 4 Mar 2015, Olivier Bonvalet wrote:
> Does kernel client affected by the problem ?

Nope.  The kernel client is unaffected.. the issue is in librbd.

sage


> 
> Le mardi 03 mars 2015 à 15:19 -0800, Sage Weil a écrit :
> > Hi,
> > 
> > This is just a heads up that we've identified a performance regression in 
> > v0.80.8 from previous firefly releases.  A v0.80.9 is working it's way 
> > through QA and should be out in a few days.  If you haven't upgraded yet 
> > you may want to wait.
> > 
> > Thanks!
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> 
--557981400-1683050595-1425429143=:25972--
