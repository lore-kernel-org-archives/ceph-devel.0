From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: some thoughts about scrub
Date: Mon, 31 Jan 2011 16:16:08 -0700
Message-ID: <1296515768.23762.216.camel@sale659.sandia.gov>
References: <AANLkTi=zk=cHU1YDDrFqq2gUmiDcxWpAX+mn3U-dP4fW@mail.gmail.com>
 <1296511912.23762.205.camel@sale659.sandia.gov>
 <AANLkTimwr1c7fvC=qCPR-iGk8diCJy9Qgw9bVWTrqoMB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:39374 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756671Ab1AaXQO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jan 2011 18:16:14 -0500
In-Reply-To: <AANLkTimwr1c7fvC=qCPR-iGk8diCJy9Qgw9bVWTrqoMB@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Mon, 2011-01-31 at 15:57 -0700, Colin McCabe wrote:
> 
> > If Ceph scrub works this way, then another
> > thing I really want to do is learn to tell my disks to not try
> > so hard to recover a sector, as I know I have at least one other
> > copy I can use to repair it, and because that minimizes the time
> > that osd is stalled.
> 
> Do you set these kind of timeouts through smartctl or hdparm?


I've never done this on any drives that we use, so I
don't know and would really like to learn more.

But here's an example of more info of the sort that 
got me thinking about it:
  http://en.wikipedia.org/wiki/Time-Limited_Error_Recovery


-- Jim



