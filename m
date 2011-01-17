From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: [ceph-commit] can't read the superblock
Date: Mon, 17 Jan 2011 10:09:34 -0800
Message-ID: <AANLkTinQbvvij5xAojnBHCq+9B-hqp4L2Ci_BRG+Kfdp@mail.gmail.com>
References: <201101151157560394466@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45685 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab1AQSJg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Jan 2011 13:09:36 -0500
Received: by eye27 with SMTP id 27so2773710eye.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Jan 2011 10:09:35 -0800 (PST)
In-Reply-To: <201101151157560394466@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Qian Wei <hzqianwei@gmail.com>
Cc: ceph-devel@vger.kernel.org

=46orwarding this to ceph-devel rather than ceph-commit.

As for your issues, there are many possibilities. It would be easier
to help you if you could provide more information about what your
system looks like and what steps you've taken to set it up.

On Fri, Jan 14, 2011 at 7:57 PM, Qian Wei <hzqianwei@gmail.com> wrote:
> Thanks for your advice, I have resolve the problem of "keyring.bin", =
and I
> finish the process of "install". But, now the client still can't moun=
t the
> system, the error message is "can't=A0read=A0the=A0superblock=A0".Mor=
eover, I can
> use "init-ceph" command to start the system,and the=A0 "cosd cmon cmd=
s" is on
> process table(so I think the system is running), but I can't=A0 use =93=
ceph=94
> command to administrate the system,
> =932011-01-13=A013:27:05.800552=A0b5f41b70=A0--=A0:/4555=A0>>=A0192.1=
68.178.160:0/0=A0pipe(0x8429c48=A0sd=3D3=A0pgs=3D0=A0cs=3D0=A0l=3D0).fa=
ult=A0first=A0fault
> =94 is the error message.Do you know what's wrong may cause these pro=
blems?
> =A0=A0=A0=A0 Thank you !!!
>
> 2011-01-15
> ________________________________
> Qian Wei
> _______________________________________________
> Ceph-commit mailing list
> Ceph-commit@lists.ceph.newdream.net
> http://lists.ceph.newdream.net/listinfo.cgi/ceph-commit-ceph.newdream=
=2Enet
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
