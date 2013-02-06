From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: [PATCH 0/8] fix some issues from cppchecker/clang++
Date: Tue, 5 Feb 2013 19:50:46 -0800
Message-ID: <9D23CE98-68BE-47AA-89BA-0D114E564E88@inktank.com>
References: <1360104750-16098-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:33233 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab3BFDuv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 22:50:51 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so394461dan.37
        for <ceph-devel@vger.kernel.org>; Tue, 05 Feb 2013 19:50:50 -0800 (PST)
In-Reply-To: <1360104750-16098-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Hi Danny -

These patches are now in the wip.cppchecker branch.  Build so far looks good.

Cheers,
Gary

On Feb 5, 2013, at 2:52 PM, Danny Al-Gaaf wrote:

> These patches fix some issues found by using cppchecker/clang++.
> 
> Danny Al-Gaaf (8):
>  WorkQueue.h: fix cast
>  ceph_crypto.cc: remove unused shutdown() outside crypto ifdef's
>  obj_bencher.cc: use vector instead of VLA's
>  include/buffer.h: fix operator=
>  include/types.h: change operator<< function parameter
>  include/xlist.h: fix C-style pointer casting
>  messages/MOSDRepScrub.h: initialize member variable in constructor
>  msg/Message.h: fix C-style pointer casting
> 
> src/common/WorkQueue.h      |  4 ++--
> src/common/ceph_crypto.cc   |  1 -
> src/common/obj_bencher.cc   | 13 +++++++------
> src/include/buffer.h        | 10 +++++++---
> src/include/types.h         |  2 +-
> src/include/xlist.h         |  6 +++---
> src/messages/MOSDRepScrub.h |  2 +-
> src/msg/Message.h           |  4 ++--
> 8 files changed, 23 insertions(+), 19 deletions(-)
> 
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

