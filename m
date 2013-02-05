From: Gregory Farnum <greg@inktank.com>
Subject: Re: Throttle::wait use case clarification
Date: Tue, 5 Feb 2013 11:14:41 -0800
Message-ID: <CAPYLRzgv65VuO3z+33f5xmr+F4tvUMUW0-kmEx=QOe-hPzF8Vg@mail.gmail.com>
References: <50FBF3A4.4010200@dachary.org>
	<6AF9B5AC8C404CFBB78E54BA8C7FA1D2@inktank.com>
	<50FD4635.9040301@dachary.org>
	<CAPYLRzjy+5=Ui+C5b5d4QFttOSYz-n6nm+ObPibeTqMF7EmFdg@mail.gmail.com>
	<51115920.2000306@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:43374 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab3BETOn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 14:14:43 -0500
Received: by mail-qa0-f53.google.com with SMTP id z4so298148qan.12
        for <ceph-devel@vger.kernel.org>; Tue, 05 Feb 2013 11:14:42 -0800 (PST)
In-Reply-To: <51115920.2000306@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Merged, thanks a bunch for the contributions. :)
-Greg

On Tue, Feb 5, 2013 at 11:10 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> Here is a new pull request containing the patch and the associated un=
it tests, all together. Thanks a lot for reviewing them :-)
>
> https://github.com/ceph/ceph/pull/39
>
> Cheers
>
> On 02/05/2013 01:22 AM, Gregory Farnum wrote:
>> Loic,
>> Sorry for the delay in getting back to you about these patches. :( I
>> finally got some time to look over them, and in general it's all goo=
d!
>> I do have some comments, though.
>>
>> On Mon, Jan 21, 2013 at 5:44 AM, Loic Dachary <loic@dachary.org> wro=
te:
>>>> Looking through the history of that test (in _reset_max), I think =
it's an accident and we actually want to be waking up the front if the =
maximum increases (or possibly in all cases, in case the front is a ver=
y large request we're going to let through anyway). Want to submit a pa=
tch? :)
>>> :-) Here it is. "make check" does not complain. I've not run teutho=
logy + qa-suite though. I figured out how to run teuthology but did not=
 yet try qa-suite.
>>>
>>> http://marc.info/?l=3Dceph-devel&m=3D135877502606311&w=3D4
>>
>> This patch to reverse the conditional is obviously fine.
>>
>>>> The other possibility I was trying to investigate is that it had s=
omething to do with handling get() requests larger than the max correct=
ly, but I can't find any evidence of that one...
>>> I've run the Throttle unit tests after uncommenting
>>> https://github.com/ceph/ceph/pull/34/files#L3R269
>>> and commenting out
>>> https://github.com/ceph/ceph/pull/34/files#L3R266
>>> and it passes.
>>
>> Regarding these unit tests, I have a few questions which I left on
>> Github. Can you address them and then give a single pull request whi=
ch
>> includes both the Throttle fix and the tests? :)
>> Thanks!
>> -Greg
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
