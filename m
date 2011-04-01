From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Re: The installation: When we start Ceph, the system stops running.
Date: Fri, 1 Apr 2011 18:43:04 +0800
Message-ID: <AANLkTinKSXuWGiw=+L1SO671hAiUDf_AUuwwYPkMvas4@mail.gmail.com>
References: <AANLkTinV864-rE6HERpmL-DBtx_eqp2DNRGqiZWatWtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64210 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539Ab1DAKnH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2011 06:43:07 -0400
Received: by fxm17 with SMTP id 17so2502885fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 01 Apr 2011 03:43:05 -0700 (PDT)
In-Reply-To: <AANLkTinV864-rE6HERpmL-DBtx_eqp2DNRGqiZWatWtA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6Zmz5puJ6JaH?= <doki74216@gmail.com>
Cc: ceph-devel@vger.kernel.org

2011/4/1 =E9=99=B3=E6=9B=89=E8=96=87 <doki74216@gmail.com>:
> Hi,
> I set an environment of 20 servers which include 2 MDSs, 3 MONs and 1=
5
> OSDes.
> My version is 0.25.2 and OS is Fedora 14.
> There's a problem when I was installing the Ceph.
> When I finished "mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs
> -k keyring.bin" .
> I start the whole Ceph system.
> But here is the problem I met:
> The system stops running and it shows the error messages as shown bel=
ow:
>
> =3D=3D=3D mon.0 =3D=3D=3D
> Starting Ceph mon0 on Ceph1...already running

There's already one monitor daemon running on that machine. Are you
recreating the whole cluster? Stop all ceph daemons before you
re-create the ceph cluster.

> =3D=3D=3D mon.1 =3D=3D=3D
> Starting Ceph mon1 on Ceph2...
> =C2=A0** WARNING: Ceph is still under heavy development, and is only =
suitable for **
> =C2=A0** =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0testing and review. =C2=A0=
Do not trust it with important data. =C2=A0 =C2=A0 =C2=A0 **
> starting mon.1 rank 1 at 192.168.200.202:6789/0 mon_data /data1/mon1
> fsid f1eb5c4c-5127-5038-6ea9-0cf47e6536c2
> accepter.bind unable to bind to 192.168.200.202:6789: Address already=
 in use
> failed: 'ssh Ceph2 =C2=A0/usr/local/bin/cmon -i 1 -c /tmp/ceph.conf.2=
9519 '
>

The monitor server is unable to bind the port 6789. You can log in to
that machine and check out what process is occupying it. There's
probably a zombie cmon there.

--=20
Henry
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
