From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: bug when using ceph and keyring does not exist
Date: Tue, 8 Nov 2011 09:57:34 -0800
Message-ID: <CAORUGqC2cDWHi37G6g8R2Q03OrkhfR-EgfB_1h5Ca6WzZThP5A@mail.gmail.com>
References: <4EB78876.10406@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59110 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab1KHR54 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2011 12:57:56 -0500
Received: by wyh15 with SMTP id 15so768545wyh.19
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2011 09:57:55 -0800 (PST)
In-Reply-To: <4EB78876.10406@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: ceph-devel@vger.kernel.org

On Sun, Nov 6, 2011 at 23:27, Smart Weblications GmbH - Florian
Wiessner <f.wiessner@smart-weblications.de> wrote:
> i think i found a bug:
=2E..
> node02:/etc/ceph# ceph
> *** Caught signal (Segmentation fault) **
> =C2=A0in thread 7fb817589720
> =C2=A0ceph version 0.37-307-gae41f32 (commit:ae41f3232a39dbf33487ab02=
cbac292f58debea8)
> =C2=A01: ceph() [0x470789]
> =C2=A02: (()+0xef60) [0x7fb817170f60]
> =C2=A03: (MonClient::_reopen_session()+0x5e4) [0x4845e4]
> =C2=A04: (MonClient::authenticate(double)+0x1a1) [0x485281]
> =C2=A05: (ceph_tool_common_init(ceph_tool_mode_t, bool)+0x55d) [0x452=
d2d]
> =C2=A06: (main()+0x4fe) [0x44fa6e]
> =C2=A07: (__libc_start_main()+0xfd) [0x7fb815b84c4d]
> =C2=A08: ceph() [0x44e519]
> Speicherzugriffsfehler

So a missing keyring make ceph command crash. I see this commit, I
think Sam found the bug independently and fixed it already. Please try
again!

commit d4ef9215fd00b08a198986fde4af5635833555ec
Author: Samuel Just <samuel.just@dreamhost.com>
Date:   2011-11-07 15:04:02 -0800

    common: return null if mc.init() unsuccessful

    Prevents ceph.cc from segfaulting on missing keyring.

    Signed-off-by: Samuel Just <samuel.just@dreamhost.com>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
