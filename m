From: Loic Dachary <loic@dachary.org>
Subject: Re: creating the issue for the v0.94.4 release
Date: Sat, 15 Aug 2015 22:15:21 +0200
Message-ID: <55CF9DD9.9020000@dachary.org>
References: <55CF14CB.1040900@dachary.org>	<CAP3mxSyGkYz6vfbE4sNkV2K6iS4waBrptQ+Vnfprqc75Uc2CHg@mail.gmail.com>	<55CF6607.8010808@dachary.org> <CAP3mxSyqMCicjzPGo119j5krgr74NnN1cp9D1mswdg=FLGqD_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wlJKtnjrKV6fBPqNCaUlhQaNVfdVN87Rc"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38644 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753332AbbHOUPe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Aug 2015 16:15:34 -0400
In-Reply-To: <CAP3mxSyqMCicjzPGo119j5krgr74NnN1cp9D1mswdg=FLGqD_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wlJKtnjrKV6fBPqNCaUlhQaNVfdVN87Rc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 15/08/2015 19:54, Abhishek Varshney wrote:
> Done ! Let me know if it is fine.

Perfect ! I have run the commands for you and the corresponding suite can=
 be seen at http://pulpito.ceph.com/. We usually add a link to each h4. w=
ith something like:

   * *running* http://pulpito.ceph.com/loic-2015-08-15_22:00:55-rados-ham=
mer-backports---basic-multi

etc. I expect teuthology will do something similar eventually but right n=
ow we have to do that manually.

As much as I like to be your command line proxy, things will be easier if=
 you can run those yourself in the future ;-) I opened an issue to that e=
nd at http://tracker.ceph.com/issues/12705. The staff in charge of the se=
pia lab is extremely busy and it may take a few weeks before you actually=
 have access.=20

Cheers

>=20
> Thanks
> Abhishek
>=20
> On Sat, Aug 15, 2015 at 9:47 PM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>=20
>=20
>     On 15/08/2015 17:49, Abhishek Varshney wrote:> Hi Loic,
>     >
>     > Thanks for the detailed explanation. I have created an issue to k=
eep track of hammer v0.94.4 release here : http://tracker.ceph.com/issues=
/12701.  I guess the HOWTO page (http://tracker.ceph.com/projects/ceph-re=
leases/wiki/HOWTO) would be updated with this tracker issue once v0.94.3 =
is released? Please correct me if I am wrong.
>=20
>     You are correct.
>=20
>     Could you also update the header http://tracker.ceph.com/issues/127=
01#teuthology-run-commit to mimic http://tracker.ceph.com/issues/11990#te=
uthology-run-commit-1e841b08cc9534e654de50967f06113fb7383b0chammer-backpo=
rts-July-20 ? It should be
>=20
>     .h3 teuthology run commit e1dadd3da9e39daf669f94715c7833d2b280bbed
>     (hammer backports August-14)
>=20
>     Because $ git rev-parse ceph/hammer-backports
>     e1dadd3da9e39daf669f94715c7833d2b280bbed
>=20
>     which is the branch you populated and that was compiled by http://c=
eph.com/gitbuilder.cgi.
>=20
>     The content of this h3. section should the the output of the comman=
d
>=20
>     git --no-pager log --format=3D'%H %s' --graph ceph/hammer..ceph/ham=
mer-backports | perl -p -e 's/"/ /g; if (/\w+\s+Merge (\d+)/) { s|\w+\s+M=
erge (\d+).*|"Pull request $1":https://github.com/ceph/ceph/pull/$1|; } e=
lse { s|(\w+)\s+(.*)|"$2":https://github.com/ceph/ceph/commit/$1|; } s/\*=
/+/; s/^/* /;'
>=20
>     it starts with:
>=20
>     * +   "Pull request 5202":https://github.com/ceph/ceph/pull/5202
>     * |\
>     * | + "rpm: add missing Java conditionals":https://github.com/ceph/=
ceph/commit/6417e8eff942dbbf6cd231ffb73136b7bdcd837f
>     * +   "Pull request 5203":https://github.com/ceph/ceph/pull/5203
>     * |\
>     * | + "Add rpm conditionals : cephfs_java":https://github.com/ceph/=
ceph/commit/37284773a754ef4b91d2b5436d46a5fd2be4f67e
>     * +   "Pull request 5204":https://github.com/ceph/ceph/pull/5204
>     ...
>=20
>     and should render nicely.
>=20
>     This should then be followed by h4. section, one per test suite we =
are going to run.
>=20
>     h4. rbd
>=20
>     <pre>
>     ./virtualenv/bin/teuthology-suite --priority 1000 --suite rbd --sub=
set $(expr $RANDOM % 5)/5 --suite-branch hammer --distro ubuntu --email l=
oic@dachary.org <mailto:loic@dachary.org> --ceph hammer-backports --machi=
ne-type plana,burnupi,mira
>     </pre>
>=20
>     etc.
>=20
>     Once this is done, I will copy paste the command to actually schedu=
le the test. And then we'll have to wait a few days for it to complete.
>=20
>     Cheers
>=20
>     >
>     > Regards
>     > Abhishek Varshney
>     >
>     > On Sat, Aug 15, 2015 at 4:00 PM, Loic Dachary <loic@dachary.org <=
mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachary.or=
g>>> wrote:
>     >
>     >     Hi Abhishek,
>     >
>     >     I'll be driving the next hammer point release (v0.94.4) and t=
heanalyst will participate as I did for v0.94.3 (i.e. helping and mentori=
ng when there is a need). During the v0.94.4 release you will have the op=
portunity to participate in all the steps. When we move to v0.94.5 you'll=
 hopefully know all you need to drive it, should you want to. As you disc=
overed over the past few weeks, it's not a complex process, but there are=
 a lot of details.
>     >
>     >     Contrary to what I told you the other day
>     >
>     >     http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_sta=
rt_backporting_a_stable_release/diff?utf8=3D%E2%9C%93&version=3D7&version=
_from=3D6&commit=3DView+differences
>     >
>     >     is not the documentation you need to create a new ticket for =
v0.94.4 and I removed this chapter to avoid further confusion. There is a=
 more detailed explanation at:
>     >
>     >     http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_sta=
rt_working_on_a_new_point_release
>     >
>     >     A section was added as a reminder that someone has to volunte=
er to drive the release.
>     >
>     >     http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_sta=
rt_working_on_a_new_point_release/diff?utf8=3D%E2%9C%93&version=3D9&versi=
on_from=3D8&commit=3DView+differences
>     >
>     >     Let me know if you need anything else to create the issue vor=
 v0.94.4.
>     >
>     >     Cheers
>     >     --
>     >     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>     >
>     >
>     >
>     > -----------------------------------------------------------------=
-------------------------------------------------------------------------=

>     >
>     > This email and any files transmitted with it are confidential and=
 intended solely for the use of the individual or entity to whom they are=
 addressed. If you have received this email in error please notify the sy=
stem manager. This message contains confidential information and is inten=
ded only for the individual named. If you are not the named addressee you=
 should not disseminate, distribute or copy this e-mail. Please notify th=
e sender immediately by e-mail if you have received this e-mail by mistak=
e and delete this e-mail from your system. If you are not the intended re=
cipient you are notified that disclosing, copying, distributing or taking=
 any action in reliance on the contents of this information is strictly p=
rohibited. Although Flipkart has taken reasonable precautions to ensure n=
o viruses are present in this email, the company cannot accept responsibi=
lity for any loss or damage arising from the use of this email or attachm=
ents
>     >
>=20
>     --
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-------------------------------------------------------------------
>=20
> This email and any files transmitted with it are confidential and inten=
ded solely for the use of the individual or entity to whom they are addre=
ssed. If you have received this email in error please notify the system m=
anager. This message contains confidential information and is intended on=
ly for the individual named. If you are not the named addressee you shoul=
d not disseminate, distribute or copy this e-mail. Please notify the send=
er immediately by e-mail if you have received this e-mail by mistake and =
delete this e-mail from your system. If you are not the intended recipien=
t you are notified that disclosing, copying, distributing or taking any a=
ction in reliance on the contents of this information is strictly prohibi=
ted. Although Flipkart has taken reasonable precautions to ensure no viru=
ses are present in this email, the company cannot accept responsibility f=
or any loss or damage arising from the use of this email or attachments
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--wlJKtnjrKV6fBPqNCaUlhQaNVfdVN87Rc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXPndkACgkQ8dLMyEl6F22ROQCeOfwuK/oSrTd5NeL1VDDSR/8z
yFQAniYSkRjyqvY3hhepmF8s143KLt2B
=udC6
-----END PGP SIGNATURE-----

--wlJKtnjrKV6fBPqNCaUlhQaNVfdVN87Rc--
