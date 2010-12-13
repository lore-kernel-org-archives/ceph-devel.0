From: Vangelis Koukis <vkoukis@cslab.ece.ntua.gr>
Subject: [PATCH] Fix uninitialized pointer in
 debug.cc:dout_handle_daemonize().
Date: Mon, 13 Dec 2010 15:38:36 +0200
Message-ID: <20101213133836.GH4783@daedalus.cslab.ece.ntua.gr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o71xDhNo7p97+qVi"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ulysses.noc.ntua.gr ([147.102.222.230]:64570 "EHLO
	ulysses.noc.ntua.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932186Ab0LMNim (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Dec 2010 08:38:42 -0500
Received: from danaos.cslab.ece.ntua.gr (danaos.cslab.ece.ntua.gr [147.102.3.1])
	by ulysses.noc.ntua.gr (8.14.4/8.14.4) with ESMTP id oBDDcbsr061425
	for <ceph-devel@vger.kernel.org>; Mon, 13 Dec 2010 15:38:37 +0200 (EET)
	(envelope-from vangelis@daedalus.cslab.ece.ntua.gr)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: cven@cslab.ece.ntua.gr


--o71xDhNo7p97+qVi
Content-Type: text/plain; charset=iso-8859-7
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Starting the MDS from the unstable branch fails instantly with a
SEGFAULT. The MDS works when started in nodaemon mode, using "-D".

The segfault happens in common/debug.cc:dout_handle_daemonize(), which
attempts to call _doss->handle_stdout_closed() with _doss being NULL.

The following patch calls _dout_open_log() to initialize _doss
before accessing it.

Signed-off-by: Vangelis Koukis <vkoukis@cslab.ece.ntua.gr>
Signed-off-by: Constantinos Venetsanopoulos <cven@cslab.ece.ntua.gr>
---
 src/common/debug.cc |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/common/debug.cc b/src/common/debug.cc
index 10cd6ce..88780f0 100644
--- a/src/common/debug.cc
+++ b/src/common/debug.cc
@@ -38,6 +38,11 @@ void _dout_open_log()
 int dout_handle_daemonize()
 {
   Mutex::Locker l(_dout_lock);
+
+  if (_dout_need_open)
+       _dout_open_log();
+
+  assert(_doss);
   _doss->handle_stdout_closed();
   _doss->handle_stderr_closed();
   return _doss->handle_pid_change();
--
1.7.2.3

--=20
Vangelis Koukis
vkoukis@cslab.ece.ntua.gr
OpenPGP public key ID:
pub  1024D/1D038E97 2003-07-13 Vangelis Koukis <vkoukis@cslab.ece.ntua.gr>
     Key fingerprint =3D C5CD E02E 2C78 7C10 8A00  53D8 FBFC 3799 1D03 8E97

Our greatest glory is not in never failing,
but in rising up every time we fail.
        -- Ralph Waldo Emerson

--o71xDhNo7p97+qVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0GIdwACgkQ+/w3mR0DjpfzvQCg+uSs9QhOXKnDeIlMfBsXQY6C
osEAn2i/HlLopWasTv+g/0lFMzJkWX5Z
=moAt
-----END PGP SIGNATURE-----

--o71xDhNo7p97+qVi--
