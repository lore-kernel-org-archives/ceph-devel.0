From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: RBD layering design draft
Date: Fri, 22 Jun 2012 02:02:38 +0000 (UTC)
Message-ID: <loom.20120622T035754-492@post.gmane.org>
References: <4FDB9FBB.9000807@inktank.com> <CADvuQRH0J2y2-G5wWbaUiHy79y_H=wMBLnyW1ZKNdo8J2aSiKw@mail.gmail.com> <4FDF620E.7030704@inktank.com> <Pine.LNX.4.64.1206181059040.11790@cobra.newdream.net> <4FDFB4A4.1080107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53706 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760801Ab2FVCCv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Jun 2012 22:02:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ShtCy-0003XH-0Y
	for ceph-devel@vger.kernel.org; Fri, 22 Jun 2012 04:02:48 +0200
Received: from 66-87-112-231.pools.spcsdns.net ([66.87.112.231])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 04:02:48 +0200
Received: from eternaleye by 66-87-112-231.pools.spcsdns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 04:02:48 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dan Mick <dan.mick <at> inktank.com> writes:

> 
> On 06/18/2012 11:01 AM, Sage Weil wrote:
> > On Mon, 18 Jun 2012, Josh Durgin wrote:
> >>>>      $ rbd copyup pool2/child1

> "disown" and "adopt"?  :)  (actually I started as a joke, but really I 
> kinda like that; fits with the parent-child name)

The issue I see with that is that the argument refers to the child rather than
the parent, so it doesn't match. I personally like 'unshare' since it'll also
work in the dedup case, but if we stick with the parent/child terminology
'emancipate' might work (although it lacks a good reverse).


