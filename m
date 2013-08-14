From: Sage Weil <sage@inktank.com>
Subject: Re: How to collect coverage with teuthology ?
Date: Wed, 14 Aug 2013 09:47:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308140945050.22762@cobra.newdream.net>
References: <520B668F.1070001@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52005 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932716Ab3HNQrN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 12:47:13 -0400
In-Reply-To: <520B668F.1070001@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 14 Aug 2013, Loic Dachary wrote:
> Hi,
> 
> Although
> 
> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-precise-amd64-gcov/log.cgi?log=26707923b23cb55583a7d6b46ef6deb9591fd165
> 
> claims to build packages with coverage ( -gcov in the name ), I can't figure out where it is nor how it is supposed to be used.

That gitbuilder runs the gcov build script in autobuild-ceph.git to build 
the package.

To use it, you do coverage: true somewhere in the job yaml (i forget 
exactly), teuthology will pull the packages from that gitbuilder instead 
of the regular one, and... I don't know the rest actually; Josh knows 
more.  We haven't done this in a while :(, but need to start doing it 
again.  One of the main annoyances is that in order for gcov to write out 
its info the process needs to shutdown cleanly, so there are a few changes 
in how teuthology invokes the daemons.

sage


> 
> A hint would be much appreciated :-)
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do nothing.
> 
> 
