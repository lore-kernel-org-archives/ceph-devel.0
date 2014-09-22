From: Sage Weil <sweil@redhat.com>
Subject: Re: issue 8747 / 9011
Date: Sun, 21 Sep 2014 19:01:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409211900410.27396@cobra.newdream.net>
References: <alpine.DEB.2.00.1409191642270.19460@cobra.newdream.net> <2949490.exWB3TExxB@debstor> <alpine.DEB.2.00.1409211227510.27396@cobra.newdream.net> <1545276.B1zDlULSSV@debstor>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32838 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbaIVCBw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Sep 2014 22:01:52 -0400
In-Reply-To: <1545276.B1zDlULSSV@debstor>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dmitry Smirnov <onlyjob@debian.org>
Cc: ceph-devel@vger.kernel.org

On Mon, 22 Sep 2014, Dmitry Smirnov wrote:
> On Sun, 21 Sep 2014 12:28:23 Sage Weil wrote:
> > Is there any possibility of enabling logging on your osds (debug ms = 1,
> > debug osd = 20) so that we can capture this?
> 
> I'll put it on my TODO list but I won't be able to do it anytime soon...
> 
> Meanwhile is there any chance for #8752 to get some attention? It is regarding 
> inconsistent PGs on RBD caching pool. Thanks.

This is one we have never seen in our QA environment, and no real leads.  
There are a couple slightly different scrub issues that pop up 
occasionally that we are trying to nail down, but this one is a bit 
different.  Being able to reliably reproduce it and generate logs is the 
usual strategy...

sage
