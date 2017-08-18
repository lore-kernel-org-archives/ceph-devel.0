From: kefu chai <tchaikov@gmail.com>
Subject: Re: Requesting to change "doesn't" to "does not", isn't to "is not".
Date: Fri, 18 Aug 2017 22:34:21 +0800
Message-ID: <CAJE9aOPYEb1rPypmU4sUS+oQPaj1T+WwFnhCc-hMZmXsQcUbDw@mail.gmail.com>
References: <5996d47e.4ef9620a.e0733.1ba8@mx.google.com> <87378p3wi2.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:38292 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdHROeW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Aug 2017 10:34:22 -0400
Received: by mail-vk0-f43.google.com with SMTP id g189so32758508vke.5
        for <ceph-devel@vger.kernel.org>; Fri, 18 Aug 2017 07:34:22 -0700 (PDT)
In-Reply-To: <87378p3wi2.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: Amit <amitkuma@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 18, 2017 at 8:12 PM, Abhishek Lekshmanan <abhishek@suse.com> wr=
ote:
> Amit <amitkuma@redhat.com> writes:
>
>> Hello,
>>
>> I believe coding guidelines does not speak about this.
>>
>> But PR (https://github.com/ceph/ceph/pull/16705) talks on it. And its
> ITYM it's here ;-)
>
>> still open.
>> If we donot agree on contractions, Let's close it.
>>
>> Though "I am" instead of "I'm" -- both are completely correct English.
>> But I read on PR, It suits more on ESL speakers and takes care of
>> non-english speakers.
>>
>> I believe while reviewing the PRs, we can ask developers for changing
>> "isn't" to "is not". [If we accept above PR?]
>> Would be a step in including "Strong Phrases, Active voices" into
>> documentation/Comments/std output..

no, i don't think we should enforce this. as this can be processed by
script. and it *is*. instead of struggling with the use of
contractions, IMHO, doc writers and reviewers need to focus on the
content.

>
> Well there are enough comments on the PR itself supporting/opposing it,
> however in the PR itself, John Wilkins mentions that if approved, it
> would be mostly automated scripts that'd doing the cleanups and not an
> imposition on the community itself to do anything special, and this
> would be better rather than requesting changes from PR submitters
> themselves. My stance on contractions themselves resonate Nathan's
> comments on the PR, but I'd not oppose whatever documentation team
> decides as it.
>
> However on code comments themselves I believe we shouldn't impose
> anything, while typo fixes and obvious mistakes should be fixed, I think
> it would be too much of an imposition if we expect every PR to confirm
> to a contract of non contractions

agreed. i think it does not make sense to be picky on the code
comments unless there are typos and syntax errors which fail to convey
the idea of the author and code.

>
> Best,
> Abhishek
>
> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton=
,
> HRB 21284 (AG N=C3=BCrnberg)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards
Kefu Chai
