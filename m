From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Ceph Benchmark HowTo
Date: Tue, 24 Jul 2012 10:55:37 -0500
Message-ID: <500EC579.4060707@inktank.com>
References: <20120724144300.GA3317@mail.sileht.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33303 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab2GXPzl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jul 2012 11:55:41 -0400
Received: by yhmm54 with SMTP id m54so6804507yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jul 2012 08:55:41 -0700 (PDT)
In-Reply-To: <20120724144300.GA3317@mail.sileht.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mehdi Abaakouk <sileht@sileht.net>
Cc: ceph-devel@vger.kernel.org

On 07/24/2012 09:43 AM, Mehdi Abaakouk wrote:
> Hi all,
>
> I am currently doing some tests on Ceph, more precisely on the RDB and RADOSGW
> parts.
> My goal is to get some performance metrics according to the hardwares and
> the Ceph setup.
>
> To do so, I am preparing a benchmark how-to, to help people to compare their
> metrics.
>
> I have started the how-to here : http://ceph.com/w/index.php?title=Benchmark
> I have linked it in the misc section of the main page.
>
> Then, first question, is it alright if I continue publishing this procedure
> on your wiki ?
>
> The how-to is not finished yet, this is only a first draft.
> My test platform is not ready yet too, so the result of the bench can't be
> used yet.
>
> The next work I will do on the how-to is to add some explanations on how
> to interpret the results of benchmark.
>
> So, if you have some comments, ideas of benchmarks, or anything that can be
> helpful to me to improve the how-to and/or compare future results,
> I would be glad to read them.
>
> And thanks a lot for your work on Ceph, this is a great storage system :)
>
> Best Regards,

Hi Mehdi,

Thanks for taking the time to put all of your benchmarking procedures 
into writing!  Having this kind of community participation is really 
important for a project like Ceph.  We use many of the same tools 
internally and personally I think it's fine to have it on the wiki.  I 
do want to stress that performance is going to be (hopefully!) improving 
over the next couple of months so we will probably want to have updated 
results (or at least remove old results!) as things improve.  Also, I'm 
not sure if we will be keeping the wiki around in it's current form. 
There was some talk about migrating to something else, but I don't 
really remember the details.

Some comments:

- 60s is a pretty short test.  You may get a more accurate 
representation of throughput by running longer tests.
- Performance degradation on aged filesystems can be an issue, so you 
may see different results if you run the test on a fresh filesystem vs 
one that has already had a lot of data written to it.
- Depending on the number of OSDs you have you may want to explicitly 
set the number of PGs when creating the benchmarking pool.
- We also have a tool called "test_filestore_workloadgen" which lets you 
directly test the filestore (data disk and journal) which can be useful 
when doing strace/perf/valgrind tests.

Also, We have some scripts in our ceph-tools repo that may also be 
useful for anyone who is interested in performance profiling or 
benchmarking.  Specifically:

analysis/log_analyzer.py - lets you analyze where high latency requests 
are spending their time if debugging/tracker options are turned on for 
the logs.

analysis/strace_parser.py - Rough tool to let you examine the frequency 
of various write/read/etc operations as reported by strace.  Useful for 
analyzing IO for things other than Ceph as well, but still in progress.

aging/runtests.py - A tool we use for running rados bench and rest bench 
internally on multiple clients.  Eventually this may be folded into our 
teuthology project as much of the functionality overlaps.  Requires 
pdsh, collectl, blktrace, perf, and possibly some other dependencies.

Thanks,
Mark
-- 
Mark Nelson
Performance Engineer
Inktank
