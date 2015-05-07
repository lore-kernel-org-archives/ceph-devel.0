From: Loic Dachary <loic@dachary.org>
Subject: Stable releases and backports team metrics
Date: Thu, 07 May 2015 16:22:46 +0200
Message-ID: <554B7536.8040508@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7icjotjpFUeB9SBpcrPlxtQ9tiVttIwQ8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59272 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750900AbbEGOWt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 May 2015 10:22:49 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>, Abhishek L <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>, LOPEZ Jean-Charles <jelopez@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7icjotjpFUeB9SBpcrPlxtQ9tiVttIwQ8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I was curious to visualize the impact of our work as a team compared to w=
hat the situation was a few months ago, back when only Red Hat employees =
cared for backports. Here is how it was for firefly v0.80.9:

$ bash ../backports.sh tags/v0.80.8..tags/v0.80.9
Backports, by organizations
---------------------------
Red Hat <contact@redhat.com>

Backports, by backporter
------------------------
David Zafman <dzafman@redhat.com>
Greg Farnum <gfarnum@redhat.com>
Jason Dillaman <dillaman@redhat.com>
Josh Durgin <jdurgin@redhat.com>
Kefu Chai <kchai@redhat.com>
Loic Dachary <ldachary@redhat.com>
Sage Weil <sweil@redhat.com>
Yan, Zheng <zyan@redhat.com>
Yehuda Sadeh <ysadehwe@redhat.com>

and here how the upcoming v0.80.10 would look if it was to be published t=
oday (not including the content of the current firefly-backports branch).=


$ bash ../backports.sh tags/v0.80.9..ceph/firefly
Backports, by organizations
---------------------------
Intel <contact@intel.com>
Red Hat <contact@redhat.com>
Reliance Jio Infocomm Ltd. <contact@ril.com>
SUSE <contact@suse.com>

Backports, by backporter
------------------------
Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
Alfredo Deza <adeza@redhat.com>
David Zafman <dzafman@redhat.com>
Greg Farnum <gfarnum@redhat.com>
Jason Dillaman <dillaman@redhat.com>
Jean-Charles Lopez <jelopez@redhat.com>
Joao Eduardo Luis <joao@suse.de>
Loic Dachary <ldachary@redhat.com>
Sage Weil <sweil@redhat.com>
Shu, Xinxin <xinxin.shu@intel.com>
Yan, Zheng <zyan@redhat.com>
Yehuda Sadeh <ysadehwe@redhat.com>

It's nice to see more diversity :-)

Cheers

cat > backports.sh <<'EOF'
range=3D"$1"
TMP=3D/tmp/credits
echo "Backports, by organizations"
echo "---------------------------"
git log --no-merges --pretty=3D'%cN <%cE>' $range | grep -v -i jenkins | =
git -c mailmap.file=3D.organizationmap check-mailmap --stdin | sort -u
echo
echo "Backports, by backporter"
echo "------------------------"
git log --no-merges --pretty=3D'%cN <%cE>' $range | grep -v -i jenkins | =
git -c mailmap.file=3D.peoplemap check-mailmap --stdin | sort -u
echo
EOF

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--7icjotjpFUeB9SBpcrPlxtQ9tiVttIwQ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVLdTYACgkQ8dLMyEl6F234nQCgoL8mwrgDv0eNBJXYZE5ZRL5O
qssAnj50gJNwfkxfeDy5AIDBhxv9yhJW
=dEcA
-----END PGP SIGNATURE-----

--7icjotjpFUeB9SBpcrPlxtQ9tiVttIwQ8--
