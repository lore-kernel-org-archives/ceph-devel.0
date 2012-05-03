From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Possible memory leak in mon?
Date: Wed, 2 May 2012 23:53:06 -0700
Message-ID: <A1BA6F85E3224387AFB0C24A7786B470@dreamhost.com>
References: <4FA1B50B.8080603@bashkirtsev.com>
 <07C999FE3BF7420ABC05B7CFF88B06AD@dreamhost.com>
 <4FA22490.5060001@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34201 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab2ECGxK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 May 2012 02:53:10 -0400
Received: by obbtb18 with SMTP id tb18so2077251obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 May 2012 23:53:10 -0700 (PDT)
In-Reply-To: <4FA22490.5060001@bashkirtsev.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel@vger.kernel.org

On Wednesday, May 2, 2012 at 11:24 PM, Vladimir Bashkirtsev wrote:
> Greg,
> =20
> Apologies for multiple emails: my mail server is backed by ceph now a=
nd =20
> it struggled this morning (separate issue). So my mail server reporte=
d =20
> back to my mailer that sending of email failed when obviously it was =
not =20
> the case.

Interesting =E2=80=94 I presume you're using the file system? That's no=
t something we've heard of anybody doing with Ceph before. :)

> =20
> [root@gamma ~]# ceph -s
> 2012-05-03 15:46:55.640951 mds e2666: 1/1/1 up {0=3D1=3Dup:active}, 1=
 =20
> up:standby
> 2012-05-03 15:46:55.647106 osd e10728: 6 osds: 6 up, 6 in
> 2012-05-03 15:46:55.654052 log 2012-05-03 15:46:26.557084 mon.2 =20
> 172.16.64.202:6789/0 2878 : [INF] mon.2 calling new monitor election
> 2012-05-03 15:46:55.654425 mon e7: 3 mons at =20
> {0=3D172.16.64.200:6789/0,1=3D172.16.64.201:6789/0,2=3D172.16.64.202:=
6789/0}
> 2012-05-03 15:46:56.961624 pg v1251669: 600 pgs: 2 creating, 598 =20
> active+clean; 309 GB data, 963 GB used, 1098 GB / 2145 GB avail
> =20
> Loggin is on but nothing obvious in there: logs quite small. Number o=
f =20
> ceph health logged (ceph monitored by nagios and so this record appea=
rs =20
> every 5 minutes), monitors periodically call for election (different =
=20
> periods between 1 to 15 minutes as it looks). That's it.

Hrm. Generally speaking the monitors shouldn't call for elections unles=
s something changes (one of them crashes) or the leader monitor is slow=
ing down.
Can you increase the debug_mon to 20, the debug_ms to 1, and post one o=
f the logs somewhere? The "Live Debugging" section of http://ceph.com/w=
iki/Debugging should give you what you need. :)
 =20
> =20
> Regards,
> Vladimir


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
