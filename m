From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: monitor dispatch queue seems backed up?
Date: Fri, 4 Mar 2011 12:38:03 -0800
Message-ID: <1C3F2964F2314471949A0E8F6C807216@gmail.com>
References: <1299258853.4750.191.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103041137050.25280@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f51.google.com ([74.125.83.51]:39074 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760093Ab1CDUiJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2011 15:38:09 -0500
Received: by gwb15 with SMTP id 15so1357819gwb.10
        for <ceph-devel@vger.kernel.org>; Fri, 04 Mar 2011 12:38:08 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1103041137050.25280@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jim Schutt <jaschut@sandia.gov>, "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Friday, March 4, 2011 at 11:48 AM, Sage Weil wrote:
Hi,
> > 
> > I'm continuing my testing of the master branch
> > (commit 1ed2d8c587) against 96 osds.
> > 
> > I'm having trouble getting a new filesystem to
> > start up. FWIW this size filesystem starts up
> > in a minute or two at most under the stable branch.
> 
> The main thing that's changed since then is the default number of PGs has 
> gone up. Can you try changing the osd_pg_bits to 6 in common/config.cc, 
> rebuild, and re-mkcephfs, and see if that gives you behavior similar to 
> stable? (mkcephfs isn't currently letting you adjust that yet.)

Hmmm, I believe that if you set the osd_pg_bits in your ceph.conf it should get picked up by mkcephfs. :) Otherwise there are command-line options, and I have checked to make sure they work!
-Greg



