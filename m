From: Dmitry Borodaenko <dborodaenko@mirantis.com>
Subject: Re: Firefly maintenance release schedule
Date: Wed, 15 Oct 2014 09:39:49 -0700
Message-ID: <CAM0pNLN0XoMtWAAqJqgF+VTZmQNu4oFPRUtrDz6FFNWWLo8Sow@mail.gmail.com>
References: <CAM0pNLO7m0=1nkhmqigfMhTeaNYOtW6no9neAWoaX9fKt0uZDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:63338 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaJOQju (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Oct 2014 12:39:50 -0400
Received: by mail-oi0-f47.google.com with SMTP id a141so1255125oig.6
        for <ceph-devel@vger.kernel.org>; Wed, 15 Oct 2014 09:39:50 -0700 (PDT)
In-Reply-To: <CAM0pNLO7m0=1nkhmqigfMhTeaNYOtW6no9neAWoaX9fKt0uZDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Sep 30, 2014 at 6:49 PM, Dmitry Borodaenko
<dborodaenko@mirantis.com> wrote:
> Last stable Firefly release (v0.80.5) was tagged on July 29 (over 2
> months ago). Since then, there were twice as many commits merged into
> the firefly branch than there existed on the branch before v0.80.5:
>
> $ git log --oneline --no-merges v0.80..v0.80.5|wc -l
> 122
> $ git log --oneline --no-merges v0.80.5..firefly|wc -l
> 227
>
> Is this a one time aberration in the process or should we expect the
> gap between maintenance updates for LTS releases of Ceph to keep
> growing?

I didn't get a response to that nag other than the v0.80.6 release
announcement on the day after, so I guess it wasn't completely ignored
:)

Except it turned out v0.80.6 was slightly less than useful as a
maintenance release:
http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-October/043701.html

Two weeks later we have v0.80.7 with 3 more commits that hopefully
make it actually usable. There are many ways to look at that from
release management perspective.

Good: 2 weeks is much better than 2 months.
Bad: that's 2.5 months since last *stable* Firefly release.
Ugly: that's 2 weeks for 3 commits, and now we have 54 more waiting
for the next release...

Wait what?! Oh right, 54 more commits were merged from firefly-next as
soon as v0.80.7 was tagged:
$ git log --oneline --no-merges v0.80.7..firefly|wc -l
54

Some of these are fixes for Urgent priority bugs, crashes, and data loss:
http://tracker.ceph.com/issues/9492
http://tracker.ceph.com/issues/9039
http://tracker.ceph.com/issues/9582
http://tracker.ceph.com/issues/9307
etc.

So what a Ceph deployer supposed to do with this? Wait another couple
of weeks (hopefully) for v0.80.8? Take v0.80.7 and hope not to
encounter any of these bugs? Or label Firefly as "not production ready
yet" and go back to Dumpling? My personal preference obviously would
be the first option, but waiting for 2.5 more months is not going to
fit my schedule :(

-- 
Dmitry Borodaenko
