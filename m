From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: protocol version mismatch
Date: Fri, 2 Mar 2012 10:41:20 -0800
Message-ID: <C3AB3368498349CBB0D2110B64070D60@dreamhost.com>
References: <CAJafhzSp7eHZ_nQBFAtGO3p02470munOPKswpR3BOtVb9K69-w@mail.gmail.com>
 <25281330682162@webcorp7.yandex-team.ru>
 <90660E33C43F48A7ACCC8E5E1ADD6AB5@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50511 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745Ab2CBSlY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 13:41:24 -0500
Received: by dajr28 with SMTP id r28so2290789daj.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Mar 2012 10:41:23 -0800 (PST)
In-Reply-To: <90660E33C43F48A7ACCC8E5E1ADD6AB5@dreamhost.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?=D0=91=D0=BE=D1=80=D0=BE=D0=B4=D0=B8=D0=BD_=D0=92=D0=BB=D0=B0=D0=B4=D0=B8=D0=BC=D0=B8=D1=80?= <d0uble@yandex-team.ru>, Christian Brunner <christian@brunner-muc.de>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Friday, March 2, 2012 at 8:06 AM, Greg Farnum wrote:
> This is a known issue that was introduced recently and will be fixed =
in the next point release. If you want it now you can pull down the "ne=
xt" branch or apply commit:244b70296622906f01cfa3d48c931aa08e663a75 to =
your source. :)
> -Greg

Actually, I guess this is just being rolled into 0.43 (no more point re=
leases on 0.42). Sage assures me it'll be packaged sometime today =E2=80=
=94 sorry for the false report!
-Greg


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
