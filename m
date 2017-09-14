From: Sage Weil <sweil@redhat.com>
Subject: Re: which mds server is damaged?
Date: Thu, 14 Sep 2017 21:37:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709142134130.16664@piezo.novalocal>
References: <CAKRxpus_QKHx=Wi8UU-g50i8g3nkEKdg2mGVcu_uO5FbAoHHFA@mail.gmail.com> <CALe9h7fhfWQ1paK7TpCMVv+FA0Ta4_5X5FGWdWdgwyLjDmZxgA@mail.gmail.com> <CAKRxpuurKQp6vQmt2_mc5ckHZMjHajnivDob58eMpcUXodOupw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751542AbdINVhj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 14 Sep 2017 17:37:39 -0400
In-Reply-To: <CAKRxpuurKQp6vQmt2_mc5ckHZMjHajnivDob58eMpcUXodOupw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 14 Sep 2017, Two Spirit wrote:
> >The thing that's damaged is a logical mds rank (0), not a physical MDS
> >daemon.  What this is telling you is that there is some serious
> >corruption in your metadata pool that prevents that particular rank
> >from starting.
> 
> Zhang helped identify the bug and put it in tracker. I didn't fully
> understand the problem but related to mds replay not happening and the
> write_pos being off. He fixed it after a full scrub was done, the
> degraded file system came back online. After a couple more hours of
> stress testing, the file system went back to degraded(earlier today).

Can you tell us more than "it went degraded"?  It's hard to know what 
you're seeing.

More generally, can you share what you did with the system that originally 
triggered the unfound object?  It ordinarily requires a sequence of 
multiple not-quite-concurrent failures to induce that state, and we don't 
see it much.  I'm surprised you're hitting it right off the bat.

Thanks!
sage
