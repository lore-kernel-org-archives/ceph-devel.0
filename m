From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Fix compile error when using nss libs:
Date: Fri, 22 Jul 2011 13:25:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107221324050.25773@cobra.newdream.net>
References: <1311356967-1797-1-git-send-email-shadowsor@gmail.com>
 <CALFpzo4Nc3y1zps9tct5BMjHa2kYSEQyPpK=66XSRtLK7WqzBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-432876489-1311366316=:25773"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34434 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab1GVUVe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 16:21:34 -0400
In-Reply-To: <CALFpzo4Nc3y1zps9tct5BMjHa2kYSEQyPpK=66XSRtLK7WqzBA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-432876489-1311366316=:25773
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 22 Jul 2011, Marcus Sorensen wrote:
> auth/Crypto.cc:218: error: expected primary-expression before ?}? token
> auth/Crypto.cc:218: error: expected ?;? before ?}? token
>=20
> Perhaps something more is missing here but this gets things going...
> apparently not used much?

Looks right.  Maybe only some compiler versions bork on that?  We=20
also usually build with crypto++ when we can (libnss sucks a=20
several ways).

Can I add your signed-off-by?=20

Thanks-
sage


> ---
> =A0src/auth/Crypto.cc | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/src/auth/Crypto.cc b/src/auth/Crypto.cc
> index 7251d09..ad256bb 100644
> --- a/src/auth/Crypto.cc
> +++ b/src/auth/Crypto.cc
> @@ -215,6 +215,7 @@ static void nss_aes_operation(CK_ATTRIBUTE_TYPE
> op, const bufferptr& secret,
> =A0err_slot:
> =A0 PK11_FreeSlot(slot);
> =A0err:
> + =A0;
> =A0}
>=20
> =A0#else
> --
> 1.7.4.1
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-432876489-1311366316=:25773--
