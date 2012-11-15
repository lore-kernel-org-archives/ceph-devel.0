From: Alex Elder <elder@inktank.com>
Subject: Re: new process: cherry-picking to stable releases
Date: Thu, 15 Nov 2012 12:37:07 -0600
Message-ID: <50A53653.40204@inktank.com>
References: <alpine.DEB.2.00.1211150926180.26823@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61629 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768466Ab2KOShL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 13:37:11 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so2507704iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 10:37:10 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211150926180.26823@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 11/15/2012 11:30 AM, Sage Weil wrote:
> If you are *ever* cherry-picking something to an older stable branch, 
> please use 
> 
>  git cherry-pick -x <sha1>
> 
> That will append a '(cherry-picked from ....)' message to the bottom of 
> the commit, allowing us to always find the original commit that we are 
> duplicating.
> 
> This implies that we are always committing to the master/next branch 
> *first*, and then cherry-picking to stable.  As a general rule, a fix 
> should always be 'upstream' first in the new branches before it is 
> backported to something older.  The exception is fix that is unique to the 
> stable branch, for example because the new code has changed.

It also implies--or to be useful requires--that anything committed
to master is pretty much permanent (and never rebased).  The master
branch should be considered append-only.

					-Alex
