From: Maxim Mikheev <mikhmv@biodatomics.com>
Subject: Re: need help in a recovering ceph
Date: Mon, 28 Nov 2011 12:35:07 -0500
Message-ID: <4ED3C64B.5060601@biodatomics.com>
References: <4ED10636.6070705@biodatomics.com> <4ED36701.3060107@widodh.nl> <4ED37271.8030504@biodatomics.com> <CAF3hT9CS9EMnuUjTJF3S9L7U21xaOiin8eaezha2QToNBgATKA@mail.gmail.com> <4ED3BCBE.6000906@biodatomics.com> <CAF3hT9CFYe9AeUH5GBCcaUsfdP9itoL9ByVmbPZwe3ETuAT1nQ@mail.gmail.com>
Reply-To: max@biodatomics.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63333 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab1K1RfL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2011 12:35:11 -0500
Received: by vcbfk14 with SMTP id fk14so3859503vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2011 09:35:10 -0800 (PST)
In-Reply-To: <CAF3hT9CFYe9AeUH5GBCcaUsfdP9itoL9ByVmbPZwe3ETuAT1nQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Greg,

it does not work:

root@s2-8core:~# rados -p data bench 10 write
Maintaining 16 concurrent writes of 4194304 bytes for at least 10 seconds.
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
     0       0         0         0         0         0         -         0
2011-11-28 12:27:25.190205 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x23032e0 tid 1
2011-11-28 12:27:25.190384 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x2303e10 tid 2
2011-11-28 12:27:25.190407 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x2300b50 tid 3
2011-11-28 12:27:25.190460 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x2300f70 tid 4
2011-11-28 12:27:25.190483 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x23019e0 tid 5
2011-11-28 12:27:25.190504 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x2301e00 tid 6
2011-11-28 12:27:25.190527 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x2304270 tid 7
2011-11-28 12:27:25.190547 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x2304690 tid 8
2011-11-28 12:27:25.190570 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x2304ab0 tid 9
2011-11-28 12:27:25.190592 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x2304ed0 tid 10
2011-11-28 12:27:25.190617 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x23052f0 tid 11
2011-11-28 12:27:25.190764 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x7fe488000cf0 tid 12
2011-11-28 12:27:25.190796 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x7fe480000ba0 tid 13
2011-11-28 12:27:25.190827 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x7fe480000fc0 tid 14
2011-11-28 12:27:25.190855 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x7fe4800013e0 tid 15
2011-11-28 12:27:25.190881 7fe493dbc740 client.7871.objecter  FULL, 
paused modify 0x7fe480001800 tid 16
     1      16        16         0         0         0         -         0
     2      16        16         0         0         0         -         0
     3      16        16         0         0         0         -         0
     4      16        16         0         0         0         -         0
     5      16        16         0         0         0         -         0
     6      16        16         0         0         0         -         0
     7      16        16         0         0         0         -         0
     8      16        16         0         0         0         -         0
     9      16        16         0         0         0         -         0
    10      16        16         0         0         0         -         0
    11      16        16         0         0         0         -         0
    12      16        16         0         0         0         -         0
    13      16        16         0         0         0         -         0
    14      16        16         0         0         0         -         0
    15      16        16         0         0         0         -         0
    16      16        16         0         0         0         -         0
    17      16        16         0         0         0         -         0
    18      16        16         0         0         0         -         0
    19      16        16         0         0         0         -         0
min lat: 9999 max lat: 0 avg lat: 0
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
    20      16        16         0         0         0         -         0
    21      16        16         0         0



root@s1-2core:~# ceph mon injectargs --mon_osd_full_ratio 96
2011-11-28 12:29:39.067860 mon <- [mon,injectargs]
2011-11-28 12:29:39.068438 mon.0 -> 'unknown command injectargs' (-22)
root@s1-2core:~# ceph mon injectargs "mon osd full ratio = 96"
2011-11-28 12:29:53.431669 mon <- [mon,injectargs,mon osd full ratio = 96]
2011-11-28 12:29:53.432076 mon.0 -> 'unknown command injectargs' (-22)

Max



On 11/28/2011 12:23 PM, Gregory Farnum wrote:
> On Mon, Nov 28, 2011 at 8:54 AM, Maxim Mikheev<mikhmv@biodatomics.com>  wrote:
>> I understand you Greg. I hope you have a good Thanksgiving.
>>
>> I did:
>> root@s2-8core:~# ceph osd reweight-by-utilization
>> 2011-11-28 11:38:40.201428 mon<- [osd,reweight-by-utilization]
>> 2011-11-28 11:38:40.209388 mon.0 ->  'SUCCESSFUL reweight-by-utilization:
>> average_util: 0.386560, overload_util: 0.463872. overloaded osds: 2
>> [1.000000 ->  0.406347], ' (0)
>>
>> How can I initiate transfer data for balancing?
>>
>> root@s2-8core:~# ceph -w
>> 2011-11-28 11:40:19.634094    pg v385135: 594 pgs: 594 active+clean; 254 GB
>> data, 522 GB used, 673 GB / 1351 GB avail
>> 2011-11-28 11:40:19.635551   mds e182: 1/1/1 up {0=a=up:active}
>> 2011-11-28 11:40:19.635592   osd e465: 3 osds: 3 up, 3 in full
>> 2011-11-28 11:40:19.635665   log 2011-11-28 09:22:55.618408 osd.2
>> 192.168.2.12:6800/1097 476 : [INF] 1.1f scrub ok
>> 2011-11-28 11:40:19.635759   mon e1: 1 mons at {a=192.168.2.11:6789/0}
>>
>> Monitor didn't show any transfer activity after changing weights.
> Hmmm. It looks like we need to rework the OSDs so they subscribe to
> map updates when full. Try running "rados -p data bench 10 write". It
> will fail, but let it go for a few seconds and it should cause all the
> OSDs to update their maps and begin shuffling data.
>
>> And another question:
>> How can I change mon_osd_full_ratio?
>> I tried this:
>> root@s2-8core:~# ceph mon injectargs 'mon_osd_full_ratio = 96'
>> 2011-11-28 11:53:11.070059 mon<- [mon,injectargs,mon_osd_full_ratio = 96]
>> 2011-11-28 11:53:11.070383 mon.0 ->  'unknown command injectargs' (-22)
> either:
> ceph mon injectargs --mon_osd_full_ratio 96
> or
> ceph mon injectargs "mon osd full ratio = 96"
> should work.
> :)
> -Greg
