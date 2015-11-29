From: John Spray <jspray@redhat.com>
Subject: Re: RFC: teuthology field in commit messages
Date: Sun, 29 Nov 2015 22:55:57 +0000
Message-ID: <CALe9h7eFM982XsrRtnoA9=Vfq3OXbbYdAV_dFEUcPukg97mt8w@mail.gmail.com>
References: <5659CE92.4000203@dachary.org> <CALe9h7edX3zQVri_KRRNRmjOnvcxhxq0EJXn=5nhF+AQY51g3g@mail.gmail.com>
 <565B5F4C.30308@dachary.org> <CALe9h7c6aB28o_1AiC_jDCw3ijdd7y07dW5zcpyu5XhSA2OuHg@mail.gmail.com>
 <565B6D3F.5080109@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33583 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbbK2W4S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Nov 2015 17:56:18 -0500
Received: by lfaz4 with SMTP id z4so176472585lfa.0
        for <ceph-devel@vger.kernel.org>; Sun, 29 Nov 2015 14:56:17 -0800 (PST)
In-Reply-To: <565B6D3F.5080109@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Nov 29, 2015 at 9:25 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 29/11/2015 21:47, John Spray wrote:
>> On Sun, Nov 29, 2015 at 8:25 PM, Loic Dachary <loic@dachary.org> wrote:
>>>
>>>
>>> On 29/11/2015 21:08, John Spray wrote:
>>>> On Sat, Nov 28, 2015 at 3:56 PM, Loic Dachary <loic@dachary.org> wrote:
>>>>> Hi Ceph,
>>>>>
>>>>> An optional teuthology field could be added to a commit message like so:
>>>>>
>>>>> teuthology: --suite rbd
>>>>>
>>>>> to state that this commit should be tested with the rbd suite. It could be parsed by bots and humans.
>>>>>
>>>>> It would make it easy and cost effective to run partial teuthology suites automatically on pull requests.
>>>>>
>>>>> What do you think ?
>>>>
>>>> Hmm, we are usually testing things at the branch/PR level rather than
>>>> on the per-commit level, so it feels a bit strange to have this in the
>>>> commit message.
>>>
>>> Indeed. But what is a branch if not the HEAD commit ?
>>
>> It's the HEAD commit, and its ancestors.  So in a typical PR (or
>> branch) there are several commits since the base (i.e. since master),
>> and perhaps only one of them has a test suite marked on it, or maybe
>> they have different test suites marked on different commits in the
>> branch.
>>
>> It's not necessarily a problem, just something that would need to have
>> a defined behaviour (maybe when testing a PR collect the "teuthology:"
>> tags from all commits in PR, and run all the suites mentioned?).
>
> That's an interesting idea :-) My understanding is that we currently test a PR by scheduling suites on its HEAD. But maybe you sometime schedule suites using a commit that's in the middle of a PR ?

I think I've made this too complicated...

What I meant was that while one would schedule suites against the HEAD
of the PR, that might not be the same commit that has the logical
testing information in.  For example, I might have main commit that
has the "Fixes: " and "teuthology: " tags, and then a second commit
(that would be HEAD) which e.g. tweaks a unit test.  It would be weird
if I had to put the teuthology: tag on the unit test commit rather
than the functional test, so I guess it would make sense to look at
the teuthology: tags from all the commits in a PR when scheduling it.

John
