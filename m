From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: some thoughts about scrub
Date: Mon, 31 Jan 2011 15:36:02 -0800
Message-ID: <20110131233602.GA2435@dreamer>
References: <AANLkTi=zk=cHU1YDDrFqq2gUmiDcxWpAX+mn3U-dP4fW@mail.gmail.com>
 <1296511912.23762.205.camel@sale659.sandia.gov>
 <AANLkTimwr1c7fvC=qCPR-iGk8diCJy9Qgw9bVWTrqoMB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55188 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083Ab1AaXf7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jan 2011 18:35:59 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimwr1c7fvC=qCPR-iGk8diCJy9Qgw9bVWTrqoMB@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Jim Schutt <jaschut@sandia.gov>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 31, 2011 at 02:57:24PM -0800, Colin McCabe wrote:
> > If Ceph scrub works this way, then another
> > thing I really want to do is learn to tell my disks to not try
> > so hard to recover a sector, as I know I have at least one other
> > copy I can use to repair it, and because that minimizes the time
> > that osd is stalled.
> 
> Do you set these kind of timeouts through smartctl or hdparm?

From what I know, you set these timeouts by having different firmware
on the hard drives. If you buy "RAID drives", that usually means more
aggressive timeouts, where as "desktop drives" can have a timeout of
e.g. a minute.

-- 
:(){ :|:&};:
