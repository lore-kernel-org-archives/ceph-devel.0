From: James Page <james.page@ubuntu.com>
Subject: Re: v0.67 Dumpling released
Date: Wed, 14 Aug 2013 09:12:32 +0100
Message-ID: <520B3BF0.8070704@ubuntu.com>
References: <alpine.DEB.2.00.1308132222350.18836@cobra.newdream.net> <24E144B8C0207547AD09C467A8259F75590569E1@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33686 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759410Ab3HNIMg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 04:12:36 -0400
In-Reply-To: <24E144B8C0207547AD09C467A8259F75590569E1@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 14/08/13 08:37, Dietmar Maurer wrote:
>> Another three months have gone by, and the next stable release of
>> Ceph is ready: Dumpling!  Thank you to everyone who has
>> contributed to this release!
> 
> Seem there is a new dependency in the ceph-common debian package:
> python-ceph
> 
> Is that really required (previous release does not depend on
> that)?

Sure is - the 'ceph' command line tool is now written in python and
uses python-ceph to interact with ceph daemons.


- -- 
James Page
Ubuntu and Debian Developer
james.page@ubuntu.com
jamespage@debian.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJSCzvwAAoJEL/srsug59jDTHwQAIxdWQy8yopDbn64heP+x5xt
TmfdF457NN26aTsNjzTz+yZ2rmdImbFBXpoGSyCVe3XMB3BLtJqcRdN7NPkGSr2u
xU8CvW8kumxgeuHMKAca19n1xYG62gGCNLVkWPv2sp8InpjQoGdd4bKi/b8T2peo
/+gBJt+oRkhNV+bWEN2fadN6QSeJp+2BYxjSyWFCX/H0NpvzXbA59Ha6pUMMOygi
j0YIgcj2snMXRMNQGoZwOlyHs7w8FhW3c9JnB6xmfk0N1cmSKrsN9H0Daum282to
cMs6yhpSTC97HMKcQrRjuVcHT7DJ40Ua1TIu0x9TDXithvQOme+wqbjT5VUFfFGk
aubWd/nFLEDkHp/dLyfGwJyMEgD7IYFcaArEBe4EThoKep7P/tOR51dxjg240x6U
T5rnQCU+cfBRp6uRPge+0lYiO+tJJLg6QrAOfz4mexOQTX3qWhUJ+je+WsRQcJ0s
B/eNYyvO7ZxTWF0ktolj8NDAtfVd/FTGrTVgWpB7h2iTgYFs9a2JUXPB2PV8KvD1
v0HeWwGKmx/gO12Suiqx9/PGcXb7FIt0j+xnPcFcm0QOaQ09aB70QT1LlsHkWUhZ
9q3TksEVo31UpW5qhh8swX6Eq4cqWyVJmMbVlqTOQ9HxElIzfEeJM4/BZgZZCd3M
RHzgb2jHmj4XSDbhGVnp
=Z7do
-----END PGP SIGNATURE-----
