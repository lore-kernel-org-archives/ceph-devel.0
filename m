From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] Why is librbd1 / librados2 from Firefly 20% slower
 than the one from dumpling?
Date: Tue, 1 Jul 2014 15:51:36 -0700
Message-ID: <CAPYLRzhJ_3WkWSFUAx+w+gt5PTLD7SYmSyQ-xPRZ31ahN4a1Ag@mail.gmail.com>
References: <539B11C4.1010400@profihost.ag>
	<CAPYLRzjL1JrgsThUejDHQsG3qcK1ZTXgcO2mHEuoHN-FbwVwsQ@mail.gmail.com>
	<53AD1411.101@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:33086 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964965AbaGAWvh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jul 2014 18:51:37 -0400
Received: by mail-qa0-f54.google.com with SMTP id v10so8174749qac.41
        for <ceph-devel@vger.kernel.org>; Tue, 01 Jul 2014 15:51:36 -0700 (PDT)
In-Reply-To: <53AD1411.101@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On Thu, Jun 26, 2014 at 11:49 PM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Hi Greg,
>
> Am 26.06.2014 02:17, schrieb Gregory Farnum:
>> Sorry we let this drop; we've all been busy traveling and things.
>>
>> There have been a lot of changes to librados between Dumpling and
>> Firefly, but we have no idea what would have made it slower. Can you
>> provide more details about how you were running these tests?
>
> it's just a normal fio run:
> fio --ioengine=rbd --bs=4k --name=foo --invalidate=0
> --readwrite=randwrite --iodepth=32 --rbdname=fio_test2 --pool=teststor
> --runtime=90 --numjobs=32 --direct=1 --group
>
> Running one time with firefly libs and one time with dumpling libs.
> Traget is always the same pool on a firefly ceph storage.

What's the backing cluster you're running against? What kind of CPU
usage do you see with both? 25k IOPS is definitely getting up there,
but I'd like some guidance about whether we're looking for a reduction
in parallelism, or an increase in per-op costs, or something else.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
