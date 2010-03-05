From: Robert Collins <robertc@robertcollins.net>
Subject: Use dkms ?
Date: Fri, 05 Mar 2010 16:50:44 +1100
Message-ID: <1267768245.3098.41.camel@lifeless-64>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8674980139829212862=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org


--===============8674980139829212862==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-BcZFkAqiLZ9MnJOJaWWN"


--=-BcZFkAqiLZ9MnJOJaWWN
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Content-Transfer-Encoding: quoted-printable

http://ceph.newdream.net/wiki/Debian talks about manually building
modules. There is a thing called 'dkms' which automatically builds
modules when an out-of-tree module package is installed, and rebuilds
them when new kernel versions are installed.=20

It would be great to have the ceph-kclient-source make use of this.

dkms is in unstable and testing, and in Ubuntu since hardy - so it
should be present on all Debian derived platforms with a new enough
kernel to use ceph anyway.

This is just a heads up, as many folk don't seem to have heard of dkms,
and it really is very nice.

$ apt-cache show dkms
...
Description: Dynamic Kernel Module Support Framework
 DKMS is a framework designed to allow individual kernel modules to be
upgraded
 without changing the whole kernel. It is also very easy to rebuild
modules as
 you upgrade kernels.
Homepage: http://linux.dell.com/dkms


Cheers,
Rob

--=-BcZFkAqiLZ9MnJOJaWWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuQm7QACgkQhnv5qfvT644DFACgmumz/MB1njWFgfZGGnUgsBYJ
rkEAn3+r8fyec8p9HpTU4hUBf4BVkWK7
=BGEy
-----END PGP SIGNATURE-----

--=-BcZFkAqiLZ9MnJOJaWWN--



--===============8674980139829212862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============8674980139829212862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============8674980139829212862==--
