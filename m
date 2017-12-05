From: Alfredo Deza <adeza@redhat.com>
Subject: Re: better doc (and build) validation
Date: Tue, 5 Dec 2017 15:27:40 -0500
Message-ID: <CAC-Np1x9R9F5Y=X-HafVmQfzgCe67A6YmJ6GdCrdGHY62KZ4_w@mail.gmail.com>
References: <CAC-Np1xfCMOD6fCeSvDZ9Wo1dGvtL816oicvBs94YarMNNcZAA@mail.gmail.com>
 <CAJ4mKGaRMb3BZ4hF5smid5u9-UwsBgirdqG9uu3HMvvieW_6zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:39088 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbdLEU1m (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Dec 2017 15:27:42 -0500
Received: by mail-qt0-f174.google.com with SMTP id k19so3899439qtj.6
        for <ceph-devel@vger.kernel.org>; Tue, 05 Dec 2017 12:27:41 -0800 (PST)
In-Reply-To: <CAJ4mKGaRMb3BZ4hF5smid5u9-UwsBgirdqG9uu3HMvvieW_6zw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Dec 5, 2017 at 12:44 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Tue, Dec 5, 2017 at 5:31 AM, Alfredo Deza <adeza@redhat.com> wrote:
>> It seems like we keep hitting catastrophic build errors with minor doc
>> changes. The last one was introduced by a change I made to the
>> ceph-disk man page that updated the title:
>>
>> https://github.com/ceph/ceph/pull/19241/commits/bd00560c20caeeb1ded211cb81533280338014d1
>>
>> That change builds correctly (!) and will render just fine, and it was
>> merged after the docs build reported as successful.
>>
>> However, this also made all subsequent binary builds break. This
>> disconnect has caused similar issues in the past. At some point the
>> docs build was completely broken for days, because there was no
>> visibility from pull requests.
>>
>> To mitigate that, we now have the docs job building for every pull
>> request, regardless if it is only editing rst files (because, yes, one
>> can break the docs build with C++).
>>
>> This has helped a lot, but it still falls short because the binary
>> build process for Ceph is different from how we build docs (including
>> man pages). This is why a successful docs build in a PR can still
>> break a binary build.
>
> Do we understand why it failed on the binary build but not the docs build?
>
> Seems like that would help us see if we can replicate any other issues.

It failed there because the man pages are generated differently, using
a couple of ad-hoc helpers that try to ensure certain conditions. In
this case, it was a Python
utility (ceph/man/conf.py). It was trying to make sure that the title
of the man page matched the name of the man page.
I had added "[DEPRECATED]" to the ceph-disk title, which failed the assertion.

But because the utilities use plain asserts, you don't get any of that
rich error reporting, just that some value != some other value.

Regardless, the reason is because the code paths are not the same, so
we need to find a way to either make them the same, or try to report
whatever code paths
we need to touch for a PR.

>
>> There are a couple of things that could help:
>>
>> 1) I don't entirely follow how CMake is building the man/doc pages,
>> but a job that tries to replicate that path could catch these
>> inconsistencies in PRs.
>>
>> 2) Build binaries on every PR, and report them as status.
>>
>> I don't know enough of CMake to attempt #1, and #2 would cause
>> contributors a lot of pain because it would involve having to push to
>> ceph-ci.git always.
>>
>> I am open to any other ideas or suggestions here.
