From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 5/6] SyntheticClient.cc: fix some memory leaks in the
 error handling
Date: Sun, 10 Feb 2013 18:07:00 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302101806160.5429@cobra.newdream.net>
References: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de> <1360340703-7170-6-git-send-email-danny.al-gaaf@bisect.de> <alpine.DEB.2.00.1302092203440.11665@cobra.newdream.net> <51175DC3.2020008@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59905 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab3BKCHA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Feb 2013 21:07:00 -0500
In-Reply-To: <51175DC3.2020008@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>

On Sun, 10 Feb 2013, Danny Al-Gaaf wrote:
> Am 10.02.2013 07:04, schrieb Sage Weil:
> > On Fri, 8 Feb 2013, Danny Al-Gaaf wrote:
> [...]
> >>    //dout(5) << "SyntheticClient::write_fd: writing to fd " << fd << dendl;
> >> -  if (fd < 0) return fd;
> >> +  if (fd < 0) {
> >> +    return fd;
> >> +    delete[] buf;
> > 
> > oops, wrong order...
> 
> I know, that's why I've send another fixed version of this patch to the
> list the same day:
> http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/12969/focus=12985

Oops, I see it now, sorry :)

I merged the memleaks branch.  The cppcheck-clang one is coming up with 
build errors tho:

	http://ceph.com/gitbuilder.cgi

Thanks!
sage
