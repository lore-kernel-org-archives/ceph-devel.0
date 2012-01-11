From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH]: set up rbd snapshot handling
Date: Wed, 11 Jan 2012 09:58:20 +0000
Message-ID: <CAJSP0QXt5ZxOfh_xXPgx+Cg0xdL=DZTxcdS72F770DFRgF=t2w@mail.gmail.com>
References: <CAF3hT9Cu0BZQfrgCpBRRaPHyfSy3V-A=jJLe3qGr4UoFMcniOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:53613 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab2AKJ6V convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jan 2012 04:58:21 -0500
Received: by wibhm14 with SMTP id hm14so215304wib.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jan 2012 01:58:20 -0800 (PST)
In-Reply-To: <CAF3hT9Cu0BZQfrgCpBRRaPHyfSy3V-A=jJLe3qGr4UoFMcniOQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

On Tue, Jan 10, 2012 at 8:01 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> +static int qemu_rbd_snap_remove(BlockDriverState *bs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cons=
t char *snapshot_name)
> +{
> + =A0 =A0BDRVRBDState *s =3D bs->opaque;
> + =A0 =A0int r;
> +
> + =A0 =A0r =3D rbd_snap_remove(s->image, snapshot_name);
> + =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0error_report("failed to remove snap: %s", strerror(-=
r));
> + =A0 =A0 =A0 =A0return r;

There's no need to report an error message here.  This function should
return -errno and let the caller decide how to show the error to the
user.  If you look at callers in the codebase they already print an
equivalent error message.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
