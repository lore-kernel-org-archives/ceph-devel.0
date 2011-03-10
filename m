From: huang jun <hjwsm1989@gmail.com>
Subject: osd cannot find cosd process after reboot
Date: Thu, 10 Mar 2011 14:37:25 +0800
Message-ID: <AANLkTi=1uDMuN18kOjLm7ysttx3nN9MdMp-7Gdni2S0W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33835 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab1CJGh1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2011 01:37:27 -0500
Received: by vws12 with SMTP id 12so1262667vws.19
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2011 22:37:25 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi:
With ceph 0.24.3 and Linux 2.6.35.9, i face problems
after we reboot osd0=A3=A8osd0 and mon=A1=A2mds on same host0=A3=A9
Check cmon\cmds\cosd process
$pidof cmon
2538
$pidof cmds
 2537
$pidof cosd
=A3=A8here is no display=A3=A9
$cat /var/run/ceph/osd.0.pid
2620
But
$ ceph osd  dump -o -
Get follows:
max_osd 1
osd0 up   in  weight 1 up_from 15 up_thru 15 down_at 14
last_clean_interval2-13 192.168.1.106:6801/5386
192.168.1.106:6802/5386 192.168.1.106:6803/5386
(here cosd pid of osd0 is 5387 ,and not equals 2620)
can you give me some advices about this?

Thanks!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
