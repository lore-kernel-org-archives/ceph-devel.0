From: John Spray <jspray@redhat.com>
Subject: Re: MultiMDS Test Progress
Date: Fri, 5 Aug 2016 13:06:04 +0100
Message-ID: <CALe9h7fOBfyvx2Bx9LVUfZA=PT8fEhTA1GMsco12ouud2Kfnig@mail.gmail.com>
References: <CA+2bHPamkv7Qa5M3FhYuFRg5cJuO4aq8e_04XmvRmir4va1t6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33262 "EHLO
	mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934983AbcHEMGZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Aug 2016 08:06:25 -0400
Received: by mail-qt0-f175.google.com with SMTP id w38so173032221qtb.0
        for <ceph-devel@vger.kernel.org>; Fri, 05 Aug 2016 05:06:25 -0700 (PDT)
In-Reply-To: <CA+2bHPamkv7Qa5M3FhYuFRg5cJuO4aq8e_04XmvRmir4va1t6Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Aug 5, 2016 at 4:54 AM, Patrick Donnelly <pdonnell@redhat.com> wrote:
> Hello all,
>
> For the past two weeks I've been in the process of resurrecting the multimds
> test suite which has not be regularly exercised in some time. This is part of
> the initial work to have multiple active metadata server configurations
> regularly tested and supported. Recent multimds test runs can be viewed (as
> always) at [1].
>
> The first stage of this work is to organize and process the current failures
> into bug reports [2-8]. These are just the currently known failures we have
> coming from our tests. Some failures like #16926 [8] are particularly
> widespread and probably masking many other failures.
>
> As the team works on these bugs, the next steps are to expand our test coverage
> of the multimds suite. So far we have planned:
>
> o [9] Testing MDS cluster size changes under load.
>
> o [10] Testing directory fragmentation and inode export under load. This test
>   will be exercising the balancer in the MDS.
>
> o [11] Testing cluster recovery during failures migration/fragmentation.
>
> o [To Be Filed] Testing rename with authoritative inodes/directories varying
>   across multiple MDSs.
>
> o [To Be Filed] Integrate recently added tests in the fs suite into the
>   multimds suite.
>
> Please let us know if you have any comments or questions.
>
> [1] http://pulpito.ceph.com/?suite=multimds
> [2] http://tracker.ceph.com/issues/16768
> [3] http://tracker.ceph.com/issues/16807
> [4] http://tracker.ceph.com/issues/16886
> [5] http://tracker.ceph.com/issues/16914
> [6] http://tracker.ceph.com/issues/16913
> [7] http://tracker.ceph.com/issues/16925
> [8] http://tracker.ceph.com/issues/16926
> [9] http://tracker.ceph.com/issues/10792
> [10] http://tracker.ceph.com/issues/7320
> [11] http://tracker.ceph.com/issues/4492

Great summary, thanks.

I'm actually really pleased that we're seeing lots of failures from
the existing multimds suite, it means it has decent coverage and we
have things to work on.

One area we're lacking in (both for multimds and the rest) is
exercising systems at their cache limits, most of our tests run well
within the default mds cache size (100k dentries).  To that end I'm
experimenting with running tests with very small cache sizes so that
they'll thrash a bit more:
https://github.com/ceph/ceph-qa-suite/commit/9be755d2903e04d30a7dbddebd430016ba41fc4c
http://pulpito.ceph.com/jspray-2016-08-05_05:00:04-fs-master-distro-basic-mira

John
