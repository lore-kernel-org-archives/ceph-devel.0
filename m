From: John Spray <jspray@redhat.com>
Subject: Re: ceph v10.2.4 QE validation status
Date: Wed, 23 Nov 2016 15:06:36 +0000
Message-ID: <CALe9h7cp8t_AJrytiN_9yoqZFny2UvfR6pT0PukTHMPNafYnhw@mail.gmail.com>
References: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com>
 <CAMMFjmGRO7F30WwU8NwMU=t3bEXEhz1G6bwZwqyQJrp7mceZdQ@mail.gmail.com>
 <87r362tr92.fsf@suse.com> <alpine.DEB.2.11.1611231441130.21102@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36231 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935294AbcKWPHc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2016 10:07:32 -0500
Received: by mail-qt0-f175.google.com with SMTP id w33so13909617qtc.3
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2016 07:06:58 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611231441130.21102@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Abhishek L <abhishek@suse.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Dillaman, Jason" <dillaman@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, "Durgin, Josh" <jdurgin@redhat.com>, Yuri Weinstein <yweinste@redhat.com>

On Wed, Nov 23, 2016 at 2:42 PM, Sage Weil <sweil@redhat.com> wrote:
> On Wed, 23 Nov 2016, Abhishek L wrote:
>>
>> Hi Sage, Greg,
>>
>>
>> Yuri Weinstein writes:
>>
>> > See updated status - http://tracker.ceph.com/issues/17487#note-32
>> >
>> > Outstanding issues:
>> >
>> > knfs - http://tracker.ceph.com/issues/16397 (same as in v10.2.3, Greg
>> > pls review/approve, assumed Approved ?)
>> >
>> > upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17847 ((Sage
>> > pls review/approve, seems persistent, but maybe not a showstopper)
>> >
>> > upgrade/infernalis-x (jewel) - deprecated (Nathan is still working
>> > to make it pass, see issues in the tacker summary above)
>> >
>> > Sage, jewel 10.2.4 can be released as soon as you agree with the
>> > findings/summary.
>>
>> Do you think we're ready to release 10.2.4 yet?
>
> I'm reproducing http://tracker.ceph.com/issues/17847 with logs to make
> sure this isn't a regression.
>
> We can ignore the infernalis runs.
>
> I think we can ignore the knfs selinux issue too.. Greg, can you confirm?

The knfs selinux issue can be ignored, yes.  Last investigation
indicated that it probably wasn't cephfs-specific.

John

> Thanks!
> sage
>
>>
>>
>> Best,
>> Abhishek
>> >
>> > Thx
>> > YuriW
>> >
>> > On Fri, Nov 11, 2016 at 8:47 AM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> >> Detailed summary of the QE Validation can be found here
>> >> http://tracker.ceph.com/issues/17487#note-32
>> >>
>> >> The following suites were in scope of this point release validation:
>> >>
>> >> rados (subset 35/50 297 jobs)
>> >> rbd
>> >> rgw
>> >> fs
>> >> krbd
>> >> kcephfs
>> >> knfs
>> >> rest
>> >> hadoop
>> >> samba
>> >> ceph-deploy
>> >> ceph-disk
>> >> upgrade/client-upgrade
>> >> upgrade/hammer-x (jewel)
>> >> upgrade/infernalis-x (jewel) - deprecated
>> >> powercycle
>> >> (please let me know if any suites are missing from this ^ list)
>> >>
>> >> ==============================
>> >> Issues requiring approval/decision:
>> >>
>> >> fs - http://tracker.ceph.com/issues/17832 (Greg pls review/approve)
>> >>
>> >> krbd - http://tracker.ceph.com/issues/17221 (Jason, Ilya pls review/approve)
>> >>
>> >> knfs - http://tracker.ceph.com/issues/16397 (same as in v10.2.3, Greg
>> >> pls review/approve)
>> >>
>> >> upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17847 ((Sage
>> >> pls review/approve)
>> >>
>> >> upgrade/infernalis-x (jewel) - deprecated, but Nathan is still working
>> >> to make it pass (Sage pls review/approve)
>> >>
>> >> powercycle - in progress
>> >>
>> >> Thx
>> >> YuriW
>>
>>
>> --
>> Abhishek Lekshmanan
>> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
