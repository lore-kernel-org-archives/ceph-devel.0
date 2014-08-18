From: Loic Dachary <loic@dachary.org>
Subject: v0.84 contributors credits
Date: Mon, 18 Aug 2014 22:38:14 +0200
Message-ID: <53F26436.6010308@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="s66nScE7vAmnXIFo3Cm7S11c9JiRV4E57"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33511 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751930AbaHRUiV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Aug 2014 16:38:21 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id D76551D0001
	for <ceph-devel@vger.kernel.org>; Mon, 18 Aug 2014 22:38:14 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s66nScE7vAmnXIFo3Cm7S11c9JiRV4E57
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to v0.=
84, by number of commits or reviews back to v0.83. The affiliation of aut=
hors to organizations can be updated by submitting a patch to https://git=
hub.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the n=
umber of commits. More often than not, the reviewer(s) is only mentioned =
in the message of the merge although it means that all associated commits=
 have been reviewed. If you are curious about how it is done, the details=
 are at https://wiki.ceph.com/Community/Ceph_contributors_list_maintenanc=
e_guide .=20

Commits by authors
     1	     97 Sage Weil <sweil@redhat.com>
     2	     67 Sage Weil <sage@inktank.com>
     3	     44 John Spray <jspray@redhat.com>
     4	     36 Samuel Just <sam.just@inktank.com>
     5	     23 Greg Farnum <greg@inktank.com>
     6	     22 Josh Durgin <josh.durgin@inktank.com>
     7	     17 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
     8	     15 John Spray <john.spray@inktank.com>
     9	     13 Haomai Wang <haomaiwang@gmail.com>
    10	     12 Loic Dachary <loic@dachary.org>
    11	     12 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    12	     11 Somnath Roy <somnath.roy@sandisk.com>
    13	     10 John Wilkins <john.wilkins@inktank.com>
    14	      9 Yehuda Sadeh <ysadey@redhat.com>
    15	      8 Yan, Zheng <zheng.z.yan@intel.com>
    16	      8 Ilya Dryomov <ilya.dryomov@inktank.com>
    17	      8 Dan Mick <dan.mick@inktank.com>
    18	      6 Yehuda Sadeh <yehuda@inktank.com>
    19	      4 Wido den Hollander <wido@42on.com>
    20	      4 Thorsten Behrens <tbehrens@suse.com>
    21	      4 Matt Benjamin <matt@linuxbox.com>
    22	      4 Ma Jianpeng <jianpeng.ma@intel.com>
    23	      3 Dmitry Smirnov <onlyjob@member.fsf.org>
    24	      3 Andrey Kuznetsov <Andrey_Kuznetsov@epam.com>
    25	      2 Xiaoxi Chen <xiaoxi.chen@intel.com>
    26	      2 Sandon Van Ness <sandon@inktank.com>
    27	      2 Huamin Chen <hchen@redhat.com>
    28	      1 Sylvain Munaut <s.munaut@whatever-company.com>
    29	      1 Stephen Jahl <stephenjahl@gmail.com>
    30	      1 Sebastien Han <sebastien.han@enovance.com>
    31	      1 Luis Pab=F3n <lpabon@redhat.com>
    32	      1 Kevin Dalley <kevin@kelphead.org>
    33	      1 Kevin Cox <kevincox@kevincox.ca>
    34	      1 Jenkins <jenkins@inktank.com>
    35	      1 Guang Yang <yguang@yahoo-inc.com>
    36	      1 Federico Simoncelli <fsimonce@redhat.com>
    37	      1 Dan van der Ster <daniel.vanderster@cern.ch>
    38	      1 Alfredo Deza <alfredo.deza@inktank.com>
Commits by organizations
     1	    216 Inktank <contact@inktank.com>
     2	    154 Red Hat <contact@redhat.com>
     3	     14 Intel <contact@intel.com>
     4	     13 UnitedStack <contact@unitedstack.com>
     5	     12 Reliance Jio Infocomm Ltd. <contact@ril.com>
     6	     12 Cloudwatt <libre.licensing@cloudwatt.com>
     7	     11 SanDisk <contact@sandisk.com>
     8	      4 Wido 42on <contact@42on.com>
     9	      4 The Linux Box <contact@linuxbox.com>
    10	      4 SUSE <contact@suse.com>
    11	      3 EPAM <contact@epam.com>
    12	      3 Debian GNU/Linux <contact@debian.org>
    13	      1 Yahoo! <contact@yahoo-inc.com>
    14	      1 Whatever <contact@whatever-company.com>
    15	      1 Unaffiliated <no@organization.net>
    16	      1 MIT Computer Science and Artificial Intelligence Laborator=
y <webmaster@csail.mit.edu>
    17	      1 HGST <contact@hgst.com>
    18	      1 eNovance <contact@enovance.com>
    19	      1 CERN <contact@cern.ch>
Reviews by authors (one review spans multiple commits)
     1	     33 Sage Weil <sweil@redhat.com>
     2	     22 Greg Farnum <greg@inktank.com>
     3	     19 Samuel Just <sam.just@inktank.com>
     4	     14 Josh Durgin <josh.durgin@inktank.com>
     5	      8 Loic Dachary <loic@dachary.org>
     6	      5 Haomai Wang <haomaiwang@gmail.com>
     7	      4 Dan Mick <dan.mick@inktank.com>
     8	      3 Yehuda Sadeh <ysadey@redhat.com>
     9	      3 John Wilkins <john.wilkins@inktank.com>
    10	      3 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
    11	      2 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@cloudwatt.com>
    12	      2 Sage Weil <sage@inktank.com>
    13	      2 John Spray <jspray@redhat.com>
    14	      2 Florent Flament <florent.flament@cloudwatt.com>
    15	      1 Yehuda Sadeh <yehuda@inktank.com>
    16	      1 Alfredo Deza <alfredo.deza@inktank.com>
Reviews by organizations (one review spans multiple commits)
     1	     69 Inktank <contact@inktank.com>
     2	     38 Red Hat <contact@redhat.com>
     3	     12 Cloudwatt <libre.licensing@cloudwatt.com>
     4	      5 UnitedStack <contact@unitedstack.com

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre











--s66nScE7vAmnXIFo3Cm7S11c9JiRV4E57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPyZDYACgkQ8dLMyEl6F23PPwCbBnjkUPg59N6WK9eSn/vtXeks
oRoAnjAya0oiqLx7haglHY39Gb2exdF1
=xA71
-----END PGP SIGNATURE-----

--s66nScE7vAmnXIFo3Cm7S11c9JiRV4E57--
