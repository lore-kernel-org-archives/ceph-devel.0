From: Alexey Kurnosov <alexey@kurnosov.spb.ru>
Subject: incomplete PG
Date: Fri, 6 Jun 2014 17:20:00 +0400
Message-ID: <20140606132000.GA17468@unsen.q53.spb.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 94.19.218.213.pool.sknt.ru ([94.19.218.213]:44955 "EHLO
	q53.spb.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbaFFNZO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Jun 2014 09:25:14 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all.

Sorry for a rude offtop, but looks like nobody can help me at ceph-users.
Here is the link to my email:
http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-June/040383.html
Here some additional data:
http://pastebin.com/Nc4y3S1U

During read requests i can see in logs:
2014-06-06 13:28:08.586262 7f335f29f700 10 osd.7 21942 dequeue_op 0x356cb40=
 prio 127 cost 0 latency 0.000352 osd_op(client.11324.1:436 rb.0.1465.2ae89=
44a.000000000bb1 [read 0~131072] 4.b940a077 e21942) v4 pg pg[4.77( empty lo=
cal-les=3D0 n=3D0 ec=3D144 les/c 19162/16786 21941/21941/21941) [7,2] r=3D0=
 lpr=3D21941 pi=3D8764-21940/115 mlcod 0'0 incomplete]


Any help would be appreciated.=20


(Somebody hit similar issue here: http://lists.ceph.com/pipermail/ceph-user=
s-ceph.com/2014-February/007948.html)

--
Alexey Kurnosov






--wac7ysb48OaltWcw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJTkcAAAAoJEOvtiXwvSWEqBiAH/RRs94aBBlG2aKpZqgjfEpOT
BW6lNfTFEPnU30u/te8ukHO0D+LebZgdv4OOFyQmanJeLplT+lMQmPlhgP+h9CGT
GbRmiWHKvwmW0HX9DJa7siGS8FjHk50WSF+JK6JeMoC5xZDLgeoVJ0Oy+VpH+WFt
ai5hXRMT9N5rrmplOc/Ct/ikDwj53phO9fvXqdhCoQUdKtim4CcUGY5wKnV2BOpB
g5IP8ow6m0xH+AKGGCbJoqjTd701g2lK3JRyrig5YP7fJ5P8eL05CxDpvvcgRHzv
KRjqdra97SDMEC15Z2aLJWZ4PX5b4NvgZXa4LocYg4cmd56dPgP4+4mf+LSfwXA=
=ahSd
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
