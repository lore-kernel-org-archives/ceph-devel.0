From: "changtao381" <changtao381@163.com>
Subject: pg scrub check problem
Date: Wed, 28 Oct 2015 17:39:09 +0800
Message-ID: <000001d11164$7fa470a0$7eed51e0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m12-14.163.com ([220.181.12.14]:45679 "EHLO m12-14.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932627AbbJ1JjQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Oct 2015 05:39:16 -0400
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'ceph-devel' <ceph-devel@vger.kernel.org>

Hi,

I=E2=80=99m testing the deep-scrub function of ceph.  And the test step=
s are below :

1)  I put an object on ceph using command :
 rados put test.txt test.txt =E2=80=93p testpool

The size of testpool is 3, so there three replicates on three osds:

osd.0:   /data1/ceph_data/osd.0/current/1.0_head/test.txt__head_8B0B610=
8__1
osd.1:   /data2/ceph_data/osd.1/current/1.0_head/test.txt__head_8B0B610=
8__1
osd.2    /data3/ceph_data/osd.2/current/1.0_head/test.txt__head_8B0B610=
8__1

2) I modified the content of one replica on osd.0 using vim editor dire=
ctly on disk

3) I run the command=20
=E3=80=80ceph pg deep-scrub 1.0

and expect it can check the inconsistent error out, but it fails. It do=
esn=E2=80=99t find the error
why?=20

Any suggestions will be appreciated! Thanks


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
