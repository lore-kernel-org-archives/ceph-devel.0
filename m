From: Sage Weil <sage@newdream.net>
Subject: Re: It's not a bug of ceph, but
Date: Wed, 13 Apr 2011 09:22:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104130922120.13408@cobra.newdream.net>
References: <4DA58180.7090701@ufm.su> <BANLkTim_rn4uzJSBp+oNVst7nYyVrU3Q=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47418 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932928Ab1DMQTI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2011 12:19:08 -0400
In-Reply-To: <BANLkTim_rn4uzJSBp+oNVst7nYyVrU3Q=g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry Chang <henry.cy.chang@gmail.com>
Cc: Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

On Wed, 13 Apr 2011, Henry Chang wrote:
> Hi,
> 
> 2011/4/13 Fyodor Ustinov <ufm@ufm.su>:
> > Hi!
> >
> > may be anyone seen this trouble?
> 
> I have seen this when running OSD with ext3 and never seen it after
> switching to ext4.

Yeah.  We've seen it on ext3 prior to 2.6.34 or so... ext3 on newer 
kernels (or ext4) seem to be okay.

sage
