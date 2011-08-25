From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH 2/2] rbd: add an option for md5 checksumming (v2)
Date: Thu, 25 Aug 2011 13:32:55 -0700
Message-ID: <CAORUGqCz8Y4_VF=PrH5QGx60nm_bziwuiyX-9rSvxqsdcLigqQ@mail.gmail.com>
References: <20110825110316.GB6517@sir.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59626 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973Ab1HYUdP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2011 16:33:15 -0400
Received: by yxj19 with SMTP id 19so2072437yxj.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2011 13:33:15 -0700 (PDT)
In-Reply-To: <20110825110316.GB6517@sir.fritz.box>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Thu, Aug 25, 2011 at 04:03, Christian Brunner <chb@muc.de> wrote:
> + =C2=A0if (buf) {
> + =C2=A0 =C2=A0dif =3D ofs-lastofs;
> + =C2=A0 =C2=A0if (dif > 0) {
> + =C2=A0 =C2=A0 =C2=A0byte *tempbuf =3D (byte *) malloc(dif);
> + =C2=A0 =C2=A0 =C2=A0memset(tempbuf, 0, dif);
> + =C2=A0 =C2=A0 =C2=A0Hash->Update((const byte *) tempbuf, dif);
> + =C2=A0 =C2=A0 =C2=A0free(tempbuf);
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0Hash->Update((const byte *) buf, len);
> + =C2=A0 =C2=A0lastofs =3D ofs + len;
> + =C2=A0}

Does this mean a file with a 100GB hole in it will make you malloc(100G=
B)?

> + =C2=A0case OPT_MD5:
> + =C2=A0case OPT_SHA1:
> + =C2=A0 =C2=A0r =3D do_hash(image, imgname, opt_cmd);
> + =C2=A0 =C2=A0if (r < 0) {
> + =C2=A0 =C2=A0 =C2=A0cerr << "md5 hashing failed: " << strerror(-r) =
<< std::endl;
> + =C2=A0 =C2=A0 =C2=A0exit(1);

It's not always md5 hashing, yet the error message says md5..
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
