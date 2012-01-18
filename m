From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <slawomir.skowron@gmail.com>
Subject: Re: Adding new mon to existing cluster in ceph v0.39(+?)
Date: Wed, 18 Jan 2012 09:42:42 +0100
Message-ID: <CAMwB3TgyYOfxGLFUiYc4qz1Av1ut+v=XS4rZ6D4kTWkUST0ubA@mail.gmail.com>
References: <CAMwB3TgxYQ8BsLCfTp+6-ZB_g0V4VGGDFqLxvxKmo3773CTwiA@mail.gmail.com>
	<CACLRD_1-ur_e4HMB4mp_FRiNzB2j8e_3N=L7Wt2feRnX3hzNQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37080 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075Ab2ARImn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2012 03:42:43 -0500
Received: by bkas6 with SMTP id s6so2534686bka.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2012 00:42:42 -0800 (PST)
In-Reply-To: <CACLRD_1-ur_e4HMB4mp_FRiNzB2j8e_3N=L7Wt2feRnX3hzNQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Now i don't remember message but it was about a public-addr of mon in
conf, and problem with no new mon in monmap. My mon section looks like
this:

        mon data =3D /vol0/data/mon.$id

        ; some minimal logging (just message traffic) to aid debugging

        debug ms =3D 1     ; see message traffic
        debug mon =3D 0   ; monitor
        debug paxos =3D 0 ; monitor replication
        debug auth =3D 0  ;

        mon allowed clock drift =3D 2

[mon.0]
        host =3D s3-10-177-64-4
        mon addr =3D 10.177.64.4:6789

[mon.1]
        host =3D s3-10-177-64-6
        mon addr =3D 10.177.64.6:6789

[mon.2]
        host =3D s3-10-177-64-8
        mon addr =3D 10.177.64.8:6789

But as i can see there is a updated doc, about adding new mon.

2012/1/10 Samuel Just <sam.just@dreamhost.com>:
> It looks like in step one you needed to supply a either monmap or
> addresses of existing monitors. =C2=A0What errors did you encounter?
> -Sam
>
> 2012/1/10 S=C5=82awomir Skowron <slawomir.skowron@gmail.com>:
>> I have some problem with adding a new mon to existing ceph cluster.
>>
>> Now cluster contains a 3 mon's, but i started with only one in one
>> machine. Then adding a second, and third machine, with new mon's, an=
d
>> OSD. Adding, a new OSD is quiet simple, but adding, a new mon is
>> compilation of some pieces in old doc of ceph, new doc, and a group
>> mails.
>>
>> This -> http://ceph.newdream.net/docs/latest/ops/manage/grow/mon/ -
>> not working properly in section (Adding a monitor)
>>
>> Maybe this will be useful for someone:
>>
>> 1. Create a new mon structure with existing one working mon instance=
,
>> maybe created with mkcepfs in init of cluster.
>>
>> =C2=A0a) edit ceph.conf, and add new mon definition in mon part of c=
onf in
>> whole cluster.
>>
>> =C2=A0b) ceph auth get mon. -o /tmp/monkey
>>
>> =C2=A0c) fsid=3D`ceph fsid --concise`
>>
>> =C2=A0d) ceph-mon -i <new-mon-id> --mkfs -k /tmp/monkey --fsid $fsid
>>
>> 2. Before you start new mon (check if new mon is not working - in my
>> case it's not starting even if i try :)), some things musts be done
>> before.
>> It's based on http://ceph.newdream.net/docs/latest/ops/manage/grow/m=
on/
>> (Removing a monitor from an unhealthy or down cluster)
>>
>> =C2=A0a) On a surviving monitor node, find the most recent monmap in=
 mon
>> dir, like in doc about removing monitor.
>>
>> =C2=A0b) On a surviving monitor node:
>>
>> =C2=A0 $ cp $mon_data/monmap/<latest-monmap-id> /tmp/foo
>> =C2=A0 $ monmaptool /tmp/foo --add <new-mon-id> <new-mon-ip>:<new-mo=
n-port>
>>
>> =C2=A0c) Inject a new monmap to working ceph mon.
>>
>> =C2=A0 =C2=A0 ceph-mon -i <surviving-mon-id> --inject-monmap /tmp/fo=
o
>>
>> =C2=A0 =C2=A0 ceph -s will show new number of mons.
>>
>> =C2=A0d) copy /tmp/foo, and inject this monmap, to every mon, that w=
orks
>> in existing cluster, even on machine with new mon to update, a monma=
p
>> in new mon directory.
>>
>> =C2=A0e) Start new mon:
>>
>> =C2=A0 service ceph start mon
>>
>> then mon_status will show a new list of mon in ceph cluster.
>>
>> =C2=A0 ceph mon_status
>>
>> Now new mon works perfect.
>>
>>
>> Maybe it's not a supported way to insert a new mon to cluster, but f=
or
>> me now it's only way that works :)
>>
>> --
>> -----
>> Pozdrawiam
>>
>> S=C5=82awek "sZiBis" Skowron
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml



--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
