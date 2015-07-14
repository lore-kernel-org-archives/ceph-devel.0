From: huang jun <hjwsm1989@gmail.com>
Subject: Re: osd suicide timeout
Date: Tue, 14 Jul 2015 08:42:08 +0800
Message-ID: <CABAwU-bJh5a8fTcr01D72pbk7ZPW7+jw58tvrkFX5B75iXh-7g@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91669B3BFF@SATLEXDAG01.amd.com>
	<CAC6JEv9GJFAyQBXU398Na=RfHROPoakbzcM6sFUCh_Cg6bE7Zw@mail.gmail.com>
	<BC97738F8E7C8742BABED7F06FB9DF91669B4DDC@SATLEXDAG01.amd.com>
	<CAC6JEv-=z3c+Awyz_YpWKO=g_Vf31iFb7s4eSFToiLtSkXKGyQ@mail.gmail.com>
	<BC97738F8E7C8742BABED7F06FB9DF91669B4FFB@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35047 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbbGNAmK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jul 2015 20:42:10 -0400
Received: by lblf12 with SMTP id f12so62311379lbl.2
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2015 17:42:08 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91669B4FFB@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: Gregory Farnum <greg@gregs42.com>, ceph-devel <ceph-devel@vger.kernel.org>

hi,Deneau
we set the filestore_max_queue_ops=1000, unlucky we alse meet the osd suicide.
we test random 4K writes, the osd_op_tp thread suicide event if we set
osd_op_thread_timeout=120,
the threads in osd_op_tp will reset the timeout handle after submit op
to FileJournal's workqueue,
so we have no idea why the thread blocked so long. the debug log
showed during that time, other threads in osd_op_tp
works fine.

2015-07-14 7:12 GMT+08:00 Deneau, Tom <tom.deneau@amd.com>:
> Greg --
>
> Not sure how to tell whether rebalancing occurred at that time.
> I do see in other osd logs complaints that they do not get a reply from
> osd.8 starting around 15:52 on that day.
>
> I see the deep-scrub of pool 14 but that was almost 30 minutes earlier.
>
> -- Tom
>
>
>> -----Original Message-----
>> From: Gregory Farnum [mailto:greg@gregs42.com]
>> Sent: Monday, July 13, 2015 11:45 AM
>> To: Deneau, Tom
>> Cc: ceph-devel
>> Subject: Re: osd suicide timeout
>>
>> heartbeat_map reset_timeout 'OSD::osd_op_tp thread 0x3ff6eb0efd0' had suicide
>> timed out after 150
>>
>> So that's the OSD's "op thread", which is the one that does most of the work.
>> You often see the FileStore::op_tp when it's the disk or filesystem breaking,
>> but I do see the line
>>
>> waiting 51 > 50 ops || 57248008 > 104857600
>>
>> which leaves me feeling pretty confident that the disk is just getting more
>> work than it can keep up with. It looks like there was some rebalancing
>> happening around this time?
>> -Greg
>>
>>
>>
>> On Mon, Jul 13, 2015 at 5:04 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
>> > Greg --
>> >
>> > Thanks.  I put the osd.log file at
>> >
>> > https://drive.google.com/file/d/0B_rfwWh40kPwQjZ3OXdjLUZNRVU/view?usp=
>> > sharing
>> >
>> > I noticed the following from journalctl output around that time, so other
>> nodes were complaining they could not reach osd.8.
>> >
>> > Jul 09 15:53:04 seattle-04-ausisv bash[8486]: 2015-07-09
>> > 15:53:03.905386 3ffa0d9efd0 -1 osd.9 2487 heartbeat_check: no reply
>> > from osd.8 since back 2015-07-09 15:52:43.256581 front 2015-07-09
>> > 15:52:43.256581 (cutoff 2015-07-09 15:52:43.905384) Jul 09 15:53:06
>> > seattle-04-ausisv bash[1060]: 2015-07-09 15:53:06.784069 3ff916fefd0
>> > -1 osd.7 2487 heartbeat_check: no reply from osd.8 since back
>> > 2015-07-09 15:52:46.474273 front 2015-07-09 15:52:46.474273 (cutoff
>> > 2015-07-09 15:52:46.784066)
>> >
>> > and here is some sar data for the disk that osd.8 was controlling
>> > (sde1=journal partition, sde2=data partition)
>> >
>> > 03:40:02 PM       DEV       tps  rd_sec/s  wr_sec/s  avgrq-sz  avgqu-sz
>> await     svctm     %util
>> > 03:50:17 PM      sde1      9.67      0.00  19046.40   1970.32      0.35
>> 35.86     30.62     29.60
>> > 03:50:17 PM      sde2     60.47   1524.27  14597.67    266.63     24.45
>> 404.30      8.54     51.67
>> > 03:50:32 PM      sde1     12.13      0.00  18158.93   1496.62      0.25
>> 20.66     17.58     21.33
>> > 03:50:32 PM      sde2     28.00   1550.93  17958.33    696.76     10.54
>> 376.50     13.52     37.87
>> > 03:50:47 PM      sde1     12.73      0.00  25446.40   1998.41      0.31
>> 24.19     22.30     28.40
>> > 03:50:47 PM      sde2     51.60    338.67  18091.73    357.18     13.05
>> 252.91      8.02     41.40
>> > 03:51:02 PM      sde1     12.27      0.00  18790.40   1531.83      0.31
>> 25.33     18.53     22.73
>> > 03:51:02 PM      sde2     33.13   2635.20  18026.67    623.60      5.02
>> 151.57     10.99     36.40
>> > 03:51:17 PM      sde1     10.13      0.00  14557.87   1436.63      0.16
>> 16.18     12.76     12.93
>> > 03:51:17 PM      sde2     46.73   1107.73  12067.00    281.91      8.55
>> 182.88      5.46     25.53
>> > 03:51:32 PM      sde1     11.93      0.00  18594.13   1558.17      0.35
>> 29.27     16.42     19.60
>> > 03:51:32 PM      sde2     22.20    555.20  18834.33    873.40      4.24
>> 191.08     13.51     30.00
>> > 03:51:47 PM      sde1     18.00      0.00  13926.40    773.69      0.19
>> 10.78     10.07     18.13
>> > 03:51:47 PM      sde2     47.27   1652.80  10775.53    262.94     12.24
>> 259.01      6.66     31.47
>> > 03:52:02 PM      sde1     21.60      0.00  10845.87    502.12      0.24
>> 11.08      9.75     21.07
>> > 03:52:02 PM      sde2     34.33   1652.80   9089.13    312.87      7.43
>> 216.41      8.45     29.00
>> > 03:52:17 PM      sde1     19.87      0.00  20198.40   1016.70      0.33
>> 16.85     13.46     26.73
>> > 03:52:17 PM      sde2     35.60   2752.53  16355.53    536.74     11.90
>> 333.33     10.90     38.80
>> > 03:52:32 PM      sde1     22.54      0.00   8434.04    374.18      0.15
>> 6.67      6.17     13.90
>> > 03:52:32 PM      sde2     35.84   2738.30   4586.30    204.38      2.01
>> 28.11      6.53     23.40
>> > 03:52:47 PM      sde1      0.00      0.00      0.00      0.00      0.00
>> 0.00      0.00      0.00
>> > 03:52:47 PM      sde2     13.37     35.83   1101.80     85.09      1.87
>> 218.65      5.75      7.69
>> > 03:53:02 PM      sde1      0.00      0.00      0.00      0.00      0.00
>> 0.00      0.00      0.00
>> > 03:53:02 PM      sde2      0.00      0.00      0.00      0.00      0.00
>> 0.00      0.00      0.00
>> > 03:53:17 PM      sde1      0.00      0.00      0.00      0.00      0.00
>> 0.00      0.00      0.00
>> > 03:53:17 PM      sde2      0.13      0.00      0.20      1.50      0.00
>> 20.00     20.00      0.27
>> > 03:53:32 PM      sde1      0.00      0.00      0.00      0.00      0.00
>> 0.00      0.00      0.00
>> > 03:53:32 PM      sde2      0.00      0.00      0.00      0.00      0.00
>> 0.00      0.00      0.00
>> > 03:53:47 PM      sde1      0.00      0.00      0.00      0.00      0.00
>> 0.00      0.00      0.00
>> > 03:53:47 PM      sde2      0.13      0.00      0.20      1.50      0.00
>> 5.00      5.00      0.07
>> > 03:54:02 PM      sde1      0.00      0.00      0.00      0.00      0.00
>> 0.00      0.00      0.00
>> > 03:54:02 PM      sde2      0.00      0.00      0.00      0.00      0.00
>> 0.00      0.00      0.00
>> > 03:54:17 PM      sde1      0.00      0.00      0.00      0.00      0.00
>> 0.00      0.00      0.00
>> > 03:54:17 PM      sde2      0.00      0.00      0.00      0.00      0.00
>> 0.00      0.00      0.00
>> > 03:54:32 PM      sde1      0.00      0.00      0.00      0.00      0.00
>> 0.00      0.00      0.00
>> > 03:54:32 PM      sde2      0.00      0.00      0.00      0.00      0.00
>> 0.00      0.00      0.00
>> >
>> > -- Tom
>> >
>> >> -----Original Message-----
>> >> From: Gregory Farnum [mailto:greg@gregs42.com]
>> >> Sent: Monday, July 13, 2015 5:07 AM
>> >> To: Deneau, Tom
>> >> Cc: ceph-devel
>> >> Subject: Re: osd suicide timeout
>> >>
>> >> On Fri, Jul 10, 2015 at 10:45 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
>> >> > I have an osd log file from an osd that hit a suicide timeout (with
>> >> > the
>> >> previous 10000 events logged).
>> >> > (On this node I have also seen this suicide timeout happen once
>> >> > before and
>> >> also a sync_entry timeout.
>> >> >
>> >> > I can see that 6 minutes or so before that osd died, other osds on
>> >> > the same node were logging messages such as
>> >> >     heartbeat_check: no reply from osd.8 so it appears that osd8
>> >> > stopped responding quite some time before it died.
>> >>
>> >> It does this deliberately when its disk threads look like they might
>> >> be stuck.
>> >>
>> >> >
>> >> > I'm wondering if there is enough information in the osd8 log file
>> >> > to deduce
>> >> why osd 8 stopped responding?
>> >> > I don't know enough to figure it out myself.
>> >> >
>> >> > Is there any expert who would be willing to take a look at the log file?
>> >>
>> >> The logs will have a backtrace in them; if you can include that and
>> >> the last hundred lines or so prior in a pastebin that you email the
>> >> list with several people can give you a pretty good idea of what's going
>> on.
>> >>
>> >> In general though, it's just going to be that the disk can't keep up
>> >> with the load being applied to it. That could be because it's
>> >> failing, or because you're pushing too much work on to it in some fashion.
>> >> -Greg



-- 
thanks
huangjun
