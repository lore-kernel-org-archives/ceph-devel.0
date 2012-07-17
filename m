From: James Page <james.page@ubuntu.com>
Subject: Re: Ceph exception for wheezy
Date: Tue, 17 Jul 2012 13:14:00 +0100
Message-ID: <50055708.3040509@ubuntu.com>
References: <50055069.703@enovance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52221 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab2GQMOF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jul 2012 08:14:05 -0400
In-Reply-To: <50055069.703@enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@enovance.com>
Cc: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>, Ceph Development <ceph-devel@vger.kernel.org>, openstack-devel@lists.alioth.debian.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 17/07/12 12:45, Loic Dachary wrote:
> Thank you for uploading 0.48 in testing: it's great to have a
> stable version for wheezy. If you need support in getting an
> exception to migrate to testing despite the freeze, I'd be happy to
> help.

The required fix to support big-endian architectures in leveldb has
just been uploaded to unstable (see [0]) as well which should help
unblock but I also see some issue with the symbols files added in the
last update causing issues on non-amd64 architectures.

Laszlo - are you looking at this? I can find some time if you need a hand.

Cheers

James

[0] http://packages.qa.debian.org/l/leveldb/news/20120717T120234Z.html

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCAAGBQJQBVcIAAoJEL/srsug59jDwnQP/ja/9RSwP6VytiUemuXSOQJH
MC/ShtHWBxB32Xn8o81sMpLHzNoX4yeTiy9GDB5i4QjqiZ+JMSfngmsyRMuk3twV
R1y6X3CAha9h5tAzMC1HiaX+S7xUyn/8E8QMHYrn12z/HQBxJCU2RosV/SUe4lbP
ygX51p4gWiYo95z+iXNIqfV/MmPhcJU0j3NDaKo/HHnS8Oy9OyoLFhZ33ew8QLyQ
ermP6o18yYRKX9SAjz97MXeTeD2QQNUduWhtdoyvYrw9iXwI2mbh/i7b4w6Cbaff
qzXaybBhtKPGKzFoFVSjdPnW8TVM0FneAvDnQ/vvoU66OnjPUKNaMXNqvabl8sQl
yaH+/TFCBJi8wkKx7gQpcL+JnxOGJx7B9N2azVyRLzx9d5dMi8U04mpR+0RBRuC5
hnYN1+MHzzAxy7d1ux/QbaJiEqe+alcmJc9u5YNicMb6ZFWkco0jGx1BvO+Z71Vv
sxCvlLFTriiqhAZN5cjcrsCIbM/JwxMSHJfY8r15sstusvHdn93ogxJ9a44pPKsQ
4aReA+NGXRik6A9m5o8HbvpTpw2yvBdkYuYh7+AYtGKwYvbshk/qlG5f9wYZQdGE
81agkpMjOQyRRpImktIoUQzA1Phs+MWOEOQNjWcq2n+J/VbyTO+WlCNa9Yq1ASHV
Es5qBLhRRVxQRDpvumPH
=wUJR
-----END PGP SIGNATURE-----
