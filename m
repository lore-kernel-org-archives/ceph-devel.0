From: Sage Weil <sage@newdream.net>
Subject: Re: crush and go
Date: Sun, 22 Mar 2015 22:20:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503222217440.12661@cobra.newdream.net>
References: <550DF141.2090800@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38050 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbbCWFUX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 01:20:23 -0400
In-Reply-To: <550DF141.2090800@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, 21 Mar 2015, Loic Dachary wrote:
> Hi,
> 
> Does anyone know of a go wrapper around the crush library ? I looked at 
> http://go-search.org/search?q=crush but did not find anything relevant.

I think it will be difficult to build such a wrapper until we spend the 
time coralling crush into a nice .so.  The challenge there is that while 
the core mapping code is quite simple (and in C, and duplicated in the 
kernel), the CrushWrapper stuff depends on a bunch of Ceph infrastrcture, 
like the bufferlist encode/decode stuff and CephContext for debugging.  
Without all of that the core mapping library isn't terribly useful or 
friendly.

I'm not sure what the best path to making it more easily consumable would 
be, to be honest...

sage
