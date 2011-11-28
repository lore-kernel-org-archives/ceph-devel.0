From: Maxim Mikheev <mikhmv@biodatomics.com>
Subject: Re: need help in a recovering ceph
Date: Mon, 28 Nov 2011 13:58:54 -0500
Message-ID: <4ED3D9EE.5080302@biodatomics.com>
References: <4ED10636.6070705@biodatomics.com> <4ED36701.3060107@widodh.nl> <4ED37271.8030504@biodatomics.com> <CAF3hT9CS9EMnuUjTJF3S9L7U21xaOiin8eaezha2QToNBgATKA@mail.gmail.com> <4ED3BCBE.6000906@biodatomics.com> <CAF3hT9CFYe9AeUH5GBCcaUsfdP9itoL9ByVmbPZwe3ETuAT1nQ@mail.gmail.com> <4ED3C64B.5060601@biodatomics.com> <CAF3hT9Cpbm1B7-fVw=AAia0F_7_Cuct1DtJDM_fAAtyY3yh2WQ@mail.gmail.com>
Reply-To: max@biodatomics.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64312 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab1K1S66 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2011 13:58:58 -0500
Received: by vcbfk14 with SMTP id fk14so3935948vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2011 10:58:57 -0800 (PST)
In-Reply-To: <CAF3hT9Cpbm1B7-fVw=AAia0F_7_Cuct1DtJDM_fAAtyY3yh2WQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Everyone,

Thank you for suggestions.
"ceph injectargs '--mon_osd_full_ratio 96'" did the job and allow me to 
get access to data.
After almost an hour data distribution on hard drives was not changed 
after reweight.
Looks like reweight is not working.

Most terrible observation is data transfer for: rados -p data bench 10 write
was low at beginning ~3.5MB/s
after one hour it is drop to 0.14MB/s and continue dropping.

How can I improve a performance?

Thanks,
    Max

On 11/28/2011 12:41 PM, Gregory Farnum wrote:
> On Mon, Nov 28, 2011 at 9:35 AM, Maxim Mikheev<mikhmv@biodatomics.com>  wrote:
>> Hi Greg,
>>
>> it does not work:
>>
>> root@s2-8core:~# rados -p data bench 10 write
>> Maintaining 16 concurrent writes of 4194304 bytes for at least 10 seconds.
>>   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>>     0       0         0         0         0         0         -         0
>> 2011-11-28 12:27:25.190205 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x23032e0 tid 1
>> 2011-11-28 12:27:25.190384 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x2303e10 tid 2
>> 2011-11-28 12:27:25.190407 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x2300b50 tid 3
>> 2011-11-28 12:27:25.190460 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x2300f70 tid 4
>> 2011-11-28 12:27:25.190483 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x23019e0 tid 5
>> 2011-11-28 12:27:25.190504 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x2301e00 tid 6
>> 2011-11-28 12:27:25.190527 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x2304270 tid 7
>> 2011-11-28 12:27:25.190547 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x2304690 tid 8
>> 2011-11-28 12:27:25.190570 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x2304ab0 tid 9
>> 2011-11-28 12:27:25.190592 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x2304ed0 tid 10
>> 2011-11-28 12:27:25.190617 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x23052f0 tid 11
>> 2011-11-28 12:27:25.190764 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x7fe488000cf0 tid 12
>> 2011-11-28 12:27:25.190796 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x7fe480000ba0 tid 13
>> 2011-11-28 12:27:25.190827 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x7fe480000fc0 tid 14
>> 2011-11-28 12:27:25.190855 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x7fe4800013e0 tid 15
>> 2011-11-28 12:27:25.190881 7fe493dbc740 client.7871.objecter  FULL, paused
>> modify 0x7fe480001800 tid 16
>>     1      16        16         0         0         0         -         0
>>     2      16        16         0         0         0         -         0
>>     3      16        16         0         0         0         -         0
>>     4      16        16         0         0         0         -         0
>>     5      16        16         0         0         0         -         0
>>     6      16        16         0         0         0         -         0
>>     7      16        16         0         0         0         -         0
>>     8      16        16         0         0         0         -         0
>>     9      16        16         0         0         0         -         0
>>    10      16        16         0         0         0         -         0
>>    11      16        16         0         0         0         -         0
>>    12      16        16         0         0         0         -         0
>>    13      16        16         0         0         0         -         0
>>    14      16        16         0         0         0         -         0
>>    15      16        16         0         0         0         -         0
>>    16      16        16         0         0         0         -         0
>>    17      16        16         0         0         0         -         0
>>    18      16        16         0         0         0         -         0
>>    19      16        16         0         0         0         -         0
>> min lat: 9999 max lat: 0 avg lat: 0
>>   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
>>    20      16        16         0         0         0         -         0
>>    21      16        16         0         0
> Yes, this is expected, but it should have gotten the OSDs to get a new
> "OSD map" so they should be transferring data based on the new weights
> now. Check your network traffic. :)
>
>> root@s1-2core:~# ceph mon injectargs --mon_osd_full_ratio 96
>> 2011-11-28 12:29:39.067860 mon<- [mon,injectargs]
>> 2011-11-28 12:29:39.068438 mon.0 ->  'unknown command injectargs' (-22)
>> root@s1-2core:~# ceph mon injectargs "mon osd full ratio = 96"
>> 2011-11-28 12:29:53.431669 mon<- [mon,injectargs,mon osd full ratio = 96]
>> 2011-11-28 12:29:53.432076 mon.0 ->  'unknown command injectargs' (-22)
> Oh, I forgot the syntax changed on these:
> ceph injectargs --mon_osd_full_ratio 96
