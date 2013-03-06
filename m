From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW Blocking on 1-2 PG's - argonaut
Date: Wed, 6 Mar 2013 06:04:34 -0800
Message-ID: <CAC-hyiGR7Ci4wnV+NAMd99gvS8J_s1RciMHZO09rKzy=qT-Kxw@mail.gmail.com>
References: <CAMwB3ThhN036aBHP+29fVJ47E=PxOnj+fTiKJrB2dANFn1-Q1w@mail.gmail.com>
	<CAC-hyiGG+f7R1jCY8CPR2HKTa7bSetnGWs+ERii6iTdEAXpWMg@mail.gmail.com>
	<CAMwB3ThWcpWNOp03tCv1vG1OckH0Nw0moKYnPDytNya2Hhv+XA@mail.gmail.com>
	<alpine.DEB.2.00.1303040900500.14723@cobra.newdream.net>
	<CAMwB3TjfkX8LJpBiicrcdf3UqZpYApBoEShebceee6KgY+C3kw@mail.gmail.com>
	<CAPYLRzhMBBsgDHSwn84EimJJUb7uGtRx8-ef933Kayhv1UMsvQ@mail.gmail.com>
	<CAMwB3TjQqYqhmSouFEgaiGwby=_mpk3hOGcrcx=9ho_+h1NdMg@mail.gmail.com>
	<CAMwB3TiB04etBKq==DsU-5KXm9bgLqTTAfNmh1LDhShzEDzc8w@mail.gmail.com>
	<CAMwB3Ticn4i3T3RZDJX5i8SMCiDa6HCRsrjeKJfVUz5wT5yBeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:62102 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757175Ab3CFOEf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 09:04:35 -0500
Received: by mail-ie0-f172.google.com with SMTP id c10so9359459ieb.17
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 06:04:34 -0800 (PST)
In-Reply-To: <CAMwB3Ticn4i3T3RZDJX5i8SMCiDa6HCRsrjeKJfVUz5wT5yBeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Mar 6, 2013 at 5:06 AM, S=C5=82awomir Skowron <szibis@gmail.com=
> wrote:
> Hi, i do some test, to reproduce this problem.
>
> As you can see, only one drive (each drive in same PG) is much more
> utilize, then others, and there are some ops in queue on this slow
> osd. This test is getting heads from s3 objects, alphabetically
> sorted. This is strange. why this files is going in much part only
> from this triple osd's.
>
> checking what osd are in this pg.
>
>  ceph pg map 7.35b
> osdmap e117008 pg 7.35b (7.35b) -> up [18,61,133] acting [18,61,133]
>
> On osd.61
>
> { "num_ops": 13,
>   "ops": [
>         { "description": "osd_sub_op(client.10376104.0:961532 7.35b
> 2b11a75b\/2013-03-06-13-8700.1-ocdn\/head\/\/7 [] v 117008'1370134

The ops log is slowing you down. Unless you really need it, set 'rgw
enable ops log =3D false'. This is off by default in bobtail.


Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
