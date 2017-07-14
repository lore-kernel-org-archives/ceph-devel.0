From: Sage Weil <sage@newdream.net>
Subject: Re: release v12.1.1?
Date: Fri, 14 Jul 2017 20:13:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707142012520.27271@piezo.novalocal>
References: <CALqRxCwq_qhLFuUnrNNLgM+qZ-oixDmaUgf9e6e+dP1EeXfKJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45320 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdGNUNd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jul 2017 16:13:33 -0400
In-Reply-To: <CALqRxCwq_qhLFuUnrNNLgM+qZ-oixDmaUgf9e6e+dP1EeXfKJQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yes!  I was hoping to get the missing deletes in there but there is plenty 
to justify the next rc.



On Fri, 14 Jul 2017, Ken Dreyer wrote:

> "git describe" indicates there are a thousand commits on master that
> are not in  v12.1.0.
> 
> Should we tag and release v12.1.1 now to get more testing?
> 
> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
