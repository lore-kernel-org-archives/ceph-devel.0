From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Jewel 10.2.7 QE status
Date: Thu, 6 Apr 2017 10:32:35 -0700
Message-ID: <ee7a7293-9b09-b2bb-a2fd-6435fa4f5379@redhat.com>
References: <CAMMFjmH_DTdeQDB-C4+A7KsUyAF0jxsZRyGn-2drEOxFds7jsw@mail.gmail.com>
 <CAMMFjmG8jPmC1Ak4mDNN87ZK1qksvN9ms3Gaw8_Wa5v4aTShDw@mail.gmail.com>
 <CALqRxCwAkWmGCv4NwPG-Aamp9EM97H5k1ae7n9J5iFy5q7=NYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933431AbdDFRch (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Apr 2017 13:32:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C39D61B9C
        for <ceph-devel@vger.kernel.org>; Thu,  6 Apr 2017 17:32:36 +0000 (UTC)
In-Reply-To: <CALqRxCwAkWmGCv4NwPG-Aamp9EM97H5k1ae7n9J5iFy5q7=NYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, Yuri Weinstein <yweinste@redhat.com>
Cc: "Development, Ceph" <ceph-devel@vger.kernel.org>

On 04/06/2017 09:23 AM, Ken Dreyer wrote:
> Hi Josh and Sage, are you ok with releasing v10.2.7 from jewel
> (a64d3e4b33e904aa6585464df8ffff6aafdec10c)?

Yes, the two failures are a race condition and a bug in the tests.

> test results passed at http://tracker.ceph.com/issues/19055#note-13
> (with known failures, as far as I can tell)
>
> - Ken
>
> On Wed, Apr 5, 2017 at 3:55 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
>> There had been lengthy discussion in #ceph-devel regarding failed
>> upgrade tests, https://github.com/ceph/teuthology/pull/1055,
>> http://tracker.ceph.com/issues/19429
>>
>> We need to decide what to do about this in context of this release.
>>
>> On Wed, Apr 5, 2017 at 1:16 PM, Yuri Weinstein <yweinste@redhat.com> wrote:
>>> Detailed summary of the QE Validation can be found here
>>> http://tracker.ceph.com/issues/19055#note-13
>>> The following suites were in scope of this point release validation:
>>>
>>> rados (subset 35/50 227 jobceph-ansibles)
>>> rbd
>>> rgw
>>> fs
>>> krbd
>>> kcephfs
>>> knfs
>>> rest
>>> hadoop - EXCLUDED
>>> samba - EXCLUDED
>>> ceph-deploy
>>> ceph-disk
>>> upgrade/client-upgrade
>>> upgrade/hammer-x (jewel)
>>> upgrade/jewel-x/point-to-point-x
>>> powercycle
>>> ceph-ansible
>>>
>>> (please let me know if any suites are missing from this ^ list)
>>>
>>> =====================
>>> Outstanding issues
>>>
>>> rados - two jobs failed, need Josh's approval
>>> krbd - seems similar to previous release, need Ilya's approval
>>>
>>> upgrade/client-upgrade
>>> and
>>> upgrade/hammer-x (jewel) - suspect
>>> http://tracker.ceph.com/issues/19429, need Sage/Josh approve
>>>
>>> Thx
>>> YuriW
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

