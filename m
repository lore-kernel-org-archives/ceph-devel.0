From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] use int64_t for return values from rbd
 instead of int
Date: Wed, 21 Nov 2012 07:41:48 +0100
Message-ID: <CAJSP0QXcjaRdeQ55GSPtSqam+WHUGPAz4+ohajTCMR8f+4oKrQ@mail.gmail.com>
References: <1353415495-30561-1-git-send-email-s.priebe@profihost.ag>
	<20121120162922.GA8665@stefanha-thinkpad.redhat.com>
	<50ABD713.3050300@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35310 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab2KUGlu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 01:41:50 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so2446817lbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Nov 2012 22:41:49 -0800 (PST)
In-Reply-To: <50ABD713.3050300@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, ceph-devel@vger.kernel.org, pve-devel@pve.proxmox.com, josh.durgin@inktank.com

On Tue, Nov 20, 2012 at 8:16 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Hi Stefan,
>
> Am 20.11.2012 17:29, schrieb Stefan Hajnoczi:
>
>> On Tue, Nov 20, 2012 at 01:44:55PM +0100, Stefan Priebe wrote:
>>>
>>> rbd / rados tends to return pretty often length of writes
>>> or discarded blocks. These values might be bigger than int.
>>>
>>> Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>
>>> ---
>>>   block/rbd.c |    4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>
>> Looks good but I want to check whether this fixes an bug you've hit?
>> Please indicate details of the bug and how to reproduce it in the commit
>> message.
>
>
> you get various I/O errors in client. As negative return values indicate I/O
> errors. When now a big positive value is returned by librbd block/rbd tries
> to store this one in acb->ret which is an int. Then it wraps around and is
> negative. After that block/rbd thinks this is an I/O error and report this
> to the guest.

It's still not clear whether this is a bug that you can reproduce.
After all, the ret value would have to be >2^31 which is a 2+ GB
request!

I'm asking if this is a critical bug fix that needs to go into QEMU
1.3-rc1 because of a real-world issue?

Stefan
