From: Sage Weil <sage@inktank.com>
Subject: Re: mkfs on osd - failed in 0.47
Date: Mon, 21 May 2012 14:24:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205211424070.5496@cobra.newdream.net>
References: <CAMwB3TgPPbPWY5814_LVvD853fnbW1gH1mQGsaUSwJMyGR0ovQ@mail.gmail.com>
 <4FBAAA6E.4000506@profihost.ag> <CAPYLRzicrk97U5j_7_n=WM-PJ6u0TZbzbTzcvOZRr+dZ3YLVOA@mail.gmail.com>
 <CAMwB3Tg=wTMGZd_Og9A2-bMzfD4tSAPW4eOZWFo4_5DQ0RyR5w@mail.gmail.com>
 <4FBAACFA.3030909@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57292 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758653Ab2EUVYa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 17:24:30 -0400
In-Reply-To: <4FBAACFA.3030909@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: =?UTF-8?B?U8WCYXdvbWlyIFNrb3dyb24=?= <szibis@gmail.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Mon, 21 May 2012, Stefan Priebe wrote:
> Am 21.05.2012 22:58, schrieb Sawomir Skowron:
> > Yes on root. 30 minutes ago on 0.46 same operation works.
> > 
> ...
> > Repo:
> > 
> > deb http://ceph.com/debian/ precise main
> 
> Same to me except i'm using debian squeeze.

I just pushed a fix for this to the stable branch.  Will build a v0.47.1 
shortly.

sage
