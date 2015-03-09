From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology-lock and choosing a kernel
Date: Mon, 09 Mar 2015 23:32:19 +0100
Message-ID: <54FE1F73.9060703@dachary.org>
References: <54FC459D.2090703@dachary.org> <6E9B72C6-1FA0-46D3-873E-EA99A52BE669@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="iUDcBiXFIxbtGOWWuK6M8fehxujQ5qsEQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55422 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751193AbbCIWc2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 18:32:28 -0400
In-Reply-To: <6E9B72C6-1FA0-46D3-873E-EA99A52BE669@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Schoen <aschoen@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iUDcBiXFIxbtGOWWuK6M8fehxujQ5qsEQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

I successfully installed a 3.19 kernel (details at http://dachary.org/?p=3D=
3594). It turns out that the loop module is compiled in and defaults to h=
aving zero partitions allowed by default. Since I was looking for a solut=
ion to have /dev/loop useable for tests, I rebooted with /boot/grub/grub.=
conf as

[ubuntu@vpm083 src]$ cat /boot/grub/grub.conf=20
default=3D0
timeout=3D5
splashimage=3D(hd0,0)/boot/grub/splash.xpm.gz
hiddenmenu
title rhel-6.5-cloudinit (3.19.0-ceph-00029-gaf5b96e)
        root (hd0,0)
        kernel /boot/vmlinuz-3.19.0-ceph-00029-gaf5b96e ro root=3DLABEL=3D=
79d3d2d4  loop.max_part=3D16
        initrd /boot/initramfs-3.19.0-ceph-00029-gaf5b96e.img


and that works fine. Do you know if I could do that from the yaml file di=
rectly ? Alternatively I could use a kernel that does not have the loop m=
odule compiled in and modprobe it with loop.max_part=3D16, but it's uncle=
ar to me what kernels are available and what their names are.

Thanks a lot for the help :-)

On 09/03/2015 14:37, Andrew Schoen wrote:
> Loic,
>=20
> After locking the node like normal, you can use teuthology to install t=
he kernel you need.  Just include the kernel stanza in your yaml file.  h=
ttp://ceph.com/teuthology/docs/teuthology.task.html#teuthology.task.kerne=
l.task
>=20
> Something like this:
>=20
>   interactive-on-error: true                                           =
                                                                         =
                             =20
>   roles:
>      - [mon.0, client.0]
>   kernel:
>      branch: testing
>   tasks:
>      - interactive:=20
>=20
> Use teuthology-lock =97list-targets to get the connection information f=
or you newly locked node and add that to your yaml.
>=20
> Best,
> Andrew
>=20
> On Mar 8, 2015, at 7:50 AM, Loic Dachary <loic@dachary.org <mailto:loic=
@dachary.org>> wrote:
>=20
>> Hi Andrew,
>>
>> After successfully locking a centos 6.5 VPS in the community lab with
>>
>> teuthology-lock --lock-many 1 --owner loic@dachary.org <mailto:loic@da=
chary.org> --machine-type vps --os-type centos --os-version 6.5
>>
>> it turns out that it has a 2.6.32 kernel by default. A more recent ker=
nel is required to run the ceph-disk tests because it relies on /dev/loop=
 handling partition tables as a regular disk would. After installing a 3.=
10 kernel from http://elrepo.org/tiki/kernel-lt and rebooting, it was no =
longer possible to reach the machine.
>>
>> The teuthology-suite command has a -k option which suggest there is a =
way to specify the kernel when provisioning a machine. The command
>>
>> ./virtualenv/bin/teuthology-suite --dry-run -k testing --priority 101 =
--suite rgw --suite-branch firefly --machine-type plana,burnupi,mira --di=
stro ubuntu --email loic@dachary.org <mailto:loic@dachary.org> --owner lo=
ic@dachary.org <mailto:loic@dachary.org>  --ceph firefly-backports
>>
>> shows lines like:
>>
>> 2015-03-08 13:43:26,432.432 INFO:teuthology.suite:dry-run: ./virtualen=
v/bin/teuthology-schedule --name loic-2015-03-08_13:43:06-rgw-firefly-bac=
kports-testing-basic-multi --num 1 --worker multi --priority 101 --owner =
loic@dachary.org <mailto:loic@dachary.org> --description 'rgw/multifs/{cl=
usters/fixed-2.yaml fs/btrfs.yaml rgw_pool_type/erasure-coded.yaml tasks/=
rgw_multipart_upload.yaml}' -- /tmp/schedule_suite_AQ2b6w /home/loic/src/=
ceph-qa-suite_firefly/suites/rgw/multifs/clusters/fixed-2.yaml /home/loic=
/src/ceph-qa-suite_firefly/suites/rgw/multifs/fs/btrfs.yaml /home/loic/sr=
c/ceph-qa-suite_firefly/suites/rgw/multifs/rgw_pool_type/erasure-coded.ya=
ml /home/loic/src/ceph-qa-suite_firefly/suites/rgw/multifs/tasks/rgw_mult=
ipart_upload.yaml
>>
>> which show the testing word as part of the job name. The https://githu=
b.com/ceph/teuthology/ page shows some more information about kernel choi=
ces but it's non trivial to figure out how to translate that into somethi=
ng that could be used in the context of teuthology-lock.
>>
>> I'm not sure where to look and I would be grateful if you could give m=
e a pointer to go in the right direction.
>>
>> Cheers
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--iUDcBiXFIxbtGOWWuK6M8fehxujQ5qsEQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT+H3MACgkQ8dLMyEl6F212oQCgqFoKShNJcyQOM1uKa/ZL7Or8
N/UAn2Uv1neo40I+NWDSSEg/iAnHRSaO
=MlUP
-----END PGP SIGNATURE-----

--iUDcBiXFIxbtGOWWuK6M8fehxujQ5qsEQ--
