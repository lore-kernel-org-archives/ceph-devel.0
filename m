From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH v2 1/2] rbd: use the higher level librbd instead of just
 librados
Date: Tue, 12 Apr 2011 08:38:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104120835380.12198@cobra.newdream.net>
References: <6f9466b6098b5159aca9c789f9fce45f409e684f.1301354138.git.josh.durgin@dreamhost.com>
 <20110408084334.GA28360@stefanha-thinkpad.localdomain> <4DA39A6A.7020403@dreamhost.com>
 <BANLkTin8oB-1bz3rDdPU8sozmA_+Qqyb7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-854140964-1302622736=:12198"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54449 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757526Ab1DLPfZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2011 11:35:25 -0400
In-Reply-To: <BANLkTin8oB-1bz3rDdPU8sozmA_+Qqyb7w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Josh Durgin <josh.durgin@dreamhost.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@hq.newdream.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-854140964-1302622736=:12198
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 Apr 2011, Stefan Hajnoczi wrote:
> On Tue, Apr 12, 2011 at 1:18 AM, Josh Durgin <josh.durgin@dreamhost.com> =
wrote:
> > On 04/08/2011 01:43 AM, Stefan Hajnoczi wrote:
> >>
> >> On Mon, Mar 28, 2011 at 04:15:57PM -0700, Josh Durgin wrote:
> >>>
> >>> librbd stacks on top of librados to provide access
> >>> to rbd images.
> >>>
> >>> Using librbd simplifies the qemu code, and allows
> >>> qemu to use new versions of the rbd format
> >>> with few (if any) changes.
> >>>
> >>> Signed-off-by: Josh Durgin<josh.durgin@dreamhost.com>
> >>> Signed-off-by: Yehuda Sadeh<yehuda@hq.newdream.net>
> >>> ---
> >>> =A0block/rbd.c =A0 =A0 =A0 | =A0785
> >>> +++++++++++++++--------------------------------------
> >>> =A0block/rbd_types.h | =A0 71 -----
> >>> =A0configure =A0 =A0 =A0 =A0 | =A0 33 +--
> >>> =A03 files changed, 221 insertions(+), 668 deletions(-)
> >>> =A0delete mode 100644 block/rbd_types.h
> >>
> >> Hi Josh,
> >> I have applied your patches onto qemu.git/master and am running
> >> ceph.git/master.
> >>
> >> Unfortunately qemu-iotests fails for me.
> >>
> >>
> >> Test 016 seems to hang in qemu-io -g -c write -P 66 128M 512
> >> rbd:rbd/t.raw. =A0I can reproduce this consistently. =A0Here is the
> >> backtrace of the hung process (not consuming CPU, probably deadlocked)=
:
> >
> > This hung because it wasn't checking the return value of rbd_aio_write.
> > I've fixed this in the for-qemu branch of
> > http://ceph.newdream.net/git/qemu-kvm.git. Also, the existing rbd
> > implementation is not 'growable' - writing to a large offset will not e=
xpand
> > the rbd image correctly. Should we implement bdrv_truncate to support t=
his
> > (librbd has a resize operation)? Is bdrv_truncate useful outside of qem=
u-img
> > and qemu-io?
>=20
> If librbd has a resize operation then it would be nice to wire up
> bdrv_truncate() for completeness.  Note that bdrv_truncate() can also
> be called online using the block_resize monitor command.
>=20
> Since rbd devices are not growable we should fix qemu-iotests to skip
> 016 for rbd.

There is a resize operation, but it's expected that you'll use it for any=
=20
bdev size change (grow or shrink).  Does qemu grow a device by writing to=
=20
the (new) highest offset, or is there another operation that should be=20
wired up?  We want to avoid a situation where RBD isn't aware of the qemu=
=20
bdev resize and has to grow a bit each time we write to a larger offset,=20
as resize is a somewhat expensive operation...

Thanks!
sage
--557981400-854140964-1302622736=:12198--
