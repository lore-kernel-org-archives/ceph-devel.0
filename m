From: "huangyellowhuang" <huangyellowhuang@163.com>
Subject: ceph on ubuntu and centos
Date: Sat, 5 Oct 2013 09:33:49 +0800
Message-ID: <005e01cec16a$f1f54400$d5dfcc00$@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m12-18.163.com ([220.181.12.18]:39590 "EHLO m12-18.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592Ab3JEBd5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Oct 2013 21:33:57 -0400
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,all
We test the ceph version 0.69 (6ca6f2f9f754031f4acdb971b71c92c9762e18c3=
) on
Ubuntu server 13.10 and centos 6.4 final
Our cluster configuration:
3 host machine, each runs 3 OSDs(use XFS as backend fs),MON and MDS run=
s on
one of the three host,
We have one KClient on Ubuntu server 13.10

The cluster runs on Ubuntu works fine and a few =91slow requests=92 msg=
s, about
100MB/s write speed.=20
But the cluster runs on centos is very bad, avg 30MB/s write speed, man=
y osd
requests slow:
2013-10-05=A008:35:09.931145=A0mon.0=A0[INF]=A0pgmap=A0v928:=A0192=A0pg=
s:=A0192=A0active+clean
;=A050873=A0MB=A0data,=A0101716=A0MB=A0used,=A013857=A0GB=A0/=A013956=A0=
GB=A0avail;=A0115=A0MB/s=A0wr,=A028=A0
op/s
2013-10-05=A008:35:12.087614=A0mon.0=A0[INF]=A0pgmap=A0v929:=A0192=A0pg=
s:=A0192=A0active+clean
;=A050901=A0MB=A0data,=A0101780=A0MB=A0used,=A013857=A0GB=A0/=A013956=A0=
GB=A0avail;=A032593=A0KB/s=A0wr,=A08
=A0op/s
2013-10-05=A008:35:03.963979=A0osd.0=A0[WRN]=A037=A0slow=A0requests,=A0=
1=A0included=A0below;=A0o
ldest=A0blocked=A0for=A0>=A0798.235962=A0secs
2013-10-05=A008:35:03.963984=A0osd.0=A0[WRN]=A0slow=A0request=A0240.831=
078=A0seconds=A0old,=A0
received=A0at=A02013-10-05=A008:31:03.132836:=A0osd_op(mds.0.1:375=A020=
0.00000000=A0[wri
tefull=A00~84]=A01.844f3494=A0e47)=A0v4=A0currently=A0no=A0flag=A0point=
s=A0reached
2013-10-05=A008:35:08.965134=A0osd.0=A0[WRN]=A037=A0slow=A0requests,=A0=
1=A0included=A0below;=A0o
ldest=A0blocked=A0for=A0>=A0803.237127=A0secs
2013-10-05=A008:35:08.965139=A0osd.0=A0[WRN]=A0slow=A0request=A0480.312=
618=A0seconds=A0old,=A0
received=A0at=A02013-10-05=A008:27:08.652461:=A0osd_op(mds.0.1:307=A020=
0.00000000=A0[wri
tefull=A00~84]=A01.844f3494=A0e47)=A0v4=A0currently=A0no=A0flag=A0point=
s=A0reached
2013-10-05=A008:35:10.965619=A0osd.0=A0[WRN]=A037=A0slow=A0requests,=A0=
1=A0included=A0below;=A0o
ldest=A0blocked=A0for=A0>=A0805.237600=A0secs
2013-10-05=A008:35:10.965624=A0osd.0=A0[WRN]=A0slow=A0request=A0120.946=
652=A0seconds=A0old,=A0
received=A0at=A02013-10-05=A008:33:10.018900:=A0osd_op(mds.0.1:404=A020=
0.00000000=A0[wri
tefull=A00~84]=A01.844f3494=A0e47)=A0v4=A0currently=A0no=A0flag=A0point=
s=A0reached
2013-10-05=A008:35:11.965986=A0osd.0=A0[WRN]=A037=A0slow=A0requests,=A0=
1=A0included=A0below;=A0o
ldest=A0blocked=A0for=A0>=A0806.237800=A0secs
2013-10-05=A008:35:11.965992=A0osd.0=A0[WRN]=A0slow=A0request=A060.4743=
14=A0seconds=A0old,=A0r
eceived=A0at=A02013-10-05=A008:34:11.491438:=A0osd_op(mds.0.1:430=A0200=
=2E00000000=A0[writ
efull=A00~84]=A01.844f3494=A0e47)=A0v4=A0currently=A0no=A0flag=A0points=
=A0reached

And we need to build a cluster have 4 hosts, each has 18 OSDs and 1 kcl=
ient,
every kclient server as samba server that serves 4 samba clients.
1) Which linux distrubtion should we used? Centos or Ubuntu?
2) What results in ceph performances so large on different distribution=
?=20
3) It seems the bottleneck is underlayer fs can not handle requests fas=
t as
ceph expect, bc the =91slow requests=92 shows if a request does not han=
dle after
30s.

Thanks!



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
