From: Sage Weil <sage@inktank.com>
Subject: Re: SIGSEGV in cephfs-java, but probably in Ceph
Date: Mon, 4 Jun 2012 19:21:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206041920250.10445@cobra.newdream.net>
References: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com>
 <CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com>
 <DC393A32-288A-4BF2-B618-9D6E0A5C29B9@cs.ucsc.edu> <05C460A496DC45689D6578B20D699425@inktank.com>
 <217DCA5E-26E6-4357-96E7-0C9AF4E06071@cs.ucsc.edu> <9C7F8B20FB3B49508B9FBEE725AB34EE@inktank.com>
 <CAPrxi59++wux__pY1M0qu+=YcVWAbkbLVWuxa95=ZLo8R64XiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49369 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757656Ab2FECVQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 22:21:16 -0400
In-Reply-To: <CAPrxi59++wux__pY1M0qu+=YcVWAbkbLVWuxa95=ZLo8R64XiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: Greg Farnum <greg@inktank.com>, Noah Watkins <jayhawk@cs.ucsc.edu>, Nam Dang <namd@de.cs.titech.ac.jp>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 4 Jun 2012, Noah Watkins wrote:
> I wonder if the Mutex::lock(bool) being printed out is a red herring... 

FWIW this assert usually means a use-after-free.

sage

