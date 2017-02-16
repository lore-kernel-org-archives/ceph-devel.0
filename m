From: John Spray <jspray@redhat.com>
Subject: Re: Permuting only some things with teuthology-suite --subset
Date: Thu, 16 Feb 2017 23:27:14 +0000
Message-ID: <CALe9h7fHkEd0_KC+hu0_Q-3AujD9dJbqKdDkraGmov5YEf-SUg@mail.gmail.com>
References: <CALe9h7dmdBKgc6DXdycRC1wXgRDMH560=RuK_ZYKzhJKvFQFKg@mail.gmail.com>
 <CAMMFjmH8Rhv1nUTVocyQz+JoaOKN9-L_GBim4CJLQwULVT8RJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36322 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933590AbdBPX1g (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 18:27:36 -0500
Received: by mail-wm0-f41.google.com with SMTP id c85so77841507wmi.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 15:27:36 -0800 (PST)
In-Reply-To: <CAMMFjmH8Rhv1nUTVocyQz+JoaOKN9-L_GBim4CJLQwULVT8RJQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Feb 16, 2017 at 11:14 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> I can't say I understand details on what you want to achieve, but I'd
> try combination of "--subset" and "--filter"
>
> I think/hope "--filter" would work on whatever you get out of "--subset" filter.

Ah, the key thing is that I don't want to just run a filtered part of
the sample, I want to control which aspects of the test are sampled,
vs which are all run.  I am also having trouble putting together the
right words to explain this :-)

So if I've got a suite that looks something like this:

mysuite/rados_pool/ec.yaml
mysuite/rados_pool/replicated.yaml
mysuite/rados_store/bluestore.yaml
mysuite/rados_store/xfs.yaml
mysuite/cephfs_inline/yes.yaml
mysuite/cephfs_inline/no.yaml
mysuite/tasks/myworkunit.yaml

Then I want to always include all permutations of cephfs_inline, while
only including a subset of the permutations of rados_pool and
rados_store.  There are 4 permutations of the rados_* bits, so I'd be
passing something like --subset=1/4, but for it to work the way I want
I need a way to tell teuthology-suite to only do the subset part on
the rados bits, and leave the cephfs bits alone.

John






> On Thu, Feb 16, 2017 at 3:11 PM, John Spray <jspray@redhat.com> wrote:
>> Evening all,
>>
>> I'm wondering if this is something that's buried in the existing code,
>> or if others have thought about it -- I'd like to be able to do the
>> --subset sampling, but only on some aspects of a suite.  Specifically,
>> in the fs suite we have some RADOS-level options like xfs vs.
>> bluestore, forthcoming EC vs. replication, and I'd like to sample
>> those, while still running all the cephfs-specific permutations
>> exhaustively.
>>
>> So if this doesn't already exist I guess it could look something like
>> --suite fs --subset=1/3, --subset-filter=rados_* (e.g. if I adopted a
>> naming convention where dirs/files controlling the rados-ish bits wre
>> named like that).
>>
>> Any thoughts?
>>
>> John
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
