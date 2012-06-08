From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Kernel crash
Date: Fri, 8 Jun 2012 09:35:59 -0700
Message-ID: <CADvuQRH9_sezGiXGX8fUUp1U_aBRSh+kQ0TsnGmSkuY5mxrZpw@mail.gmail.com>
References: <1934548.axdquzlaJh@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44808 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab2FHQgT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 12:36:19 -0400
Received: by pbbrp8 with SMTP id rp8so2757605pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jun 2012 09:36:19 -0700 (PDT)
In-Reply-To: <1934548.axdquzlaJh@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

On Wed, May 30, 2012 at 10:35 AM, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
> I just saw a kernel crash on one of my machines. It had the cephfs fr=
om the
> ceph cluster mounted using the in-kernel client:
=2E..
> [522247.751290] =C2=A0[<ffffffff815ea46a>] bad_area_nosemaphore+0x13/=
0x15
> [522247.751397] =C2=A0[<ffffffff815f7b76>] do_page_fault+0x416/0x4f0
> [522247.751503] =C2=A0[<ffffffff814ce5dd>] ? sock_recvmsg+0x11d/0x140
> [522247.751611] =C2=A0[<ffffffff812c0ea6>] ? cpumask_next_and+0x36/0x=
50
> [522247.751718] =C2=A0[<ffffffff815f4475>] page_fault+0x25/0x30
> [522247.751828] =C2=A0[<ffffffffa03ccba4>] ? ceph_x_destroy_authorize=
r+0x14/0x40
> [libceph]
> [522247.751995] =C2=A0[<ffffffffa040f9be>] get_authorizer+0x6e/0x140 =
[ceph]
> [522247.752104] =C2=A0[<ffffffff814ce646>] ? kernel_recvmsg+0x46/0x60

Hi. I can't find any other reports of kernel crashes related to
ceph_x_destroy_authorizer either.

If this keeps happening, please file a bug report at
http://tracker.newdream.net/ with details on the circumstance in which
it triggers, and we'll get back to it once we re-focus on the Ceph
Distributed File System. Right now, we are focusing our efforts in the
RADOS, RBD and radosgw functionality, in an effort to stabilize and
optimize the core object store of the product even more.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
