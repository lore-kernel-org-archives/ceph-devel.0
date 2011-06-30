From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: MDS Replay Issues
Date: Thu, 30 Jun 2011 15:24:36 -0700
Message-ID: <BANLkTikEnx-emjMs=XyxuzHzvJq3jd+GTA@mail.gmail.com>
References: <B828A4C02BE12543ACDFCF7EB0C693C678862E5C65@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35609 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab1F3WZH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2011 18:25:07 -0400
Received: by vws1 with SMTP id 1so1986260vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Jun 2011 15:25:06 -0700 (PDT)
In-Reply-To: <B828A4C02BE12543ACDFCF7EB0C693C678862E5C65@NC-SVR-09.netelligent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nigh <mnigh@netelligent.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Looks like you set your max_mds to be 2 at some point (note the 2/2/2
up -- that's 2 up out of 2 logical MDSes with a max_mds of 2).
Otherwise the system wouldn't let them both into replay unless there's
some bug that's increasing it.
Trying this myself, I started up one of each kind of node in a
cluster, then started up a new cmds and it went into standby like it
should.
-Greg

On Thu, Jun 30, 2011 at 2:41 PM, Mark Nigh <mnigh@netelligent.com> wrot=
e:
> I build a new cluster today with the latest commit
>
> ceph version 0.30-222-g310032e (commit:310032ee8128f6417ac302c0f5ecd2=
7c691cbcc7)
>
> I had a working file system until I created another mds on my second =
node. At that time, both mds were in active (which I think is incorrect=
) so I rebooted the second mds in the hopes it would go to standby, but=
 it went into replay. I rebooted the first mds and that is now in repla=
y.
>
> root@ceph00:/var/log/ceph# ceph -s
> 2011-06-30 16:40:10.000802 =A0 =A0pg v613: 1188 pgs: 1188 active+clea=
n; 43 KB data, 22160 KB used, 33442 GB / 33466 GB avail
> 2011-06-30 16:40:10.003563 =A0 mds e22: 2/2/2 up {0=3D0=3Dup:replay,1=
=3D1=3Dup:replay}
> 2011-06-30 16:40:10.003602 =A0 osd e44: 12 osds: 12 up, 12 in
> 2011-06-30 16:40:10.003686 =A0 log 2011-06-30 16:13:54.782061 mon0 10=
=2E6.1.80:6789/0 5 : [INF] mds? 10.6.1.80:6800/6886 up:boot
> 2011-06-30 16:40:10.003770 =A0 mon e1: 1 mons at {0=3D10.6.1.80:6789/=
0}
>
> The replay has been happening a lot lately so I expect I am doing som=
ething wrong. Here is the end of the mds logs.
>
> 2011-06-30 16:13:50.650812 7f199aa27760 ceph version 0.30-222-g310032=
e.commit: 310032ee8128f6417ac302c0f5ecd27c691cbcc7. process: cmds. pid:=
 6886
> 2011-06-30 16:13:50.652738 7f199774a700 mds-1.0 ms_handle_connect on =
10.6.1.80:6789/0
> 2011-06-30 16:13:54.782292 7f199774a700 mds-1.0 handle_mds_map standb=
y
> 2011-06-30 16:14:02.580014 7f199774a700 mds0.3 handle_mds_map i am no=
w mds0.3
> 2011-06-30 16:14:02.580035 7f199774a700 mds0.3 handle_mds_map state c=
hange up:standby --> up:replay
> 2011-06-30 16:14:02.580042 7f199774a700 mds0.3 replay_start
> 2011-06-30 16:14:02.580055 7f199774a700 mds0.3 =A0recovery set is 1
> 2011-06-30 16:14:02.580063 7f199774a700 mds0.3 =A0need osdmap epoch 4=
3, have 42
> 2011-06-30 16:14:02.580070 7f199774a700 mds0.3 =A0waiting for osdmap =
43 (which blacklists prior instance)
> 2011-06-30 16:14:02.580100 7f199774a700 mds0.cache handle_mds_failure=
 mds0 : recovery peers are 1
>
> Thanks for your help.
>
> Mark Nigh
> Systems Architect
> mnigh@netelligent.com
> =A0(p) 314.392.6926
>
>
>
> This transmission and any attached files are privileged, confidential=
 or otherwise the exclusive property of the intended recipient or Netel=
ligent Corporation. If you are not the intended recipient, any disclosu=
re, copying, distribution or use of any of the information contained in=
 or attached to this transmission is strictly prohibited. If you have r=
eceived this transmission in error, please contact us immediately by re=
sponding to this message or by telephone (314-392-6900) and promptly de=
stroy the original transmission and its attachments.
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
