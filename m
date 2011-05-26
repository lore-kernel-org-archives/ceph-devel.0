From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Minimum Recommended Hardware
Date: Thu, 26 May 2011 13:30:49 -0400
Message-ID: <BANLkTi=Q-Tm1i1eUDhuKEpSp+2+hKJvZdQ@mail.gmail.com>
References: <b792daeb0cd450e18e6c275abb595dcd@pl1.haspere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41722 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757672Ab1EZRaw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2011 13:30:52 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 690AAC401
	for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 10:30:52 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id 165C6C3E9
	for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 10:30:51 -0700 (PDT)
Received: by ewy4 with SMTP id 4so339662ewy.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 10:30:50 -0700 (PDT)
In-Reply-To: <b792daeb0cd450e18e6c275abb595dcd@pl1.haspere.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: YS3fpFE2ykfB@dyweni.com
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On Thu, May 19, 2011 at 1:27 AM, Dyweni - Ceph-Devel
<YS3fpFE2ykfB@dyweni.com> wrote:
> 4 x OSD
> =A0OSD1 =3D
> =A0 =A0P3 1Ghz, 256K Cache
> =A0 =A02GB RAM
> =A0 =A080GB IDE (dd_rescue can read about 45MB/s sustained)
> =A0 =A01Gb NIC (e1000 driver)
> =A0OSD2 =3D
> =A0 =A0P3 550Mhz, 512K Cache
> =A0 =A0768MB RAM
> =A0 =A040GB IDE (dd_rescue can read about 30MB/s sustained)
> =A0 =A01Gb NIC (e1000 driver)
> =A0OSD3 =3D
> =A0 =A0Celeron 1Ghz, 128K Cache
> =A0 =A0512MB RAM
> =A0 =A018GB IDE (dd_rescue can read about 15MB/s sustained)
> =A0 =A01Gb NIC (e1000 driver)
> =A0OSD4 =3D
> =A0 =A0P3 1Ghz, 256K Cache
> =A0 =A0512MB RAM
> =A0 =A020GB IDE (dd_rescue can read about 40MB/s sustained)
> =A0 =A01Gb NIC (e1000 driver)

I'm pretty sure these drives are your problem -- they're just not very
fast. Remember that in general, each write to Ceph is going to write
to both the journal and the data store -- which cuts your drives down
to 22.5, 15, 7.5, 20 MB/s in the best case (and likely a lot worse --
the journal will be a streaming write but the data store will be
random writes, and everything's slower at random writes). On top of
that, we've found that the slowest drives in a cluster can have a
pretty large impact on performance since the faster OSDs end up
consistently waiting on the slow drives.

We have seen other issues with slow CPUs, but those generally only
manifest themselves during recovery and are getting active improvement
as we come across them. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
