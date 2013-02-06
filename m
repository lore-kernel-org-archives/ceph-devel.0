From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH v2 0/8] fix some issues from cppchecker/clang++
Date: Wed, 6 Feb 2013 10:44:11 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302061044040.13326@cobra.newdream.net>
References: <1360148571-6984-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46422 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab3BFSoM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 13:44:12 -0500
In-Reply-To: <1360148571-6984-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>, Gary Lowell <gary.lowell@inktank.com>

THanks-

I just pulled this in, along with the rbd-fuse fix.

On Wed, 6 Feb 2013, Danny Al-Gaaf wrote:

> These patches fix some issues found by using cppchecker/clang++.
> 
> ---
> v2: - [4/8]: don't copy append_buffer and last_p
>     - [7/8]: use C++ initalize syntax for constructor
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
>  src/include/buffer.h        |  8 +++++---
>  src/include/types.h         |  2 +-
>  src/include/xlist.h         |  6 +++---
>  src/messages/MOSDRepScrub.h |  5 ++++-
>  src/msg/Message.h           |  4 ++--
>  8 files changed, 24 insertions(+), 19 deletions(-)
> 
> -- 
> 1.8.1.2
> 
> 
