From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 0/6] fix build (ceph.spec)
Date: Wed, 30 Jan 2013 10:07:55 -0800
Message-ID: <92E15B6073484C53B4AE3A0B85F0FC25@inktank.com>
References: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:36020 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666Ab3A3SIB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 13:08:01 -0500
Received: by mail-da0-f49.google.com with SMTP id v40so883544dad.36
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 10:08:00 -0800 (PST)
In-Reply-To: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>, dan.mick@inktank.com
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Watkins Noah <noah.watkins@inktank.com>

On Wednesday, January 30, 2013 at 10:00 AM, Danny Al-Gaaf wrote:
> This set fixes some issues in the spec file. 
> 
> I'm not sure what the reason for #35e5d74e5c5786bc91df5dc10b5c08c77305df4e
> was. But I would revert it and fix the underlaying issues instead.


That is a pretty obtuse commit message, but it was actually because while rbd-fuse is ready to be in-tree, we don't think it's ready for people to be using; there are some undocumented gotchas involved with it and not a lot of testing. :)

I'll let others comment on the Java library moves and other packaging changes.
-Greg

