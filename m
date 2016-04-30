From: Sage Weil <sage@newdream.net>
Subject: Re: building boost statically
Date: Fri, 29 Apr 2016 21:43:30 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604292137110.26967@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com> <CACJqLyYtBQ8N95BHSH48AD-XexCx+QU9XB8djvomH_rer1tn+w@mail.gmail.com> <CALqRxCyQkBPF0t7RcYzhcFZCzEeviAyL+XeQU0Dr+An1Tx5s4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46831 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbcD3BnX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Apr 2016 21:43:23 -0400
In-Reply-To: <CALqRxCyQkBPF0t7RcYzhcFZCzEeviAyL+XeQU0Dr+An1Tx5s4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 29 Apr 2016, Ken Dreyer wrote:
> On Thu, Apr 28, 2016 at 8:31 PM, Haomai Wang <haomai@xsky.com> wrote:
> > Yes, I'm always glad to see more deps removed!
> 
> It's not removed, it's just moved. The Ceph project will then be on
> the hook for all boost security updates.
> 
> I think we should bundle less not more.  Build times are already long enough...

If building separate packages and including them in all the repos is in 
fact easier, that seems like the right choice.  Static linkage makes 
development easier, but we can make do.

Whether it's static or dynamic, though, we're on the hook for updating the 
packages for bugs or security update either way.  Unless we just give up 
an wait for the distros to catch up, but I don't think that's a viable 
option...

sage

