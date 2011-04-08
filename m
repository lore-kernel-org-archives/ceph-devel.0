From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH v2 1/2] rbd: use the higher level librbd instead of just
 librados
Date: Fri, 08 Apr 2011 11:36:08 -0700
Message-ID: <4D9F5598.10007@dreamhost.com>
References: <6f9466b6098b5159aca9c789f9fce45f409e684f.1301354138.git.josh.durgin@dreamhost.com> <20110408084334.GA28360@stefanha-thinkpad.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43397 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550Ab1DHSgJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2011 14:36:09 -0400
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

Thanks for testing and the detailed instructions! I'm looking into this now.

Josh Durgin
