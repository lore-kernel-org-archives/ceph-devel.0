From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: -fno-omit-frame-pointer
Date: Sat, 21 Feb 2015 14:09:50 -0800
Message-ID: <mcavng$p5n$1@ger.gmane.org>
References: <alpine.DEB.2.00.1502211252520.27009@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53816 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbbBUWKL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 21 Feb 2015 17:10:11 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YPIFT-0001o0-J8
	for ceph-devel@vger.kernel.org; Sat, 21 Feb 2015 23:10:07 +0100
Received: from 66-87-139-69.pools.spcsdns.net ([66-87-139-69.pools.spcsdns.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 21 Feb 2015 23:10:07 +0100
Received: from eternaleye by 66-87-139-69.pools.spcsdns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 21 Feb 2015 23:10:07 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil wrote:

> Hey Mark,
> 
> I just watched Brendan Gregg's talk at SCALE (which was extremely good)
> and one of the things he mentioned is the importance of
> -fno-omit-frame-pointer.  I notice we are setting it via do_autogen.sh
> (i.e., for developers) but not in the production builds.  Should we be?
> I think it's important to be able to get meaningful callgraph output from
> production deployments and I suspect there is minimal performance impact.
> 
> http://www.slideshare.net/brendangregg/scale2015-linux-perfprofiling

I personally favor DWARF-based unwinding - for one, on register-starved 
architectures such as 32-bit x86, the frame pointer itself can skew 
performance.

With regard to it inflating instance size, that's something that can be 
mitigated - via split debuginfo (only pull in the ones you actually need), 
compressed debug info (zlib -9 shrinks it a good bit), and semantic 
deduplication/compression with dwz.

