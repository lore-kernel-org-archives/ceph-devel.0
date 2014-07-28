From: John Spray <john.spray@redhat.com>
Subject: Re: wip-objecter
Date: Tue, 29 Jul 2014 00:45:57 +0100
Message-ID: <CAGd4Wr1+aCNf4aN2f3mYgxGDRo3K-eZ9ZOng2OAywXMGZDFj7Q@mail.gmail.com>
References: <alpine.DEB.2.00.1407251727430.5027@cobra.newdream.net>
	<CAGd4Wr17ds-r8u4ZZfSwptsCV9LV43s206=c_uee5Lp4R7ex3A@mail.gmail.com>
	<alpine.DEB.2.00.1407281437030.4962@cobra.newdream.net>
	<alpine.DEB.2.00.1407281512440.4962@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38284 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbaG1Xp6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jul 2014 19:45:58 -0400
Received: by mail-pa0-f46.google.com with SMTP id lj1so11366686pab.33
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jul 2014 16:45:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407281512440.4962@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jul 28, 2014 at 11:17 PM, Sage Weil <sweil@redhat.com> wrote:
> I wonder if a safer approach is to make a subclass of Context called
> RelockingContext, which takes an mds_lock * in the ctor, and then make all
> of the other completions subclasses of that.  That way we can use type
> checking to ensure that all Context's passed to MDLog::submit_entry() (or
> other places that make sense) are of the right type.  Hopefully there
> aren't any classes that are used in both and locking and non-locking
> context...

Greg and I chatted about this sort of thing a bit last week, where the
same sort of mechanism might be used to distinguish completions that
need to go via a finisher vs. ones that are safe to call directly.  I
convinced myself that wasn't going to work last week (because we have
to call completions from the journaler in the right order), but the
general idea of declaratively distinguishing contexts like this is
still appealing.

The following are the interesting attributes of contexts:
  1 Contexts that just don't care how they're called (e.g.
C_OnFinisher can be called any which way)
  2 Contexts that will take mds_lock (if you're holding it, send via
finisher thread)
  3 Contexts that require mds_lock is already held
  4 Contexts that may call into Journaler (you may not call this while
holding Journaler.lock, if you're holding it, send via finisher
thread)
  5 Contexts that may do Objecter I/O (you may not call this from an
objecter callback, if you're in that situation you must go via a
finisher thread)

These are not all exclusive.  Number 5 goes away when we switch to
librados, because it's already going to be going via a finisher thread
before calling back our I/O completions.  For the moment we get the
same effect by using C_OnFinisher with all the C_IO_* contexts.

Number 4 goes away if Journaler sends all its completions via a
finisher, as seems to be the simplest thing to do right now.

> Alternatively, we could make a LockingFinisher class that takes the
> specified lock (mds_lock) before calling each Context.  That might be
> simpler?

Hmm, if we did that then completions might sometimes hop up multiple
finishers if they went e.g. first into a "take the mds lock" finisher
then subsequently via a "the mds lock must be held" finisher (second
one being strictly redundant but it sure would be nice to have the
check in there somehow).

The explicit Context subclasses has lots of appeal to me from the
compile-time assurance we would have that we were using the right kind
of thing in the right kind of place, e.g. when we do add_waiter calls
on an inode's lock we can check at compile time that we're passing a
"mds lock already held" subclass.

John
