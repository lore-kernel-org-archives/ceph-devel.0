From: Sage Weil <sage@inktank.com>
Subject: Re: Stable/Master debian/rules not stripping all packages
Date: Tue, 3 Jul 2012 08:55:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207030854560.28638@cobra.newdream.net>
References: <201207031358.20801.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37872 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab2GCPzi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 11:55:38 -0400
In-Reply-To: <201207031358.20801.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

On Tue, 3 Jul 2012, Amon Ott wrote:
> Hi folks,
> 
> just found out that some Debian binary packages do not get stripped - a 53MB 
> ceph-mds does look a bit weird.
> 
> Identified packages ceph-mds and gceph and added these lines:
>         dh_strip -pceph-mds --dbg-package=ceph-mds-dbg
>         dh_strip -pgceph --dbg-package=gceph-dbg

I added stripping for ceph-mds, but gceph has been removed... I'm 
curious which you're looking at that has both ceph-mds and gceph?

Thanks!
sage

