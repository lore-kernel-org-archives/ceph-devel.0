From: hnuzhoulin <hnuzhoulin2@gmail.com>
Subject: an osd feign death,but ceph health is ok
Date: Mon, 11 Jan 2016 16:08:04 +0800
Message-ID: <op.ya2d7qwl6jkj1f@zhoulindemacbook-pro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35597 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758561AbcAKIIU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jan 2016 03:08:20 -0500
Received: by mail-pa0-f51.google.com with SMTP id ho8so56929102pac.2
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jan 2016 00:08:20 -0800 (PST)
Received: from zhoulindemacbook-pro.local ([183.62.249.162])
        by smtp.gmail.com with ESMTPSA id 79sm3078027pfk.28.2016.01.11.00.08.15
        for <ceph-devel@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 11 Jan 2016 00:08:18 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,guys.
right now,I face a problem in my openstack+ceph.
some vm can not start and some occur blue screen=A1=A3

the output of ceph -s say the cluster is OK.

So I using following command to check the volume first:
rbd ls -p volumes|while read line;do rbd info $line -p volumes ;done

then quickly I get a error:
2016-01-11 15:23:13.574314 7f8d95d8a700  0 -- 10.1.41.52:0/1003136 >> =20
192.168.1.5:6805/18353 pipe(0x22d3bc0 sd=3D4 :0 s=3D1 pgs=3D0 cs=3D0 l=3D=
1 =20
c=3D0x22d3e50).fault

so I restart the osd which pid is 18353 in host 192.168.1.5

then it spend some time to recovery,when it become OK again.I can resta=
rt =20
vm as normal now.

so my problem is,how can I know whether occur feign death that ceph -s =
can =20
not monitor.

My ceoh is firefly 0.80.7

Thanks


-------------------------
hnuzhoulin@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
