From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [ceph-users] keyvaluestore backend metadata overhead
Date: Tue, 10 Feb 2015 14:33:23 +0800
Message-ID: <CACJqLybC77hydikKMXb5CT1Upv-fWrVZWdhbwvx7eXK4yMXKaw@mail.gmail.com>
References: <CAC8iE5iHTEfSQL978paWpu9hSfUbE65OVT_dKi2P=yvWSQ5JhA@mail.gmail.com>
	<alpine.DEB.2.00.1501291447290.3895@cobra.newdream.net>
	<CACJqLya-SNwudLTOqu2RPgr3_MZKzFWi9gXYH_xCg1WjxAx59w@mail.gmail.com>
	<CAC8iE5jrYquoQ+n+uwiiZ5uevXfipGsab9a_CgjtZoW9h1L0SQ@mail.gmail.com>
	<CACJqLyZnx28QEDU-Jy3KjzS6sumMG_ivqJQ9Ye_cg++Cj8WWQg@mail.gmail.com>
	<CAC8iE5gmiFFGikg0JatUs-7Jfv3sgFPd3ESx5+bOdkYSP6ByKg@mail.gmail.com>
	<CAC8iE5ggZme9BKz7noCynEpjd2yhCnoK5yd79pM2g7-237ZxkA@mail.gmail.com>
	<CACJqLyZSDrCZKvC2REFzXvT+owV38de4ys+JmcENEL=zPtQGBg@mail.gmail.com>
	<CAC8iE5gK_bO9CMJTbnRzz3zzgOrDJ8vZOUX9hjjyQAQQQzR-hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:38927 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbbBJGdZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 01:33:25 -0500
Received: by mail-we0-f173.google.com with SMTP id w55so19969031wes.4
        for <ceph-devel@vger.kernel.org>; Mon, 09 Feb 2015 22:33:24 -0800 (PST)
In-Reply-To: <CAC8iE5gK_bO9CMJTbnRzz3zzgOrDJ8vZOUX9hjjyQAQQQzR-hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Pacejo <cpacejo@clearskydata.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Feb 10, 2015 at 2:29 AM, Chris Pacejo <cpacejo@clearskydata.com> wrote:
> On Tue, Feb 3, 2015 at 9:31 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
>> Maybe more detail number can help us a bit.
>
> Here's what we're testing with and what we observe:
>
> Hardware:
>  2x6-core hyperthreaded Xeon E5-2620 v2 2.10GHz CPU
>  8x8 GiB DDR3 RAM
>  4x4 TB 7200 RPM 8 ms 183 MB/s SAS rotary disks
>
> Software:
>  CentOS 7
>  CEPH 0.91
>  4 OSDs
>  osd pool default size = 1 (just for testing!)
>  keyvaluestore op threads = 16
>  keyvaluestore backend = mysql (our own backend)
>  one MySQL process per OSD, each writing to a separate disk
>
> Test setup:
>  rados bench on a fresh install
>  256 concurrent writes
>  360 seconds
>  2700 byte objects, and 1 MiB objects
>  measure throughput with rados bench
>  measure CPU usage by observing top
>  measure max concurrent transaction submits by instrumenting the
> KeyValueDB interface
>
> With this setup, we observe that, with 2700 byte objects:
>
>  7.4 MiB/s (~2900 ops/s) throughput,
>  170%/170%/60%/60% OSD CPU usage,
>  200%/200%/65%/65% MySQL CPU usage, and
>  3/3/1/1 maximum concurrent transaction submits;
>
> and with 1 MiB objects:
>
>  50.7 MiB/s (~51 ops/s) throughput,
>  14%/14%/4%/4% OSD CPU usage,
>  50%/50%/15%/15% MySQL CPU usage, and
>  3/3/1/1 maximum concurrent transaction submits.

It looks like that a little unbalance ops for four osds?

>
> We know that our transaction concurrency measurement is not buggy, as
> it will consistently report up to `keyvaluestore op threads`
> concurrent submits both on OSD startup on this same hardware, and
> during benchmarking in a resource-constrained VM.  We are pretty sure
> MySQL is not the bottleneck, since we've been able to throw much more
> at it (concurrently); at least 10 kops/s per instance.  (Sequentially
> it is not so good; hence our fixation on the low transaction
> concurrency!)
>
> Let me know if there are any other figures which would be helpful in
> diagnosing why the OSDs are not issuing as many concurrent
> transactions as we'd like, or why they are using so much CPU.  Thanks
> for your help.

I think you can look at perf dump result to see whether exists full
throttle queue, such as keyvaluestore queue.

Sorry, I still can't think of anything may prevent concurrent level
above objectstore backend, at most of cases, backend should be the
bottleneck

>
> - Chris



-- 
Best Regards,

Wheat
