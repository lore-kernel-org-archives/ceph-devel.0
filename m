From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH 00/15] fix more issues from clang(++) and cppchecker
Date: Sun, 10 Feb 2013 14:38:53 +0100
Message-ID: <5117A2ED.9060507@bisect.de>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de> <alpine.DEB.2.00.1302092201010.11665@cobra.newdream.net>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:57764 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754791Ab3BJNi6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sun, 10 Feb 2013 08:38:58 -0500
In-Reply-To: <alpine.DEB.2.00.1302092201010.11665@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>

Am 10.02.2013 07:02, schrieb Sage Weil:
> Hey Danny-
> 
> These look good, modulo those 2 comments.  Do you have a public git tree 
> with these patches I can cherry-pick or pull from?  It's a bit faster than 
> yanking them off the list for merge (although posting to the list for 
> review is still good, of course).

Check:

https://github.com/dalgaaf/ceph.git

I've move the patches to these branches and filled a pull request:

wip-da-sca-memleaks (6 patches, incl. fixed version of patch 5)
-> https://github.com/ceph/ceph/pull/42

wip-da-sca-cppcheck-clang (13 patches, without patch 1 and 13)
-> https://github.com/ceph/ceph/pull/43

Danny
