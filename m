From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] mds: remove waiting lock before merging with
 neighbours
Date: Thu, 1 Aug 2013 11:07:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308011106190.22584@cobra.newdream.net>
References: <1375110344-26133-1-git-send-email-ddiss@suse.de> <20130801141112.2517c0c4@f163.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36306 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab3HASHU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 14:07:20 -0400
In-Reply-To: <20130801141112.2517c0c4@f163.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: ceph-devel@vger.kernel.org

On Thu, 1 Aug 2013, David Disseldorp wrote:
> Hi,
> 
> Did anyone get a chance to look at this change?
> Any comments/feedback/ridicule would be appreciated.

Sorry, not yet--and Greg just headed out for vacation yesterday.  It's on 
my list to look at when I have some time tonight or tomorrow, though. 
Thanks!  

I'm hopefully this will clear up some of the locking hangs we've seen with 
the samba and flock tests...

sage


> 
> Cheers, David
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
