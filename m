From: Loic Dachary <loic@dachary.org>
Subject: Re: CephFS and the next jewel release v10.2.3
Date: Thu, 25 Aug 2016 23:13:02 +0200
Message-ID: <57BF5F5E.3070105@dachary.org>
References: <57BC1089.9080209@dachary.org>
 <CAJ4mKGZ0DAH8Osa4mS8dupxg49GxBeutnvv3e55wSfsO0vt2SQ@mail.gmail.com>
 <CAJ4mKGbOzdxCoFhzmXmbQbs0G2MuxwSR2Qb83WkGGJNXg8TgFg@mail.gmail.com>
 <57BE0B4C.6060104@dachary.org>
 <CAJ4mKGbYD6mKjcH_++E1HF1zRBX5sVWJoq-z=h+_UQBMXEr9Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37531 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754199AbcHYVN5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2016 17:13:57 -0400
In-Reply-To: <CAJ4mKGbYD6mKjcH_++E1HF1zRBX5sVWJoq-z=h+_UQBMXEr9Kg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

The run completed at http://pulpito.ceph.com/loic-2016-08-25_06:39:08-fs-jewel-backports-distro-basic-smithi/ with no valgrind error but a few other failures. Note that it is based on the jewel-backports branch which contains a few more backports in addition to https://github.com/ceph/ceph/pull/10847 and I'm not sure what to blame yet. I'll look into it tomorrow unless you beat me to it :-)

Cheers

On 24/08/2016 23:03, Gregory Farnum wrote:
> On Wed, Aug 24, 2016 at 2:02 PM, Loic Dachary <loic@dachary.org> wrote:
>>
>>
>> On 24/08/2016 22:46, Gregory Farnum wrote:
>>> On Wed, Aug 24, 2016 at 11:11 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>>> On Tue, Aug 23, 2016 at 1:59 AM, Loic Dachary <loic@dachary.org> wrote:
>>>>> Hi John,
>>>>>
>>>>> The next jewel release as found at https://github.com/ceph/ceph/tree/jewel passed the fs suite (http://tracker.ceph.com/issues/16344#note-30 except for three valgrind failures). Do you think the jewel branch is ready for QE to start their own round of testing ?
>>>>>
>>>>> Cheers
>>>>>
>>>>> P.S. CC'ing Greg because John is on vacation, in case a decision is to be made before he returns.
>>>>
>>>> Ugh, I went to check these valgrind failures and they're a failed
>>>> mutex assert on shutdown. Let me dig into what's happening. :(
>>>> -Greg
>>>
>>> Hmm, we seem to have some badly-colliding backports. If you look at
>>> commit ac449472df2978123192d5f22247d8b8bc5efb28 and MDSRank.cc line
>>> 242, you'll see it does mds_lock.Unlock() twice in quick succession.
>>> :(
>>>
>>> One of them came in from 7c2eab19, and the other from 1d3a8168. I
>>> think maybe the patches got reordered in their backport order or
>>> something.
>>>
>>> Patrick, can you give https://github.com/ceph/ceph/pull/10847 a quick
>>> review? Loic, can you then run the failed tests against a backport
>>> branch which includes that patch?
>>
>> https://github.com/ceph/ceph/pull/10847 has been pushed as part of the jewel-backports integration branch right now and I'll schedule a fs run as soon as it finishes building. Thanks for the quick fix !
> 
> Sure. Assuming that works out everything else looked good to me. :)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
