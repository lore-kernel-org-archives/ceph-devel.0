From: Loic Dachary <loic@dachary.org>
Subject: v0.80 contributors credits
Date: Wed, 07 May 2014 10:41:37 +0200
Message-ID: <5369F1C1.8030207@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6iVH4gH979Cdgw3FmFwuHBVDmp6GvGFQC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:57278 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577AbaEGIlk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 May 2014 04:41:40 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id DCC734210B
	for <ceph-devel@vger.kernel.org>; Wed,  7 May 2014 10:41:37 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6iVH4gH979Cdgw3FmFwuHBVDmp6GvGFQC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to v0.=
80, by number of commits or reviews back to v0.79. The affiliation of aut=
hors to organizations can be updated by submitting a patch to https://git=
hub.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the n=
umber of commits. More often than not, the reviewer(s) is only mentioned =
in the message of the merge although it means that all associated commits=
 have been reviewed.=20

If you are curious about how it is done, the details are at the end of th=
is mail.=20

Commits by authors
     1	    114 Sage Weil <sage@inktank.com>
     2	     75 Samuel Just <sam.just@inktank.com>
     3	     34 Yan, Zheng <zheng.z.yan@intel.com>
     4	     29 Greg Farnum <greg@inktank.com>
     5	     25 David Zafman <david.zafman@inktank.com>
     6	     21 Josh Durgin <josh.durgin@inktank.com>
     7	     11 Loic Dachary <loic@dachary.org>
     8	      7 Yehuda Sadeh <yehuda@inktank.com>
     9	      5 John Wilkins <john.wilkins@inktank.com>
    10	      5 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
    11	      5 Babu Shanmugam <anbu@enovance.com>
    12	      4 Warren Usui <warren.usui@inktank.com>
    13	      3 John Spray <john.spray@inktank.com>
    14	      2 Jenkins <jenkins@inktank.com>
    15	      2 Guang Yang <yguang@yahoo-inc.com>
    16	      2 Dan Mick <dan.mick@inktank.com>
    17	      1 Wido den Hollander <wido@42on.com>
    18	      1 Florent Bautista <florent@coppint.com>
    19	      1 Dmitry Smirnov <onlyjob@member.fsf.org>
    20	      1 Alfredo Deza <alfredo.deza@inktank.com>
Commits by organizations
     1	    293 Inktank <contact@inktank.com>
     2	     34 Intel <contact@intel.com>
     3	     11 Cloudwatt <libre.licensing@cloudwatt.com>
     4	      5 eNovance <contact@enovance.com>
     5	      2 Yahoo! <contact@yahoo-inc.com>
     6	      1 Wido 42on <contact@42on.com>
     7	      1 Unaffiliated <no@organization.net>
     8	      1 Debian GNU/Linux <contact@debian.org>
Reviews by authors (one review spans multiple commits)
     1	     44 Sage Weil <sage@inktank.com>
     2	     21 Samuel Just <sam.just@inktank.com>
     3	     11 Josh Durgin <josh.durgin@inktank.com>
     4	      9 Greg Farnum <greg@inktank.com>
     5	      4 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
     6	      3 Yehuda Sadeh <yehuda@inktank.com>
     7	      2 Mark Nelson <mark.nelson@inktank.com>
     8	      1 Yan, Zheng <zheng.z.yan@intel.com>
     9	      1 Nikola Kotur <kotnick@gmail.com>
    10	      1 David Zafman <david.zafman@inktank.com>
    11	      1 Christophe Courtaut <christophe.courtaut@gmail.com>
    12	      1 Alfredo Deza <alfredo.deza@inktank.com>
Reviews by organizations (one review spans multiple commits)
     1	     96 Inktank <contact@inktank.com>
     2	      1 Intel <contact@intel.com>
     3	      1 Commerce Guys <contact@commerceguys.com>
     4	      1 Cloudwatt <libre.licensing@cloudwatt.com>

The script used to generate this output is (copy paste at the root of a g=
it clone https://github.com/ceph/ceph.git):

cat > credits.sh <<'EOF'
range=3D$1
echo "Commits by authors"
git log --pretty=3D'%aN <%aE>' $range | sort | uniq -c | sort -rn | nl
echo "Commits by organizations"
git log --pretty=3D'%aN <%aE>' $range | git -c mailmap.file=3D.organizati=
onmap check-mailmap --stdin | sort | uniq -c | sort -rn | nl
echo "Reviews by authors (one review spans multiple commits)"
git log --pretty=3D%b $range | perl -n -e 'print "$_\n" if(s/^\s*Reviewed=
-by:\s*(.*<.*>)\s*$/\1/)' | git check-mailmap --stdin | sort | uniq -c | =
sort -rn | nl
echo "Reviews by organizations (one review spans multiple commits)"
git log --pretty=3D%b $range | perl -n -e 'print "$_\n" if(s/^\s*Reviewed=
-by:\s*(.*<.*>)\s*$/\1/)' | git check-mailmap --stdin | git -c mailmap.fi=
le=3D.organizationmap check-mailmap --stdin | sort | uniq -c | sort -rn |=
 nl
EOF
bash credits.sh tags/v0.79...tags/v0.80

Authors names are normalized with .mailmap and authors affiliations to a =
given organization comes from .organizationmap, both of which can be foun=
d and patched at the root of the ceph source tree.

More sophisticated reports can be generated and visualized by tools such =
as http://bitergia.com/ or http://stackalytics.com/.=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--6iVH4gH979Cdgw3FmFwuHBVDmp6GvGFQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNp8cEACgkQ8dLMyEl6F22HzgCfYEamxUJSSkRkaQ/6vLMxniJK
EvAAn2brGoKBLZf/Z9emcVMpnVpaefhQ
=jRv1
-----END PGP SIGNATURE-----

--6iVH4gH979Cdgw3FmFwuHBVDmp6GvGFQC--
