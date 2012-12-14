From: James Page <james.page@ubuntu.com>
Subject: Re: Debian packaging question
Date: Fri, 14 Dec 2012 09:03:47 +0000
Message-ID: <50CAEB73.2070601@ubuntu.com>
References: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com> <50C6C5E5.6010107@widodh.nl> <0D99561D-3A0B-4766-9770-8A90E37B7A24@inktank.com> <50C705A9.1030603@ubuntu.com> <7A33695B-249B-4638-94BF-BC3BD283216B@inktank.com> <50C864A8.1010707@ubuntu.com> <alpine.DEB.2.00.1212120742140.8754@cobra.newdream.net> <50C90293.4060407@ubuntu.com> <95BEC6FE-ECFA-4106-BF1F-C4BD43819602@inktank.com> <50C99B5E.9010006@ubuntu.com> <3EBEC3BA-3E32-413E-8DBF-5ED7A5FB6F36@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49520 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab2LNJDv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 04:03:51 -0500
In-Reply-To: <3EBEC3BA-3E32-413E-8DBF-5ED7A5FB6F36@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gary Lowell <gary.lowell@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Wido den Hollander <wido@widodh.nl>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 14/12/12 04:38, Gary Lowell wrote:
>> I think that the "--debbuildopts '-j8 -b'" might be trouncing
>> the
>>> - --binary-arch flag - I'll get pbuilder setup and give it a
>>> test - I normally use sbuild (for which the packaging changes
>>> did have the desired effect).
> 
> I does appear to have been the --debbuildopts causing the problem.
> The combination of your rules file update and removing
> --debbuildopts  built just the arch dependent packages.

Good - I'd not managed to actually test this out (I was struggling
with pbuilder).

> Thanks for the help.

No problem

Cheers

James

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJQyutzAAoJEL/srsug59jDr9wQAIMFuAUVeFhp1O+yJshBqnY2
7pY4rz1sw7/qjbklIe9ZSlOKy6tSTLEnW0a2qBhGKgsD/5bvhS8QoSUPeLtWOYwY
Z+om/Z7+voKD1cbbez+qc/sD/uJa6+B8aql3uuSCZwlrESbVUwsRSR+jCsUQwEEh
njipllOmYUZSvpHheFMGEjkbZBsVUz4f84mmEh1vSRXyV/4Xvt9AMHWHnnvkazbK
i/qaRgOF1ux/Jag1z5XowhB6/ugvCiRwhHONuxijchFcWNxQ5j4Y7pfTeZENKO2I
7H6N9W/tucgCyo+EQ3v7+DYpzAxiZK2qJG+ZWSIGUGxUZfcVzmXPAVkibwOCiQ+i
+e7pg0ncdMLlbQoAW1c1prNa5kKFKrnh/lDN+YYOVt1v0ckLHjBev256AWUiSKmw
PoFOewVqb5ESvWepqhjwoM+SnKLsgXvz1NEvFZBx1xKojxmaLtrh1j3IzJiQWY/Z
QG9eyYLkhlxBur2dxksUAk0EwdbiQBWQp32y4hdg2+tUvuZoFisf3rmzu4eZCE7B
FRECb0hZ4K8EN0VOdiCHt/+2abYJ3rZoKDlpVkqrQYHPYML9Wign6O79SU9oGvUn
ZqoV1wnvPUK6Ze92QYDdMkZ1lMXf2YM5ySxgayMjboKeV9wysy6tvns0MO2on9tn
qLO6iJb++3FP4L7wJFOG
=oil3
-----END PGP SIGNATURE-----
