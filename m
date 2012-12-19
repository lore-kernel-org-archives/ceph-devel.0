From: James Page <james.page@ubuntu.com>
Subject: Crash whilst detecting mime-type in radosgw/0.55.1
Date: Wed, 19 Dec 2012 15:10:28 +0000
Message-ID: <50D1D8E4.8000808@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43869 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab2LSPKc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 10:10:32 -0500
Received: from host212-140-201-242.range212-140.btcentralplus.com ([212.140.201.242] helo=[192.168.1.50])
	by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <james.page@ubuntu.com>)
	id 1TlLHy-0000bq-OL
	for ceph-devel@vger.kernel.org; Wed, 19 Dec 2012 15:10:30 +0000
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi

I'm seeing a couple of issues with Ceph 0.55.1 on Ubuntu raring
(current development release) whilst testing the keystone integration
with radosgw.

1) Crash in RADOS Gateway when Content-Type not specified in Upload

https://bugs.launchpad.net/ubuntu/+source/ceph/+bug/1092137

RADOS Gateway crashes when trying to match the mime type with the
extension of the file being uploaded - full backtrace here:

http://paste.ubuntu.com/1450073/

If the file has no extension then all is good!

I'm uploading using the python-swiftclient package using the following
command:

   swift upload test quantal-server-cloudimg-amd64-disk1.img

for example.

   swift upload test quantal-server-cloudimg-amd64-disk1

works OK.

2) swift list returns no output

I was expecting a list of the buckets I had just created - but instead
I get zip; I can stat the buckets OK individually but the top level
list returns nothing - am I missing something?

Other than those two things the integration with Keystone was pretty
easy to get up and running and will feature in the next version of the
Ceph RADOS Gateway charm for Juju (see 1) - nice work!

Cheers

James

[1] http://jujucharms.com/charms/precise/ceph-radosgw

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJQ0djkAAoJEL/srsug59jDrlUP/AgssXzjxG7HMmlW4c0Js0DS
tBWMsJBZJuiVYwO/+KLNotg9lNPHWqsMeloZ/AeWen6Q2p5R3Qy4/NBtFHF6wb4S
MWgkD3Euy/JDnt/ak7FqCTVkTuIxT4oOjegAeAkMLA9v6N6HBBIN2KIj8ymtB91C
8RbgEVyqMyF78DVVZlrvfhaeOBc6HIhssbFWnMRxMjSlxY9mPhhSB420KvBl5GY9
Kkcw7zTSnid8b6oOkSZiKqawCWJp62N/8G9Tb4X35nmtRppXvhA2Wquh7DteDMhN
b9MulZ95RukOfog1mBGFbyTLbh9XG3FON4q3+KzUwH8oRUttgx0HnxViSz47UwMg
pbCDmCCJtu+d5zpxUdYpcLFotwEBQR9zhVy4cMtykXz4ScYyKuoJ7aoEQ4ZsNscZ
Iy6ACHD8EGm8N9CqfFcTX0nsKMZQmUpcRydy7Y+k2/m+WQMk0egi91womz7HA6lP
7u8JoAlu3L2zX7i9PKjy+R+/8oP60NpMgFPyi5cmISOgDrAjlFFZXEEgQ49X+HF/
JjH8i3fgdk2ua7zuj/a4T9zRknzd2N1eBHjeWsYFeWkUPSkWLuD2s8eRueNOY8Z8
/IK8Y3sNIMGpdzY+G0Gv/UXmNL7hNtKD4nQg3w40PMl47p0XAsqNlOwPYFu9c/AC
UltxNFRl5pvp+o9EJ7AB
=99E2
-----END PGP SIGNATURE-----
