From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: newstore direction
Date: Fri, 23 Oct 2015 07:47:53 -0400
Message-ID: <562A1E69.2050704@redhat.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
 <CALe9h7dUQcp6zOSFDfnXSQo4VOTObFCWj+HD-idwE1nNzQVsgA@mail.gmail.com>
 <alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net>
 <CAJ4mKGY0=+isJhh4oF3kqtxEZ6HWSDZXJyM9sBHxc8s21M_y8g@mail.gmail.com>
 <alpine.DEB.2.00.1510201422450.16833@cobra.newdream.net>
 <5626BECA.7070306@redhat.com>
 <alpine.DEB.2.00.1510210616060.16833@cobra.newdream.net>
 <5627981B.2040409@redhat.com> <loom.20151023T081245-920@post.gmane.org>
 <562A14D3.4070509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41187 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbbJWLrz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 23 Oct 2015 07:47:55 -0400
In-Reply-To: <562A14D3.4070509@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Howard Chu <hyc@symas.com>, ceph-devel@vger.kernel.org

On 10/23/2015 07:06 AM, Ric Wheeler wrote:
> On 10/23/2015 02:21 AM, Howard Chu wrote:
>>> Normally, best practice is to use batching to avoid paying worst case latency
>>> >when you do a synchronous IO. Write a batch of files or appends without
>> fsync,
>>> >then go back and fsync and you will pay that latency once (not per file/op).
>> If filesystems would support ordered writes you wouldn't need to fsync at
>> all. Just spit out a stream of writes and declare that batch N must be
>> written before batch N+1. (Note that this is not identical to "write
>> barriers", which imposed the same latencies as fsync by blocking all I/Os at
>> a barrier boundary. Ordered writes may be freely interleaved with un-ordered
>> writes, so normal I/O traffic can proceed unhindered. Their ordering is only
>> enforced wrt other ordered writes.)
>>
>> A bit of a shame that Linux's SCSI drivers support Ordering attributes but
>> nothing above that layer makes use of it.
>
> I think that if the stream on either side of the barrier is large enough, 
> using ordered tags (SCSI speak) versus doing stream1, fsync(), stream2, should 
> have the same performance.
>
> Not clear to me if we could do away with an fsync to trigger a cache flush 
> here either - do SCSI ordered tags require that the writes be acknowledged 
> only when durable, or can the device ack them once the target has them 
> (including in a volatile write cache)?
>
> Ric
>
>

One other note, the file & storage kernel people discussed using ordering years 
ago. One of the issues is that the devices themselves need to support. While 
S-ATA devices are portrayed as SCSI in the kernel, ATA does not (and still does 
not as far as I know?) support ordered tags.

Regards,

Ric


