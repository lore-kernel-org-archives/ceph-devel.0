From: Abhishek L <abhishek@suse.com>
Subject: Re: ceph v10.2.4 QE validation status
Date: Wed, 23 Nov 2016 11:39:05 +0100
Message-ID: <87r362tr92.fsf@suse.com>
References: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com> <CAMMFjmGRO7F30WwU8NwMU=t3bEXEhz1G6bwZwqyQJrp7mceZdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:44698 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934961AbcKWLA1 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 23 Nov 2016 06:00:27 -0500
In-reply-to: <CAMMFjmGRO7F30WwU8NwMU=t3bEXEhz1G6bwZwqyQJrp7mceZdQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Dillaman, Jason" <dillaman@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Yuri Weinstein <yweinste@redhat.com>


Hi Sage, Greg,


Yuri Weinstein writes:

> See updated status - http://tracker.ceph.com/issues/17487#note-32
>
> Outstanding issues:
>
> knfs - http://tracker.ceph.com/issues/16397 (same as in v10.2.3, Greg
> pls review/approve, assumed Approved ?)
>
> upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17847 ((Sage
> pls review/approve, seems persistent, but maybe not a showstopper)
>
> upgrade/infernalis-x (jewel) - deprecated (Nathan is still working
> to make it pass, see issues in the tacker summary above)
>
> Sage, jewel 10.2.4 can be released as soon as you agree with the
> findings/summary.

Do you think we're ready to release 10.2.4 yet?


Best,
Abhishek
>
> Thx
> YuriW
>
> On Fri, Nov 11, 2016 at 8:47 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> Detailed summary of the QE Validation can be found here
>> http://tracker.ceph.com/issues/17487#note-32
>>
>> The following suites were in scope of this point release validation:
>>
>> rados (subset 35/50 297 jobs)
>> rbd
>> rgw
>> fs
>> krbd
>> kcephfs
>> knfs
>> rest
>> hadoop
>> samba
>> ceph-deploy
>> ceph-disk
>> upgrade/client-upgrade
>> upgrade/hammer-x (jewel)
>> upgrade/infernalis-x (jewel) - deprecated
>> powercycle
>> (please let me know if any suites are missing from this ^ list)
>>
>> ==============================
>> Issues requiring approval/decision:
>>
>> fs - http://tracker.ceph.com/issues/17832 (Greg pls review/approve)
>>
>> krbd - http://tracker.ceph.com/issues/17221 (Jason, Ilya pls review/approve)
>>
>> knfs - http://tracker.ceph.com/issues/16397 (same as in v10.2.3, Greg
>> pls review/approve)
>>
>> upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17847 ((Sage
>> pls review/approve)
>>
>> upgrade/infernalis-x (jewel) - deprecated, but Nathan is still working
>> to make it pass (Sage pls review/approve)
>>
>> powercycle - in progress
>>
>> Thx
>> YuriW


--
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
