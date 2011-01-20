From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: can't read the superbloack
Date: Wed, 19 Jan 2011 20:50:03 -0800
Message-ID: <AANLkTi=TWipdK19hJU-OL5EKkb-R49jxonqSCBaurPSm@mail.gmail.com>
References: <AANLkTim8CMPTHE9nWOxoza9WZPwwJ3=ZU5T+Y6iKyXdv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33075 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031Ab1ATEuE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jan 2011 23:50:04 -0500
Received: by eye27 with SMTP id 27so76882eye.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jan 2011 20:50:03 -0800 (PST)
In-Reply-To: <AANLkTim8CMPTHE9nWOxoza9WZPwwJ3=ZU5T+Y6iKyXdv@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Qian Wei <hzqianwei@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jan 18, 2011 at 6:38 PM, Qian Wei <hzqianwei@gmail.com> wrote:
> Now the my client machine still can't mount the system, the error
> message is "can't read the superblock ".Moreover, I can use
> "init-ceph" command to start the system,and the =A0"cosd cmon cmds" i=
s
> on process table(so I think the system is running), but I can't =A0us=
e
> =93ceph=94 command to administrate the system, =932011-01-13 13:27:05=
=2E800552
> b5f41b70 -- :/4555 >> 192.168.178.160:0/0 pipe(0x8429c48 sd=3D3 pgs=3D=
0
> cs=3D0 l=3D0).fault first fault =94 is the error message.Do you know =
what's
> wrong may cause these problems?
Well, that "fault first fault" message is very generic so doesn't tell
us much. However, between that and the superblock error, there's
clearly some issue about communicating with your monitor. There are a
few ways to debug this, but let's check out your configuration file...
> [mon0]
> =A0 =A0 =A0 =A0host =3D cephosd
> =A0 =A0 =A0 =A0mon addr =3D 192.168.178.160
I'm pretty sure that's your problem. You need to specify a port as
well. If that doesn't resolve your issues, we can take a deeper look.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
