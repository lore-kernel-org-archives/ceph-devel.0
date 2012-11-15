From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more
 flexible
Date: Thu, 15 Nov 2012 07:05:24 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211150704200.4011@cobra.newdream.net>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de> <alpine.DEB.2.00.1208100851260.8611@cobra.newdream.net> <502530C9.7030008@bisect.de> <alpine.DEB.2.00.1208100909190.8611@cobra.newdream.net> <alpine.DEB.2.00.1208161448060.26904@cobra.newdream.net>
 <CADvuQRGBEva_8OB--M2JxMBoCXQ3i5GJkaJ-QvP-SoVqv7xDzw@mail.gmail.com> <alpine.DEB.2.00.1208161635290.26904@cobra.newdream.net> <5093993C.6000902@bisect.de> <alpine.DEB.2.00.1211141611340.26823@cobra.newdream.net> <50A4C4A7.6050008@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43472 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768118Ab2KOPFZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 10:05:25 -0500
In-Reply-To: <50A4C4A7.6050008@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny@bisect.de>
Cc: ceph-devel@vger.kernel.org

On Thu, 15 Nov 2012, Danny Al-Gaaf wrote:
> Hi Sage,
> 
> Am 15.11.2012 01:12, schrieb Sage Weil:
> > Hi Danny,
> > 
> > Have you had a chance to work on this?  I'd like to include this 
> > in bobtail.  If you don't have time we can go ahead an implement it, but 
> > I'd like avoid duplicating effort.
> 
> I already work on it. Do you have a deadline for bobtail?

Release is ~3 weeks off, but it is technically frozen.  This week would be 
best so that we can make sure it is well tested.

Thanks!
sage
