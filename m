From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Stable release HOWTO: hunt for lost page
Date: Mon, 14 Dec 2015 14:23:29 -0500
Message-ID: <CAC-Np1wchnL2p1uu=PfYg8XGLMt+aKNQwfuy9ChsrfXbyJSC2A@mail.gmail.com>
References: <566ED01C.2020306@dachary.org>
	<CAP3mxSwdrEN72xxCyCsvjkT5DSrk+jw3W2DnQ5sUL1grHZhFBw@mail.gmail.com>
	<566ED927.7040400@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37077 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088AbbLNTXa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Dec 2015 14:23:30 -0500
Received: by wmnn186 with SMTP id n186so135263920wmn.0
        for <ceph-devel@vger.kernel.org>; Mon, 14 Dec 2015 11:23:29 -0800 (PST)
In-Reply-To: <566ED927.7040400@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Abhishek Varshney <abhishek.varshney@flipkart.com>, Nathan Cutler <ncutler@suse.cz>, Abhishek L <abhishek.lekshmanan@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Dec 14, 2015 at 9:58 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Abhishek,
>
> On 14/12/2015 15:40, Abhishek Varshney wrote:
>> Hi Loic,
>>
>> I have revived the page at
>> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_triage_inc=
oming_backport_pull_requests
>> from https://web.archive.org with a version cached on 4th October.
>
> Perfect ! It has not changed much in the past few month, I can't thin=
k of something we added that would be missing.
>
>> Please review it, in case there are any changes to it.
>>
>> Disabling the page deletion sounds like a good idea.
>
> Done.
>
> Cheers
>
>>
>> Thanks
>> Abhishek
>>
>> On Mon, Dec 14, 2015 at 7:50 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>> Hi,
>>>
>>> It looks like we've lost http://tracker.ceph.com/projects/ceph-rele=
ases/wiki/HOWTO_triage_incoming_backport_pull_requests . We can re-writ=
e it, of course, it's not that complex. But looking at the index I can'=
t find it ( http://tracker.ceph.com/projects/ceph-releases/wiki/index )=
 and the activity backlog ( http://tracker.ceph.com/projects/ceph-relea=
ses/activity?utf8=3D%E2%9C%93&show_issues=3D1&show_wiki_edits=3D1 ) doe=
s not show an event when a page is deleted.
>>>
>>> I suppose it's an accident and I propose we disable the page deleti=
on feature to avoid such mistakes in the future (pages can be renamed t=
o things like REMOVE-ME instead ;-).

Maybe this should be in source control? There are plenty of
repositories where this could live in the ceph org. If that doesn't
accommodate this use case we could certainly have a distinct one
created

>>>
>>> What do you think ?
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
