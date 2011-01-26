From: tsuna <tsunanet@gmail.com>
Subject: Re: Auto-striping feature
Date: Tue, 25 Jan 2011 20:34:49 -0800
Message-ID: <AANLkTiniHjvhwvd9q-iOvg_fpupr69hEs40OXX5efGNp@mail.gmail.com>
References: <1408EC05-75B0-4DD8-B6D6-7F5D10AAC096@gmail.com>
 <AANLkTinw9OZprRD8XoK9rjBm5Q_5aez8n-ZK75+hihYo@mail.gmail.com> <Pine.LNX.4.64.1101252031290.19989@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38209 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab1AZEfK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jan 2011 23:35:10 -0500
Received: by wwa36 with SMTP id 36so579862wwa.1
        for <ceph-devel@vger.kernel.org>; Tue, 25 Jan 2011 20:35:09 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1101252031290.19989@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregf@hq.newdream.net>, Tatsuya Kawano <tatsuya6502@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jan 25, 2011 at 8:32 PM, Sage Weil <sage@newdream.net> wrote:
> Actually, you just need to make sure that object_size is a multiple o=
f
> stripe_unit. =A0The striping strategy puts each stripe_unit on stripe=
_count
> consecutive objects until they reach a size of stripe_count; it then =
moves

Did you mean "until they reach a size of object_size"?

> onto the next set of stripe_count objects. =A0The default degenerate =
case
> has stripe_unit =3D=3D object_size and stripe_count =3D=3D 1.

--=20
Benoit "tsuna" Sigoure
Software Engineer @ www.StumbleUpon.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
