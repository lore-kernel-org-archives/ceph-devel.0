From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: [PATCH] overflow of int ret: use ssize_t for ret
Date: Thu, 22 Nov 2012 20:09:32 +0100
Message-ID: <50AE786C.30702@profihost.ag>
References: <1353575275-1343-1-git-send-email-s.priebe@profihost.ag>
	<50AE5590.5010804@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <50AE5590.5010804@suse.de>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Cc: peter.maydell@linaro.org, sw@weilnetz.de, qemu-devel@nongnu.org, stefanha@gmail.com, josh.durgin@inktank.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Andreas,

thanks for your comment. Do i have to resend this patch?

--
Greets,
Stefan

Am 22.11.2012 17:40, schrieb Andreas Färber:
> Am 22.11.2012 10:07, schrieb Stefan Priebe:
>> When acb->cmd is WRITE or DISCARD block/rbd stores rcb->size into acb->ret
>>
>> Look here:
>>     if (acb->cmd == RBD_AIO_WRITE ||
>>          acb->cmd == RBD_AIO_DISCARD) {
>>          if (r<  0) {
>>              acb->ret = r;
>>              acb->error = 1;
>>          } else if (!acb->error) {
>>              acb->ret = rcb->size;
>>          }
>>
>> right now acb->ret is just an int and we might get an overflow if size is too big.
>> For discards rcb->size holds the size of the discard - this might be some TB if you
>> discard a whole device.
>>
>> The steps to reproduce are:
>> mkfs.xfs -f a whole device bigger than int in bytes. mkfs.xfs sends a discard. Important is that you use scsi-hd and set discard_granularity=512. Otherwise rbd disabled discard support.
>
> Whatever type you decide to use, please add an identifying topic such as
> "block/rbd:" in the subject (int ret is very generic!), and this patch
> is missing a Signed-off-by.
>
> Regards,
> Andreas
>
>
