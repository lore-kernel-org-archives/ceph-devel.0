From: Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org>
Subject: v13.2.4 Mimic released
Date: Mon, 07 Jan 2019 11:37:05 +0100
Message-ID: <87pnt83ga6.fsf@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2100813826019842651=="
Return-path: <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-announce-ceph.com>,
 <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-announce-ceph.com/>
List-Post: <mailto:ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-announce-ceph.com>,
 <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "Ceph-announce" <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-maintainers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============2100813826019842651==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


This is the fourth bugfix release of the Mimic v13.2.x long term stable
release series. This release includes two security fixes atop of v13.2.3
We recommend all users upgrade to this version. If you've already
upgraded to v13.2.3, the same restrictions from v13.2.2->v13.2.3 apply
here as well.

Notable Changes
=2D--------------

* CVE-2018-16846: rgw: enforce bounds on max-keys/max-uploads/max-parts (`i=
ssue#35994 <http://tracker.ceph.com/issues/35994>`_)
* CVE-2018-14662: mon: limit caps allowed to access the config store

Notable Changes in v13.2.3
=2D--------------------------

* The default memory utilization for the mons has been increased
  somewhat.  Rocksdb now uses 512 MB of RAM by default, which should
  be sufficient for small to medium-sized clusters; large clusters
  should tune this up.  Also, the `mon_osd_cache_size` has been
  increase from 10 OSDMaps to 500, which will translate to an
  additional 500 MB to 1 GB of RAM for large clusters, and much less
  for small clusters.

* Ceph v13.2.2 includes a wrong backport, which may cause mds to go into
  'damaged' state when upgrading Ceph cluster from previous version.
  The bug is fixed in v13.2.3. If you are already running v13.2.2,
  upgrading to v13.2.3 does not require special action.

* The bluestore_cache_* options are no longer needed. They are replaced
  by osd_memory_target, defaulting to 4GB. BlueStore will expand
  and contract its cache to attempt to stay within this
  limit. Users upgrading should note this is a higher default
  than the previous bluestore_cache_size of 1GB, so OSDs using
  BlueStore will use more memory by default.
  For more details, see the `BlueStore docs <http://docs.ceph.com/docs/mimi=
c/rados/configuration/bluestore-config-ref/#automatic-cache-sizing>`_.

* This version contains an upgrade bug, http://tracker.ceph.com/issues/3668=
6,
  due to which upgrading during recovery/backfill can cause OSDs to fail. T=
his
  bug can be worked around, either by restarting all the OSDs after the upg=
rade,
  or by upgrading when all PGs are in "active+clean" state. If you have alr=
eady
  successfully upgraded to 13.2.2, this issue should not impact you. Going
  forward, we are working on a clean upgrade path for this feature.


For more details please refer to the release blog at
https://ceph.com/releases/13-2-4-mimic-released/

Getting ceph
* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-13.2.4.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* Release git sha1: b10be4d44915a4d78a8e06aa31919e74927b142e

=2D-=20
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton,
HRB 21284 (AG N=C3=BCrnberg)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEac9IOI7jdGxe1B8W+fBkHxtl7V8FAlwzK9EACgkQ+fBkHxtl
7V9Q6gf8Dxds5fdEad3RtK5zDqa9H97fCpGoupv0sInOopJNT2VZcvGFHB6N+viq
Vv8p+AII2J/juJ1rzbrlYzpP+BZbra4Q/5F9KPXz0gd0Cc0gJM8QlbgOhJVSaQZJ
k1rs7UzNF595UCHKRxnrg/VV4gndV/qzw0d1rNRYM1eRQDA8ezNQIVv9IQ6HMYS8
+2qolkUGgqLNAoKW6sIZNfqJC0igd7PHrXYR2R4EV8LPLwbgLHKk+DamZvCBAFP3
lteqygq90p7XCqegIFU10hAXWAF3Juk2ySxQAdQYodCR0Yw3MWtTsTZzoxZ6B7MG
yM5HEd8W/vBdIAgKaeYphmcfsjMIBQ==
=jjrW
-----END PGP SIGNATURE-----
--=-=-=--

--===============2100813826019842651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-announce mailing list
Ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-announce-ceph.com

--===============2100813826019842651==--
