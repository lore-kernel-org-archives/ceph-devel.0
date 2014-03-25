From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 22:03:31 +0100
Message-ID: <1395781411.2076.19.camel@localhost>
References: <1395736765.2823.29.camel@localhost>
			 <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
			 <53316D18.7040103@ieee.org>
			 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
			 <53317BC2.9010700@ieee.org>
			 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>
			 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>
			 <5331853D.40408@ieee.org> <1395767705.9967.5.camel@localhost>
			 <5331C05D.1060008@ieee.org> <1395773582.2076.10.camel@localhost>
			 <5331D2E8.6060002@ieee.org>
			 <CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>
		 <1395778894.2076.12.camel@localhost> <5331E608.40206@ieee.org>
	 <1395779358.2076.14.camel@localhost> <5331EA9C.90004@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:41941 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500AbaCYVDd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 17:03:33 -0400
In-Reply-To: <5331EA9C.90004@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

=46or me all this images are RBD v1 images, without layering.

# rbd info sas3copies/env4-spool
rbd image 'env4-spool':
	size 10240 MB in 2560 objects
	order 22 (4096 KB objects)
	block_name_prefix: rb.0.1536881.238e1f29
	format: 1

(the one reported here :=20
Mar 25 21:17:58 murmillia kernel: [ 2205.255938] obj_request ffff88025a=
2b3c48
Mar 25 21:17:58 murmillia kernel: [ 2205.255940]     ->object_name <rb.=
0.1536881.238e1f29.000000000439>
Mar 25 21:17:58 murmillia kernel: [ 2205.255941]     ->offset 0
Mar 25 21:17:58 murmillia kernel: [ 2205.255943]     ->length 28672
Mar 25 21:17:58 murmillia kernel: [ 2205.255944]     ->type 0x1
Mar 25 21:17:58 murmillia kernel: [ 2205.255945]     ->flags 0x3
Mar 25 21:17:58 murmillia kernel: [ 2205.255946]     ->which 1
Mar 25 21:17:58 murmillia kernel: [ 2205.255948]     ->xferred 28672
Mar 25 21:17:58 murmillia kernel: [ 2205.255949]     ->result 0
)

At VM level, this block device is formated in ext4, and used for Exim4
(MTA) spool, and can handle a lots of writes.

And this ceph pool use 3 replica, with a "per network" CRUSH rule.


Le mardi 25 mars 2014 =C3=A0 15:44 -0500, Alex Elder a =C3=A9crit :
> Olivier, it appears this is a layered image, i.e., the image
> is a clone of another.  Can you tell us any more about the
> way these images are organized?  Do you have one master image
> and others are based on that?  Is there more than one layer to
> the organization?  (Do these questions make sense?)
>=20
> 					-Alex
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
