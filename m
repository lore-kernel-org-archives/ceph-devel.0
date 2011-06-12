From: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Subject: Re: OSD wrongly marked up (well, half up)
Date: Sun, 12 Jun 2011 14:21:25 +0200
Message-ID: <BANLkTik9w5F5XnV4R-JPWYZmZQ1vw9kd6Q@mail.gmail.com>
References: <BANLkTimJZ=zpr0VoiSDK34Dkc4sVZeqX=w@mail.gmail.com>
	<BANLkTinf3vucv+=+Xpj1G=ocTEOQbqO-CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44584 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233Ab1FLMV0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Jun 2011 08:21:26 -0400
Received: by gxk21 with SMTP id 21so2501956gxk.19
        for <ceph-devel@vger.kernel.org>; Sun, 12 Jun 2011 05:21:25 -0700 (PDT)
In-Reply-To: <BANLkTinf3vucv+=+Xpj1G=ocTEOQbqO-CA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

Thank you very much Colin !

I was trying to check the different variable set on OSD, MDS and MON
but realized that we can't dump the conf of a MON.

 ceph osd dump -o - and  ceph mds dump -o - works fine to see
different variables but it's not working for MONs.
Do we have to use a different syntax to dump out the mon conf or is it
planned to port the dump feature for mon as well ?

Regards,
Wilfrid

2011/6/12 Colin McCabe <cmccabe@alumni.cmu.edu>:
> On Sat, Jun 11, 2011 at 2:08 PM, Wilfrid Allembrand
> <wilfrid.allembrand@gmail.com> wrote:
>> Hi all,
>>
>> On my test cluster I have 3 MON, 2 MDS and 2 OSD. I'm doing some
>> failover test on OSD and got a strange thing on the status.
>> The 2 nodes hosting the OSDs have been shutdown but the status conti=
nu
>> to 'see' one alive :
>
> Hi Wilfrid,
>
> Usually OSDMaps are propagated peer-to-peer amongst the OSDs. This
> means that OSDs that go down are rapidly detected. However, when all
> OSDs go down, there are no more OSDs to send OSDmaps. In this case, w=
e
> rely on a timeout in the monitor to determine that all the OSDs are
> down.
>
> After mon_osd_report_timeout seconds elapse without an osdmap being
> sent from an OSD, the monitor marks it down. The default is 900
> seconds or 15 minutes. So once you wait for 15 minutes, all the OSDs
> should be marked as down.
>
> sincerely,
> Colin
>
>
>>
>> # ceph -v
>> ceph version 0.29 (commit:8e69c39f69936e2912a887247c6e268d1c9059ed)
>> # uname -a
>> Linux test2 2.6.38-8-server #42-Ubuntu SMP Mon Apr 11 03:49:04 UTC
>> 2011 x86_64 x86_64 x86_64 GNU/Linux
>>
>> root@test2:~# ceph health
>> 2011-06-11 17:03:38.492734 mon <- [health]
>> 2011-06-11 17:03:38.493913 mon1 -> 'HEALTH_WARN 594 pgs degraded,
>> 551/1102 degraded (50.000%); 1/2 osds down, 1/2 osds out' (0)
>>
>> root@test2:~# ceph osd stat
>> 2011-06-11 17:03:48.071885 mon <- [osd,stat]
>> 2011-06-11 17:03:48.073290 mon1 -> 'e31: 2 osds: 1 up, 1 in' (0)
>>
>> root@test2:~# ceph mds stat
>> 2011-06-11 17:03:54.868986 mon <- [mds,stat]
>> 2011-06-11 17:03:54.870418 mon1 -> 'e48: 1/1/1 up {0=3Dtest4=3Dup:ac=
tive},
>> 1 up:standby' (0)
>>
>> root@test2:~# ceph mon stat
>> 2011-06-11 17:04:09.638549 mon <- [mon,stat]
>> 2011-06-11 17:04:09.639994 mon0 -> 'e1: 3 mons at
>> {0=3D10.1.56.231:6789/0,1=3D10.1.56.232:6789/0,2=3D10.1.56.233:6789/=
0},
>> election epoch 508, quorum 0,1,2' (0)
>>
>> How could it be, is it a bug ?
>> (be sure I triple checked that my 2 osd nodes are really shutdown)
>>
>> Thanks !
>> Wilfrid
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
