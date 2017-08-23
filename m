From: Sage Weil <sage@newdream.net>
Subject: Re: needs-backport label on github/ceph/ceph
Date: Wed, 23 Aug 2017 13:59:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708231355580.20435@piezo.novalocal>
References: <CAJE9aONVUvVCuKEdrLxNf8Z1YEard8ZoT9wy+tdzgCn9UTQb-Q@mail.gmail.com> <CALe9h7cvEeD27eyL8rMTsbfwzXvX20RebMSDkBm+=F0kKzVBMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32799 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754001AbdHWN72 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Aug 2017 09:59:28 -0400
In-Reply-To: <CALe9h7cvEeD27eyL8rMTsbfwzXvX20RebMSDkBm+=F0kKzVBMA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 22 Aug 2017, John Spray wrote:
> On Tue, Aug 22, 2017 at 4:09 PM, kefu chai <tchaikov@gmail.com> wrote:
> > i noticed that we have a new label named "needs-backport" [0]? could
> > you shed some light on how we are supposed to use it? i thought we
> > were going to cherry-pick all PRs with this label merged after the
> > luminous was forked. but seems we are still marking PRs should be
> > included by luminous with the "luminous" milestone. so i have no clues
> > now =(
> 
> I'm curious too -- I believe the authoriative way to mark something
> for backport is in a tracker ticket, so a separate label probably
> isn't needed?

I added it for tagging PRs that don't have a tracker ticket open (e.g., 
small usability cleanups that weren't bugs).  It's a bit less overhead 
than opening a ticket and going through the usual process.

It was helpful when every third PR had to be cherry-picked to 
luminous; that will be less common once the release is out the door.

sage
