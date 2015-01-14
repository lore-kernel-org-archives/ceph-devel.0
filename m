From: Loic Dachary <loic@dachary.org>
Subject: v0.91 contributors credits
Date: Thu, 15 Jan 2015 00:28:47 +0100
Message-ID: <54B6FBAF.40500@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="dCRui6fjl2irRaXV8jnIFEdt6TiaNDt6H"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:40167 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751410AbbANX2u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jan 2015 18:28:50 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 6503042BA2
	for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 00:28:47 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dCRui6fjl2irRaXV8jnIFEdt6TiaNDt6H
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to v0.=
91, by number of commits or reviews back to v0.90. The affiliation of aut=
hors to organizations can be updated by submitting a patch to https://git=
hub.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the n=
umber of commits. More often than not, the reviewer(s) is only mentioned =
in the message of the merge although it means that all associated commits=
 have been reviewed. If you are curious about how it is done, the details=
 are at https://wiki.ceph.com/Community/Ceph_contributors_list_maintenanc=
e_guide .=20

Commits by authors
     1	    214 Sage Weil <sweil@redhat.com>
     2	     32 Yunchuan Wen <yunchuanwen@ubuntukylin.com>
     3	     31 Loic Dachary <ldachary@redhat.com>
     4	     28 Haomai Wang <haomaiwang@gmail.com>
     5	     27 Ma Jianpeng <jianpeng.ma@intel.com>
     6	     22 Yan, Zheng <zyan@redhat.com>
     7	     22 John Spray <jspray@redhat.com>
     8	     14 Nilamdyuti Goswami <ngoswami@redhat.com>
     9	     14 David Zafman <dzafman@redhat.com>
    10	     13 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    11	      9 Yehuda Sadeh <ysadehwe@redhat.com>
    12	      7 Samuel Just <sjust@redhat.com>
    13	      6 Dan Mick <dmick@redhat.com>
    14	      5 Matt Benjamin <matt@cohortfs.com>
    15	      5 Janne Grunau <j@jannau.net>
    16	      4 Wido den Hollander <wido@42on.com>
    17	      4 David Anderson <dave@natulte.net>
    18	      3 Xinze Chi <xmdxcxz@gmail.com>
    19	      3 Noah Watkins <nwatkins@redhat.com>
    20	      3 Ken Dreyer <kdreyer@redhat.com>
    21	      3 Jason Dillaman <dillaman@redhat.com>
    22	      3 Greg Farnum <gfarnum@redhat.com>
    23	      3 Dan van der Ster <daniel.vanderster@cern.ch>
    24	      2 Kefu Chai <tchaikov@gmail.com>
    25	      2 Jo=E3o Eduardo Lu=EDs <joao@redhat.com>
    26	      2 Dong Yuan <yuandong1222@gmail.com>
    27	      1 Zhiqiang Wang <zhiqiang.wang@intel.com>
    28	      1 Xiaoxi Chen <xiaoxi.chen@intel.com>
    29	      1 Warren Usui <wusui@redhat.com>
    30	      1 VRan Liu <gliuwr@gmail.com>
    31	      1 Shu, Xinxin <xinxin.shu@intel.com>
    32	      1 shishir gowda <shishir.gowda@sandisk.com>
    33	      1 Sebastien Han <sebastien.han@enovance.com>
    34	      1 Ray Lv <xiangyulv@gmail.com>
    35	      1 Patrick McGarry <pmcgarry@redhat.com>
    36	      1 Ning Yao <zay11022@gmail.com>
    37	      1 Mehdi Abaakouk <sileht@sileht.net>
    38	      1 Ilya Dryomov <idryomov@redhat.com>
    39	      1 Dongmao Zhang <deanraccoon@gmail.com>
    40	      1 Christos Stavrakakis <stavr.chris@gmail.com>
    41	      1 Chris Holcombe <chris.holcombe@nebula.com>
    42	      1 Alfredo Deza <adeza@redhat.com>
Commits by organizations
     1	    355 Red Hat <contact@redhat.com>
     2	     32 Ubuntu Kylin <contact@ubuntukylin.com>
     3	     30 UnitedStack <contact@unitedstack.com>
     4	     30 Intel <contact@intel.com>
     5	     19 Unaffiliated <no@organization.net>
     6	     13 Reliance Jio Infocomm Ltd. <contact@ril.com>
     7	      5 CohortFS, LLC <contact@cohortfs.com>
     8	      4 Wido 42on <contact@42on.com>
     9	      3 CERN <contact@cern.ch>
    10	      2 Inktank <contact@inktank.com>
    11	      1 Yahoo! <contact@yahoo-inc.com>
    12	      1 SanDisk <contact@sandisk.com>
    13	      1 Nebula <info@nebula.com>
    14	      1 eNovance <contact@enovance.com>
Reviews by authors (one review spans multiple commits)
     1	     37 Sage Weil <sweil@redhat.com>
     2	     25 Loic Dachary <ldachary@redhat.com>
     3	     18 Samuel Just <sjust@redhat.com>
     4	     11 Josh Durgin <jdurgin@redhat.com>
     5	      9 Greg Farnum <gfarnum@redhat.com>
     6	      3 Yan, Zheng <zyan@redhat.com>
     7	      3 John Wilkins <jwilkins@redhat.com>
     8	      2 John Spray <jspray@redhat.com>
     9	      2 Jo=E3o Eduardo Lu=EDs <joao@redhat.com>
    10	      1 Yehuda Sadeh <ysadehwe@redhat.com>
    11	      1 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>
    12	      1 Haomai Wang <haomaiwang@gmail.com>
    13	      1 David Zhang <david.z1003@yahoo.com>
    14	      1 David Zafman <dzafman@redhat.com>
Reviews by organizations (one review spans multiple commits)
     1	    112 Red Hat <contact@redhat.com>
     2	      1 UnitedStack <contact@unitedstack.com>
     3	      1 Unaffiliated <no@organization.net>
     4	      1 Intel <contact@intel.com>

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre















--dCRui6fjl2irRaXV8jnIFEdt6TiaNDt6H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS2+68ACgkQ8dLMyEl6F21/sQCfW3yAg5Umb7sFt/TojvzYD9wE
/xAAnjelkVWcXsa7L/A4bnaPrxmRftxY
=OZ2L
-----END PGP SIGNATURE-----

--dCRui6fjl2irRaXV8jnIFEdt6TiaNDt6H--
