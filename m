From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] librados: Bump the version to 0.48
Date: Wed, 4 Jul 2012 09:29:07 -0700
Message-ID: <6ED535BAF3394911BDF4F16441761D6A@inktank.com>
References: <1341409564-26660-1-git-send-email-wido@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43435 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683Ab2GDQ3E convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 12:29:04 -0400
Received: by pbbrp8 with SMTP id rp8so11257474pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jul 2012 09:29:04 -0700 (PDT)
In-Reply-To: <1341409564-26660-1-git-send-email-wido@widodh.nl>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Hmmm =E2=80=94 we generally try to modify these versions when the API c=
hanges, not on every sprint. It looks to me like Sage added one functio=
n in 0.45 where we maybe should have bumped it, but that was a long tim=
e ago and at this point we should maybe just eat it?
-Greg


On Wednesday, July 4, 2012 at 6:46 AM, Wido den Hollander wrote:

> =20
> Signed-off-by: Wido den Hollander <wido@widodh.nl (mailto:wido@widodh=
=2Enl)>
> ---
> src/include/rados/librados.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> =20
> diff --git a/src/include/rados/librados.h b/src/include/rados/librado=
s.h
> index 9f723f7..4870b0f 100644
> --- a/src/include/rados/librados.h
> +++ b/src/include/rados/librados.h
> @@ -23,7 +23,7 @@ extern "C" {
> #endif
> =20
> #define LIBRADOS_VER_MAJOR 0
> -#define LIBRADOS_VER_MINOR 44
> +#define LIBRADOS_VER_MINOR 48
> #define LIBRADOS_VER_EXTRA 0
> =20
> #define LIBRADOS_VERSION(maj, min, extra) ((maj << 16) + (min << 8) +=
 extra)
> -- =20
> 1.7.9.5
> =20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
