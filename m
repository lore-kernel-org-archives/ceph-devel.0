From: Loic Dachary <loic@dachary.org>
Subject: Re: NO pg created for eruasre-coded pool
Date: Tue, 14 Oct 2014 03:11:35 -0700
Message-ID: <543CF6D7.2070204@dachary.org>
References: <11821_1413277626_543CE7BA_11821_8781_1_B9C8EFBF13B1354DB5FA000660D66DD00C18C864@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4r9QuN8w0Ibm7GX9PSTMDDlqb1pSO1WMf"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44547 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754304AbaJNKLj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 06:11:39 -0400
In-Reply-To: <11821_1413277626_543CE7BA_11821_8781_1_B9C8EFBF13B1354DB5FA000660D66DD00C18C864@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ghislain.chevalier@orange.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4r9QuN8w0Ibm7GX9PSTMDDlqb1pSO1WMf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 14/10/2014 02:07, ghislain.chevalier@orange.com wrote:
> Hi all,
>=20
> Context :
> Ceph : Firefly 0.80.6
> Sandbox Platform  : Ubuntu 12.04 LTS, 5 VM (VMware), 3 mons, 10 osd
>=20
>=20
> Issue:
> I created an erasure-coded pool using the default profile=20
> --> ceph osd pool create ecpool 128 128 erasure default
> the erasure-code rule was dynamically created and associated to the poo=
l.
> root@p-sbceph14:/etc/ceph# ceph osd crush rule dump erasure-code
> { "rule_id": 7,
>   "rule_name": "erasure-code",
>   "ruleset": 52,
>   "type": 3,
>   "min_size": 3,
>   "max_size": 20,
>   "steps": [
>         { "op": "set_chooseleaf_tries",
>           "num": 5},
>         { "op": "take",
>           "item": -1,
>           "item_name": "default"},
>         { "op": "chooseleaf_indep",
>           "num": 0,
>           "type": "host"},
>         { "op": "emit"}]}
> root@p-sbceph14:/var/log/ceph# ceph osd pool get ecpool crush_ruleset
> crush_ruleset: 52

> No error message was displayed at pool creation but no pgs were created=
=2E
> --> rados lspools confirms the pool is created but rados/ceph df shows =
no pg for this pool
>=20
> The command  "rados -p ecpool put services /etc/services" is inactive (=
stalled)
> and the following message is encountered in ceph.log
> 2014-10-14 10:36:50.189432 osd.5 10.192.134.123:6804/21505 799 : [WRN] =
slow request 960.230073 seconds old, received at 2014-10-14 10:20:49.9592=
55: osd_op(client.1192643.0:1 services [writefull 0~19281] 100.5a48a9c2 o=
ndisk+write e11869) v4 currently waiting for pg to exist locally
>=20
> I don't know if I missed something or if the problem is somewhere else.=
=2E

The erasure-code rule displayed will need at least three hosts. If there =
are not enough hosts with OSDs the mapping will fail and put will hang un=
til an OSD becomes available to complete the mapping of OSDs to the PGs. =
What does your ceph osd tree shows ?

Cheers

>=20
> Best regards=20
> =20
> =20
> =20
>=20
>=20
>=20
>=20
>=20
>=20
> _______________________________________________________________________=
__________________________________________________
>=20
> Ce message et ses pieces jointes peuvent contenir des informations conf=
identielles ou privilegiees et ne doivent donc
> pas etre diffuses, exploites ou copies sans autorisation. Si vous avez =
recu ce message par erreur, veuillez le signaler
> a l'expediteur et le detruire ainsi que les pieces jointes. Les message=
s electroniques etant susceptibles d'alteration,
> Orange decline toute responsabilite si ce message a ete altere, deforme=
 ou falsifie. Merci.
>=20
> This message and its attachments may contain confidential or privileged=
 information that may be protected by law;
> they should not be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender and =
delete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have b=
een modified, changed or falsified.
> Thank you.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--4r9QuN8w0Ibm7GX9PSTMDDlqb1pSO1WMf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQ89tcACgkQ8dLMyEl6F22jsgCfX5DlMkmXSRDE/Mh9/fNI1bNY
dGIAmwRE8B2/qcFlzUpNOxy6IoFqnjjF
=wDaB
-----END PGP SIGNATURE-----

--4r9QuN8w0Ibm7GX9PSTMDDlqb1pSO1WMf--
