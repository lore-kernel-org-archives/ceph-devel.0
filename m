From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: optmize librbd for iops
Date: Tue, 13 Nov 2012 08:55:03 +0100
Message-ID: <50A1FCD7.7090303@profihost.ag>
References: <50A0FE96.9030708@profihost.ag> <50A1FC14.3010007@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:46633 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab2KMHzD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 02:55:03 -0500
In-Reply-To: <50A1FC14.3010007@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 13.11.2012 08:51, schrieb Josh Durgin:
> On 11/12/2012 05:50 AM, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>>
>> are there any plans to optimize librbd for iops? Right now i'm able to
>> get 50.000 iop/s via iscsi and 100.000 iop/s using multipathing with
>> iscsi.
>>
>> With librbd i'm stuck to around 18.000iops. As this scales with more
>> hosts but not with more disks in a vm. It must be limited by rbd
>> implementation in kvm / librbd.
>
> It'd be interesting to see which layers are most limiting in this
> case - qemu/kvm, librados, or librbd.
>
> How does rados bench with 4k writes and then 4k reads with many
> concurrent IOs do?
Right now i'm using qemu-kvm with librbd and fio inside guest. How does 
the rados bench work?

Stefan
