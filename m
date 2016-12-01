From: Alfredo Deza <adeza@redhat.com>
Subject: Re: ceph v10.2.4 QE validation status
Date: Thu, 1 Dec 2016 08:26:39 -0500
Message-ID: <CAC-Np1y-vffembS6a-=Xctb=eeL=K6y_EPkHns2GY4u=tZVGuQ@mail.gmail.com>
References: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
 <CAMMFjmGRO7F30WwU8NwMU=t3bEXEhz1G6bwZwqyQJrp7mceZdQ@mail.gmail.com> <87r362tr92.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34062 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754525AbcLAN0l (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Dec 2016 08:26:41 -0500
Received: by mail-qt0-f182.google.com with SMTP id n6so220172674qtd.1
        for <ceph-devel@vger.kernel.org>; Thu, 01 Dec 2016 05:26:40 -0800 (PST)
In-Reply-To: <87r362tr92.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek@suse.com>
Cc: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Dillaman, Jason" <dillaman@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Yuri Weinstein <yweinste@redhat.com>

On Wed, Nov 23, 2016 at 5:39 AM, Abhishek L <abhishek@suse.com> wrote:
>
> Hi Sage, Greg,
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

I thought this PR had made it https://github.com/ceph/ceph/pull/11749
but apparently it didn't for Jewel

The backport PR for Jewel is https://github.com/ceph/ceph/pull/11884

It fixes quite a bit of issues we've had for deployment. It is only
relevant when bootstrapping, when keys are needed for the first time.

Hopefully we can include it as well.
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
