From: Samuel Just <sam.just@inktank.com>
Subject: Re: ceph on ubuntu and centos
Date: Mon, 7 Oct 2013 13:13:36 -0700
Message-ID: <CA+4uBUZuaTJD8Ji0NK7A7ti7j=Ue3MibSX0Cbt+hvH-9wY_KNA@mail.gmail.com>
References: <005e01cec16a$f1f54400$d5dfcc00$@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:62437 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756650Ab3JGUNi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Oct 2013 16:13:38 -0400
Received: by mail-ee0-f50.google.com with SMTP id d51so3526327eek.37
        for <ceph-devel@vger.kernel.org>; Mon, 07 Oct 2013 13:13:36 -0700 (PDT)
In-Reply-To: <005e01cec16a$f1f54400$d5dfcc00$@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huangyellowhuang <huangyellowhuang@163.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Interesting!  What kernel versions were running on the 13.10 and
centos 6.4 clusters?
-Sam

On Fri, Oct 4, 2013 at 6:33 PM, huangyellowhuang
<huangyellowhuang@163.com> wrote:
> Hi,all
> We test the ceph version 0.69 (6ca6f2f9f754031f4acdb971b71c92c9762e18=
c3) on
> Ubuntu server 13.10 and centos 6.4 final
> Our cluster configuration:
> 3 host machine, each runs 3 OSDs(use XFS as backend fs),MON and MDS r=
uns on
> one of the three host,
> We have one KClient on Ubuntu server 13.10
>
> The cluster runs on Ubuntu works fine and a few =91slow requests=92 m=
sgs, about
> 100MB/s write speed.
> But the cluster runs on centos is very bad, avg 30MB/s write speed, m=
any osd
> requests slow:
> 2013-10-05 08:35:09.931145 mon.0 [INF] pgmap v928: 192 pgs: 192 activ=
e+clean
> ; 50873 MB data, 101716 MB used, 13857 GB / 13956 GB avail; 115 MB/s =
wr, 28
> op/s
> 2013-10-05 08:35:12.087614 mon.0 [INF] pgmap v929: 192 pgs: 192 activ=
e+clean
> ; 50901 MB data, 101780 MB used, 13857 GB / 13956 GB avail; 32593 KB/=
s wr, 8
>  op/s
> 2013-10-05 08:35:03.963979 osd.0 [WRN] 37 slow requests, 1 included b=
elow; o
> ldest blocked for > 798.235962 secs
> 2013-10-05 08:35:03.963984 osd.0 [WRN] slow request 240.831078 second=
s old,
> received at 2013-10-05 08:31:03.132836: osd_op(mds.0.1:375 200.000000=
00 [wri
> tefull 0~84] 1.844f3494 e47) v4 currently no flag points reached
> 2013-10-05 08:35:08.965134 osd.0 [WRN] 37 slow requests, 1 included b=
elow; o
> ldest blocked for > 803.237127 secs
> 2013-10-05 08:35:08.965139 osd.0 [WRN] slow request 480.312618 second=
s old,
> received at 2013-10-05 08:27:08.652461: osd_op(mds.0.1:307 200.000000=
00 [wri
> tefull 0~84] 1.844f3494 e47) v4 currently no flag points reached
> 2013-10-05 08:35:10.965619 osd.0 [WRN] 37 slow requests, 1 included b=
elow; o
> ldest blocked for > 805.237600 secs
> 2013-10-05 08:35:10.965624 osd.0 [WRN] slow request 120.946652 second=
s old,
> received at 2013-10-05 08:33:10.018900: osd_op(mds.0.1:404 200.000000=
00 [wri
> tefull 0~84] 1.844f3494 e47) v4 currently no flag points reached
> 2013-10-05 08:35:11.965986 osd.0 [WRN] 37 slow requests, 1 included b=
elow; o
> ldest blocked for > 806.237800 secs
> 2013-10-05 08:35:11.965992 osd.0 [WRN] slow request 60.474314 seconds=
 old, r
> eceived at 2013-10-05 08:34:11.491438: osd_op(mds.0.1:430 200.0000000=
0 [writ
> efull 0~84] 1.844f3494 e47) v4 currently no flag points reached
>
> And we need to build a cluster have 4 hosts, each has 18 OSDs and 1 k=
client,
> every kclient server as samba server that serves 4 samba clients.
> 1) Which linux distrubtion should we used? Centos or Ubuntu?
> 2) What results in ceph performances so large on different distributi=
on?
> 3) It seems the bottleneck is underlayer fs can not handle requests f=
ast as
> ceph expect, bc the =91slow requests=92 shows if a request does not h=
andle after
> 30s.
>
> Thanks!
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
