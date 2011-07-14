From: AnnyRen <annyren6@gmail.com>
Subject: Re: rejoin mds daemon, 17 osd are suddenly down and out
Date: Thu, 14 Jul 2011 14:07:26 +0800
Message-ID: <CADF7qQXN2Ebv1VJQxCjCLwMWf84pb4zBfDx7yqoEN508WKic-g@mail.gmail.com>
References: <CADF7qQWkza=j_dapnRqJdPX-2i9HnEqpJ6aQ10CGFCDmU5KZCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57428 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab1GNGH1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2011 02:07:27 -0400
Received: by iyb12 with SMTP id 12so6206858iyb.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 23:07:26 -0700 (PDT)
In-Reply-To: <CADF7qQWkza=j_dapnRqJdPX-2i9HnEqpJ6aQ10CGFCDmU5KZCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

attached the log when I boot a mds up (cmds -i a -c /etc/ceph/ceph.conf=
)

2011-07-14 10:07:22.080571 mon0 192.168.10.1:6789/0 75 : [INF] mds?
192.168.10.4:6800/20883 up:boot
2011-07-14 10:14:59.182202 mon0 192.168.10.1:6789/0 76 : [INF] osd7
out (down for 300.007145)
2011-07-14 10:15:04.182906 mon0 192.168.10.1:6789/0 77 : [INF] osd15
out (down for 300.007564)
2011-07-14 10:15:09.183510 mon0 192.168.10.1:6789/0 78 : [INF] osd1
out (down for 300.007286)
2011-07-14 10:15:09.183553 mon0 192.168.10.1:6789/0 79 : [INF] osd3
out (down for 300.007285)
2011-07-14 10:15:09.183576 mon0 192.168.10.1:6789/0 80 : [INF] osd4
out (down for 300.007285)
2011-07-14 10:15:09.183593 mon0 192.168.10.1:6789/0 81 : [INF] osd5
out (down for 300.007284)
2011-07-14 10:15:09.183609 mon0 192.168.10.1:6789/0 82 : [INF] osd8
out (down for 300.007284)
2011-07-14 10:15:09.183627 mon0 192.168.10.1:6789/0 83 : [INF] osd12
out (down for 300.007284)
2011-07-14 10:15:09.183644 mon0 192.168.10.1:6789/0 84 : [INF] osd13
out (down for 300.007283)
2011-07-14 10:15:09.183660 mon0 192.168.10.1:6789/0 85 : [INF] osd19
out (down for 300.007283)
2011-07-14 10:15:09.183675 mon0 192.168.10.1:6789/0 86 : [INF] osd23
out (down for 300.007282)
2011-07-14 10:15:14.184369 mon0 192.168.10.1:6789/0 87 : [INF] osd9
out (down for 300.007294)
2011-07-14 10:15:14.184410 mon0 192.168.10.1:6789/0 88 : [INF] osd10
out (down for 300.007294)
2011-07-14 10:15:14.184431 mon0 192.168.10.1:6789/0 89 : [INF] osd11
out (down for 300.007293)
2011-07-14 10:15:14.184446 mon0 192.168.10.1:6789/0 90 : [INF] osd18
out (down for 300.007293)
2011-07-14 10:15:14.184465 mon0 192.168.10.1:6789/0 91 : [INF] osd21
out (down for 300.007292)
2011-07-14 10:16:09.188393 mon0 192.168.10.1:6789/0 92 : [INF] osd6
out (down for 300.009465)


Did I operate incorrectly when starting up a mds ?
Does anyone know why I start up a mds and most osds are out and down  :=
(
Thank you.

2011/7/14 AnnyRen <annyren6@gmail.com>:
> Hi, developers:
>
> My environment is 3 mons, 2 mds, 25 osds, and ceph version is v0.30.
> This morning, I found one mds(standby one) lost when I run "ceph -w"
>
> The original mds info should be =A0{mds e42: 1/1/1 up {0=3Db=3Dup:act=
ive}, 1
> up:standby}
> but I found the standby one lost
>
> so I ssh to mds1 to run "cmds -i a -c /etc/ceph/ceph.conf" , and chec=
k
> the mds daemon run correctly.
>
> After then, I found 17 osds suddenly down and out,
> ---------------------------------------------------------------------=
------------------------------------
> osd0 up =A0 in =A0weight 1 up_from 139 up_thru 229 down_at 138
> last_clean_interval 120-137 192.168.10.10:6800/11191
> 192.168.10.10:6801/11191 192.168.10.10:6802/11191
> osd1 down out up_from 141 up_thru 160 down_at 166 last_clean_interval=
 117-139
> osd2 up =A0 in =A0weight 1 up_from 147 up_thru 222 down_at 146
> last_clean_interval 125-145 192.168.10.12:6800/10173
> 192.168.10.12:6801/10173 192.168.10.12:6802/10173
> osd3 down out up_from 154 up_thru 160 down_at 166 last_clean_interval=
 130-152
> osd4 down out up_from 155 up_thru 160 down_at 166 last_clean_interval=
 130-153
> osd5 down out up_from 153 up_thru 160 down_at 166 last_clean_interval=
 134-151
> osd6 down out up_from 153 up_thru 160 down_at 170 last_clean_interval=
 135-151
> osd7 down out up_from 157 up_thru 160 down_at 162 last_clean_interval=
 133-155
> osd8 down out up_from 154 up_thru 160 down_at 166 last_clean_interval=
 134-152
> osd9 down out up_from 155 up_thru 160 down_at 168 last_clean_interval=
 133-153
> osd10 down out up_from 141 up_thru 160 down_at 168 last_clean_interva=
l 118-139
> osd11 down out up_from 145 up_thru 160 down_at 168 last_clean_interva=
l 119-143
> osd12 down out up_from 142 up_thru 160 down_at 166 last_clean_interva=
l 123-140
> osd13 down out up_from 147 up_thru 160 down_at 166 last_clean_interva=
l 123-145
> osd14 up =A0 in =A0weight 1 up_from 143 up_thru 223 down_at 142
> last_clean_interval 124-141 192.168.10.24:6800/10122
> 192.168.10.24:6801/10122 192.168.10.24:6802/10122
> osd15 down out up_from 147 up_thru 160 down_at 164 last_clean_interva=
l 121-145
> osd16 up =A0 in =A0weight 1 up_from 148 up_thru 222 down_at 147
> last_clean_interval 124-146 192.168.10.26:6800/9881
> 192.168.10.26:6801/9881 192.168.10.26:6802/9881
> osd17 up =A0 in =A0weight 1 up_from 148 up_thru 223 down_at 147
> last_clean_interval 122-146 192.168.10.27:6800/9986
> 192.168.10.27:6801/9986 192.168.10.27:6802/9986
> osd18 down out up_from 146 up_thru 160 down_at 168 last_clean_interva=
l 124-144
> osd19 down out up_from 147 up_thru 160 down_at 166 last_clean_interva=
l 125-145
> osd20 up =A0 in =A0weight 1 up_from 148 up_thru 222 down_at 147
> last_clean_interval 126-146 192.168.10.30:6800/9816
> 192.168.10.30:6801/9816 192.168.10.30:6802/9816
> osd21 down out up_from 148 up_thru 160 down_at 168 last_clean_interva=
l 126-146
> osd22 up =A0 in =A0weight 1 up_from 149 up_thru 220 down_at 148
> last_clean_interval 127-147 192.168.10.32:6800/9640
> 192.168.10.32:6801/9640 192.168.10.32:6802/9640
> osd23 down out up_from 153 up_thru 160 down_at 166 last_clean_interva=
l 128-151
> osd24 up =A0 in =A0weight 1 up_from 150 up_thru 225 down_at 149
> last_clean_interval 132-148 192.168.10.34:6800/10581
> 192.168.10.34:6801/10581 192.168.10.34:6802/10581
> ---------------------------------------------------------------------=
------------------------------------
>
> Many pgs are degraded, I ssh to every down and out osd host to see lo=
g
> (/var/log/ceph/osd.x.log), but there is nothing recorded in logs...
> Why the logs stopped logging anything?
>
> So I run "cosd -i x -c /etc/ceph/ceph.conf" on every down osd
> individually to make them up and in, and then I can read/write files
> form ceph....
>
>
> Could anyone tell me what's going on in my environment?
> 1. OSD Stability problem?
> 2. Ceph didn't write logs unexpectedly.
>
> =A0Thanks a lot! =A0:)
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
