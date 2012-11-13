From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: optmize librbd for iops
Date: Tue, 13 Nov 2012 00:20:21 -0800
Message-ID: <50A202C5.1070104@inktank.com>
References: <50A0FE96.9030708@profihost.ag> <50A1FC14.3010007@inktank.com> <50A1FCD7.7090303@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52909 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab2KMIUY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 03:20:24 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so4886101pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 13 Nov 2012 00:20:24 -0800 (PST)
In-Reply-To: <50A1FCD7.7090303@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/12/2012 11:55 PM, Stefan Priebe wrote:
> Am 13.11.2012 08:51, schrieb Josh Durgin:
>> On 11/12/2012 05:50 AM, Stefan Priebe - Profihost AG wrote:
>>> Hello list,
>>>
>>> are there any plans to optimize librbd for iops? Right now i'm able to
>>> get 50.000 iop/s via iscsi and 100.000 iop/s using multipathing with
>>> iscsi.
>>>
>>> With librbd i'm stuck to around 18.000iops. As this scales with more
>>> hosts but not with more disks in a vm. It must be limited by rbd
>>> implementation in kvm / librbd.
>>
>> It'd be interesting to see which layers are most limiting in this
>> case - qemu/kvm, librados, or librbd.
>>
>> How does rados bench with 4k writes and then 4k reads with many
>> concurrent IOs do?
> Right now i'm using qemu-kvm with librbd and fio inside guest. How does
> the rados bench work?

rados bench uses librados aio, keeping several operations in flight.
IO size is the same as object size for it.

You can do a 4k write benchmark that doesn't delete the objects it
writes, with 32 IOs in flight for 300 seconds:

rados -p data bench 300 write -b 4096 -t 32 --no-cleanup

Then a read benchmark (only sequential is implemented, but with 4k
objects it's similar to random if you flush the osd's page cache before
running it):

rados -p data bench 300 seq -b 4096 -t 32

You can divide the avg throughput by IO size to get IOPS.

Josh
