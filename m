From: "doki74216@gmail.com" <doki74216@gmail.com>
Subject: Re: How to reduce active mds number
Date: Tue, 3 May 2011 10:07:01 +0800
Message-ID: <BANLkTi=BR6tDMjm_cZD6beBQ_VB4Ojj1gw@mail.gmail.com>
References: <BANLkTikGYbYnWQfPPMFo3spsuzOq315m=Q@mail.gmail.com>
	<Pine.LNX.4.64.1104220845110.15351@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49752 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab1ECCHC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 May 2011 22:07:02 -0400
Received: by pzk9 with SMTP id 9so3294964pzk.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 May 2011 19:07:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104220845110.15351@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I am testing the same case.
My system is 1 MON , 2 MDS, 3OSD.
Here is my steps:

1) First, I set the max number of MDS to 2 , so there are two active MD=
Ss.
192.168.200.184:6800/2095 '0' mds0.1 up:active seq 66
192.168.200.185:6800/1911 '1' mds1.1 up:active seq 25635
2) I want to set the active one to standby. I excute"ceph mds
set_max_mds 1" and "ceph mds stop 0".
    But here is why I confuse:
    mds0 becomes stopping not standby.??
    It shows:
192.138.200.185:6800/14465 =911=92mds0.6 up:stopping seq 14
192.138.200.184:6800/15442 =910=92mds1.1 up:active seq 210

3) When I excute"ceph mds set_max_mds 2", mds0 doesn't become active,
    I type"ceph mds dump -o -"
    But it shows:
192.138.200.185:6800/14465 =911=92mds0.6 up:stopping seq 14 export_targ=
ets=3D1
192.138.200.184:6800/15442 =910=92mds1.1 up:active seq 210
   There is no two active MDSes, why?

4) Therefore, I still hope that there are one active mds and one
standby mds(by default).
    I restart the system. I execute" /etc/init.d/ceph -a stop" and "
/etc/init.d/ceph -a start"
    I type"ceph -s"
    But it shows:
mds e52:  2/2/1 up {0=3Dup:rejoin, 1=3Dup:resolve}
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  what means?
    After awhile I execue=94ceph mds stat=94 , it shows:
=91e61: 2/2/1 up {o=3Dup:relay, 1=3Dup:relay}=92 (0)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ what means?

5) I set the man active number to one because I still want the system
by default value(one active and one standby).
    I execute"ceph mds set_max_mds 1"
    It shows:
mds e80: 2/2/1 up {0=3Dup:rejoin, 1=3Dup:rejoin}, 1:up:standby
mds e80: 2/2/1 up {0=3Dup:active, 1=3Dup:rejoin}, 1:up:standby
mds e80: 2/2/1 up {0=3Dup:active, 1=3Dup:active}, 1:up:standby
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    I don't know what it means.
    Why there are three statuses? Aren't there just 2 MDSes in my syste=
m?
    I execue"ceph -s"
    It shows:
mds e94: 2/2/1 up {0=3Dup:active,1=3Dup:active}, 1 up:standby

Please help me to solve these questions..
And teach me how to set the MDS by the default(1 active & 1 standby)?
Thank you very much  ^^


Best regards

Stefanie Chen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
