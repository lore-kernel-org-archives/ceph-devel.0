From: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Hammer vs Jewel librbd performance testing and git
	bisection results
Date: Wed, 11 May 2016 08:21:18 -0500
Message-ID: <f9f54455-8348-42b7-153b-e38850eed5e1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "cbt-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <cbt-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Guys,

we spent some time over the past week looking at hammer vs jewel RBD 
performance in HDD only, HDD+NVMe journal, and NVMe cases with the 
default filestore backend.  We ran into a number of issues during 
testing and I don't want to get into everything, but we were eventually 
able to get a good set of data out of fio's bandwidth and latency logs. 
Fio's log sampling intervals were not uniform, but Jens has since 
written an experimental patch for fio that fixes this which you can find 
in this thread:

http://www.spinics.net/lists/fio/msg04713.html

We ended up writing a parser that can work around this by reading 
multiple fio bw/latency log files and getting aggregate data even 
assuming non-uniform sample intervals.  This was briefly part of CBT, 
but recently was included upstream in fio itself.  Armed with this, we 
were able to get a seemingly accurate view of hammer vs jewel 
performance across various IO sizes:

https://docs.google.com/spreadsheets/d/1MK09ZXufTUCgqa9jVJFO-J9oZWMKn7SnKN7NJ45fzTE/edit?usp=sharing

The gist of this is that Jewel is faster than Hammer for many random 
workloads (Read, Write, and Mixed).  There is one specific case where 
performance degrades significantly: 64-128k sequential reads.  We 
couldn't find anything obviously wrong with these tests, so we spent 
some time running git bisects between hammer and jewel with the NVMe 
test configuration (these tests were faster to setup/run than the HDD 
setup).  We tested about 45 different commits with anywhere from 1-5 
samples depending on how confident the results looked:

https://docs.google.com/spreadsheets/d/1hbsyNM5pr-ZwBuR7lqnphEd-4kQUid0C9eRyta3ohOA/edit?usp=sharing

There are several commits of interest that have a noticeable effect on 
128K sequential read performance:


1) https://github.com/ceph/ceph/commit/3a7b5e3

This commit was the first that introduced anywhere from a 0-10% 
performance decrease in the 128K sequential read tests.  Primarily it 
made performance lower on average and more variable.


2) https://github.com/ceph/ceph/commit/c474ee42

This commit had a very large impact, reducing performance by another 20-25%.


3) https://github.com/ceph/ceph/commit/66e7464

This was a fix that helped regain some of the performance loss due to 
c474ee42, but didn't totally reclaim it.


4) 218bc2d - b85a5fe

Between commits 218bc2d and b85a5fe, there's a fair amount of 
variability in the test results.  It's possible that some of the commits 
here are having an effect on performance, but it's difficult to tell. 
Might be worth more investigation after other bottlenecks are removed.


5) https://github.com/ceph/ceph/commit/8aae868

The new AioImageRequestWQ appears to be the cause of the most recent 
large reduction in 128K sequential read performance.


6) 8aae868 - 6f18f04

There may be some additional small performance impacts in these commits, 
though it's difficult to tell which ones since most of the bisects had 
to be skipped due to ceph failing to compile.

This is what we know so far, thank for reading. :)

Mark
