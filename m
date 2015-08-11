From: Jan Schermer <jan@schermer.cz>
Subject: Re: [ceph-users] Is it safe to increase pg number in a production environment
Date: Tue, 11 Aug 2015 18:02:40 +0200
Message-ID: <E241718F-6359-42BC-BC2C-64FCC4E4E192@schermer.cz>
References: <CALAOqpNhquUYW5YqNDZQh4K927Xumw8GcPPoYRsmyEhSHBY-Xw@mail.gmail.com> <CAN=+7FVjixrHHUZ01-5HaLd19SbjLkhqpKdKN1jDqPCk1UoR0A@mail.gmail.com> <55C0ED88.2050102@profihost.ag> <CAM9_UU8Mxycvk91NSrFSMQ5=jDxaXcajzB7CTGDZ2sJJ0YW7-w@mail.gmail.com> <55C116FA.3060909@profihost.ag> <CABZ+qq=ie9w__Vtyq-Xc=2ugrPvgnno2zZsgVQqtYOE2OT9cqg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3075\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36972 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965076AbbHKQCt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Aug 2015 12:02:49 -0400
Received: by wibhh20 with SMTP id hh20so203249102wib.0
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2015 09:02:47 -0700 (PDT)
In-Reply-To: <CABZ+qq=ie9w__Vtyq-Xc=2ugrPvgnno2zZsgVQqtYOE2OT9cqg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, =?utf-8?B?5LmU5bu65bOw?= <scaleqiao@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, cbt@ceph.com, ceph-users <ceph-users@ceph.com>

Could someone clarify what the impact of this bug is?
We did increase pg_num/pgp_num and we are on dumpling (0.67.12 unofficial snapshot).
Most of our clients are likely restarted already, but not all. Should we be worried?

Thanks
Jan

> On 11 Aug 2015, at 17:31, Dan van der Ster <dan@vanderster.com> wrote:
> 
> On Tue, Aug 4, 2015 at 9:48 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>> Hi,
>> 
>> Am 04.08.2015 um 21:16 schrieb Ketor D:
>>> 
>>> Hi Stefan,
>>>       Could you describe more about the linger ops bug?
>>>       I'm runing Firefly as you say still has this bug.
>> 
>> 
>> It will be fixed in next ff release.
>> 
>> This on:
>> http://tracker.ceph.com/issues/9806
>> 
> 
> Just to clarify one point: it appears that the fix needs to be applied
> on both the OSDs _and_ all clients, right? So all our kvm clients
> would need to be restarted to get firefly 0.80.11 prior to any
> attempted splits. :-(
> 
> Cheers, Dan
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

