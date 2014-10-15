From: Dmitry Borodaenko <dborodaenko@mirantis.com>
Subject: Re: Firefly maintenance release schedule
Date: Wed, 15 Oct 2014 14:45:04 -0700
Message-ID: <CAM0pNLNi-1ZG8NjVTgCbV-rPczkqGjDPRz9i8kXytLk29jstyg@mail.gmail.com>
References: <CAM0pNLO7m0=1nkhmqigfMhTeaNYOtW6no9neAWoaX9fKt0uZDg@mail.gmail.com>
	<CAM0pNLN0XoMtWAAqJqgF+VTZmQNu4oFPRUtrDz6FFNWWLo8Sow@mail.gmail.com>
	<CAPYLRzg5we+dGkAGpbC1Byop+L5aiF40pjfdZpynPKRLokHvwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:59564 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbaJOVpF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Oct 2014 17:45:05 -0400
Received: by mail-ob0-f176.google.com with SMTP id m8so1823293obr.7
        for <ceph-devel@vger.kernel.org>; Wed, 15 Oct 2014 14:45:04 -0700 (PDT)
In-Reply-To: <CAPYLRzg5we+dGkAGpbC1Byop+L5aiF40pjfdZpynPKRLokHvwA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

Gregory,

Thanks for prompt response, we'll go with v0.80.7.

It still would be nice if v0.80.8 doesn't take as long as v0.80.6, I
suspect one of the reasons you messed it up was too many commits
without intermediate releases.

On Wed, Oct 15, 2014 at 9:59 AM, Gregory Farnum <greg@inktank.com> wrote:
> Take .80.7. All of the bugs you've cited, you are supremely unlikely
> to run into. The "Urgent" tag is a measure of planning priority, not
> of impact to users; here it generally means "we found a bug on a
> stable branch that we can reproduce". Taking them in order:
> http://tracker.ceph.com/issues/9492: only happens if you try and cheat
> with your CRUSH rules, and obviously nobody did that until Sage
> suggested it as a solution to the problem somebody had 29 days ago
> when this was discovered.
> http://tracker.ceph.com/issues/9039: The most serious here, but only
> happens if you're using RGW, and storing user data in multiple pools,
> and issue a COPY command to copy data between different pools.
> http://tracker.ceph.com/issues/9582: Only happens if you're using the
> op timeout feature of librados with the C bindings OR the op timeout
> feature *and* the user-provided buffers in the C++ interface. (To the
> best of my knowledge, the people who discovered this are the only ones
> using op timeouts.)
> http://tracker.ceph.com/issues/9307: I'm actually not sure what's
> going on here; looks like some kind of extremely rare race when
> authorizing requests? (ie, fixed by a retry)
>
> We messed up the v0.80.6 release in a very specific way (and if you
> were deploying a new cluster it wasn't a problem), but you're
> extrapolating too much from the presence of patches about what their
> impact is and what the system's stability is. These are largely
> cleaning up rough edges around user interfaces, and smoothing out
> issues in the new functionality that a standard deployment isn't going
> to experience. :)
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com



-- 
Dmitry Borodaenko
