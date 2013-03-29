From: Sage Weil <sage@inktank.com>
Subject: Re: Using google mock
Date: Fri, 29 Mar 2013 08:24:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303290823350.6485@cobra.newdream.net>
References: <51553FB4.8000208@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52903 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893Ab3C2PYN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 11:24:13 -0400
In-Reply-To: <51553FB4.8000208@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 29 Mar 2013, Loic Dachary wrote:
> Hi,
> 
> Google mock ( ) provides convenient string matchers ( http://code.google.com/p/googlemock/wiki/CheatSheet#String_Matchers ) that would be useful when writing unit tests. It is available in most distributions:
> 
> http://packages.debian.org/search?keywords=google-mock
> https://launchpad.net/ubuntu/+source/google-mock
> http://rpmfind.net/linux/rpm2html/search.php?query=gmock
> 
> I've never used it before. Any objection on adding it as a dependency in addition to google test ?

I think as long as it is in EPEL or we can get an el6 package for those 
builds, it should be fine.

http://ceph.com/gitbuilder.cgi

is what we need to cover.

Thanks!
sage

