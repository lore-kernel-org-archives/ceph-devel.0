From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: "ceph osd map" pointer to the code
Date: Tue, 24 Sep 2013 14:07:50 +0100
Message-ID: <52418EA6.3070503@inktank.com>
References: <etPan.52418730.7a6d8d3c.f19a@leseb-mba.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:45727 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab3IXNHq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Sep 2013 09:07:46 -0400
Received: by mail-we0-f180.google.com with SMTP id u57so4474501wes.39
        for <ceph-devel@vger.kernel.org>; Tue, 24 Sep 2013 06:07:45 -0700 (PDT)
In-Reply-To: <etPan.52418730.7a6d8d3c.f19a@leseb-mba.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <sebastien.han@enovance.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/24/2013 01:36 PM, S=C3=A9bastien Han wrote:
> Hi guys,
>
> Does anyone can point me to the piece of code called during the =E2=80=
=9Cceph osd map =E2=80=98pool=E2=80=99 =E2=80=98object=E2=80=99=E2=80=9D=
 command please?
> Thanks!

$ git grep -n 'osd map' src/mon
src/mon/MonCommands.h:338:COMMAND("osd map " \
src/mon/OSDMonitor.cc:2093:  } else if (prefix =3D=3D "osd map") {

You'll want the second hit, on src/mon/OSDMonitor.cc

   -Joao



--=20
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
