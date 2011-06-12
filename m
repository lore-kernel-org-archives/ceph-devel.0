From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: OSD wrongly marked up (well, half up)
Date: Sat, 11 Jun 2011 21:20:38 -0700
Message-ID: <BANLkTinf3vucv+=+Xpj1G=ocTEOQbqO-CA@mail.gmail.com>
References: <BANLkTimJZ=zpr0VoiSDK34Dkc4sVZeqX=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44055 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab1FLEUk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Jun 2011 00:20:40 -0400
Received: by fxm17 with SMTP id 17so2197751fxm.19
        for <ceph-devel@vger.kernel.org>; Sat, 11 Jun 2011 21:20:39 -0700 (PDT)
In-Reply-To: <BANLkTimJZ=zpr0VoiSDK34Dkc4sVZeqX=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Jun 11, 2011 at 2:08 PM, Wilfrid Allembrand
<wilfrid.allembrand@gmail.com> wrote:
> Hi all,
>
> On my test cluster I have 3 MON, 2 MDS and 2 OSD. I'm doing some
> failover test on OSD and got a strange thing on the status.
> The 2 nodes hosting the OSDs have been shutdown but the status contin=
u
> to 'see' one alive :

Hi Wilfrid,

Usually OSDMaps are propagated peer-to-peer amongst the OSDs. This
means that OSDs that go down are rapidly detected. However, when all
OSDs go down, there are no more OSDs to send OSDmaps. In this case, we
rely on a timeout in the monitor to determine that all the OSDs are
down.

After mon_osd_report_timeout seconds elapse without an osdmap being
sent from an OSD, the monitor marks it down. The default is 900
seconds or 15 minutes. So once you wait for 15 minutes, all the OSDs
should be marked as down.

sincerely,
Colin


>
> # ceph -v
> ceph version 0.29 (commit:8e69c39f69936e2912a887247c6e268d1c9059ed)
> # uname -a
> Linux test2 2.6.38-8-server #42-Ubuntu SMP Mon Apr 11 03:49:04 UTC
> 2011 x86_64 x86_64 x86_64 GNU/Linux
>
> root@test2:~# ceph health
> 2011-06-11 17:03:38.492734 mon <- [health]
> 2011-06-11 17:03:38.493913 mon1 -> 'HEALTH_WARN 594 pgs degraded,
> 551/1102 degraded (50.000%); 1/2 osds down, 1/2 osds out' (0)
>
> root@test2:~# ceph osd stat
> 2011-06-11 17:03:48.071885 mon <- [osd,stat]
> 2011-06-11 17:03:48.073290 mon1 -> 'e31: 2 osds: 1 up, 1 in' (0)
>
> root@test2:~# ceph mds stat
> 2011-06-11 17:03:54.868986 mon <- [mds,stat]
> 2011-06-11 17:03:54.870418 mon1 -> 'e48: 1/1/1 up {0=3Dtest4=3Dup:act=
ive},
> 1 up:standby' (0)
>
> root@test2:~# ceph mon stat
> 2011-06-11 17:04:09.638549 mon <- [mon,stat]
> 2011-06-11 17:04:09.639994 mon0 -> 'e1: 3 mons at
> {0=3D10.1.56.231:6789/0,1=3D10.1.56.232:6789/0,2=3D10.1.56.233:6789/0=
},
> election epoch 508, quorum 0,1,2' (0)
>
> How could it be, is it a bug ?
> (be sure I triple checked that my 2 osd nodes are really shutdown)
>
> Thanks !
> Wilfrid
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
