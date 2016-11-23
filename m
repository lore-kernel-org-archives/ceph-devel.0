From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: ceph v10.2.4 QE validation status
Date: Wed, 23 Nov 2016 09:39:43 -0500
Message-ID: <CAJ4mKGbW=9VhuV45tttbXLeBD3-2RmwUo1mV9no1rgC7t0D2Gw@mail.gmail.com>
References: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
 <CAMMFjmGRO7F30WwU8NwMU=t3bEXEhz1G6bwZwqyQJrp7mceZdQ@mail.gmail.com> <87r362tr92.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34972 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936122AbcKWOjp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2016 09:39:45 -0500
Received: by mail-oi0-f46.google.com with SMTP id b126so16363612oia.2
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2016 06:39:45 -0800 (PST)
In-Reply-To: <87r362tr92.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek@suse.com>, Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Dachary, Loic" <ldachary@redhat.com>, John Spray <jspray@redhat.com>

On Wed, Nov 23, 2016 at 5:39 AM, Abhishek L <abhishek@suse.com> wrote:
>
> Hi Sage, Greg,

John signed off on the FS stuff and he's the one who does that now.
Looks good to me. ;)
-Greg

>
>
> Yuri Weinstein writes:
>
>> See updated status - http://tracker.ceph.com/issues/17487#note-32
>>
>> Outstanding issues:
>>
>> knfs - http://tracker.ceph.com/issues/16397 (same as in v10.2.3, Greg
>> pls review/approve, assumed Approved ?)
>>
>> upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17847 ((Sage
>> pls review/approve, seems persistent, but maybe not a showstopper)
>>
>> upgrade/infernalis-x (jewel) - deprecated (Nathan is still working
>> to make it pass, see issues in the tacker summary above)
>>
>> Sage, jewel 10.2.4 can be released as soon as you agree with the
>> findings/summary.
>
> Do you think we're ready to release 10.2.4 yet?
>
>
> Best,
> Abhishek
>>
>> Thx
>> YuriW
>>
>> On Fri, Nov 11, 2016 at 8:47 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
>>> Detailed summary of the QE Validation can be found here
>>> http://tracker.ceph.com/issues/17487#note-32
>>>
>>> The following suites were in scope of this point release validation:
>>>
>>> rados (subset 35/50 297 jobs)
>>> rbd
>>> rgw
>>> fs
>>> krbd
>>> kcephfs
>>> knfs
>>> rest
>>> hadoop
>>> samba
>>> ceph-deploy
>>> ceph-disk
>>> upgrade/client-upgrade
>>> upgrade/hammer-x (jewel)
>>> upgrade/infernalis-x (jewel) - deprecated
>>> powercycle
>>> (please let me know if any suites are missing from this ^ list)
>>>
>>> ==============================
>>> Issues requiring approval/decision:
>>>
>>> fs - http://tracker.ceph.com/issues/17832 (Greg pls review/approve)
>>>
>>> krbd - http://tracker.ceph.com/issues/17221 (Jason, Ilya pls review/approve)
>>>
>>> knfs - http://tracker.ceph.com/issues/16397 (same as in v10.2.3, Greg
>>> pls review/approve)
>>>
>>> upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17847 ((Sage
>>> pls review/approve)
>>>
>>> upgrade/infernalis-x (jewel) - deprecated, but Nathan is still working
>>> to make it pass (Sage pls review/approve)
>>>
>>> powercycle - in progress
>>>
>>> Thx
>>> YuriW
>
>
> --
> Abhishek Lekshmanan
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
