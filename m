From: Alfredo Deza <adeza@redhat.com>
Subject: Re: better doc (and build) validation
Date: Wed, 6 Dec 2017 07:02:24 -0500
Message-ID: <CAC-Np1wBsweGNUjLJhfk1CKGC45+dyoBLUZU3qGNcoyN2zJELg@mail.gmail.com>
References: <CAC-Np1xfCMOD6fCeSvDZ9Wo1dGvtL816oicvBs94YarMNNcZAA@mail.gmail.com>
 <CAJ4mKGaRMb3BZ4hF5smid5u9-UwsBgirdqG9uu3HMvvieW_6zw@mail.gmail.com>
 <CAC-Np1x9R9F5Y=X-HafVmQfzgCe67A6YmJ6GdCrdGHY62KZ4_w@mail.gmail.com> <CAJE9aONJJADPmGDee4LBr1vUeFgf0cfJRZV3SdSBaTivhKkHOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:45064 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbdLFMCZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Dec 2017 07:02:25 -0500
Received: by mail-qt0-f178.google.com with SMTP id g10so8241560qtj.12
        for <ceph-devel@vger.kernel.org>; Wed, 06 Dec 2017 04:02:25 -0800 (PST)
In-Reply-To: <CAJE9aONJJADPmGDee4LBr1vUeFgf0cfJRZV3SdSBaTivhKkHOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Dec 6, 2017 at 2:44 AM, kefu chai <tchaikov@gmail.com> wrote:
> On Wed, Dec 6, 2017 at 4:27 AM, Alfredo Deza <adeza@redhat.com> wrote:
>> On Tue, Dec 5, 2017 at 12:44 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>> On Tue, Dec 5, 2017 at 5:31 AM, Alfredo Deza <adeza@redhat.com> wrote:
>>>> It seems like we keep hitting catastrophic build errors with minor doc
>>>> changes. The last one was introduced by a change I made to the
>>>> ceph-disk man page that updated the title:
>>>>
>>>> https://github.com/ceph/ceph/pull/19241/commits/bd00560c20caeeb1ded211cb81533280338014d1
>>>>
>>>> That change builds correctly (!) and will render just fine, and it was
>>>> merged after the docs build reported as successful.
>>>>
>>>> However, this also made all subsequent binary builds break. This
>>>> disconnect has caused similar issues in the past. At some point the
>>>> docs build was completely broken for days, because there was no
>>>> visibility from pull requests.
>>>>
>>>> To mitigate that, we now have the docs job building for every pull
>>>> request, regardless if it is only editing rst files (because, yes, one
>>>> can break the docs build with C++).
>>>>
>>>> This has helped a lot, but it still falls short because the binary
>>>> build process for Ceph is different from how we build docs (including
>
> please note, the cmake building system builds all the artifacts we ship to
> our enduser. in addition to the binaries, it also builds and intalls scripts,
> documents, sample configurations, copyright, and more. it's more than
> merely a "binary build process". i'd call it a "build process". =)
>
>>>> man pages). This is why a successful docs build in a PR can still
>>>> break a binary build.
>>>
>>> Do we understand why it failed on the binary build but not the docs build?
>>>
>>> Seems like that would help us see if we can replicate any other issues.
>>
>> It failed there because the man pages are generated differently, using
>> a couple of ad-hoc helpers that try to ensure certain conditions. In
>> this case, it was a Python
>> utility (ceph/man/conf.py). It was trying to make sure that the title
>> of the man page matched the name of the man page.
>> I had added "[DEPRECATED]" to the ceph-disk title, which failed the assertion.
>>
>> But because the utilities use plain asserts, you don't get any of that
>> rich error reporting, just that some value != some other value.
>>
>> Regardless, the reason is because the code paths are not the same, so
>> we need to find a way to either make them the same, or try to report
>> whatever code paths
>> we need to touch for a PR.
>>
>>>
>>>> There are a couple of things that could help:
>>>>
>>>> 1) I don't entirely follow how CMake is building the man/doc pages,
>>>> but a job that tries to replicate that path could catch these
>>>> inconsistencies in PRs.
>
> could you define "a job"? we have a target for building the man pages.
> "make manpages" will build all of them.

See, I didn't know :)

However! That would only build the man pages. I've broken builds
before when a man page that was expected
by ceph.spec wasn't there. `make manpages` would get us closer though,
this is great. By 'job' I meant A jenkins job that could check this.

>
>>>>
>>>> 2) Build binaries on every PR, and report them as status.
>
> yeah, i guess that's what "needs-qa" is for.

That lacks visibility on reporting back to the PR, and it is a very
manual process that someone has to go through. My concern is to solve
this
in a programmatic way that has a way to notify the author and reviewers of a PR.

I realize that building binaries for every PR is just not practical
for us at the pace they get produced.
>
>>>>
>>>> I don't know enough of CMake to attempt #1, and #2 would cause
>>>> contributors a lot of pain because it would involve having to push to
>>>> ceph-ci.git always.
>>>>
>>>> I am open to any other ideas or suggestions here.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Regards
> Kefu Chai
