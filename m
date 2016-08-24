From: Loic Dachary <loic@dachary.org>
Subject: Re: CephFS and the next jewel release v10.2.3
Date: Wed, 24 Aug 2016 23:02:04 +0200
Message-ID: <57BE0B4C.6060104@dachary.org>
References: <57BC1089.9080209@dachary.org>
 <CAJ4mKGZ0DAH8Osa4mS8dupxg49GxBeutnvv3e55wSfsO0vt2SQ@mail.gmail.com>
 <CAJ4mKGbOzdxCoFhzmXmbQbs0G2MuxwSR2Qb83WkGGJNXg8TgFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52858 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbcHXVCJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 17:02:09 -0400
In-Reply-To: <CAJ4mKGbOzdxCoFhzmXmbQbs0G2MuxwSR2Qb83WkGGJNXg8TgFg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 24/08/2016 22:46, Gregory Farnum wrote:
> On Wed, Aug 24, 2016 at 11:11 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
>> On Tue, Aug 23, 2016 at 1:59 AM, Loic Dachary <loic@dachary.org> wrote:
>>> Hi John,
>>>
>>> The next jewel release as found at https://github.com/ceph/ceph/tree/jewel passed the fs suite (http://tracker.ceph.com/issues/16344#note-30 except for three valgrind failures). Do you think the jewel branch is ready for QE to start their own round of testing ?
>>>
>>> Cheers
>>>
>>> P.S. CC'ing Greg because John is on vacation, in case a decision is to be made before he returns.
>>
>> Ugh, I went to check these valgrind failures and they're a failed
>> mutex assert on shutdown. Let me dig into what's happening. :(
>> -Greg
> 
> Hmm, we seem to have some badly-colliding backports. If you look at
> commit ac449472df2978123192d5f22247d8b8bc5efb28 and MDSRank.cc line
> 242, you'll see it does mds_lock.Unlock() twice in quick succession.
> :(
> 
> One of them came in from 7c2eab19, and the other from 1d3a8168. I
> think maybe the patches got reordered in their backport order or
> something.
> 
> Patrick, can you give https://github.com/ceph/ceph/pull/10847 a quick
> review? Loic, can you then run the failed tests against a backport
> branch which includes that patch?

https://github.com/ceph/ceph/pull/10847 has been pushed as part of the jewel-backports integration branch right now and I'll schedule a fs run as soon as it finishes building. Thanks for the quick fix !

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
