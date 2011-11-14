From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: rbd - input/output error
Date: Mon, 14 Nov 2011 14:13:12 -0800
Message-ID: <CAORUGqCi3yTxSVm+D3B1sM9cMb+64TVoaThxSm7VGZsgODBaew@mail.gmail.com>
References: <4EBF98B5.7040706@b1-systems.de> <Pine.LNX.4.64.1111141148220.29742@cobra.newdream.net>
 <4EC18864.4010308@b1-systems.de> <Pine.LNX.4.64.1111141338160.3717@cobra.newdream.net>
 <4EC18F46.70102@b1-systems.de> <Pine.LNX.4.64.1111141401270.3717@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33577 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297Ab1KNWNe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 17:13:34 -0500
Received: by wyh15 with SMTP id 15so6412365wyh.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2011 14:13:33 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1111141401270.3717@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Mario van der Linde <linde@b1-systems.de>, ceph-devel@vger.kernel.org

On Mon, Nov 14, 2011 at 14:09, Sage Weil <sage@newdream.net> wrote:
=2E..
> My last attempt to make automake fill in the @libdirpath@ correctly i=
n
> common/config_opts.h failed miserably, further entrenching my frustra=
tion
> with autotools. =C2=A0It's bug http://tracker.newdream.net/issues/161=
4, if
> someone with better autotools-fu than I wants to fix this. =C2=A0IIRC=
 I tried a
> few different methods but could only make it substitute in @prefix@/l=
ib64,
> but not /usr/lib64...

=46or some reason #1614 didn't want me to edit it, so I opened
http://tracker.newdream.net/issues/1722 to make sure this doesn't get
lost. With all the new distributions coming out multi-arch, this is
going to get more common.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
