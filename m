From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [PATCH/RFC 5/6] doc: Add missing documentation for osd pool get.
Date: Mon, 28 Nov 2011 10:37:51 -0800
Message-ID: <CAF3hT9Aqa9xpn9CGQiUFuVZz_Lp5SpqtVpN5D5h=mPnmLLC_kw@mail.gmail.com>
References: <20111121180656.GO13394@systemlinux.org>
	<1322489076-31364-1-git-send-email-maan@systemlinux.org>
	<1322489076-31364-6-git-send-email-maan@systemlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64104 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab1K1Shw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2011 13:37:52 -0500
Received: by ggnr5 with SMTP id r5so5517843ggn.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2011 10:37:51 -0800 (PST)
In-Reply-To: <1322489076-31364-6-git-send-email-maan@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: ceph-devel@vger.kernel.org

On Mon, Nov 28, 2011 at 6:04 AM, Andre Noll <maan@systemlinux.org> wrot=
e:
> "osd pool set" was already documented, but the corresponding "get"
> command was not. This patch adds the list of valid fields for this
> command, together with short descriptions.
>
> Signed-Off-By: Andre Noll <maan@systemlinux.org>
> ---
> =A0doc/ops/monitor.rst | =A0 11 +++++++++++
> =A01 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/doc/ops/monitor.rst b/doc/ops/monitor.rst
> index 4de3c19..076c8e1 100644
> --- a/doc/ops/monitor.rst
> +++ b/doc/ops/monitor.rst
> @@ -197,6 +197,17 @@ Changes a pool setting. Valid fields are:
>
> =A0::
>
> + =A0 =A0 =A0 $ ceph osd pool get POOL FIELD
> +
> +Get the value of a pool setting. Valid fields are:
> +
> + =A0 =A0 =A0 * ``pg_num``: See above.
> + =A0 =A0 =A0 * ``pgp_num``: See above.
> + =A0 =A0 =A0 * ``lpg_num``: The localized pg number.
> + =A0 =A0 =A0 * ``lpgp_num``: The number of localized pgs.
The lpg_num and lpgp_num are analogous to the pg_num and the pgp_num =97
the lpg_num is the number of local PGs, and the lpgp_num is the number
used for placing them. This matters less for the local PGs than the
regular PGs but it can still control where the replicas are placed.
-Greg

> =A0 =A0 =A0 =A0$ ceph osd scrub N
>
> =A0Sends a scrub command to osdN. To send the command to all osds, us=
e ``*``.
> --
> 1.7.8.rc1.14.g248db
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
