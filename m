From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [Qemu-devel] [PATCH] use int64_t for return values from rbd instead
 of int
Date: Tue, 20 Nov 2012 20:16:35 +0100
Message-ID: <50ABD713.3050300@profihost.ag>
References: <1353415495-30561-1-git-send-email-s.priebe@profihost.ag> <20121120162922.GA8665@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:45871 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2KTTQw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 14:16:52 -0500
In-Reply-To: <20121120162922.GA8665@stefanha-thinkpad.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ceph-devel@vger.kernel.org, pve-devel@pve.proxmox.com, josh.durgin@inktank.com

Hi Stefan,

Am 20.11.2012 17:29, schrieb Stefan Hajnoczi:
> On Tue, Nov 20, 2012 at 01:44:55PM +0100, Stefan Priebe wrote:
>> rbd / rados tends to return pretty often length of writes
>> or discarded blocks. These values might be bigger than int.
>>
>> Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>
>> ---
>>   block/rbd.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> Looks good but I want to check whether this fixes an bug you've hit?
> Please indicate details of the bug and how to reproduce it in the commit
> message.

you get various I/O errors in client. As negative return values indicate 
I/O errors. When now a big positive value is returned by librbd 
block/rbd tries to store this one in acb->ret which is an int. Then it 
wraps around and is negative. After that block/rbd thinks this is an I/O 
error and report this to the guest.

Stefan
