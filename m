From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Are we ready for jewel 10.2.6?
Date: Thu, 16 Feb 2017 11:55:10 +0100
Message-ID: <CABZ+qqm5z=dxpvFZchuFGWVfWgnq3CVCCY9srckFg8P7BKhumA@mail.gmail.com>
References: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz> <CAC7t81bh9xOh77e73zXpHWhvWhPiMagTiER6LqpqqGfHiMqZrg@mail.gmail.com>
 <c8317af2-a8a2-2f22-7083-46f24057f10a@dachary.org> <CAF-wwdEb_afYCQgjH5XpBbvk3J+dzg+CJ-agK6KsFajzu2gA1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37547 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbdBPKzy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 05:55:54 -0500
Received: by mail-wm0-f46.google.com with SMTP id v77so12075338wmv.0
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 02:55:54 -0800 (PST)
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com. [74.125.82.53])
        by smtp.gmail.com with ESMTPSA id k70sm3045354wmc.3.2017.02.16.02.55.51
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 02:55:52 -0800 (PST)
Received: by mail-wm0-f53.google.com with SMTP id r141so12056091wmg.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 02:55:51 -0800 (PST)
In-Reply-To: <CAF-wwdEb_afYCQgjH5XpBbvk3J+dzg+CJ-agK6KsFajzu2gA1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Alexey Sheplyakov <asheplyakov@mirantis.com>, Nathan Cutler <ncutler@suse.cz>, Abhishek Lekshmanan <abhishek@suse.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi guys,

How close is 10.2.6? It would be really nice if this one-liner could
be included: http://tracker.ceph.com/issues/18708

Cheers, Dan


On Thu, Feb 9, 2017 at 6:10 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
> https://github.com/ceph/ceph/pull/11410 maybe?
>
> On Fri, Feb 3, 2017 at 5:02 PM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Alexey,
>>
>> On 02/03/2017 07:11 AM, Alexey Sheplyakov wrote:
>>> Hi,
>>>
>>>> I'm still merging RGW backports and there a few more miscellaneous bac=
kports still in the queue.
>>>
>>> Any chance to have https://github.com/ceph/ceph/pull/13004 included in =
10.2.6?
>>
>> Thanks for rebasing it :-) It now needs to go through a round of testing=
, which may or may not happen. Note however that you can run the relevant r=
gw teuthology jobs to test this pull request and if they succeed it will be=
 merged.
>>
>> Cheers
>>
>>>
>>> Best regards,
>>>       Alexey
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Cheers,
> Brad
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
