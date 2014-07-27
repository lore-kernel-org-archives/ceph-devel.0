From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Fwd: S3 API Compatibility support
Date: Sun, 27 Jul 2014 00:41:00 +0000
Message-ID: <robbat2-20140727T003939-297659615Z@orbis-terrarum.net>
References: <CANA9Uk55UZXtKzS=urk3Q+KY=DoWoTaCRf=rKiEtjt9y7FYw7A@mail.gmail.com>
 <CANA9Uk6E9t30Ve3pKhZa1cW4g6N7JjzG8JgiwOoDa9TWdNEagQ@mail.gmail.com>
 <alpine.DEB.2.00.1407250848060.22752@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:45330 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbaG0BWu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 26 Jul 2014 21:22:50 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id D419F33FE8F
	for <ceph-devel@vger.kernel.org>; Sun, 27 Jul 2014 01:22:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1407250848060.22752@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: M Ranga Swami Reddy <swamireddy@gmail.com>, ceph-devel@vger.kernel.org

On Fri, Jul 25, 2014 at 08:49:25AM -0700,  Sage Weil wrote:
> On Fri, 25 Jul 2014, M Ranga Swami Reddy wrote:
> > Hi Team: As per the ceph document a few S3 APIs compatibility not supported.
> > 
> > Link: http://ceph.com/docs/master/radosgw/s3/
> > 
> > Is there plan to support the ?n supported item in the above table?
> > or
> > Any working on this?
> 
> Yes.  Unfortunately this table isn't particularly detailed or accurate or 
> up to date.   The main gap, I think, is versioned objects.
> 
> Are there specfiic parts of the S3 API that are missing that you need?  
> That sort of info is very helpful for prioritizing effort...
Fine-grained object policies would be useful here, w/ users+groups
brought in from keystone.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
