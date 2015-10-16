From: Loic Dachary <loic@dachary.org>
Subject: Re: osd activation under 9.1.0
Date: Fri, 16 Oct 2015 23:18:12 +0200
Message-ID: <56216994.60303@dachary.org>
References: <BC97738F8E7C8742BABED7F06FB9DF9192524D2B@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fwi3QlkVUMILm4Ern55A9JuUfW80Kddtr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44812 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750711AbbJPVSQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Oct 2015 17:18:16 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9192524D2B@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fwi3QlkVUMILm4Ern55A9JuUfW80Kddtr
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 16/10/2015 23:09, Deneau, Tom wrote:
> Using 9.1.0 I am getting the error shown below at ceph-deploy osd activ=
ate time.
>=20
> + ceph-deploy --overwrite-conf osd activate Intel-2P-Sandy-Bridge-04:/v=
ar/local//dev/sdf2:/dev/sdf1

Is:

/var/local//dev/sdf2

intentional ? Note that ceph now runs as ceph, not as root.

Cheers

> ...
> [][WARNIN] INFO:ceph-disk:Running command: /usr/bin/ceph-osd --cluster =
ceph --mkfs --mkkey -i 4 --monmap /var/local/\
> /dev/sdf2/activate.monmap --osd-data /var/local//dev/sdf2 --osd-journal=
 /var/local//dev/sdf2/journal --osd-uuid 204865df-8dbf-4f26-91f2-5dfa7c3a=
49f8 --keyring /var/local//dev/sdf2/keyring --setuser ceph --setgroup cep=
h
> [][WARNIN] 2015-10-16 13:13:41.464615 7f3f40642940 -1 filestore(/var/lo=
cal//dev/sdf2) mkjournal error creating journ\
> al on /var/local//dev/sdf2/journal: (13) Permission denied
> [][WARNIN] 2015-10-16 13:13:41.464635 7f3f40642940 -1 OSD::mkfs: Object=
Store::mkfs failed with error -13
> [][WARNIN] 2015-10-16 13:13:41.464669 7f3f40642940 -1  ** ERROR: error =
creating empty object store in /var/local//de\
> v/sdf2: (13) Permission denied
> [][WARNIN] Traceback (most recent call last):
> [][WARNIN]   File "/usr/sbin/ceph-disk", line 3576, in <module>
> [][WARNIN]     main(sys.argv[1:])
> [][WARNIN]   File "/usr/sbin/ceph-disk", line 3530, in main
> [][WARNIN]     args.func(args)
> [][WARNIN]   File "/usr/sbin/ceph-disk", line 2432, in main_activate
> [][WARNIN]     init=3Dargs.mark_init,
> [][WARNIN]   File "/usr/sbin/ceph-disk", line 2258, in activate_dir
> [][WARNIN]     (osd_id, cluster) =3D activate(path, activate_key_templa=
te, init)
> [][WARNIN]   File "/usr/sbin/ceph-disk", line 2360, in activate
> [][WARNIN]     keyring=3Dkeyring,
> [][WARNIN]   File "/usr/sbin/ceph-disk", line 1950, in mkfs
> [][WARNIN]     '--setgroup', get_ceph_user(),
> [][WARNIN]   File "/usr/sbin/ceph-disk", line 349, in command_check_cal=
l
> [][WARNIN]     return subprocess.check_call(arguments)
> [][WARNIN]   File "/usr/lib/python2.7/subprocess.py", line 540, in chec=
k_call
> [][WARNIN]     raise CalledProcessError(retcode, cmd)
> [][WARNIN] subprocess.CalledProcessError: Command '['/usr/bin/ceph-osd'=
, '--cluster', 'ceph', '--mkfs', '--mkkey', '
> -i', '4', '--monmap', '/var/local//dev/sdf2/activate.monmap', '--osd-da=
ta', '/var/local//dev/sdf2', '--osd-journal', '/var/local//dev/sdf2/journ=
al', '--osd-uuid', '204865df-8dbf-4f26-91f2-5dfa7c3a49f8', '--keyring', '=
/var/local//dev/sdf2/keyring', '--setuser', 'ceph', '--setgroup\
> ', 'ceph']' returned non-zero exit status 1
> [][ERROR ] RuntimeError: command returned non-zero exit status: 1
> [ceph_deploy][ERROR ] RuntimeError: Failed to execute command: ceph-dis=
k -v activate --mark-init upstart --mount /var/local//dev/sdf2
>=20
> When I look at the data disk, I see the following. =20
>=20
>   -rw-r--r-- 1 root ceph   210 Oct 16 13:13 activate.monmap
>   -rw-r--r-- 1 ceph ceph    37 Oct 16 13:13 ceph_fsid
>   drwxr-sr-x 3 ceph ceph  4096 Oct 16 13:13 current
>   -rw-r--r-- 1 ceph ceph    37 Oct 16 13:13 fsid
>   lrwxrwxrwx 1 root ceph     9 Oct 16 13:13 journal -> /dev/sdf1
>   -rw-r--r-- 1 ceph ceph    21 Oct 16 13:13 magic
>   -rw-r--r-- 1 ceph ceph     4 Oct 16 13:13 store_version
>   -rw-r--r-- 1 ceph ceph    53 Oct 16 13:13 superblock
>   -rw-r--r-- 1 ceph ceph     2 Oct 16 13:13 whoami
>=20
> (The parent directory has
>   drwxr-sr-x 3 ceph ceph  4096 Oct 16 13:13 sdf2)
>=20
> I had been creating the partitions myself and then passing them to ceph=
-deploy osd prepare and osd activate.
> Which worked fine before 9.1.0.
> Is there some extra permissions setup I need to do for 9.1.0?
>=20
> Alternatively, is there a single-node setup script for 9.1.0 that I can=
 look at?
>=20
> -- Tom Deneau
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--fwi3QlkVUMILm4Ern55A9JuUfW80Kddtr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYhaZQACgkQ8dLMyEl6F23GDgCggFcna/5reQhoQ+pE/9AIUbnM
DOsAoLbbLPvPaBAkOPShKOV+mFVgEB2X
=dPAH
-----END PGP SIGNATURE-----

--fwi3QlkVUMILm4Ern55A9JuUfW80Kddtr--
