From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Memstore performance improvements v0.90 vs v0.87
Date: Tue, 27 Jan 2015 15:03:24 -0600
Message-ID: <54C7FD1C.40406@redhat.com>
References: <3649A15A2562B54294DE14BCE5AC79120AB30A5D@FMSMSX106.amr.corp.intel.com> <3649A15A2562B54294DE14BCE5AC79120AB30EEA@FMSMSX106.amr.corp.intel.com> <54B6F103.9000708@redhat.com> <3649A15A2562B54294DE14BCE5AC79120AB31012@FMSMSX106.amr.corp.intel.com>
Reply-To: mnelson@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:57718 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933064AbbA0VDc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jan 2015 16:03:32 -0500
Received: by mail-qa0-f54.google.com with SMTP id w8so13311347qac.13
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jan 2015 13:03:31 -0800 (PST)
In-Reply-To: <3649A15A2562B54294DE14BCE5AC79120AB31012@FMSMSX106.amr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Blinick, Stephen L" <stephen.l.blinick@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Stephen,

Took a little longer than I wanted it to, but I finally got some results 
looking at RHEL7 and Ubuntu 14.04 in our test lab.  This is with a 
recent master pull.

Tests are with rados bench to a single memstore OSD on localhost.

Single Op Avg Write Latency:

Ubuntu 14.04:            0.91ms
Ubuntu 14.04 (no debug): 0.67ms
RHEL 7:                  0.49ms
RHEL 7 (no debug):       0.31ms

Single Op Avg read Latency:

Ubuntu 14.04:            0.58ms
Ubuntu 14.04 (no debug): 0.33ms
RHEL 7:                  0.32ms
RHEL 7 (no debug):       0.17ms

I then checked avg network latency to localhost using ping for 120s:

Ubuntu 14.04: 0.025ms
RHEL 7:       0.015ms

So looking at your results, I see similar latency numbers, though not 
quite as dramatic (ie  Ubuntu isn't quite so bad).  I wanted to know if 
the latency would be hidden if enough IOs were thrown at the problem so 
I increased concurrent IOs to 256:

256 concurrent op Write IOPS:

Ubuntu 14.04:             7199 IOPS
Ubuntu 14.04 (no debug): 14613 IOPS
RHEL 7:                   7784 IOPS
REHL 7 (no debug):       17907 IOPS

256 concurrent op Read IOPS:

Ubuntu 14.04:             9887 IOPS
Ubuntu 14.04 (no debug): 20489 IOPS
RHEL 7:                  10832 IOPS
REHL 7 (no debug):       21257 IOPS

So on one hand I'm seeing an effect similar to what you saw, but once I 
throw enough concurrency at the problem it seems like other things take 
over as the bottleneck.  With default debug logging levels the latency 
difference is mostly masked, but with debugging off we see at least for 
writes a fairly substantial difference.

I collected some system utilization data during the tests and will go 
back and see if I can discover anything more with perf as well.  I think 
the two big takeaways at this point are:

1) There is definitely something interesting going on with Ubuntu vs 
RHEL (Maybe network related).
2) Our debug logging has become a major bottleneck in high IOPS 
scenarios (though we already kind of knew this).

Mark

On 01/14/2015 05:39 PM, Blinick, Stephen L wrote:
> Haha :)  Well, my intuition is still pointing to something I've configured wrong (or had wrong).. but it will be interesting to see what it is.
>
> -----Original Message-----
> From: Mark Nelson [mailto:mark.nelson@inktank.com]
> Sent: Wednesday, January 14, 2015 3:43 PM
> To: Blinick, Stephen L; Ceph Development
> Subject: Re: Memstore performance improvements v0.90 vs v0.87
>
> On 01/14/2015 04:32 PM, Blinick, Stephen L wrote:
>> I went back and grabbed 87 and built it on RHEL7 as well, and performance is also similar (much better).  I've also run it on a few systems (Dual socket 10-core E5v2,  Dual socket 6-core E5v3).  So, it's related to my switch to RHEL7, and not to the code changes between v0.90 and v0.87.     Will post when I get more data.
>
> Stephen, you are practically writing press releases for the RHEL guys here! ;)
>
> Mark
>
>>
>> Thanks,
>>
>> Stephen
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Blinick,
>> Stephen L
>> Sent: Wednesday, January 14, 2015 12:06 AM
>> To: Ceph Development
>> Subject: Memstore performance improvements v0.90 vs v0.87
>>
>> In the process of moving to a new cluster (RHEL7 based) I grabbed v0.90, compiled RPM's and re-ran the simple local-node memstore test I've run on .80 - .87.  It's a single Memstore OSD and a single Rados Bench client locally on the same node.  Increasing queue depth and measuring latency /IOPS.  So far, the measurements have been consistent across different hardware and code releases (with about a 30% improvement with the OpWQ Sharding changes that came in after Firefly).
>>
>> These are just very early results, but I'm seeing a very large improvement in latency and throughput with v90 on RHEL7.   Next  I'm working to get lttng installed and working in RHEL7 to determine where the improvement is.   On previous levels, these measurements have been roughly the same using a real (fast) backend (i.e. NVMe flash), and I will verify here as well.   Just wondering if anyone else has measured similar improvements?
>>
>>
>> 100% Reads or Writes, 4K Objects, Rados Bench
>>
>> ========================
>> V0.87: Ubuntu 14.04LTS
>>
>> *Writes*
>> #Thr	IOPS	Latency(ms)
>> 1	618.80		1.61
>> 2	1401.70		1.42
>> 4	3962.73		1.00
>> 8	7354.37		1.10
>> 16	7654.67		2.10
>> 32	7320.33		4.37
>> 64	7424.27		8.62
>>
>> *Reads*
>> #thr	IOPS	Latency(ms)
>> 1	837.57		1.19
>> 2	1950.00		1.02
>> 4	6494.03		0.61
>> 8	7243.53		1.10
>> 16	7473.73		2.14
>> 32	7682.80		4.16
>> 64	7727.10		8.28
>>
>>
>> ========================
>> V0.90:  RHEL7
>>
>> *Writes*
>> #Thr	IOPS	Latency(ms)
>> 1	2558.53		0.39
>> 2	6014.67		0.33
>> 4	10061.33	0.40
>> 8	14169.60	0.56
>> 16	14355.63	1.11
>> 32	14150.30	2.26
>> 64	15283.33	4.19
>>
>> *Reads*
>> #Thr	IOPS	Latency(ms)
>> 1	4535.63		0.22
>> 2	9969.73		0.20
>> 4	17049.43	0.23
>> 8	19909.70	0.40
>> 16	20320.80	0.79
>> 32	19827.93	1.61
>> 64	22371.17	2.86
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
