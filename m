From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv6] rbd block driver fix race between aio
 completition and aio cancel
Date: Mon, 10 Dec 2012 14:09:48 +0100
Message-ID: <50C5DF1C.2050407@redhat.com>
References: <1354265746-8390-1-git-send-email-s.priebe@profihost.ag> <CAJSP0QUk=L628z4Nb7Z6Zx3U2BA7iEvA=rVoBMMwj3n-x=DW8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64674 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab2LJNKC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 10 Dec 2012 08:10:02 -0500
In-Reply-To: <CAJSP0QUk=L628z4Nb7Z6Zx3U2BA7iEvA=rVoBMMwj3n-x=DW8w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Am 30.11.2012 14:50, schrieb Stefan Hajnoczi:
> On Fri, Nov 30, 2012 at 9:55 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>> This one fixes a race which qemu had also in iscsi block driver
>> between cancellation and io completition.
>>
>> qemu_rbd_aio_cancel was not synchronously waiting for the end of
>> the command.
>>
>> To archieve this it introduces a new status flag which uses
>> -EINPROGRESS.
>>
>> Changes since PATCHv5:
>> - qemu_aio_release has to be done in qemu_rbd_aio_cancel if I/O
>>   was cancelled
>>
>> Changes since PATCHv4:
>> - removed unnecessary qemu_vfree of acb->bounce as BH will always
>>   run
>>
>> Changes since PATCHv3:
>> - removed unnecessary if condition in rbd_start_aio as we
>>   haven't start io yet
>> - moved acb->status = 0 to rbd_aio_bh_cb so qemu_aio_wait always
>>   waits until BH was executed
>>
>> Changes since PATCHv2:
>> - fixed missing braces
>> - added vfree for bounce
>>
>> Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>
>>
>> ---
>>  block/rbd.c |   20 ++++++++++++--------
>>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@gmail.com>

Thanks, applied to the block branch.

For future patches, please put a "---" line between the real commit
message (including the SoB, of course) and the changelog so that git am
automatically removes the changelog.

Kevin
