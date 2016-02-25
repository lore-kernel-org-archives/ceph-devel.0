From: Loic Dachary <loic@dachary.org>
Subject: Re: vstart and Python bindings
Date: Thu, 25 Feb 2016 14:04:13 +0700
Message-ID: <56CEA76D.9040200@dachary.org>
References: <20160224233718.6a8c7569@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:41065 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757967AbcBYHEX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Feb 2016 02:04:23 -0500
In-Reply-To: <20160224233718.6a8c7569@lembas.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>, ceph-devel@vger.kernel.org

Hi Pete,

You need https://github.com/ceph/ceph/pull/7792 which is going to be me=
rged real soon now ;-)

Cheers

On 25/02/2016 13:37, Pete Zaitcev wrote:
> I did a git pull today and rebuilt. Ran vstart, and it produced a
> Python traceback, ending with:
>=20
> ImportError: No module named rados
>=20
> Oooookay... This box never had Python bindings installed, but okay,
> someone innovated something. Fine, I thought. Installed python-rados,
> and ./ceph -w tracebacks:
>=20
> Traceback (most recent call last):
>   File "./ceph", line 953, in <module>
>     retval =3D main()
>   File "./ceph", line 778, in main
>     run_in_thread(cluster_handle.monitor_log, level, watch_cb, 0)
> AttributeError: 'Rados' object has no attribute 'monitor_log'
>=20
> Of course. The system version of pybind is obsolete, but ./ceph gets
> wrong one. Actually, it's not even getting built from .pyx anymore.
>=20
> Could whoever did all this please undo?
>=20
> -- Pete
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
