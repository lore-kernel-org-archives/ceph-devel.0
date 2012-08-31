From: Sage Weil <sage@inktank.com>
Subject: Re: wip-crush
Date: Fri, 31 Aug 2012 13:36:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208311331000.2525@cobra.newdream.net>
References: <alpine.DEB.2.00.1208211807330.12167@cobra.newdream.net> <5034F0B4.3060107@hastexo.com> <C4813C81-696A-4261-A4E7-991C719C0DB2@ornl.gov> <alpine.DEB.2.00.1208220929390.32470@cobra.newdream.net> <CAPYLRzjmcOuSkxG1iO8GqEZPeLchKwKP94KizB7mXWzAU2a57w@mail.gmail.com>
 <alpine.DEB.2.00.1208221047460.29719@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48607 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859Ab2HaUgL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 16:36:11 -0400
In-Reply-To: <alpine.DEB.2.00.1208221047460.29719@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "Atchley, Scott" <atchleyes@ornl.gov>, Florian Haas <florian@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Okay, it's trivial to change 'pool' to 'root' in the default generated 
crush map, and update all the docs accordingly.  The problem is that some 
stuff built on top of ceph has 'pool=default' in there, including our chef 
cookbooks and those that other people are building.

I see a few options:

1) - Document that pool=default should be used for clusters created 
     pre-0.52, and root=default for clusters created after that (at 
     http://ceph.com/docs/...).
   - Tell new tools to use root=default
   - Encourage existing tools to use *both* root=default pool=default (if 
     the type is not present, it will be ignored).  They will break on 
     newly created clusters with new code, but it will at least happen 
     quickly (on cluster creation).
   - Make noise in the release notes+announcement.

2) Make 'pool' be silently translated to 'root' (and the other way around) 
   if the type is not present.  That way new tools with old clusters will 
   work, and new clusters with old automation will work.

Other ideas?  I don't much like #2.

sage
