From: AnnyRen <annyren6@gmail.com>
Subject: Re: rejoin mds daemon, 17 osd are suddenly down and out
Date: Fri, 15 Jul 2011 10:30:02 +0800
Message-ID: <CADF7qQV5YT7FEb6pTtDfQvd=O8mVTgHqgcizYmkA9gTXvb519Q@mail.gmail.com>
References: <CADF7qQWkza=j_dapnRqJdPX-2i9HnEqpJ6aQ10CGFCDmU5KZCg@mail.gmail.com>
	<4E1F235C.3000207@hq.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61045 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356Ab1GOCaD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2011 22:30:03 -0400
Received: by yxi11 with SMTP id 11so374401yxi.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jul 2011 19:30:02 -0700 (PDT)
In-Reply-To: <4E1F235C.3000207@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: samuel.just@dreamhost.com
Cc: ceph-devel@vger.kernel.org

Hi, Samuel:
Thanks for your reply.

2011/7/15 Samuel Just <samuelj@hq.newdream.net>:
> Not sure about the lack of logs, is something rotating the logs? =A0T=
here

After I started up mds daemon, I found that all down osds didn't write
logs anymore.

> could have been a bug that caused the osds to crash, but I'll need th=
e logs
> to hazard a guess as to what caused it. =A0Starting the mds that way =
should
> not have killed the osds. =A0Do the running osds produce logs? =A0The=
 logging
> should default to /var/log/ceph/.

I look for osd logs in /var/log/ceph, but there is nothing unless I
restart the osd daemon.

> -Sam
>
> On 07/13/2011 08:54 PM, AnnyRen wrote:
>>
>> Hi, developers:
>>
>> My environment is 3 mons, 2 mds, 25 osds, and ceph version is v0.30.
>> This morning, I found one mds(standby one) lost when I run "ceph -w"
>>
>> The original mds info should be =A0{mds e42: 1/1/1 up {0=3Db=3Dup:ac=
tive}, 1
>> up:standby}
>> but I found the standby one lost
>>
>> so I ssh to mds1 to run "cmds -i a -c /etc/ceph/ceph.conf" , and che=
ck
>> the mds daemon run correctly.
>>
>> After then, I found 17 osds suddenly down and out,
>>
>> --------------------------------------------------------------------=
-------------------------------------
>> osd0 up =A0 in =A0weight 1 up_from 139 up_thru 229 down_at 138
>> last_clean_interval 120-137 192.168.10.10:6800/11191
>> 192.168.10.10:6801/11191 192.168.10.10:6802/11191
>> osd1 down out up_from 141 up_thru 160 down_at 166 last_clean_interva=
l
>> 117-139
>> osd2 up =A0 in =A0weight 1 up_from 147 up_thru 222 down_at 146
>> last_clean_interval 125-145 192.168.10.12:6800/10173
>> 192.168.10.12:6801/10173 192.168.10.12:6802/10173
>> osd3 down out up_from 154 up_thru 160 down_at 166 last_clean_interva=
l
>> 130-152
>> osd4 down out up_from 155 up_thru 160 down_at 166 last_clean_interva=
l
>> 130-153
>> osd5 down out up_from 153 up_thru 160 down_at 166 last_clean_interva=
l
>> 134-151
>> osd6 down out up_from 153 up_thru 160 down_at 170 last_clean_interva=
l
>> 135-151
>> osd7 down out up_from 157 up_thru 160 down_at 162 last_clean_interva=
l
>> 133-155
>> osd8 down out up_from 154 up_thru 160 down_at 166 last_clean_interva=
l
>> 134-152
>> osd9 down out up_from 155 up_thru 160 down_at 168 last_clean_interva=
l
>> 133-153
>> osd10 down out up_from 141 up_thru 160 down_at 168 last_clean_interv=
al
>> 118-139
>> osd11 down out up_from 145 up_thru 160 down_at 168 last_clean_interv=
al
>> 119-143
>> osd12 down out up_from 142 up_thru 160 down_at 166 last_clean_interv=
al
>> 123-140
>> osd13 down out up_from 147 up_thru 160 down_at 166 last_clean_interv=
al
>> 123-145
>> osd14 up =A0 in =A0weight 1 up_from 143 up_thru 223 down_at 142
>> last_clean_interval 124-141 192.168.10.24:6800/10122
>> 192.168.10.24:6801/10122 192.168.10.24:6802/10122
>> osd15 down out up_from 147 up_thru 160 down_at 164 last_clean_interv=
al
>> 121-145
>> osd16 up =A0 in =A0weight 1 up_from 148 up_thru 222 down_at 147
>> last_clean_interval 124-146 192.168.10.26:6800/9881
>> 192.168.10.26:6801/9881 192.168.10.26:6802/9881
>> osd17 up =A0 in =A0weight 1 up_from 148 up_thru 223 down_at 147
>> last_clean_interval 122-146 192.168.10.27:6800/9986
>> 192.168.10.27:6801/9986 192.168.10.27:6802/9986
>> osd18 down out up_from 146 up_thru 160 down_at 168 last_clean_interv=
al
>> 124-144
>> osd19 down out up_from 147 up_thru 160 down_at 166 last_clean_interv=
al
>> 125-145
>> osd20 up =A0 in =A0weight 1 up_from 148 up_thru 222 down_at 147
>> last_clean_interval 126-146 192.168.10.30:6800/9816
>> 192.168.10.30:6801/9816 192.168.10.30:6802/9816
>> osd21 down out up_from 148 up_thru 160 down_at 168 last_clean_interv=
al
>> 126-146
>> osd22 up =A0 in =A0weight 1 up_from 149 up_thru 220 down_at 148
>> last_clean_interval 127-147 192.168.10.32:6800/9640
>> 192.168.10.32:6801/9640 192.168.10.32:6802/9640
>> osd23 down out up_from 153 up_thru 160 down_at 166 last_clean_interv=
al
>> 128-151
>> osd24 up =A0 in =A0weight 1 up_from 150 up_thru 225 down_at 149
>> last_clean_interval 132-148 192.168.10.34:6800/10581
>> 192.168.10.34:6801/10581 192.168.10.34:6802/10581
>>
>> --------------------------------------------------------------------=
-------------------------------------
>>
>> Many pgs are degraded, I ssh to every down and out osd host to see l=
og
>> (/var/log/ceph/osd.x.log), but there is nothing recorded in logs...
>> Why the logs stopped logging anything?
>>
>> So I run "cosd -i x -c /etc/ceph/ceph.conf" on every down osd
>> individually to make them up and in, and then I can read/write files
>> form ceph....
>
> At this point, did the osds go down again?
>>
>> Could anyone tell me what's going on in my environment?
>> 1. OSD Stability problem?
>> 2. Ceph didn't write logs unexpectedly.
>>
>> =A0Thanks a lot! =A0:)
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
