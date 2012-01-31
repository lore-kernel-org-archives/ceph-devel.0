From: Dallas Kashuba <dallas@newdream.net>
Subject: Re: Nagios plugin
Date: Tue, 31 Jan 2012 15:47:38 -0800
Message-ID: <E94185BB-E205-4DBA-8506-84B461C3758D@newdream.net>
References: <4848775.TCucqMtAc2@mranderson>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54149 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab2AaXrj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jan 2012 18:47:39 -0500
In-Reply-To: <4848775.TCucqMtAc2@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?iso-8859-1?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

Hi,

We've posted our current Ceph nagios plugin here:

https://github.com/dreamhost/ceph-nagios-plugin/blob/master/check_ceph.=
pl

It's perl and does its thing by parsing the output of "ceph health".

 - Dallas

On Jan 30, 2012, at 6:50 AM, Sz=E9kelyi Szabolcs wrote:

> Hi Dallas,
>=20
> I've seen in #709 that you've been working on the Nagios plugin for C=
eph. I=20
> want to monitor Ceph from Nagios, too, and avoid duplicating your wor=
k. But I=20
> can't find the result anywhere. Can you point me to the right place, =
if it's=20
> available for the public?
>=20
> Thanks,
> --=20
> cc
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
