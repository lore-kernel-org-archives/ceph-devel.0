From: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] add CephFS support in VirtFS
Date: Wed, 17 Feb 2016 08:41:16 -0700
Message-ID: <56C4949C.6090200@redhat.com>
References: <56C00B60.6000502@gmail.com> <20160215091727.GB3105@redhat.com>
 <56C421F6.1000102@gmail.com> <20160217093716.GC30300@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6MdhT6I7i10ocFGIIeh54hO6pdivS7bHf"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47138 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422745AbcBQPlY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Feb 2016 10:41:24 -0500
In-Reply-To: <20160217093716.GC30300@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Daniel P. Berrange" <berrange@redhat.com>, Jevon Qiao <scaleqiao@gmail.com>
Cc: haomaiwang@gmail.com, mst@redhat.com, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com, Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, gfarnum@redhat.com, gkurz@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6MdhT6I7i10ocFGIIeh54hO6pdivS7bHf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2016 02:37 AM, Daniel P. Berrange wrote:
> If you have a branch holding a whole series of patches to submit, then
> it is easier to automate it. eg
>=20
>  git rebase -i master -x 'git show | ./scripts/checkpatch.pl -'

Or even make it part of 'git commit':
http://wiki.qemu.org/Contribute/SubmitAPatch mentions a link to
http://blog.vmsplice.net/2011/03/how-to-automatically-run-checkpatchpl.ht=
ml

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6MdhT6I7i10ocFGIIeh54hO6pdivS7bHf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJWxJScAAoJEKeha0olJ0NqTwsH/3iU/3HTgEzuTxRv9Ec1DR4K
MQ9iGqxVu8I0sYaUTVPGAF/ZxH70lFPHbBCzjF5PGZVN5iMDXwq3unobO4goX8NK
GK0GoLCwDgl3VLF8pI0LOlR74gq4XRb+iYHZ1qdzjkQQtWSwW14oCVQMAs5ytoxl
Sbq9ZO806XP1mNrfoB+B/RRYG592UduhHEXNccabgczdb3vRuKZXokkkMpYydp87
y2malIhJFnjX/4zhv24ktu0+LteAUDbk3kyh9zrA91TIJQD05uMkISPXaFn6YVL9
OP+OmqHY2W+b++1YJsUrW/40cbEPLTboLI4yAfTpXdc8CaEwHbvMVz69DiYLYNM=
=it43
-----END PGP SIGNATURE-----

--6MdhT6I7i10ocFGIIeh54hO6pdivS7bHf--
