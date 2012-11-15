From: Sage Weil <sage@inktank.com>
Subject: Re: ceph-osd cpu usage
Date: Thu, 15 Nov 2012 08:52:40 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211150852300.22766@cobra.newdream.net>
References: <7840e3d1-17b2-4618-ae1f-ff3dbdff71f6@mailpro> <50A4DDE8.8040506@profihost.ag> <50A50640.1040103@inktank.com> <50A513A1.90101@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44481 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768484Ab2KOQwk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 11:52:40 -0500
In-Reply-To: <50A513A1.90101@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

On Thu, 15 Nov 2012, Stefan Priebe wrote:
> Am 15.11.2012 16:12, schrieb Mark Nelson:
> > Out of curiosity, does it help much if you disable crc32c calculations?
> > Use the "nocrc" option in your ceph.conf file.  I've had my eye on
> > crcutil as an alternative to how we do crc32c now.
> > 
> > http://code.google.com/p/crcutil/
> 
> Will try that how and where to i set the nocrc option?
> 
> Is it
> [global]
> nocrc = true

ms nocrc = true

sage
