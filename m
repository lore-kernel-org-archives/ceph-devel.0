From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 0/8] fix some issues from cppchecker/clang++
Date: Tue, 5 Feb 2013 21:51:05 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302052150430.22404@cobra.newdream.net>
References: <1360104750-16098-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37384 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab3BFFvF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 00:51:05 -0500
In-Reply-To: <1360104750-16098-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>

On Tue, 5 Feb 2013, Danny Al-Gaaf wrote:
> These patches fix some issues found by using cppchecker/clang++.

A couple comments, but otherwise these look good. 

Thanks, Danny!
sage


> 
> Danny Al-Gaaf (8):
>   WorkQueue.h: fix cast
>   ceph_crypto.cc: remove unused shutdown() outside crypto ifdef's
>   obj_bencher.cc: use vector instead of VLA's
>   include/buffer.h: fix operator=
>   include/types.h: change operator<< function parameter
>   include/xlist.h: fix C-style pointer casting
>   messages/MOSDRepScrub.h: initialize member variable in constructor
>   msg/Message.h: fix C-style pointer casting
> 
>  src/common/WorkQueue.h      |  4 ++--
>  src/common/ceph_crypto.cc   |  1 -
>  src/common/obj_bencher.cc   | 13 +++++++------
>  src/include/buffer.h        | 10 +++++++---
>  src/include/types.h         |  2 +-
>  src/include/xlist.h         |  6 +++---
>  src/messages/MOSDRepScrub.h |  2 +-
>  src/msg/Message.h           |  4 ++--
>  8 files changed, 23 insertions(+), 19 deletions(-)
> 
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
