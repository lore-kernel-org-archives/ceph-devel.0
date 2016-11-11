From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: master branch merges must pass unit tests
Date: Thu, 10 Nov 2016 21:14:52 -0500
Message-ID: <CA+2bHPae64=fuuUCz2yaa0rEKahwDVgupU3JLeBwkm8SxW_Gyg@mail.gmail.com>
References: <alpine.DEB.2.11.1611082147590.29278@piezo.us.to> <alpine.DEB.2.11.1611082331480.29278@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:35973 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935655AbcKKCPX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Nov 2016 21:15:23 -0500
Received: by mail-it0-f46.google.com with SMTP id q124so280066316itd.1
        for <ceph-devel@vger.kernel.org>; Thu, 10 Nov 2016 18:15:23 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611082331480.29278@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 8, 2016 at 6:34 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 8 Nov 2016, Sage Weil wrote:
>> I enabled the github check that the unit tests pass in order to merge to
>> master.  These tests still aren't completely reliable, but they're close,
>> and we'll make better progress if we start enforcing it now.
>
> I went a bit further and also checked the box requiring a review and
> preventing pushes directly to master branch.  These are already uneforced
> requirements so this shouldn't slow people down *except* that we need to
> start using the new github 'review' feature that lets you explicitly
> approve changes.
>
> Again, the core developers can override these restrictions if necessary.
>
> I haven't done anything to the stable branches, but we might want to do
> the same thing there...

I went ahead and tried to merge a simple PR to see what would happen:

https://github.com/ceph/ceph/pull/11904

Before review:

$ git push upstream master
Counting objects: 9, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (9/9), 1.57 KiB | 0 bytes/s, done.
Total 9 (delta 7), reused 8 (delta 7)
remote: Resolving deltas: 100% (7/7), completed with 7 local objects.
remote: error: GH006: Protected branch update failed for refs/heads/master.
remote: error: Required status check "default" is failing. At least
one approved review is required
To github.com:ceph/ceph.git
 ! [remote rejected] master -> master (protected branch hook declined)
error: failed to push some refs to 'git@github.com:ceph/ceph.git'

Not unexpected, then I did a review.

$ git push upstream master --force
Counting objects: 9, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (9/9), 1.57 KiB | 0 bytes/s, done.
Total 9 (delta 7), reused 8 (delta 7)
remote: Resolving deltas: 100% (7/7), completed with 7 local objects.
remote: error: GH006: Protected branch update failed for refs/heads/master.
remote: error: Required status check "default" is failing.
To github.com:ceph/ceph.git
 ! [remote rejected] master -> master (protected branch hook declined)
error: failed to push some refs to 'git@github.com:ceph/ceph.git'

(With and without --force, same result.)

My understanding is that only users/teams with admin writes (or
organization owners) on ceph/ceph can push in this situation. Is that
what we want? I don't think we have anyone with admin on ceph/ceph but
maybe I somehow can't see those users/teams.

-- 
Patrick Donnelly
