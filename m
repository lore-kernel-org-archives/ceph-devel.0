From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: improve speed with auth supported=none
Date: Thu, 15 Nov 2012 09:07:48 +0100
Message-ID: <50A4A2D4.2030003@profihost.ag>
References: <50A117B9.4060804@profihost.ag> <CAOLwVU=2BNvOs1SUqVrXS9Wajng5zk0mebnK3cZnZFO=rzrGbw@mail.gmail.com> <50A170BF.5030402@profihost.ag> <50A1F9F8.4030808@inktank.com> <50A1FC4D.8010000@profihost.ag> <50A39B9D.4080304@astranetwork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:57827 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992722Ab2KOIH4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 03:07:56 -0500
In-Reply-To: <50A39B9D.4080304@astranetwork.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Soporte <soporte@astranetwork.net>
Cc: "ce >> \"ceph-devel@vger.kernel.org\"" <ceph-devel@vger.kernel.org>

Am 14.11.2012 14:24, schrieb Soporte:
> El 13/11/2012 04:52 a.m., Stefan Priebe escribi=F3:
>> Am 13.11.2012 08:42, schrieb Josh Durgin:
>>> On 11/12/2012 01:57 PM, Stefan Priebe wrote:
>>>> Thanks,
>>>>
>>>> this gives another burst for iops. I'm now at 23.000 iops ;-) So f=
or
>>>> random 4k iops ceph auth and especially the logging is a lot of
>>>> overhead.
>>>
>>> How much difference did disabling auth make vs only disabling loggi=
ng?
>>
>> disable debug logging: 3000 iops
>> disable auth logging: 2000 iops
>>
>> Is anybody in the ceph team also interested in a call graph of kvm
>> when VM is doing random 4k write io?

> Hi.
>
> How disable debug and auth loggin in ceph.conf?

I have right now putted this stuff in all section - this is def.=20
overkill but i didn't know where to put which of them:
[global]
         auth cluster required =3D none
         auth service required =3D none
         auth supported =3D none
         auth client required =3D none

         debug lockdep =3D 0/0
         debug context =3D 0/0
         debug crush =3D 0/0
         debug buffer =3D 0/0
         debug timer =3D 0/0
         debug journaler =3D 0/0
         debug osd =3D 0/0
         debug optracker =3D 0/0
         debug objclass =3D 0/0
         debug filestore =3D 0/0
         debug journal =3D 0/0
         debug ms =3D 0/0
         debug monc =3D 0/0
         debug tp =3D 0/0
         debug auth =3D 0/0
         debug finisher =3D 0/0
         debug heartbeatmap =3D 0/0
         debug perfcounter =3D 0/0
         debug asok =3D 0/0
         debug throttle =3D 0/0

[mon]
         debug lockdep =3D 0/0
         debug context =3D 0/0
         debug crush =3D 0/0
         debug buffer =3D 0/0
         debug timer =3D 0/0
         debug journaler =3D 0/0
         debug osd =3D 0/0
         debug optracker =3D 0/0
         debug objclass =3D 0/0
         debug filestore =3D 0/0
         debug journal =3D 0/0
         debug ms =3D 0/0
         debug monc =3D 0/0
         debug tp =3D 0/0
         debug auth =3D 0/0
         debug finisher =3D 0/0
         debug heartbeatmap =3D 0/0
         debug perfcounter =3D 0/0
         debug asok =3D 0/0
         debug throttle =3D 0/0

[osd]
         debug lockdep =3D 0/0
         debug context =3D 0/0
         debug crush =3D 0/0
         debug buffer =3D 0/0
         debug timer =3D 0/0
         debug journaler =3D 0/0
         debug osd =3D 0/0
         debug optracker =3D 0/0
         debug objclass =3D 0/0
         debug filestore =3D 0/0
         debug journal =3D 0/0
         debug ms =3D 0/0
         debug monc =3D 0/0
         debug tp =3D 0/0
         debug auth =3D 0/0
         debug finisher =3D 0/0
         debug heartbeatmap =3D 0/0
         debug perfcounter =3D 0/0
         debug asok =3D 0/0
         debug throttle =3D 0/0


Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
