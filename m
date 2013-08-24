From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH] mds: remove waiting lock before merging with neighbours
Date: Sat, 24 Aug 2013 14:02:49 +0200
Message-ID: <20130824140249.7a6493c1@plati.site>
References: <1375110344-26133-1-git-send-email-ddiss@suse.de>
	<CAPYLRzgeWsdxyqWNRykH1Ac+TChQwFh4PKmP7D81jc89YOZJ9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48523 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479Ab3HXMC7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 24 Aug 2013 08:02:59 -0400
In-Reply-To: <CAPYLRzgeWsdxyqWNRykH1Ac+TChQwFh4PKmP7D81jc89YOZJ9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 23 Aug 2013 13:58:56 -0700
Gregory Farnum <greg@inktank.com> wrote:

>     When handling a lock request, the MDS calls adjust_locks() to merge
>     the new lock with available neighbours. If the new lock is merged,
>     then the waiting_locks entry is not located in the subsequent
>     remove_waiting() call because adjust_locks changed the new lock to
>     include the old locks.
>     This fix ensures that the waiting_locks entry is removed prior to
>     modification during merge.

Looks good.

> And it's now merged into master and backported to dumpling. Thank you very much!

Great, thanks Gregory.

Cheers, David
