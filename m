From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Are we ready for jewel 10.2.6?
Date: Thu, 9 Feb 2017 15:10:09 +1000
Message-ID: <CAF-wwdEb_afYCQgjH5XpBbvk3J+dzg+CJ-agK6KsFajzu2gA1w@mail.gmail.com>
References: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz> <CAC7t81bh9xOh77e73zXpHWhvWhPiMagTiER6LqpqqGfHiMqZrg@mail.gmail.com>
 <c8317af2-a8a2-2f22-7083-46f24057f10a@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33509 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdBIFKL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Feb 2017 00:10:11 -0500
Received: by mail-io0-f177.google.com with SMTP id v96so8708637ioi.0
        for <ceph-devel@vger.kernel.org>; Wed, 08 Feb 2017 21:10:11 -0800 (PST)
In-Reply-To: <c8317af2-a8a2-2f22-7083-46f24057f10a@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Alexey Sheplyakov <asheplyakov@mirantis.com>, Nathan Cutler <ncutler@suse.cz>, Abhishek Lekshmanan <abhishek@suse.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

https://github.com/ceph/ceph/pull/11410 maybe?

On Fri, Feb 3, 2017 at 5:02 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Alexey,
>
> On 02/03/2017 07:11 AM, Alexey Sheplyakov wrote:
>> Hi,
>>
>>> I'm still merging RGW backports and there a few more miscellaneous backports still in the queue.
>>
>> Any chance to have https://github.com/ceph/ceph/pull/13004 included in 10.2.6?
>
> Thanks for rebasing it :-) It now needs to go through a round of testing, which may or may not happen. Note however that you can run the relevant rgw teuthology jobs to test this pull request and if they succeed it will be merged.
>
> Cheers
>
>>
>> Best regards,
>>       Alexey
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Loïc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
