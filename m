From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Adding new mon to existing cluster in ceph v0.39(+?)
Date: Tue, 10 Jan 2012 14:19:27 -0800
Message-ID: <CACLRD_1-ur_e4HMB4mp_FRiNzB2j8e_3N=L7Wt2feRnX3hzNQg@mail.gmail.com>
References: <CAMwB3TgxYQ8BsLCfTp+6-ZB_g0V4VGGDFqLxvxKmo3773CTwiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:54548 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712Ab2AJWTa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jan 2012 17:19:30 -0500
Received: by werm1 with SMTP id m1so51342wer.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jan 2012 14:19:27 -0800 (PST)
In-Reply-To: <CAMwB3TgxYQ8BsLCfTp+6-ZB_g0V4VGGDFqLxvxKmo3773CTwiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?S=C5=82awomir_Skowron?= <slawomir.skowron@gmail.com>
Cc: ceph-devel@vger.kernel.org

It looks like in step one you needed to supply a either monmap or
addresses of existing monitors.  What errors did you encounter?
-Sam

2012/1/10 S=C5=82awomir Skowron <slawomir.skowron@gmail.com>:
> I have some problem with adding a new mon to existing ceph cluster.
>
> Now cluster contains a 3 mon's, but i started with only one in one
> machine. Then adding a second, and third machine, with new mon's, and
> OSD. Adding, a new OSD is quiet simple, but adding, a new mon is
> compilation of some pieces in old doc of ceph, new doc, and a group
> mails.
>
> This -> http://ceph.newdream.net/docs/latest/ops/manage/grow/mon/ -
> not working properly in section (Adding a monitor)
>
> Maybe this will be useful for someone:
>
> 1. Create a new mon structure with existing one working mon instance,
> maybe created with mkcepfs in init of cluster.
>
> =C2=A0a) edit ceph.conf, and add new mon definition in mon part of co=
nf in
> whole cluster.
>
> =C2=A0b) ceph auth get mon. -o /tmp/monkey
>
> =C2=A0c) fsid=3D`ceph fsid --concise`
>
> =C2=A0d) ceph-mon -i <new-mon-id> --mkfs -k /tmp/monkey --fsid $fsid
>
> 2. Before you start new mon (check if new mon is not working - in my
> case it's not starting even if i try :)), some things musts be done
> before.
> It's based on http://ceph.newdream.net/docs/latest/ops/manage/grow/mo=
n/
> (Removing a monitor from an unhealthy or down cluster)
>
> =C2=A0a) On a surviving monitor node, find the most recent monmap in =
mon
> dir, like in doc about removing monitor.
>
> =C2=A0b) On a surviving monitor node:
>
> =C2=A0 $ cp $mon_data/monmap/<latest-monmap-id> /tmp/foo
> =C2=A0 $ monmaptool /tmp/foo --add <new-mon-id> <new-mon-ip>:<new-mon=
-port>
>
> =C2=A0c) Inject a new monmap to working ceph mon.
>
> =C2=A0 =C2=A0 ceph-mon -i <surviving-mon-id> --inject-monmap /tmp/foo
>
> =C2=A0 =C2=A0 ceph -s will show new number of mons.
>
> =C2=A0d) copy /tmp/foo, and inject this monmap, to every mon, that wo=
rks
> in existing cluster, even on machine with new mon to update, a monmap
> in new mon directory.
>
> =C2=A0e) Start new mon:
>
> =C2=A0 service ceph start mon
>
> then mon_status will show a new list of mon in ceph cluster.
>
> =C2=A0 ceph mon_status
>
> Now new mon works perfect.
>
>
> Maybe it's not a supported way to insert a new mon to cluster, but fo=
r
> me now it's only way that works :)
>
> --
> -----
> Pozdrawiam
>
> S=C5=82awek "sZiBis" Skowron
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
