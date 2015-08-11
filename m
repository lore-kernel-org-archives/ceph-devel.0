From: Dan van der Ster <dan@vanderster.com>
Subject: Re: [ceph-users] Is it safe to increase pg number in a production environment
Date: Tue, 11 Aug 2015 17:31:57 +0200
Message-ID: <CABZ+qq=ie9w__Vtyq-Xc=2ugrPvgnno2zZsgVQqtYOE2OT9cqg@mail.gmail.com>
References: <CALAOqpNhquUYW5YqNDZQh4K927Xumw8GcPPoYRsmyEhSHBY-Xw@mail.gmail.com>
 <CAN=+7FVjixrHHUZ01-5HaLd19SbjLkhqpKdKN1jDqPCk1UoR0A@mail.gmail.com>
 <55C0ED88.2050102@profihost.ag> <CAM9_UU8Mxycvk91NSrFSMQ5=jDxaXcajzB7CTGDZ2sJJ0YW7-w@mail.gmail.com>
 <55C116FA.3060909@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:32884 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370AbbHKPck (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Aug 2015 11:32:40 -0400
Received: by lalv9 with SMTP id v9so30447337lal.0
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2015 08:32:38 -0700 (PDT)
Received: from mail-lb0-f177.google.com (mail-lb0-f177.google.com. [209.85.217.177])
        by smtp.gmail.com with ESMTPSA id f1sm541515laf.15.2015.08.11.08.32.36
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 08:32:37 -0700 (PDT)
Received: by lbbpu9 with SMTP id pu9so88189814lbb.3
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2015 08:32:36 -0700 (PDT)
In-Reply-To: <55C116FA.3060909@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Ketor D <d.ketor@gmail.com>, =?UTF-8?B?5LmU5bu65bOw?= <scaleqiao@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, cbt@ceph.com

On Tue, Aug 4, 2015 at 9:48 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Hi,
>
> Am 04.08.2015 um 21:16 schrieb Ketor D:
>>
>> Hi Stefan,
>>        Could you describe more about the linger ops bug?
>>        I'm runing Firefly as you say still has this bug.
>
>
> It will be fixed in next ff release.
>
> This on:
> http://tracker.ceph.com/issues/9806
>

Just to clarify one point: it appears that the fix needs to be applied
on both the OSDs _and_ all clients, right? So all our kvm clients
would need to be restarted to get firefly 0.80.11 prior to any
attempted splits. :-(

Cheers, Dan
