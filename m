From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Random blocks when accessing rbd images
Date: Thu, 15 Dec 2011 13:28:14 -0800
Message-ID: <CACLRD_2XOOPkegpp5M=L2WLJUO_YMdB97EHd0K-9=n=yRwb5Tw@mail.gmail.com>
References: <1404301.on6okQVZ04@pc10>
	<3807778.ycpoZxnZL4@pc10>
	<CACLRD_1LPhCC3szKfsj_pZ6-5rr=pr+P8KyWO76CxU6x0K17mA@mail.gmail.com>
	<6461662.le4U8ybEo2@pc10>
	<4EEA2D58.2090601@grnet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45915 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855Ab1LOV2Q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2011 16:28:16 -0500
Received: by faar15 with SMTP id r15so2709277faa.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2011 13:28:15 -0800 (PST)
In-Reply-To: <4EEA2D58.2090601@grnet.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is likely the problem.  I'll try to reproduce it today. (Meant to
post this to the list the first time)
-Sam

On Thu, Dec 15, 2011 at 9:24 AM, Stratos Psomadakis <psomas@grnet.gr> w=
rote:
> On 12/15/2011 06:44 PM, Guido Winkelmann wrote:
>> Am Donnerstag, 15. Dezember 2011, 08:30:26 schrieben Sie:
>>> 'ceph pg dump' will tell you the status (active/clean/scrubbing/etc=
)
>>> for each pg. =C2=A0Does the same pg remain in state active+clean+sc=
rubbing
>>> for more than 10 minutes?
>> Well, I used ceph -s, which only gave me a summary, but there defini=
tely was a
>> PG that was in active+clean+scrubbing for a long time (a lot longer =
than 10
>> minutes), and remained so until I restarted one of the osds.
>>
>> Unfortunately I don't know how to reliably reproduce the problem, so=
 I can't
>> check now...
> When I hit that bug, I was able to trigger it (more easily) by settin=
g:
> =C2=A0 =C2=A0osd scrub max interval =3D 120
> in the [osd] section in ceph.conf, forcing the cluster to send pg scr=
ubs
> more often.
>
> Now, if you stress the cluster a bit (some heavy I/O), coupled with
> singe OSD restarts, I think you could be able to trigger it.
>
> Btw, I was using the rbd in-kernel driver.
>
> Some info from the debugging I did, I think that at some point after
> setting finalizing_scrub =3D true, it turns out that (last_update_app=
lied
> !=3D info.last_update), but the scrub operation is never requeued by
> op_applied for some reason, and so the PG is stuck as scrubbing.
>
>> =C2=A0 =C2=A0 =C2=A0 Guido
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
> --
> Stratos Psomadakis
> <psomas@grnet.gr>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
