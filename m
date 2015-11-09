From: "Denis V. Lunev" <den-lists@parallels.com>
Subject: Re: [Qemu-devel] qemu : rbd block driver internal snapshot and
 vm_stop is hanging forever
Date: Mon, 9 Nov 2015 10:22:34 +0300
Message-ID: <564049BA.1090805@parallels.com>
References: <310812067.2785504.1447038645014.JavaMail.zimbra@oxygem.tv>
 <5640490B.5030700@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay.parallels.com ([195.214.232.42]:40966 "EHLO
	relay.parallels.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbbKIHWp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 02:22:45 -0500
In-Reply-To: <5640490B.5030700@parallels.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>

On 11/09/2015 10:19 AM, Denis V. Lunev wrote:
> On 11/09/2015 06:10 AM, Alexandre DERUMIER wrote:
>> Hi,
>>
>> with qemu (2.4.1), if I do an internal snapshot of an rbd device,
>> then I pause the vm with vm_stop,
>>
>> the qemu process is hanging forever
>>
>>
>> monitor commands to reproduce:
>>
>>
>> # snapshot_blkdev_internal drive-virtio0 yoursnapname
>> # stop
>>
>>
>>
>>
>> I don't see this with qcow2 or sheepdog block driver for example.
>>
>>
>> Regards,
>>
>> Alexandre
>>
> this could look like the problem I have recenty trying to
> fix with dataplane enabled. Patch series is named as
>
> [PATCH for 2.5 v6 0/10] dataplane snapshot fixes
>
> Den

anyway, even if above will not help, can you collect gdb
traces from all threads in QEMU process. May be I'll be
able to give a hit.

Den
