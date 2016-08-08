From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: rbd backports
Date: Mon, 8 Aug 2016 22:30:07 +0300
Message-ID: <20160808193006.GA2179@gmail.com>
References: <57A82FE4.10604@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38092 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbcHHTaK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Aug 2016 15:30:10 -0400
Received: by mail-wm0-f49.google.com with SMTP id o80so160403503wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 08 Aug 2016 12:30:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57A82FE4.10604@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Loic,

It works perfectly fine for me! Thank you for your detailed
explanation. Please, let me know if you need any other help with these
PRs from me.

On Mon, Aug 08, 2016 at 09:08:20AM +0200, Loic Dachary wrote:
> Hi Mykola,
> 
> A short note to explain why you were assigned a dozen rbd jewel backports today:
> 
> https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+assignee%3Atrociny+milestone%3Ajewel
> 
> Most of them were authored by someone from the backport team. They have been tested to not break the rbd suite so we are confident they do not contain a trivial problem. But our understanding of the rbd codebase is limited and before merging them we seek approval from the person who merged the original pull request in master. You merged a number of rbd pull request in master and this is why we end up asking for your final review on these backports.
> 
> Please let us know if this work is too much of a burden to you and we will try to find an alternate solution. Except for the simplest cases, figuring out if a set of commits makes sense in a stable version can be challenging.
> 
> Cheers
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Mykola Golub
