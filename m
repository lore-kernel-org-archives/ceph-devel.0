From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 1/2] rbd: use the higher level librbd instead of just librados
Date: Tue, 12 Apr 2011 09:54:19 +0100
Message-ID: <BANLkTin8oB-1bz3rDdPU8sozmA_+Qqyb7w@mail.gmail.com>
References: <6f9466b6098b5159aca9c789f9fce45f409e684f.1301354138.git.josh.durgin@dreamhost.com>
	<20110408084334.GA28360@stefanha-thinkpad.localdomain>
	<4DA39A6A.7020403@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55914 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab1DLIyU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2011 04:54:20 -0400
In-Reply-To: <4DA39A6A.7020403@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@hq.newdream.net>

On Tue, Apr 12, 2011 at 1:18 AM, Josh Durgin <josh.durgin@dreamhost.com=
> wrote:
> On 04/08/2011 01:43 AM, Stefan Hajnoczi wrote:
>>
>> On Mon, Mar 28, 2011 at 04:15:57PM -0700, Josh Durgin wrote:
>>>
>>> librbd stacks on top of librados to provide access
>>> to rbd images.
>>>
>>> Using librbd simplifies the qemu code, and allows
>>> qemu to use new versions of the rbd format
>>> with few (if any) changes.
>>>
>>> Signed-off-by: Josh Durgin<josh.durgin@dreamhost.com>
>>> Signed-off-by: Yehuda Sadeh<yehuda@hq.newdream.net>
>>> ---
>>> =A0block/rbd.c =A0 =A0 =A0 | =A0785
>>> +++++++++++++++--------------------------------------
>>> =A0block/rbd_types.h | =A0 71 -----
>>> =A0configure =A0 =A0 =A0 =A0 | =A0 33 +--
>>> =A03 files changed, 221 insertions(+), 668 deletions(-)
>>> =A0delete mode 100644 block/rbd_types.h
>>
>> Hi Josh,
>> I have applied your patches onto qemu.git/master and am running
>> ceph.git/master.
>>
>> Unfortunately qemu-iotests fails for me.
>>
>>
>> Test 016 seems to hang in qemu-io -g -c write -P 66 128M 512
>> rbd:rbd/t.raw. =A0I can reproduce this consistently. =A0Here is the
>> backtrace of the hung process (not consuming CPU, probably deadlocke=
d):
>
> This hung because it wasn't checking the return value of rbd_aio_writ=
e.
> I've fixed this in the for-qemu branch of
> http://ceph.newdream.net/git/qemu-kvm.git. Also, the existing rbd
> implementation is not 'growable' - writing to a large offset will not=
 expand
> the rbd image correctly. Should we implement bdrv_truncate to support=
 this
> (librbd has a resize operation)? Is bdrv_truncate useful outside of q=
emu-img
> and qemu-io?

If librbd has a resize operation then it would be nice to wire up
bdrv_truncate() for completeness.  Note that bdrv_truncate() can also
be called online using the block_resize monitor command.

Since rbd devices are not growable we should fix qemu-iotests to skip
016 for rbd.

>> Test 008 failed with an assertion but succeeded when run again. =A0I=
 think
>> this is a race condition:
>
> This is likely a use-after-free, but I haven't been able to find the =
race
> condition yet (or reproduce it). Could you get a backtrace from the c=
ore
> file?

Unfortunately I have no core file and wasn't able to reproduce it again=
=2E

Is qemu-iotests passing for you now?

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
