From: Sage Weil <sage@inktank.com>
Subject: Re: OSD crashed today in os/JournalingObjectStore.cc
Date: Wed, 5 Dec 2012 06:41:01 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212050639480.17270@cobra.newdream.net>
References: <50BF1A43.4060605@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36411 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab2LEOlC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Dec 2012 09:41:02 -0500
In-Reply-To: <50BF1A43.4060605@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 5 Dec 2012, Stefan Priebe - Profihost AG wrote:
> Hello list,
> 
> i updated to latest next from today and then after 20 minutes an OSD was
> crashing in os/JournalingObjectStore.cc.
> 
> Attached is the log.

Hmm, this is perplexing.  It might just be a bad assert, but I can't see 
how it could happen.  Any chance you can reproduce with

	debug journal = 0/10

in the [osd] section?  That will give us a dump if it fails the assert.

Thanks!
s
