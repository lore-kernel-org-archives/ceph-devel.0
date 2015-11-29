From: John Spray <jspray@redhat.com>
Subject: Re: RFC: teuthology field in commit messages
Date: Sun, 29 Nov 2015 20:47:11 +0000
Message-ID: <CALe9h7c6aB28o_1AiC_jDCw3ijdd7y07dW5zcpyu5XhSA2OuHg@mail.gmail.com>
References: <5659CE92.4000203@dachary.org> <CALe9h7edX3zQVri_KRRNRmjOnvcxhxq0EJXn=5nhF+AQY51g3g@mail.gmail.com>
 <565B5F4C.30308@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34181 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbbK2Urd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Nov 2015 15:47:33 -0500
Received: by lffu14 with SMTP id u14so175135140lff.1
        for <ceph-devel@vger.kernel.org>; Sun, 29 Nov 2015 12:47:31 -0800 (PST)
In-Reply-To: <565B5F4C.30308@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Nov 29, 2015 at 8:25 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 29/11/2015 21:08, John Spray wrote:
>> On Sat, Nov 28, 2015 at 3:56 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>> Hi Ceph,
>>>
>>> An optional teuthology field could be added to a commit message lik=
e so:
>>>
>>> teuthology: --suite rbd
>>>
>>> to state that this commit should be tested with the rbd suite. It c=
ould be parsed by bots and humans.
>>>
>>> It would make it easy and cost effective to run partial teuthology =
suites automatically on pull requests.
>>>
>>> What do you think ?
>>
>> Hmm, we are usually testing things at the branch/PR level rather tha=
n
>> on the per-commit level, so it feels a bit strange to have this in t=
he
>> commit message.
>
> Indeed. But what is a branch if not the HEAD commit ?

It's the HEAD commit, and its ancestors.  So in a typical PR (or
branch) there are several commits since the base (i.e. since master),
and perhaps only one of them has a test suite marked on it, or maybe
they have different test suites marked on different commits in the
branch.

It's not necessarily a problem, just something that would need to have
a defined behaviour (maybe when testing a PR collect the "teuthology:"
tags from all commits in PR, and run all the suites mentioned?).

John


>
>> However, if a system existed that would auto-test things when I put
>> something magic in a commit message, I would probably use it!
>>
>> John
>>
>>
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
