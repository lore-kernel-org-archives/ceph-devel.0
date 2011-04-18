From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [Regression,bisected] 2.6.39-rc3 ceph client write hangs
Date: Mon, 18 Apr 2011 16:05:54 +0200
Message-ID: <201104181605.54981.maciej.rutecki@gmail.com>
References: <4DA879CA.8060305@sandia.gov> <201104172017.15090.maciej.rutecki@gmail.com> <Pine.LNX.4.64.1104172249540.18433@cobra.newdream.net>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49196 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab1DROGB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 10:06:01 -0400
In-Reply-To: <Pine.LNX.4.64.1104172249540.18433@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jim Schutt <jaschut@sandia.gov>, dchinner@redhat.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On poniedzia=C5=82ek, 18 kwietnia 2011 o 07:52:40 Sage Weil wrote:
> This was a simple s/igrab/ihold/ fix.  See
>=20
> 283a85dc6e670083adb1e5437bd93d163f4f801a
>=20
> in the for-linus branch of ceph-client.git.  I'll push to Linus in th=
e
> next few days.
>=20

Thanks, closing.

--=20
Maciej Rutecki
http://www.maciek.unixy.pl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
