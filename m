From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: osd cannot find cosd process after reboot
Date: Thu, 10 Mar 2011 10:08:58 -0800
Message-ID: <B0304C5EE27C431CA5C86CBBD4514472@gmail.com>
References: <AANLkTi=1uDMuN18kOjLm7ysttx3nN9MdMp-7Gdni2S0W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43147 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab1CJSJD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2011 13:09:03 -0500
Received: by qwd7 with SMTP id 7so1450210qwd.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2011 10:09:01 -0800 (PST)
In-Reply-To: <AANLkTi=1uDMuN18kOjLm7ysttx3nN9MdMp-7Gdni2S0W@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hmm, this does seem odd. How do you have Ceph installed and configured?

Just to be clear:
You have one machine hosting a monitor, MDS, and OSD. You reboot that m=
achine and the MDS and monitor come back up, but the OSD doesn't. And y=
ou appear to have an OSD running somewhere else?
This doesn't make a lot of sense to me, but maybe I'm misunderstanding =
or there's something strange with your config file -- can you show us, =
please?
-Greg
On Wednesday, March 9, 2011 at 10:37 PM, huang jun wrote:=20
> Hi:
> With ceph 0.24.3 and Linux 2.6.35.9, i face problems
> after we reboot osd0=EF=BC=88osd0 and mon=E3=80=81mds on same host0=EF=
=BC=89
> Check cmon\cmds\cosd process
> $pidof cmon
> 2538
> $pidof cmds
>  2537
> $pidof cosd
> =EF=BC=88here is no display=EF=BC=89
> $cat /var/run/ceph/osd.0.pid
> 2620
> But
> $ ceph osd dump -o -
> Get follows:
> max_osd 1
> osd0 up in weight 1 up_from 15 up_thru 15 down_at 14
> last_clean_interval2-13 192.168.1.106:6801/5386
> 192.168.1.106:6802/5386 192.168.1.106:6803/5386
> (here cosd pid of osd0 is 5387 ,and not equals 2620)
> can you give me some advices about this?
>=20
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
