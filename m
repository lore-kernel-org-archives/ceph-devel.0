From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 1/2] rbd: use the higher level librbd instead of just librados
Date: Tue, 12 Apr 2011 22:14:31 +0100
Message-ID: <BANLkTi=kaTwMA1zBmd486dcNH=jVTB6STQ@mail.gmail.com>
References: <6f9466b6098b5159aca9c789f9fce45f409e684f.1301354138.git.josh.durgin@dreamhost.com>
	<20110408084334.GA28360@stefanha-thinkpad.localdomain>
	<4DA39A6A.7020403@dreamhost.com>
	<BANLkTin8oB-1bz3rDdPU8sozmA_+Qqyb7w@mail.gmail.com>
	<Pine.LNX.4.64.1104120835380.12198@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47200 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932553Ab1DLVOc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2011 17:14:32 -0400
In-Reply-To: <Pine.LNX.4.64.1104120835380.12198@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Josh Durgin <josh.durgin@dreamhost.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@hq.newdream.net>

On Tue, Apr 12, 2011 at 4:38 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 12 Apr 2011, Stefan Hajnoczi wrote:
>> On Tue, Apr 12, 2011 at 1:18 AM, Josh Durgin <josh.durgin@dreamhost.=
com> wrote:
>> > On 04/08/2011 01:43 AM, Stefan Hajnoczi wrote:
>> >>
>> >> On Mon, Mar 28, 2011 at 04:15:57PM -0700, Josh Durgin wrote:
>> >>>
>> >>> librbd stacks on top of librados to provide access
>> >>> to rbd images.
>> >>>
>> >>> Using librbd simplifies the qemu code, and allows
>> >>> qemu to use new versions of the rbd format
>> >>> with few (if any) changes.
>> >>>
>> >>> Signed-off-by: Josh Durgin<josh.durgin@dreamhost.com>
>> >>> Signed-off-by: Yehuda Sadeh<yehuda@hq.newdream.net>
>> >>> ---
>> >>> =A0block/rbd.c =A0 =A0 =A0 | =A0785
>> >>> +++++++++++++++--------------------------------------
>> >>> =A0block/rbd_types.h | =A0 71 -----
>> >>> =A0configure =A0 =A0 =A0 =A0 | =A0 33 +--
>> >>> =A03 files changed, 221 insertions(+), 668 deletions(-)
>> >>> =A0delete mode 100644 block/rbd_types.h
>> >>
>> >> Hi Josh,
>> >> I have applied your patches onto qemu.git/master and am running
>> >> ceph.git/master.
>> >>
>> >> Unfortunately qemu-iotests fails for me.
>> >>
>> >>
>> >> Test 016 seems to hang in qemu-io -g -c write -P 66 128M 512
>> >> rbd:rbd/t.raw. =A0I can reproduce this consistently. =A0Here is t=
he
>> >> backtrace of the hung process (not consuming CPU, probably deadlo=
cked):
>> >
>> > This hung because it wasn't checking the return value of rbd_aio_w=
rite.
>> > I've fixed this in the for-qemu branch of
>> > http://ceph.newdream.net/git/qemu-kvm.git. Also, the existing rbd
>> > implementation is not 'growable' - writing to a large offset will =
not expand
>> > the rbd image correctly. Should we implement bdrv_truncate to supp=
ort this
>> > (librbd has a resize operation)? Is bdrv_truncate useful outside o=
f qemu-img
>> > and qemu-io?
>>
>> If librbd has a resize operation then it would be nice to wire up
>> bdrv_truncate() for completeness. =A0Note that bdrv_truncate() can a=
lso
>> be called online using the block_resize monitor command.
>>
>> Since rbd devices are not growable we should fix qemu-iotests to ski=
p
>> 016 for rbd.
>
> There is a resize operation, but it's expected that you'll use it for=
 any
> bdev size change (grow or shrink). =A0Does qemu grow a device by writ=
ing to
> the (new) highest offset, or is there another operation that should b=
e
> wired up? =A0We want to avoid a situation where RBD isn't aware of th=
e qemu
> bdev resize and has to grow a bit each time we write to a larger offs=
et,
> as resize is a somewhat expensive operation...

Good it sounds like RBD and QEMU have similar concepts here.  The
bdrv_truncate() operation is a (rare) image resize operation.  It is
not the extend-beyond-EOF grow operation which QEMU simply performs as
a write beyond bdrv_getlength() bytes.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
