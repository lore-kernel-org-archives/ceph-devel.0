From: Wido den Hollander <wido@pcextreme.nl>
Subject: Default config value for osd_disk_thread_ioprio_class
Date: Wed, 29 Apr 2015 14:10:47 +0200
Message-ID: <5540CA47.8010201@pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([109.72.87.231]:59758 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422762AbbD2MQg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Apr 2015 08:16:36 -0400
Received: from ox01.pcextreme.nl (ox01.pcextreme.nl [IPv6:2a00:f10:101::6f7b:25:143])
	by support.pcextreme.nl (Postfix) with ESMTPS id F358B2C319
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2015 14:10:47 +0200 (CEST)
Received: from [IPv6:2001:610:b10:1d8:51bd:3c0e:2bb2:cf0b] (unknown [IPv6:2001:610:b10:1d8:51bd:3c0e:2bb2:cf0b])
	by ox01.pcextreme.nl (Postfix) with ESMTPSA id 9E15654024C
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2015 14:10:47 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

In the process of upgrading a cluster from Giant to Hammer I saw this
on the OSD logs:

2015-04-29 14:02:37.015454 7f887875e900 -1 osd.456 43089
set_disk_tp_priority(22) Invalid argument:
osd_disk_thread_ioprio_class is  but only the following values are
allowed: idle, be or rt

That is correct, since config_opts.h says:

OPTION(osd_disk_thread_ioprio_class, OPT_STR, "") // rt realtime be
best effort idle

It's nothing bad, but it would be nicer if we got rid of it.

What to do here? Allow "" as a config setting and then ignore it or
set the default to rt, be or idle?

- -- 
Met vriendelijke groet / Kind regards,

Wido den Hollander

PCextreme B.V.

http://www.pcextreme.nl/contact
Tel direct: +31 (0)118 700 212
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJVQMpHAAoJEH3G8jg7TO7a7QsH/0k4ijmOewQaLZz9FMOvnBMz
EFuZWwrpuZYncUDGXqXKYygQwsRMCSJkWX0vE7GJ0/6OalqD9qgbEHhCfNj/G/wR
jwQCX1dWwXX6+PDBSQHWyUIsH1v/UGOAw1jLRyMrgZe8MZcSNgVBnvU8vPKVlD7j
MjLXM/10CDubpuxe67rsgJxNPAA0LJnsyjNWtj3PwwdWgZCV7lwYLuCxh3oVKrMP
8I8RcofcKK53SVN/KI/mgk8UiUvTaob4pIff6fimLLRufzM+27FlnDFn3hZArDjD
izMqoUnaPNM6OBbDNiLUoywVAnDhtDcH2UtRrJCdHWyTi+Ej3oJDxxigq0Gpjlo=
=2wZ0
-----END PGP SIGNATURE-----
