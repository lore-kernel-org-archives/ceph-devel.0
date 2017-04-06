From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Jewel 10.2.7 QE status
Date: Thu, 6 Apr 2017 10:23:13 -0600
Message-ID: <CALqRxCwAkWmGCv4NwPG-Aamp9EM97H5k1ae7n9J5iFy5q7=NYw@mail.gmail.com>
References: <CAMMFjmH_DTdeQDB-C4+A7KsUyAF0jxsZRyGn-2drEOxFds7jsw@mail.gmail.com>
 <CAMMFjmG8jPmC1Ak4mDNN87ZK1qksvN9ms3Gaw8_Wa5v4aTShDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35727 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754719AbdDFQXP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Apr 2017 12:23:15 -0400
Received: by mail-vk0-f51.google.com with SMTP id r69so46823858vke.2
        for <ceph-devel@vger.kernel.org>; Thu, 06 Apr 2017 09:23:15 -0700 (PDT)
In-Reply-To: <CAMMFjmG8jPmC1Ak4mDNN87ZK1qksvN9ms3Gaw8_Wa5v4aTShDw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>

Hi Josh and Sage, are you ok with releasing v10.2.7 from jewel
(a64d3e4b33e904aa6585464df8ffff6aafdec10c)?

test results passed at http://tracker.ceph.com/issues/19055#note-13
(with known failures, as far as I can tell)

- Ken

On Wed, Apr 5, 2017 at 3:55 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
> There had been lengthy discussion in #ceph-devel regarding failed
> upgrade tests, https://github.com/ceph/teuthology/pull/1055,
> http://tracker.ceph.com/issues/19429
>
> We need to decide what to do about this in context of this release.
>
> On Wed, Apr 5, 2017 at 1:16 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> Detailed summary of the QE Validation can be found here
>> http://tracker.ceph.com/issues/19055#note-13
>> The following suites were in scope of this point release validation:
>>
>> rados (subset 35/50 227 jobceph-ansibles)
>> rbd
>> rgw
>> fs
>> krbd
>> kcephfs
>> knfs
>> rest
>> hadoop - EXCLUDED
>> samba - EXCLUDED
>> ceph-deploy
>> ceph-disk
>> upgrade/client-upgrade
>> upgrade/hammer-x (jewel)
>> upgrade/jewel-x/point-to-point-x
>> powercycle
>> ceph-ansible
>>
>> (please let me know if any suites are missing from this ^ list)
>>
>> =====================
>> Outstanding issues
>>
>> rados - two jobs failed, need Josh's approval
>> krbd - seems similar to previous release, need Ilya's approval
>>
>> upgrade/client-upgrade
>> and
>> upgrade/hammer-x (jewel) - suspect
>> http://tracker.ceph.com/issues/19429, need Sage/Josh approve
>>
>> Thx
>> YuriW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
