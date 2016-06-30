From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: SIGTERM and osd close
Date: Thu, 30 Jun 2016 18:16:20 +0200
Message-ID: <20160630161620.GA29096@predictor>
References: <CY1PR0201MB182059A3B8115A640EB69BA985240@CY1PR0201MB1820.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:48209 "EHLO predictor.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501AbcF3QNe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 Jun 2016 12:13:34 -0400
Content-Disposition: inline
In-Reply-To: <CY1PR0201MB182059A3B8115A640EB69BA985240@CY1PR0201MB1820.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jun 30, 2016 at 03:45:56PM +0000, Ramesh Chander wrote:
> Hi All,
>=20
> When I use stop.sh without any argument, I suppose it calls pkill wit=
h SIGTERM on osds as well as other processes.
>=20
> Does osd handle this signal and take care of closing all components?

Yes, it does clean shutdown of daemons affected. This can be proven by
measuring the time between signal dispatch and actual OSD daemon going =
away
(usually few seconds).

--=20
Piotr Da=C5=82ek
branch@predictor.org.pl
http://blog.predictor.org.pl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
