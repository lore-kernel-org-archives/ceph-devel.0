From: Sage Weil <sage@inktank.com>
Subject: Re: v0.56 released
Date: Wed, 2 Jan 2013 12:46:22 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301021245410.13956@cobra.newdream.net>
References: <alpine.DEB.2.00.1212311721310.1906@cobra.newdream.net> <50E39A4E.1060700@conversis.de> <50E39B68.40800@inktank.com> <CAOLwVUnYP1HTfimBf2PKBW5TA7gSuKRhsB1u6YPwUQGs633mvg@mail.gmail.com> <alpine.DEB.2.00.1301020935270.13956@cobra.newdream.net>
 <CAOLwVU=3W-QQ2tsdCGU4zq2OUiiTv7tFE20z20k2dgXQL7WknQ@mail.gmail.com> <alpine.DEB.2.00.1301021010310.13956@cobra.newdream.net> <50E49814.9000904@conversis.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60644 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab3ABUqX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 15:46:23 -0500
In-Reply-To: <50E49814.9000904@conversis.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dennis Jacobfeuerborn <dennisml@conversis.de>
Cc: =?ISO-8859-15?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 2 Jan 2013, Dennis Jacobfeuerborn wrote:
> On 01/02/2013 07:11 PM, Sage Weil wrote:
> > On Wed, 2 Jan 2013, S?bastien Han wrote:
> >> Debian-testing shows the version 0.56-1, maybe I misunderstood but I
> >> thought that 0.56-1 bobtail was the new version of the stable branch.
> >> So I was expecting to see it here
> >> http://ceph.com/debian/dists/precise/main/binary-amd64/Packages
> >>
> >> Correct me if I'm wrong :)
> > 
> > It will be soon, but we're doing some additional validation before calling 
> > it bobtail.  We may also move the URLs around a bit... more on that soon!
> 
> What happens if you find a problem that needs a small update? Will the
> bobtail version be bumped to v0.57?

v0.56.1, v0.56.2, etc., will follow in this series and bugs are found and 
backported.

sage
