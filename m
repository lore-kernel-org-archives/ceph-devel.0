From: John Spray <jspray@redhat.com>
Subject: Re: [ceph-users] updating the documentation
Date: Tue, 18 Jul 2017 22:14:43 +0100
Message-ID: <CALe9h7eLk6cOXx7yeDt=cBpOcVGgJE_1aMgq8b9_r3BsaADwJA@mail.gmail.com>
References: <alpine.DEB.2.11.1707121823111.3424@piezo.novalocal>
 <CA+2bHPaRDo=HLpui_4jcMXcFCzgR6UsmetpX7B6t2L-160oV=A@mail.gmail.com>
 <alpine.DEB.2.11.1707121926150.32272@piezo.novalocal> <CALe9h7fN+K0twCGgCLboiRzehdZBfCdST2yRXm2Zp1=r-rBqcg@mail.gmail.com>
 <CAJ4mKGYGJybO1=r+bbVagt5SjBdBtj6tm-+A855vJT_QecRV6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:35841 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdGRVPE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jul 2017 17:15:04 -0400
Received: by mail-wr0-f180.google.com with SMTP id y43so46823782wrd.3
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jul 2017 14:15:04 -0700 (PDT)
In-Reply-To: <CAJ4mKGYGJybO1=r+bbVagt5SjBdBtj6tm-+A855vJT_QecRV6w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On Tue, Jul 18, 2017 at 9:03 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Tue, Jul 18, 2017 at 6:51 AM, John Spray <jspray@redhat.com> wrote:
>> On Wed, Jul 12, 2017 at 8:28 PM, Sage Weil <sweil@redhat.com> wrote:
>>> On Wed, 12 Jul 2017, Patrick Donnelly wrote:
>>>> On Wed, Jul 12, 2017 at 11:29 AM, Sage Weil <sweil@redhat.com> wrote:
>>>> > In the meantime, we can also avoid making the problem worse by requiring
>>>> > that all pull requests include any relevant documentation updates.  This
>>>> > means (1) helping educate contributors that doc updates are needed, (2)
>>>> > helping maintainers and reviewers remember that doc updates are part of
>>>> > the merge criteria (it will likely take a bit of time before this is
>>>> > second nature), and (3) generally inducing developers to become aware of
>>>> > the documentation that exists so that they know what needs to be updated
>>>> > when they make a change.
>>>>
>>>> There was a joke to add a bot which automatically fails PRs for no
>>>> documentation but I think there is an way to make that work in a
>>>> reasonable way. Perhaps the bot could simply comment on all PRs
>>>> touching src/ that documentation is required and where to look, and
>>>> then fails a doc check. A developer must comment on the PR to say it
>>>> passes documentation requirements before the bot changes the check to
>>>> pass.
>>>>
>>>> This addresses all three points in an automatic way.
>>>
>>> This is a great idea.  Greg brought up the idea of a bot but we
>>> didn't think of a "docs ok"-type comment to make it happy.
>>>
>>> Anybody interested in coding it up?
>>>
>>> Piotr makes a good point about config_opts.h, although that problem is
>>> about to go away (or at least change) with John's config update:
>>>
>>>         https://github.com/ceph/ceph/pull/16211
>>>
>>> (Config options will be documented in the code where the schema is
>>> defined, and docs.ceph.com .rst will eventually be auto-generated from
>>> that.)
>>
>>
>> Separate to the discussion of bots, here's a proposed change to the
>> SubmittingPatches.rst to formalize the expectation that submitters
>> make doc changes in their PRs.
>
> https://github.com/ceph/ceph/pull/16394 was meant to go here, I think. :)

Correct!  I like to throw the mistakes out there every once in a while
to check someone is paying attention :-)

John

> -Greg
>
>>
>> The twist here is that in addition to requiring submitters to make
>> changes, there is a responsibility on the component tech leads to
>> ensure there is a proper place for doc changes to go.  That means that
>> if someone comes with a change to a completely undocumented area of
>> functionality, then it is not the submitter's responsibility to create
>> the whole page just to note their small change (although it would
>> obviously be awesome if they did).
>>
>> Cheers,
>> John
>>
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
