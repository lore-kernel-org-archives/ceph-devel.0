From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH v2 1/2] rbd: use the higher level librbd instead of just
 librados
Date: Mon, 11 Apr 2011 17:18:50 -0700
Message-ID: <4DA39A6A.7020403@dreamhost.com>
References: <6f9466b6098b5159aca9c789f9fce45f409e684f.1301354138.git.josh.durgin@dreamhost.com> <20110408084334.GA28360@stefanha-thinkpad.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51499 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab1DLASu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2011 20:18:50 -0400
In-Reply-To: <20110408084334.GA28360@stefanha-thinkpad.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@hq.newdream.net>

On 04/08/2011 01:43 AM, Stefan Hajnoczi wrote:
> On Mon, Mar 28, 2011 at 04:15:57PM -0700, Josh Durgin wrote:
>> librbd stacks on top of librados to provide access
>> to rbd images.
>>
>> Using librbd simplifies the qemu code, and allows
>> qemu to use new versions of the rbd format
>> with few (if any) changes.
>>
>> Signed-off-by: Josh Durgin<josh.durgin@dreamhost.com>
>> Signed-off-by: Yehuda Sadeh<yehuda@hq.newdream.net>
>> ---
>>   block/rbd.c       |  785 +++++++++++++++--------------------------------------
>>   block/rbd_types.h |   71 -----
>>   configure         |   33 +--
>>   3 files changed, 221 insertions(+), 668 deletions(-)
>>   delete mode 100644 block/rbd_types.h
>
> Hi Josh,
> I have applied your patches onto qemu.git/master and am running
> ceph.git/master.
>
> Unfortunately qemu-iotests fails for me.
>
>
> Test 016 seems to hang in qemu-io -g -c write -P 66 128M 512
> rbd:rbd/t.raw.  I can reproduce this consistently.  Here is the
> backtrace of the hung process (not consuming CPU, probably deadlocked):

This hung because it wasn't checking the return value of rbd_aio_write.
I've fixed this in the for-qemu branch of 
http://ceph.newdream.net/git/qemu-kvm.git. Also, the existing rbd 
implementation is not 'growable' - writing to a large offset will not 
expand the rbd image correctly. Should we implement bdrv_truncate to 
support this (librbd has a resize operation)? Is bdrv_truncate useful 
outside of qemu-img and qemu-io?

> Test 008 failed with an assertion but succeeded when run again.  I think
> this is a race condition:

This is likely a use-after-free, but I haven't been able to find the 
race condition yet (or reproduce it). Could you get a backtrace from the 
core file?

Thanks,
Josh
