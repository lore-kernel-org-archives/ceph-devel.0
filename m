From: Michael Morgan <mmorgan@dca.net>
Subject: Re: Problem with cephx in 0.55
Date: Wed, 12 Dec 2012 15:13:53 -0500
Message-ID: <20121212201353.GB24346@staff.dca.net>
References: <CAGqxmDNyHLCKSc8z-F+XPJJG2xyYjBdgPaeM5TmZ1SM6BntfGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from staff.dca.net ([207.245.84.197]:41818 "EHLO staff.dca.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645Ab2LLUNy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 12 Dec 2012 15:13:54 -0500
Content-Disposition: inline
In-Reply-To: <CAGqxmDNyHLCKSc8z-F+XPJJG2xyYjBdgPaeM5TmZ1SM6BntfGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Maciej =?utf-8?Q?Ga=C5=82kiewicz?= <maciejgalkiewicz@ragnarson.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Dec 12, 2012 at 03:19:22PM +0100, Maciej Ga=C5=82kiewicz wrote:
> Hello
>=20
> I can't map rbd volume after upgrading to 0.55 from 0.53.
>=20
> # ceph auth list
> ...
> client.test
>         key: AQAaAshQ6NakBRAAHbOaK7DvO9NIKDwTV5REMw=3D=3D
>         caps: [mon] allow r
>         caps: [osd] allow rwx pool=3Dwinnie-test
>=20
>=20
> If I use admin key or use "caps: [osd] allow rwx" instead of "caps:
> [osd] allow rwx pool=3Dwinnie-test" it works fine.
>=20

Hi,

 Try removing the "=3D" from the osd cap, ie.

client.test
        key: AQAaAshQ6NakBRAAHbOaK7DvO9NIKDwTV5REMw=3D=3D
        caps: [mon] allow r
        caps: [osd] allow rwx pool winnie-test

 I believe that changed after 0.53. I know my 0.54 cluster only works w=
ith
"allow rwx pool name". Good luck!

-Mike
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
