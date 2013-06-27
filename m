From: Sage Weil <sage@inktank.com>
Subject: Re: wip-libcephfs rebase
Date: Thu, 27 Jun 2013 12:48:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306271246440.397@cobra.newdream.net>
References: <466224703.168.1372355669107.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48082 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab3F0Tsh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jun 2013 15:48:37 -0400
In-Reply-To: <466224703.168.1372355669107.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, aemerson <aemerson@linuxbox.com>, David Zafman <david.zafman@inktank.com>, Ilya Storozhilov <Ilya_Storozhilov@epam.com>

On Thu, 27 Jun 2013, Matt W. Benjamin wrote:
> Just to confirm what Adam and I are doing on this end, ie, this is our plan to rebase wip-libcephfs following wip-libcephfs-rebase.
> 
> * proceeding commit-wise on wip-libcephfs-rebase, mapping each change back to a commit in wip-libcephfs

I wouldn't worry about referencing the original commits unless it is 
important to you guys (it isn't to me).  Those commits won't appear in the 
canonical ceph.git source tree anyway.

> ** striking out anything marked reject in rebase
> ** striking out anything marked "whitespace"
> *** (unless you want these)

We can keep the whitespace fixes, as long as they are in spearate patches 
from real changes

> ** either striking out or motivating in commit message anything marked "why"
> ** updating commit messages of every commit which remains
> *** with author, signed off by, SHAs of the source commit(s), updated commit message (background authors)
> * test, fix, and rebase as necessary
> * cherry-pick changes from Ilya
> ** adapt anything we propose to adjust in new commits
> * rebase on head
> * push to our Ceph repo for review/pull when ready

Sounds good!

sage
