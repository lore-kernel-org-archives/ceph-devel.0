From: Sage Weil <sage@inktank.com>
Subject: Re: rados_clone_range for different pgs
Date: Fri, 2 Aug 2013 06:17:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308020615420.15391@cobra.newdream.net>
References: <CA+CdmLbW+Tb2Wz1+DNJ4yFZ7-gDG1XsPfvKGZ-H5iJZQJ=QvZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45641 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab3HBNRk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Aug 2013 09:17:40 -0400
In-Reply-To: <CA+CdmLbW+Tb2Wz1+DNJ4yFZ7-gDG1XsPfvKGZ-H5iJZQJ=QvZw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Krasnianskiy <oleg.krasnianskiy@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Oleg,

On Fri, 2 Aug 2013, Oleg Krasnianskiy wrote:
> Hi
> 
> I have asked this question in ceph-users, but did not get any
> response, so I'll test my luck again, but with ceph-devel =)

Sorry about that!
 
> Is there any way to copy part of one object into another one if they
> reside in different pgs?
> There is rados_clone_range, but it requires both objects to be inside one pg.

There is no way currently.  The clone_range can only (reliably) work on an 
OSD if it is stored with the same locator key; otherwise you have a ~R/N 
chance of that happening (where N is the number of OSDs, R is the number 
of replicas), which isn't worth optimizing for.  If the objects aren't 
stored together, you need to read and then write the data; this avoids 
adding additional complexity to the OSD for minimal gain.

Do you have a use-case in mind where this functionality is important?

sage

