From: Christian Brunner <chb@muc.de>
Subject: qemu librbd patches
Date: Mon, 9 May 2011 10:59:41 +0200
Message-ID: <BANLkTim4jTVJH5y6o5rHq8pm_KfH0Jiz0w@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45612 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205Ab1EII7m convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 May 2011 04:59:42 -0400
Received: by vxi39 with SMTP id 39so5524432vxi.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 May 2011 01:59:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

after upgrading to qemu with josh's librbd patches I'm triggering the
following assertion, when I'm running "yum upgrade" inside a guest.

I suspect there is a race condition somewhere, but I don't have a clue
at the moment.

Regards,
Christian

common/Mutex.h: In function 'void Mutex::Lock(bool)', in thread '0x7fea=
16b36700'
common/Mutex.h: 118: FAILED assert(r =3D=3D 0)
common/Mutex.h: In function 'void Mutex::Lock(bool)', in thread '0x7fea=
16b36700'
common/Mutex.h: 118: FAILED assert(r =3D=3D 0)
=A0ceph version 0.27.1 (commit:44900d4c13f02913b3347cac3e1dc33632d5b8ff=
)
=A01: (librbd::aio_write(librbd::ImageCtx*, unsigned long, unsigned
long, char const*, librbd::AioCompletion*)+0x54e) [0x7fea2299523e]
=A02: /usr/bin/qemu-kvm() [0x46a165]
=A03: /usr/bin/qemu-kvm() [0x46a1d0]
=A04: /usr/bin/qemu-kvm() [0x44349f]
=A0ceph version 0.27.1 (commit:44900d4c13f02913b3347cac3e1dc33632d5b8ff=
)
=A01: (librbd::aio_write(librbd::ImageCtx*, unsigned long, unsigned
long, char const*, librbd::AioCompletion*)+0x54e) [0x7fea2299523e]
=A02: /usr/bin/qemu-kvm() [0x46a165]
=A03: /usr/bin/qemu-kvm() [0x46a1d0]
=A04: /usr/bin/qemu-kvm() [0x44349f]
=A0ceph version 0.27.1 (commit:44900d4c13f02913b3347cac3e1dc33632d5b8ff=
)
=A01: (librbd::aio_write(librbd::ImageCtx*, unsigned long, unsigned
long, char const*, librbd::AioCompletion*)+0x54e) [0x7fea2299523e]
=A02: /usr/bin/qemu-kvm() [0x46a165]
=A03: /usr/bin/qemu-kvm() [0x46a1d0]
=A04: /usr/bin/qemu-kvm() [0x44349f]
=A0ceph version 0.27.1 (commit:44900d4c13f02913b3347cac3e1dc33632d5b8ff=
)
=A01: (librbd::aio_write(librbd::ImageCtx*, unsigned long, unsigned
long, char const*, librbd::AioCompletion*)+0x54e) [0x7fea2299523e]
=A02: /usr/bin/qemu-kvm() [0x46a165]
=A03: /usr/bin/qemu-kvm() [0x46a1d0]
=A04: /usr/bin/qemu-kvm() [0x44349f]
terminate called after throwing an instance of 'ceph::FailedAssertion'
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
