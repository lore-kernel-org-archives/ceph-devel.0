From: Sage Weil <sage@inktank.com>
Subject: Re: Xen blktap driver for Ceph RBD : Anybody wants to test ? :p
Date: Fri, 26 Apr 2013 08:51:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304260851200.4184@cobra.newdream.net>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com> <51704AF4.7060908@42on.com> <CAF6-1L5uhOknmR7O6TtrYoiE6Sqb1FbN1-U2cpDbAR31-i2=5A@mail.gmail.com> <67AC8E8B-C295-49EA-BD52-39F06E3C5A37@openminds.be>
 <CAF6-1L50V3cn0Sqcw-LajZh=dO=x91HTe4mL2yQ-k5yiGeJ2sg@mail.gmail.com> <517664AD02000099000F6C41@collaborate.seakr.com> <CAF6-1L4HPK0A_T-PmsonFCFUmA5ugT8Y_CXmwdG7-erRnfEhSA@mail.gmail.com> <5176961F02000099000F6C70@collaborate.seakr.com>
 <CAF6-1L4J_VoEBPO1MmF5KMkqrperc3E-QNoXEnK4ied9G3goFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58567 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab3DZPvx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 11:51:53 -0400
In-Reply-To: <CAF6-1L4J_VoEBPO1MmF5KMkqrperc3E-QNoXEnK4ied9G3goFg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Nick Couchman <Nick.Couchman@seakr.com>, Wido den Hollander <wido@42on.com>, pasik@iki.fi, Bernard Grymonpon <bernard@openminds.be>, ceph-devel@vger.kernel.org

On Fri, 26 Apr 2013, Sylvain Munaut wrote:
> Hi,
> 
> 
> I just wanted to mention that I implemented a simple request merging
> strategy to counter-act the request splitting done by the Xen block if
> protocol.
> 
> The results are pretty good. When comparing to using the rbd kernel
> module, I can now get 2-4x better write performance and 2x read
> performance.

Is this in the blktap layer or in librbd?  FWIW, when rbd cache = true, 
the writes will get merged by the cache and written out in large extents 
on flush.

sage
