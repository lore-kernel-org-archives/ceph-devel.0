From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Re: Files lost after mds rebuild
Date: Tue, 20 Nov 2012 09:58:27 +0800
Message-ID: <CAJiejCSRwOV12098uGGVOg9J38oYNSwYeHcqb7DKEtycL6m10Q@mail.gmail.com>
References: <CAJiejCTWvtn6yS+_9h07t4KWqRHPqT-Oe23KtXmnvf7ZZbsAAw@mail.gmail.com>
 <CAPYLRzikTGx=c+qJazxL=6amBj-GYT6fm9-noKmDGcABnAUUjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:45495 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab2KTB6r convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 20:58:47 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so3878819iay.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 17:58:47 -0800 (PST)
In-Reply-To: <CAPYLRzikTGx=c+qJazxL=6amBj-GYT6fm9-noKmDGcABnAUUjw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2012/11/20 Gregory Farnum <greg@inktank.com>:
> On Mon, Nov 19, 2012 at 7:55 AM, Drunkard Zhang <gongfan193@gmail.com=
> wrote:
>> I created a ceph cluster for test, here's mistake I made:
>> Add a second mds: mds.ab, executed 'ceph mds set_max_mds 2', then
>> removed the mds just added;
>> Then 'ceph mds set_max_mds 1', the first mds.aa crashed, and became =
laggy.
>> As I can't repair mds.aa, so did 'ceph mds newfs metadata data
>> --yes-i-really-mean-it';
>
> So this command is a mkfs sort of thing. It's deleted all the
> "allocation tables" and filesystem metadata in favor of new, empty
> ones. You should not run "--yes-i-really-mean-it" commands if you
> don't know exactly what the command is doing and why you're using it.
>
>> mds.aa was back, but 1TB data was in cluster lost, but disk space
>> still used, by 'ceps -s'.
>>
>> Is there any chance I can get my data back? If can't, how can I
>> retrieve back the disk space.
>
> There's not currently a great way to get that data back. With
> sufficient energy it could be re-constructed by looking through all
> the RADOS objects and putting something together.
> To retrieve the disk space, you'll want to delete the "data" and
> "metadata" RADOS pools. This will of course *eliminate* the data you
> have in your new filesystem, so grab that out first if there's
> anything there you care about. Then create the pools and run the newf=
s
> command again.
> Also, you've got the syntax wrong on that newfs command. You should b=
e
> using pool IDs:
> "ceph mds newfs 1 0 --yes-i-really-mean-it"
> (Though these IDs may change after re-creating the pools.)
> -Greg
>
Thanks, I got you.

>
>> Now it looks like:
>> log3 ~ # ceph -s
>>    health HEALTH_OK
>>    monmap e1: 1 mons at {log3=3D10.205.119.2:6789/0}, election epoch=
 0,
>> quorum 0 log3
>>    osdmap e1555: 28 osds: 20 up, 20 in
>>     pgmap v56518: 960 pgs: 960 active+clean; 1134 GB data, 2306 GB
>> used, 51353 GB / 55890 GB avail
>>    mdsmap e703: 1/1/1 up {0=3Daa=3Dup:active}, 1 up:standby
>>
>> log3 ~ # df | grep osd |sort
>> /dev/sdb1       2.8T  124G  2.5T   5% /ceph/osd.0
>> /dev/sdc1       2.8T  104G  2.6T   4% /ceph/osd.1
>> /dev/sdd1       2.8T   84G  2.6T   4% /ceph/osd.2
>> /dev/sde1       2.8T  117G  2.6T   5% /ceph/osd.3
>> /dev/sdf1       2.8T  105G  2.6T   4% /ceph/osd.4
>> /dev/sdg1       2.8T   84G  2.6T   4% /ceph/osd.5
>> /dev/sdh1       2.8T  140G  2.5T   6% /ceph/osd.6
>> /dev/sdi1       2.8T  134G  2.5T   5% /ceph/osd.8
>> /dev/sdj1       2.8T  112G  2.6T   5% /ceph/osd.7
>> /dev/sdk1       2.8T  159G  2.5T   6% /ceph/osd.9
>> /dev/sdl1       2.8T  126G  2.5T   5% /ceph/osd.10
>>
>> osd on another host didn't show.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
=E5=BC=A0=E7=BB=8D=E6=96=87
gongfan193@gmail.com
zhangsw@gwbnsh.net.cn
18601633785
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
