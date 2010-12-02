From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Re: Status of ceph ITP?
Date: Thu, 02 Dec 2010 01:30:51 +0100
Message-ID: <1291249852.14018.611.camel@julia.gcs.org.hu>
References: <1290365977.9821.3.camel@clint-MacBookPro>
	 <Pine.LNX.4.64.1011211521510.17131@cobra.newdream.net>
	 <1290436452.9821.5.camel@clint-MacBookPro>
	 <Pine.LNX.4.64.1011291120510.4337@cobra.newdream.net>
	 <1291075213.14018.101.camel@julia.gcs.org.hu>
	 <Pine.LNX.4.64.1011300922530.30759@cobra.newdream.net>
	 <1291221518.14018.564.camel@julia.gcs.org.hu>
	 <Pine.LNX.4.64.1012011010570.29814@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-w26Vo0yGFtxoSta2UzTq"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.routers.hu ([212.40.96.82]:35258 "EHLO mail.routers.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753656Ab0LBAbu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 Dec 2010 19:31:50 -0500
In-Reply-To: <Pine.LNX.4.64.1012011010570.29814@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Clint Byrum <clint@ubuntu.com>, asheesh@asheesh.org, 506040@bugs.debian.org, noel@debian.org, ceph-devel@vger.kernel.org


--=-w26Vo0yGFtxoSta2UzTq
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Sage,

On Wed, 2010-12-01 at 10:15 -0800, Sage Weil wrote:
> Can you take a look at the 'testing' branch in git commit 5bdae2af? =20
> That's how I've been doing releases, more or less.  Assuming packaging=
=20
> issues are sorted out prior to that point, that's all that should be=20
> needed, right?=20
 I think I've noted that cephfs and radosacl are without manpages.
Please write one for them. Do you have an upstream changelog somewhere?
ChangeLog is still empty. Really minor that I write 'new upstream
release' to debian/changelog . Otherwise it's OK for uploading.

> I can also set you up with push access to update the=20
> debian/ stuff at your leisure without sending patches over the list.
 Would be easier with push rights for debian/ if you trust me. I've my
GnuPG key that you can check with any local or nearby Debian
Developer(s) that I'm in the web of trust.

> (BTW, the v0.23.2 bugfix release is mostly pointless as v0.24 is just a=
=20
> couple days away anyway.  Just for the sake of illustration...)
 There's no chance that ceph will be included in Squeeze and the next
release of Ubuntu is several months away. You have time and it's your
decision when should I first upload ceph. Please note that Debian is in
freeze ATM, it may need even two weeks to be accepted to the archive[1];
and even if it's in the NEW queue, I can upload new versions into it.
I'm not an ftp-master, but your package maybe rejected[2] for two
reasons. I think only debian/copyright is not enough, all source files
should have a comment header about their license in short. You have it
in cephfs.cc , cfuse.cc , etc; but missing in barclass.cc , cconf.cc ,
cls_acl.cc and in others. Second is that you link with OpenSSL when your
license is (L)GPL. See their FAQ[3] and the fact that I can't find any
upstream license file permitting that nor it's mentioned in
debian/copyright . Also you may see the debian/copyright of my packages,
like neon27[4]: it has a pointer to the full license file
under /usr/share/common-licenses/ .
On the other hand, it went into Ubuntu without any problems. Clint,
No=E8l? Feel free to post comment on what needs to be done with ceph
packaging to be accepted on the first round.

Regards,
Laszlo/GCS
[1] http://ftp-master.debian.org/new.html
[2] http://ftp-master.debian.org/REJECT-FAQ.html
[3] http://www.openssl.org/support/faq.html#LEGAL2
[4] http://packages.debian.org/changelogs/pool/main/n/neon27/current/copyri=
ght

--=-w26Vo0yGFtxoSta2UzTq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkz26LMACgkQGkxvZbuqR8mS8gCcDKWy1MrwJnx0/QwTAcOekqCR
/jQAoIEU0ycnxdkZaHLodu9gDTeeQUfO
=So2W
-----END PGP SIGNATURE-----

--=-w26Vo0yGFtxoSta2UzTq--

