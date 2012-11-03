From: Sage Weil <sage@inktank.com>
Subject: Re: Reduce bandwidth for remapping/backfill/recover?
Date: Sat, 3 Nov 2012 12:19:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1211031217500.25450@cobra.newdream.net>
References: <EDED730E-CCE5-4A07-AF1E-2D90E0686218@filoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35705 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab2KCTTM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 15:19:12 -0400
In-Reply-To: <EDED730E-CCE5-4A07-AF1E-2D90E0686218@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Oliver,

On Sat, 3 Nov 2012, Oliver Francke wrote:
> Hi *
> 
> anybody out there, who can help with an idea for reducing bandwidth when incorporating 2 new nodes into a cluster?
> I know of "osd recovery max active = X" ( 5 default), but with 4 OSD's per node, there is enough possibility to saturate our backnet ( 1Gig at the moment).
> Any other way to not disturb users too much?

This is something the current development releases do on their own.  This 
week we'll also be merging code that (in general) balances recovery work 
with client work, which should improve things significantly.  Stay tuned!

Until then, 'osd recovery max active' is the knob of choice.

sage
