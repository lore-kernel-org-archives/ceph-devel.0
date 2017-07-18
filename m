From: Sage Weil <sage@newdream.net>
Subject: Re: release v12.1.1?
Date: Tue, 18 Jul 2017 17:52:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707181752300.27271@piezo.novalocal>
References: <CALqRxCwq_qhLFuUnrNNLgM+qZ-oixDmaUgf9e6e+dP1EeXfKJQ@mail.gmail.com> <alpine.DEB.2.11.1707142012520.27271@piezo.novalocal> <CALqRxCzCu3dchCu30CEmirxAkpYhe2NuZ73zHWcsUT0eg_QeoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56482 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdGRRwn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jul 2017 13:52:43 -0400
In-Reply-To: <CALqRxCzCu3dchCu30CEmirxAkpYhe2NuZ73zHWcsUT0eg_QeoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 18 Jul 2017, Ken Dreyer wrote:
> On Fri, Jul 14, 2017 at 2:13 PM, Sage Weil <sage@newdream.net> wrote:
> > Yes!  I was hoping to get the missing deletes in there but there is plenty
> > to justify the next rc.
> 
> "git describe master" still thinks the latest tag for that branch is v12.1.0:
> 
> v12.1.0-1133-gd91f57c
> 
> What do we need to do to make that look right (12.1.1-something)?

Fixed (merged luminous branch back into master).

sage
