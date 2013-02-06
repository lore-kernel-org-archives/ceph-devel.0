From: "Michel, Adam K - (amichel)" <amichel@email.arizona.edu>
Subject: Ceph RBD Client Filesystem Benchmarks
Date: Wed, 6 Feb 2013 23:18:05 +0000
Message-ID: <033E32DA143A5344982E0EEF039D899B1C1CCBB7@BigThunder.catnet.arizona.edu>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="Apple-Mail=_918DC223-8C76-4820-B6C8-D775318ECC1B";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from minsk.email.arizona.edu ([128.196.130.204]:46033 "EHLO
	smtpgate.email.arizona.edu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755962Ab3BFXYo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 18:24:44 -0500
Received: from mailgators_amavis (arbidol.email.arizona.edu [128.196.130.231])
	by smtpgate.email.arizona.edu (Postfix) with ESMTP id 0FBF08DA9A5
	for <ceph-devel@vger.kernel.org>; Wed,  6 Feb 2013 16:18:07 -0700 (MST)
Received: from smtp.catnet.arizona.edu (whirl.catnet.arizona.edu [10.140.53.107])
	by smtpgate.email.arizona.edu (Postfix) with ESMTPS id A35066A99D3
	for <ceph-devel@vger.kernel.org>; Wed,  6 Feb 2013 16:18:06 -0700 (MST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

--Apple-Mail=_918DC223-8C76-4820-B6C8-D775318ECC1B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

I did some testing against an RBD device in my local environment to suss =
out differences between a few filesystem options. Folks in #ceph thought =
this data might be interesting to some on the list, so I'm posting a =
link to my spreadsheet here.

http://mirrors.arizona.edu/ceph-devel/oxide-rbd-benches.xlsx

My ceph cluster layout is pretty simple. I have one server node with all =
the OSDs. It's a backblaze-style pod with 40 drives, 1 OSD per drive, =
dual-core i3 at 3GHz, 16GB of RAM and small SSD for system disk. It's =
running Ubuntu 12.04 and attached with 10GbE to a switch in my lab. I =
have three mons on older Dell hardware, 2950s, dual quad-core E5345 =
Xeon, 32GB of RAM. They're running CentOS6 (needed support for the QL =
CNAs I had available) attached with 10GbE internal to the lab as well. I =
can provide ceph configuration data if anyone would like, but I followed =
the documentation pretty religiously so I expect it is quite vanilla. =
The client I used for testing is a VMware VM running Ubuntu 12.04 in a =
different environment (ran out of hardware in the lab) which has a 1GbE =
bottleneck in its path to the lab.

I created a 5TB rbd (it is theoretically going to end up in use in a =
pilot for a dropbox-style service for our campus, thus the rather =
strangely large size for testing) and mapped it to the client, created a =
GPT partition table with a single primary partition starting at sector =
8192 (on guidance from someone in #ceph) and then formatted it with =
filesystem defaults for each of ext4, xfs and btrfs. I mounted with no =
special options in all cases.

I ran bonnie++ v1.97 with the option to skip char tests. For iozone I =
tested record sizes up to 4096 on default max file size of 512M. I've =
generated all the standard 3d charts for the iozone results in their =
respective sheets to the right of their matching data tables.

I make no particular claims to have done this as well as possible and =
would appreciate any feedback from the list on any kind of testing =
rubric that might generate data of more use to the community at large. =
This particular round of testing was mostly for my own edification.

Hopefully some of you find this useful!

Cheers,
Adam

--
Adam Michel
Systems Administrator
UITS, University of Arizona
amichel@arizona.edu
5206262189


--Apple-Mail=_918DC223-8C76-4820-B6C8-D775318ECC1B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)

iEYEARECAAYFAlES5K0ACgkQPBqR4gACPetv9ACdHCfXZHKMesLMs30492Rv8hrh
nzsAnRMYX9S+vkaIqFgZwyATZKKHWUYE
=sI+4
-----END PGP SIGNATURE-----

--Apple-Mail=_918DC223-8C76-4820-B6C8-D775318ECC1B--
