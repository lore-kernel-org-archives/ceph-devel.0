From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH 1/2] rbd: allow importing from stdin
Date: Wed, 16 May 2012 09:39:08 -0700
Message-ID: <CADvuQRFE55pWrU8jBu8wvPW2cZ+d61=eoTuzve49y60B=f_MHQ@mail.gmail.com>
References: <20120516142750.GA8485@sir.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38389 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab2EPQj3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 May 2012 12:39:29 -0400
Received: by dady13 with SMTP id y13so1202973dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 May 2012 09:39:29 -0700 (PDT)
In-Reply-To: <20120516142750.GA8485@sir.fritz.box>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Wed, May 16, 2012 at 7:27 AM, Christian Brunner <chb@muc.de> wrote:
> This patch allows importing images from stdin with the following comm=
and:
>
> =C2=A0 rbd import --size=3D<size in MB> - [dest-image]
>
> Signed-off-by: Christian Brunner <chb@muc.de>
> ---
> =C2=A0src/rbd.cc | =C2=A0 37 +++++++++++++++++++++++++------------
> =C2=A01 files changed, 25 insertions(+), 12 deletions(-)
>
> - =C2=A0r =3D fstat(fd, &stat_buf);
> - =C2=A0if (r < 0) {
> - =C2=A0 =C2=A0r =3D -errno;
> - =C2=A0 =C2=A0cerr << "stat error " << path << std::endl;
> - =C2=A0 =C2=A0return r;
> + =C2=A0if (fd > 0) {
> + =C2=A0 =C2=A0r =3D fstat(fd, &stat_buf);
> + =C2=A0 =C2=A0if (r < 0) {
> + =C2=A0 =C2=A0 =C2=A0r =3D -errno;
> + =C2=A0 =C2=A0 =C2=A0cerr << "stat error " << path << std::endl;
> + =C2=A0 =C2=A0 =C2=A0return r;
> + =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0size =3D (uint64_t)stat_buf.st_size;
> =C2=A0 }
> - =C2=A0size =3D (uint64_t)stat_buf.st_size;
> +

There's no reason why you couldn't stat stdin too, it's just not
guaranteed to give you anything helpful. Think "rbd import - myimg
<file". Just do the stat and react to the results, don't avoid the
stat.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
