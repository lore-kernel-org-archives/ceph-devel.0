From: John Spray <jspray@redhat.com>
Subject: ceph-qa-suite branching (merge it into ceph.git?)
Date: Wed, 13 Apr 2016 11:52:21 +0100
Message-ID: <CALe9h7fp=qaio8npS0naXjCp9bbg-kkB6bXG9PcGXGftvD4puA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35614 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbcDMKwm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 06:52:42 -0400
Received: by mail-oi0-f42.google.com with SMTP id p188so58351965oih.2
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 03:52:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, ceph-qa <ceph-qa@ceph.com>

Lately, we've instances where ceph.git and ceph-qa-suite.git got
slightly out of sync, as we were adding new stuff and interface
changes to ceph (especially in cephfs).

We used to have two repos (ceph and teuthology), now we have three
(ceph, ceph-qa-suite and teuthology).  Splitting tests out of
teuthology was a good thing, but maybe they should have gone into the
ceph tree instead of a new repo?  The ceph-qa-suite branching seems to
pretty much mirror what we do with ceph, with master vs jewel etc.

Historically we had a comparatively static set of workloads in the qa
suite (e.g. kernel-untar-build, fsstresss, pjd), which didn't change
much with ceph changes.  But these days we're adding much more
detailed tests, so there's more effort to keep the two in sync.

I would personally love to be able to have a single PR that contained
my code and the tests for it.  What if after Jewel we pulled all of
ceph-qa-suite into the ceph repo?

We could still enable folks running test changes without having to
rebuild ceph packages: the suite sha1 selected when running a
teuthology suite could still be different from that used for
installing ceph, it's just that it would fetch that sha1 from the ceph
repo instead of from a separate repo.

John
