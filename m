From: Sage Weil <sage@newdream.net>
Subject: Re: add stop_scrub command for ceph
Date: Mon, 23 Mar 2015 06:48:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503230646440.6964@cobra.newdream.net>
References: <CANE=7sXF+_s7eOaLCsLW9scwrdbpfzGWqVfz86u399PCs1eNAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40020 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbbCWNsP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 09:48:15 -0400
In-Reply-To: <CANE=7sXF+_s7eOaLCsLW9scwrdbpfzGWqVfz86u399PCs1eNAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xinze Chi <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Mon, 23 Mar 2015, Xinze Chi wrote:
> hi ceph:
> 
>     Currently, there is not a command which can stop scrubbing when
> the pg is doing scrub or deep
> scrub. What about add a command to support it ? I think this s every
> used for system administrator.
> 
>      I have add a issue to track it. http://tracker.ceph.com/issues/11202.

This sounds like the right solution to me.

I think the main thing we need in order to ensure this works reliably is 
to modify ceph-qa-suite.git/tasks/thrasosds.py and/or ceph_manager.py so 
that it periodically sets/unsets the noscrub flags so that we exercise the 
new cancellation code path.  Do you mind preparing a patch for that too?

Thanks!
sage
