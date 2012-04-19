From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: [PATCH 6/6] rbd: correct sysfs snap attribute documentation
Date: Thu, 19 Apr 2012 11:07:19 -0700
Message-ID: <CAC-hyiERXveesgOk6z97M3EENw1LS0FTwzRnxja0LAAkCXS=Ww@mail.gmail.com>
References: <4F8ED154.6050500@dreamhost.com>
	<4F8ED28B.9010705@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58089 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919Ab2DSSHU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Apr 2012 14:07:20 -0400
Received: by bkcik5 with SMTP id ik5so6603760bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Apr 2012 11:07:19 -0700 (PDT)
In-Reply-To: <4F8ED28B.9010705@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 18, 2012 at 7:41 AM, Alex Elder <elder@dreamhost.com> wrote=
:
> Each attribute is prefixed with "snap_".
>
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> Reviewed-by: Alex Elder <elder@dreamhost.com>
> ---
> =A0Documentation/ABI/testing/sysfs-bus-rbd | =A0 =A04 ++--
> =A01 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: b/Documentation/ABI/testing/sysfs-bus-rbd
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/Documentation/ABI/testing/sysfs-bus-rbd
> +++ b/Documentation/ABI/testing/sysfs-bus-rbd
> @@ -65,11 +65,11 @@
> =A0Entries under /sys/bus/rbd/devices/<dev-id>/snap_<snap-name>
> =A0-------------------------------------------------------------
>
> -id
> +snap_id
>
> =A0 =A0 =A0 =A0The rados internal snapshot id assigned for this snaps=
hot
>
> -size
> +snap_size
>
> =A0 =A0 =A0 =A0The size of the image when this snapshot was taken.
>


Reviewed-by: Yehuda Sadeh <yehuda@hq.newdream.net>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
