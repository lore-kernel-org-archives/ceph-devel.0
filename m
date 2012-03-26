From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Problems when startup ceph - mds always in creating status
Date: Mon, 26 Mar 2012 09:46:06 -0700
Message-ID: <CACLRD_3hEzw5ODFBSx4-Jwy+5-yLrz0ycWB0bD8LSq4aC2nBQA@mail.gmail.com>
References: <2d863c.50.1363edf5dd6.Coremail.lixiaobing10@otcaix.iscas.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:43874 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932824Ab2CZQqI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 12:46:08 -0400
Received: by wibhq7 with SMTP id hq7so4602534wib.1
        for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 09:46:06 -0700 (PDT)
In-Reply-To: <2d863c.50.1363edf5dd6.Coremail.lixiaobing10@otcaix.iscas.ac.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: lixiaobing10@otcaix.iscas.ac.cn
Cc: ceph-devel@vger.kernel.org

Can you post your ceph.conf?
-Sam

2012/3/23  <lixiaobing10@otcaix.iscas.ac.cn>:
> Hi ceph-devel,
>
> When I followed the instruction from 'Using Hadoop with Ceph' wiki to=
 let hadoop use ceph, I encountered a problem when I started ceph. Usin=
g 'ceph -s' command, I found that mds was always in 'creating' status, =
and could not enter 'active=E2=80=99 status. The output of 'ceph -s' is=
 like following:
>
> pg v9: 6 pgs: 6 active+clean+degraded; 0 KB data, 376 KB used, 5118 M=
B / 5119 MB avail
> mds e3: 1/1/1 up {0=3D0=3Dup:creating}
> osd e3: 1 osds: 1 up, 1 in
> log 2012-03-23 10:36:25.411393 osd.0 192.168.122.100:6801/19407 6 : [=
INF] 2.1p0 scrub ok
> mon e1: 1 mons at {0=3D192.168.122.100:6789/0}
>
> I set the debug level to 20 to get everything in log files. But I am =
too new to ceph, and cannot locate the error. Could someone give me any=
 guidance? Thank you very much!
>
> Best,
> Xiaobing
>
> P.S.
> My experiment environment is xen-4.1.2, Dom0 kernel 3.2.12, and DomU =
is Fedora14; and I installed ceph all in one DomU;
> I use =E2=80=98mkcephfs -c /etc/ceph/ceph.conf -a --mkbtrfs=E2=80=99 =
to format ceph; and =E2=80=98init-ceph -c /etc/ceph/ceph.conf -a start=E2=
=80=99 to start ceph;
>
> P.P.S.
> Because my mail with attachment could not reach ceph-devel@vger.kerne=
l.org , I can send you them separately if you need them. Thanks for you=
r attention and time!
>
>
>
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
