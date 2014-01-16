From: Loic Dachary <loic@dachary.org>
Subject: Re: v0.75 contributors credits ( experimental) (take 2)
Date: Thu, 16 Jan 2014 09:07:50 +0100
Message-ID: <52D79356.20604@dachary.org>
References: <52D715D9.9010907@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="w05GLXCoAoDhnI6xb6F9lx467b2UkODCm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:45044 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbaAPIH6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jan 2014 03:07:58 -0500
In-Reply-To: <52D715D9.9010907@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Ceph Community <ceph-community@lists.ceph.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w05GLXCoAoDhnI6xb6F9lx467b2UkODCm
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

There are significant differences from the previous mail. For instance Da=
mien Simard does not show anymore although a patch from him was merged in=
 master January 3rd. When publishing a release, some patches are picked a=
nd others are left in master. The previous method listed all refs from ma=
ster in a range of dates and therefore did not account for this. The curr=
ent method compares the refs from one release tag to another and is accur=
ate.

That does not mean there are no other errors, but I think we got the diff=
erence between releases right this time ;-)

Cheers

On 16/01/2014 00:12, Loic Dachary wrote:
> [Amended after comments from Noah Watkins, Patrick McGarry, Andrew Wood=
ward, Ian Colle, Robin H. Johnson]=20
>=20
> Hi Ceph,
>=20
> Here is a sorted list of authors and organizations who contributed to v=
0.75, by number of commits or reviews back to v0.74. The affiliation of a=
uthors to organizations can be updated by submitting a patch to https://g=
ithub.com/ceph/ceph/blob/master/.organizationmap
>=20
> All commits are reviewed but the number of reviews is a fraction of the=
 number of commits. The reviewer(s) is only mentioned in the message of t=
he merge although it means that all associated commits have been reviewed=
=2E=20
>=20
> If you are curious about how it is done, the details are at the end of =
this mail.=20
>=20
> Commits by authors
>      1	    259 Sage Weil <sage@inktank.com>
>      2	     80 Loic Dachary <loic@dachary.org>
>      3	     39 Greg Farnum <greg@inktank.com>
>      4	     38 Yan, Zheng <zheng.z.yan@intel.com>
>      5	     30 Noah Watkins <noah.watkins@inktank.com>
>      6	     23 Yehuda Sadeh <yehuda@inktank.com>
>      7	     15 Ilya Dryomov <ilya.dryomov@inktank.com>
>      8	     14 Josh Durgin <josh.durgin@inktank.com>
>      9	     14 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
>     10	      8 Haomai Wang <haomaiwang@gmail.com>
>     11	      4 Alfredo Deza <alfredo.deza@inktank.com>
>     12	      3 Robin H. Johnson <robbat2@gentoo.org>
>     13	      3 David Zafman <david.zafman@inktank.com>
>     14	      3 Alexandre Oliva <oliva@gnu.org>
>     15	      2 Tamil Muthamizhan <tamil.muthamizhan@inktank.com>
>     16	      2 John Wilkins <john.wilkins@inktank.com>
>     17	      2 Andreas Peters <andreas.joachim.peters@cern.ch>
>     18	      1 Xihui He <xihuihe@gmail.com>
>     19	      1 Wido den Hollander <wido@42on.com>
>     20	      1 Thomas Bechtold <thomasbechtold@jpberlin.de>
>     21	      1 Steve Stock <steve@technolope.org>
>     22	      1 Sebastien Han <sebastien.han@enovance.com>
>     23	      1 Rutger ter Borg <rutger@terborg.net>
>     24	      1 Laurent Barbe <laurent@ksperis.com>
>     25	      1 Ken Dreyer <ken.dreyer@inktank.com>
>     26	      1 Kai Zhang <zakir.exe@gmail.com>
>     27	      1 Gary Lowell <gary.lowell@inktank.com>
>     28	      1 Dan van der Ster <daniel.vanderster@cern.ch>
>     29	      1 Christophe Courtaut <christophe.courtaut@gmail.com>
>     30	      1 Christian Marie <pingu@anchor.net.au>
>     31	      1 Bj=F8rnar Ness <bjornar.ness@gmail.com>
> Commits by organizations
>      1	    407 Inktank <contact@inktank.com>
>      2	     81 Cloudwatt <libre.licensing@cloudwatt.com>
>      3	     38 Intel <contact@intel.com>
>      4	      8 UnitedStack <contact@unitedstack.com>
>      5	      3 GNU <contact@gnu.org>
>      6	      3 Gentoo <contact@gentoo.org>
>      7	      3 CERN <contact@cern.ch>
>      8	      1 Xihui He <xihuihe@gmail.com>
>      9	      1 Wido 42on <contact@42on.com>
>     10	      1 Thomas Bechtold <thomasbechtold@jpberlin.de>
>     11	      1 Steve Stock <steve@technolope.org>
>     12	      1 Rutger ter Borg <rutger@terborg.net>
>     13	      1 Laurent Barbe <laurent@ksperis.com>
>     14	      1 Kai Zhang <zakir.exe@gmail.com>
>     15	      1 eNovance <contact@enovance.com>
>     16	      1 Christian Marie <pingu@anchor.net.au>
>     17	      1 Bj=F8rnar Ness <bjornar.ness@gmail.com>
> Reviews by authors (one review spans multiple commits)
>      1	     54 Sage Weil <sage@inktank.com>
>      2	     14 Greg Farnum <greg@inktank.com>
>      3	     11 Loic Dachary <loic@dachary.org>
>      4	      7 Josh Durgin <josh.durgin@inktank.com>
>      5	      6 Samuel Just <sam.just@inktank.com>
>      6	      6 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
>      7	      3 Christophe Courtaut <christophe.courtaut@gmail.com>
>      8	      2 Yehuda Sadeh <yehuda@inktank.com>
>      9	      1 Andreas Peters <andreas.joachim.peters@cern.ch>
> Reviews by organizations (one review spans multiple commits)
>      1	     89 Inktank <contact@inktank.com>
>      2	     14 Cloudwatt <libre.licensing@cloudwatt.com>
>      3	      1 CERN <contact@cern.ch>
>=20
> The script used to generate this output is (copy paste at the root of a=
 git clone https://github.com/ceph/ceph.git):
>=20
> cat > credits.sh <<'EOF'
> range=3D$1
> echo "Commits by authors"
> git log --pretty=3D'%aN <%aE>' $range | sort | uniq -c | sort -rn | nl
> echo "Commits by organizations"
> git log --pretty=3D'%aN <%aE>' $range | git -c mailmap.file=3D.organiza=
tionmap check-mailmap --stdin | sort | uniq -c | sort -rn | nl
> echo "Reviews by authors (one review spans multiple commits)"
> git log --pretty=3D%b $range | perl -n -e 'print "$_\n" if(s/^\s*Review=
ed-by:\s*(.*<.*>)\s*$/\1/)' | git check-mailmap --stdin | sort | uniq -c =
| sort -rn | nl
> echo "Reviews by organizations (one review spans multiple commits)"
> git log --pretty=3D%b $range | perl -n -e 'print "$_\n" if(s/^\s*Review=
ed-by:\s*(.*<.*>)\s*$/\1/)' | git check-mailmap --stdin | git -c mailmap.=
file=3D.organizationmap check-mailmap --stdin | sort | uniq -c | sort -rn=
 | nl
> EOF
> bash credits.sh tags/v0.74...tags/v0.75
>=20
> Authors names are normalized with .mailmap and authors affiliations to =
a given organization comes from .organizationmap, both of which can be fo=
und and patched at the root of the ceph source tree.
>=20
> More sophisticated reports can be generated and visualized by tools suc=
h as http://bitergia.com/ or http://stackalytics.com/.=20
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--w05GLXCoAoDhnI6xb6F9lx467b2UkODCm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLXk1YACgkQ8dLMyEl6F236JACgofNWdfFiKqXtaaDoK7u5i71L
mBMAoJSaeK3TUaVEbfcLLc/4T8Ia2MNB
=RVjZ
-----END PGP SIGNATURE-----

--w05GLXCoAoDhnI6xb6F9lx467b2UkODCm--
