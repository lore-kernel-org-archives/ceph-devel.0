From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology-lock and choosing a kernel
Date: Tue, 10 Mar 2015 08:48:20 +0100
Message-ID: <54FEA1C4.7020109@dachary.org>
References: <54FC459D.2090703@dachary.org>	<6E9B72C6-1FA0-46D3-873E-EA99A52BE669@redhat.com>	<54FE1F73.9060703@dachary.org> <CAOi1vP8T+JY1v9fnSAvK3UMr2MnzN+KJTWMY26k6zD5p_HCP_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nkNxKISEHnJi3KwfJkj6EO4cftgTmN3up"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55639 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751024AbbCJHsW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Mar 2015 03:48:22 -0400
In-Reply-To: <CAOi1vP8T+JY1v9fnSAvK3UMr2MnzN+KJTWMY26k6zD5p_HCP_Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nkNxKISEHnJi3KwfJkj6EO4cftgTmN3up
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

On 10/03/2015 08:19, Ilya Dryomov wrote:
> On Tue, Mar 10, 2015 at 1:32 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Andrew,
>>
>> I successfully installed a 3.19 kernel (details at http://dachary.org/=
?p=3D3594). It turns out that the loop module is compiled in and defaults=
 to having zero partitions allowed by default. Since I was looking for a =
solution to have /dev/loop useable for tests, I rebooted with /boot/grub/=
grub.conf as
>>
>> [ubuntu@vpm083 src]$ cat /boot/grub/grub.conf
>> default=3D0
>> timeout=3D5
>> splashimage=3D(hd0,0)/boot/grub/splash.xpm.gz
>> hiddenmenu
>> title rhel-6.5-cloudinit (3.19.0-ceph-00029-gaf5b96e)
>>         root (hd0,0)
>>         kernel /boot/vmlinuz-3.19.0-ceph-00029-gaf5b96e ro root=3DLABE=
L=3D79d3d2d4  loop.max_part=3D16
>>         initrd /boot/initramfs-3.19.0-ceph-00029-gaf5b96e.img
>>
>>
>> and that works fine. Do you know if I could do that from the yaml file=
 directly ? Alternatively I could use a kernel that does not have the loo=
p module compiled in and modprobe it with loop.max_part=3D16, but it's un=
clear to me what kernels are available and what their names are.
>=20
> I think you can run a set of commands from yaml (see "exec" stanza), so=

> you can sort of script it (GRUB_CMDLINE_LINUX=3D, etc), but that's neve=
r
> going to be reliable.
>=20
> Basically the only kernel available right now is the testing flavor.
> debug flavor is some random config and has been unused for a while.
> I can try changing testing config to do CONFIG_BLK_DEV_LOOP=3Dm if you
> don't find a good way to workaround it.
>=20
> https://lists.ubuntu.com/archives/kernel-team/2009-September/007364.htm=
l
> is apparently the reason it's compiled in (our config is a somewhat old=

> and slightly stripped down Ubuntu config).

Thanks for exploring the history so far back ;-) I hope to find an easier=
 path but its comforting to know where we stand.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--nkNxKISEHnJi3KwfJkj6EO4cftgTmN3up
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT+ocQACgkQ8dLMyEl6F23kpACaA0M2Wo/TJKVG2WdWJKmKXOS5
CLEAn0VLrbTDZeBIyHc+McvYpX0mDP19
=tPu8
-----END PGP SIGNATURE-----

--nkNxKISEHnJi3KwfJkj6EO4cftgTmN3up--
