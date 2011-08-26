From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 2/2] rbd: add an option for md5 checksumming (v3)
Date: Fri, 26 Aug 2011 12:20:55 -0700
Message-ID: <CAC-hyiGwEZqaFGvSDnGoSn_vc5c7L_QatEpSER2JP2r-Ssj9cQ@mail.gmail.com>
References: <20110826185117.GA19365@sir.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44635 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab1HZTU5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Aug 2011 15:20:57 -0400
Received: by bke11 with SMTP id 11so2775015bke.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Aug 2011 12:20:56 -0700 (PDT)
In-Reply-To: <20110826185117.GA19365@sir.fritz.box>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Fri, Aug 26, 2011 at 11:51 AM, Christian Brunner <chb@muc.de> wrote:
> +static int hash_read_cb(uint64_t ofs, size_t len, const char *buf, v=
oid *arg)
> +{
> + =A0ceph::crypto::Digest *Hash =3D (ceph::crypto::Digest *)arg;
> + =A0byte *hashbuf =3D (byte *) buf;

Looking at it again, hashbuf is pretty much useless, you can use buf di=
rectly.

> + =A0byte *tempbuf =3D NULL;
> +
> + =A0if (!buf) {
> + =A0 =A0len =3D ofs-lastofs;

Why setting len here? len was already passed in.

> + =A0 =A0tempbuf =3D (byte *) malloc(len);
> + =A0 =A0if (!tempbuf)
> + =A0 =A0 =A0return -ENOMEM;
> + =A0 =A0hashbuf =3D tempbuf;

buf =3D tempbuf;

> + =A0}
> + =A0Hash->Update((const byte *) hashbuf, len);
> +
> + =A0lastofs =3D ofs + len;

you don't need lastofs either.

> +
> + =A0free(tempbuf);
> +
> + =A0return 0;
> +}
> +
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
