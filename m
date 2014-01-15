From: Loic Dachary <loic@dachary.org>
Subject: Re: [Ceph-community] v0.75 contributors credits ( experimental)
Date: Wed, 15 Jan 2014 18:26:06 +0100
Message-ID: <52D6C4AE.704@dachary.org>
References: <52D6450E.1090605@dachary.org> <CACEfbZgrHbCFGPXkTSsO=kWZycOoZTKC_xJWpnDhqX4gw7+hHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JGjtWNQQnCMd86kG5kvAIbwnGMCIUSo2S"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:44440 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbaAOR0J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jan 2014 12:26:09 -0500
In-Reply-To: <CACEfbZgrHbCFGPXkTSsO=kWZycOoZTKC_xJWpnDhqX4gw7+hHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Woodward <xarses@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Ceph Community <ceph-community@lists.ceph.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JGjtWNQQnCMd86kG5kvAIbwnGMCIUSo2S
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 15/01/2014 16:47, Andrew Woodward wrote:
> Loic,
>=20
> Have you seen the stackalytics project that we use for OpenStack?=20
>=20
> http://www.stackalytics.com/
> https://github.com/Mirantis/stackalytics
>=20

Hi Andrew,=20

I know of stackalytics and recently updated my affiliations there ;-)=20

The purpose of this tiny script is originally to be of use to metrics.cep=
h.com : it can read from https://github.com/ceph/ceph/blob/master/.organi=
zationmap to figure out the affiliation of authors. More importantly, aut=
hors can update this information with the same path they use on a daily b=
asis to contribute to ceph itself: there is nothing to learn to fix a mis=
take or add a new affiliation. The command line is also a convenient way =
to see that the mapping works, without the need to deploy a graphical use=
r interface.

And to answer Patrick's question : what I would like to see is a count of=
 reviewers in a graphical user interface. It is important to me ( and pro=
bably others ) when I explain to my employer the nature of the work I do =
in Ceph. If reviews show on a leaderboard, it is easier to explain why it=
 is important to keep the project healthy because other developers also s=
pend time reviewing.

Cheers

>=20
>=20
> On Wed, Jan 15, 2014 at 12:21 AM, Loic Dachary <loic@dachary.org <mailt=
o:loic@dachary.org>> wrote:
>=20
>     Hi Ceph,
>=20
>     Here is a sorted list of authors and organizations who contributed =
to v0.75, by number of commits or reviews back to v0.74. The affiliation =
of authors to organizations can be updated by submitting a patch to https=
://github.com/ceph/ceph/blob/master/.organizationmap
>=20
>     If you are curious about how it is done, the details are at the end=
 of this mail.
>=20
>     Commits by authors
>          1      104 Sage Weil <sage@inktank.com <mailto:sage@inktank.co=
m>>
>          2       86 Loic Dachary <loic@dachary.org <mailto:loic@dachary=
=2Eorg>>
>          3       18 Noah Watkins <noah.watkins@inktank.com <mailto:noah=
=2Ewatkins@inktank.com>>
>          4       12 David Zafman <david.zafman@inktank.com <mailto:davi=
d.zafman@inktank.com>>
>          5        8 Josh Durgin <josh.durgin@inktank.com <mailto:josh.d=
urgin@inktank.com>>
>          6        7 John Wilkins <john.wilkins@inktank.com <mailto:john=
=2Ewilkins@inktank.com>>
>          7        6 Samuel Just <sam.just@inktank.com <mailto:sam.just@=
inktank.com>>
>          8        4 Yan, Zheng <zheng.z.yan@intel.com <mailto:zheng.z.y=
an@intel.com>>
>          9        3 Ken Dreyer <ken.dreyer@inktank.com <mailto:ken.drey=
er@inktank.com>>
>         10        2 Yehuda Sadeh <yehuda@inktank.com <mailto:yehuda@ink=
tank.com>>
>         11        2 Greg Farnum <greg@inktank.com <mailto:greg@inktank.=
com>>
>         12        2 Gary Lowell <gary.lowell@inktank.com <mailto:gary.l=
owell@inktank.com>>
>         13        2 David Moreau Simard <dmsimard@iweb.com <mailto:dmsi=
mard@iweb.com>>
>         14        2 Christophe Courtaut <christophe.courtaut@gmail.com =
<mailto:christophe.courtaut@gmail.com>>
>         15        1 Yan, Zheng <ukernel@gmail.com <mailto:ukernel@gmail=
=2Ecom>>
>         16        1 Xihui He <xihuihe@gmail.com <mailto:xihuihe@gmail.c=
om>>
>         17        1 Rutger ter Borg <rutger@terborg.net <mailto:rutger@=
terborg.net>>
>         18        1 Kun Huang <academicgareth@gmail.com <mailto:academi=
cgareth@gmail.com>>
>         19        1 Jonathan Dieter <jdieter@lesbg.com <mailto:jdieter@=
lesbg.com>>
>         20        1 Dan Mick <dan.mick@inktank.com <mailto:dan.mick@ink=
tank.com>>
>         21        1 Bj=F8rnar Ness <bjornar.ness@gmail.com <mailto:bjor=
nar.ness@gmail.com>>
>         22        1 Andreas Peters <andreas.joachim.peters@cern.ch <mai=
lto:andreas.joachim.peters@cern.ch>>
>     Commits by organizations
>          1      165 Inktank <contact@inktank.com <mailto:contact@inktan=
k.com>>
>          2       88 Cloudwatt <libre.licensing@cloudwatt.com <mailto:li=
bre.licensing@cloudwatt.com>>
>          3        4 Intel <contact@intel.com <mailto:contact@intel.com>=
>
>          4        2 IWeb <contact@iweb.com <mailto:contact@iweb.com>>
>          5        1 Yan, Zheng <ukernel@gmail.com <mailto:ukernel@gmail=
=2Ecom>>
>          6        1 Xihui He <xihuihe@gmail.com <mailto:xihuihe@gmail.c=
om>>
>          7        1 Rutger ter Borg <rutger@terborg.net <mailto:rutger@=
terborg.net>>
>          8        1 Kun Huang <academicgareth@gmail.com <mailto:academi=
cgareth@gmail.com>>
>          9        1 Jonathan Dieter <jdieter@lesbg.com <mailto:jdieter@=
lesbg.com>>
>         10        1 CERN <contact@cern.ch <mailto:contact@cern.ch>>
>         11        1 Bj=F8rnar Ness <bjornar.ness@gmail.com <mailto:bjor=
nar.ness@gmail.com>>
>     Reviews by authors
>          1       28 Sage Weil <sage@inktank.com <mailto:sage@inktank.co=
m>>
>          2        6 Loic Dachary <loic@dachary.org <mailto:loic@dachary=
=2Eorg>>
>          3        6 Josh Durgin <josh.durgin@inktank.com <mailto:josh.d=
urgin@inktank.com>>
>          4        3 Samuel Just <sam.just@inktank.com <mailto:sam.just@=
inktank.com>>
>          5        2 Yan, Zheng <zheng.z.yan@intel.com <mailto:zheng.z.y=
an@intel.com>>
>          6        2 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com <mailt=
o:joao.luis@inktank.com>>
>          7        2 Greg Farnum <greg@inktank.com <mailto:greg@inktank.=
com>>
>          8        2 Dan Mick <dan.mick@inktank.com <mailto:dan.mick@ink=
tank.com>>
>          9        1 Yehuda Sadeh <yehuda@inktank.com <mailto:yehuda@ink=
tank.com>>
>         10        1 Roald J. van Loon <roald@roaldvanloon.nl <mailto:ro=
ald@roaldvanloon.nl>>
>         11        1 Noah Watkins <noah.watkins@inktank.com <mailto:noah=
=2Ewatkins@inktank.com>>
>         12        1 David Moreau Simard <dmsimard@iweb.com <mailto:dmsi=
mard@iweb.com>>
>         13        1 Andreas Peters <andreas.joachim.peters@cern.ch <mai=
lto:andreas.joachim.peters@cern.ch>>
>     Reviews by organizations
>          1       45 Inktank <contact@inktank.com <mailto:contact@inktan=
k.com>>
>          2        6 Cloudwatt <libre.licensing@cloudwatt.com <mailto:li=
bre.licensing@cloudwatt.com>>
>          3        2 Intel <contact@intel.com <mailto:contact@intel.com>=
>
>          4        1 Roald van Loon Consultancy <roald@roaldvanloon.nl <=
mailto:roald@roaldvanloon.nl>>
>          5        1 IWeb <contact@iweb.com <mailto:contact@iweb.com>>
>          6        1 CERN <contact@cern.ch <mailto:contact@cern.ch>>
>=20
>     The script used to generate this output is (copy paste at the root =
of a git clone https://github.com/ceph/ceph.git):
>=20
>     cat > credits.sh <<'EOF'
>     previous_version=3D$1
>     next_version=3D$2
>=20
>     echo "Commits by authors"
>     git log --after $previous_version --before $next_version --pretty=3D=
'%aN <%aE>' | sort | uniq -c | sort -rn | nl
>     echo "Commits by organizations"
>     git log --after $previous_version --before $next_version --pretty=3D=
'%aN <%aE>' | git -c mailmap.file=3D.organizationmap check-mailmap --stdi=
n | sort | uniq -c | sort -rn | nl
>     echo "Reviews by authors"
>     git log --after $previous_version --before $next_version --pretty=3D=
%b | perl -n -e 'print "$_\n" if(s/^\s*Reviewed-by:\s*(.*<.*>)\s*$/\1/)' =
| git check-mailmap --stdin | sort | uniq -c | sort -rn | nl
>     echo "Reviews by organizations"
>     git log --after $previous_version --before $next_version --pretty=3D=
%b | perl -n -e 'print "$_\n" if(s/^\s*Reviewed-by:\s*(.*<.*>)\s*$/\1/)' =
| git check-mailmap --stdin | git -c mailmap.file=3D.organizationmap chec=
k-mailmap --stdin | sort | uniq -c | sort -rn | nl
>     EOF
>     v0_74=3D2013-12-30 ; v0_75=3D2014-01-14 ; bash credits.sh $v0_74 $v=
0_75
>=20
>     Authors names are normalized with .mailmap and authors affiliations=
 to a given organization comes from .organizationmap, both of which can b=
e found and patched at the root of the ceph source tree.
>=20
>     --
>     Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20
>     _______________________________________________
>     Ceph-community mailing list
>     Ceph-community@lists.ceph.com <mailto:Ceph-community@lists.ceph.com=
>
>     http://lists.ceph.com/listinfo.cgi/ceph-community-ceph.com
>=20
>=20
>=20
>=20
> --=20
> If google has done it, Google did it right!

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--JGjtWNQQnCMd86kG5kvAIbwnGMCIUSo2S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLWxK4ACgkQ8dLMyEl6F22eCgCgj/QP89ILd13gk24UXMSI5y70
JJYAniRJBI9bEIzNDX0CEoZmhGJuuBkQ
=SXQd
-----END PGP SIGNATURE-----

--JGjtWNQQnCMd86kG5kvAIbwnGMCIUSo2S--
