From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: all rbd users: set 'filestore fiemap = false'
Date: Mon, 18 Jun 2012 10:29:15 +0200
Message-ID: <4FDEE6DB.8030406@filoo.de>
References: <Pine.LNX.4.64.1206172053320.16985@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:41011 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab2FRI3S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 04:29:18 -0400
In-Reply-To: <Pine.LNX.4.64.1206172053320.16985@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

On 06/18/2012 06:02 AM, Sage Weil wrote:
> If you are using RBD, and want to avoid potential image corruption, a=
dd
>
> 	filestore fiemap =3D false
>
> to the [osd] section of your ceph.conf and restart your OSDs.

as far as this heals some trouble, but I fairly don't understand...

>
> We've tracked down the source of some corruption to racy/buggy FIEMAP
> ioctl behavior.  The RBD client (when caching is diabled--the default=
)
> uses a 'sparse read' operation that the OSD implements by doing an fs=
ync
> on the object file, mapping which extents are allocated, and sending =
only
> that data over the wire.  We have observed incorrect/changing FIEMAP =
on
> both btrfs:
>
> 	fsync
> 	fiemap returns mapping
> 	<time passes, no modifications to file>
> 	fiemap returns different mapping

=2E.. that even an initial start of a VM leads to corruption of the rea=
d data?

I get s/t like:

--- 8-< ---

Loading, please wait
/sbin/init: relocation error: ...
  not defined in file libc.so.6...
[     0.81...] Kernel panic - not snycing: Attempted to kill init!

--- 8-< ---

host-kernel is now 3.4.1 + qemu-1.0.1, but shows failures with other=20
kernel/qemu-versions, too.

Keeping fingers crossed for Josh, though ;-)
Give me a shout, If I can do some debugging,

regards,

Oliver.

>
> Josh is still tracking down which kernels and file system are affecte=
d;
> fortunately it is relatively easy to reproduce with the test_librbd_f=
sx
> tool.  In the meantime, the (mis)feature can be safely disabled. It w=
ill
> default to off in 0.48. It is unclear whether it's really much of a
> performance win anyway.
>
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
