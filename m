From: Wido den Hollander <wido@widodh.nl>
Subject: Re: towards a user-mode diagnostic log mechanism
Date: Fri, 23 Dec 2011 11:04:44 +0100
Message-ID: <4EF4523C.9030104@widodh.nl>
References: <4EEFF614.8040207@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:38086 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069Ab1LWKEZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Dec 2011 05:04:25 -0500
In-Reply-To: <4EEFF614.8040207@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 12/20/2011 03:42 AM, Mark Kampe wrote:
> I'd like to keep this ball moving ... as I believe that the
> limitations of our current logging mechanisms are already
> making support difficult, and that is about to become worse.
>

I'll have to agree on that.

Running a larger cluster with full debugging on is nearly impossible. It 
puts a lot of load on your systems which could even lead to more trouble.

> As a first step, I'd just like to get opinions on the general
> requirements we are trying to satisfy, and decisions we have
> to make along the way.
>
> Comments?
>
> I Requirements
>
> A. Primary Requirements (must have)
> 1. information captured
> a. standard: time, sub-system, level, proc/thread
> b. additional: operation and parameters
> c. extensible for new operations
> 2. efficiency
> a. run time overhead < 1%
> (I believe this requires delayed flush circular bufferring)
> b. persistent space O(Gigabytes per node-year)
> 3. configurability
> a. capture level per sub-system
> 4. persistence
> a. flushed out on process shut-down
> b. recoverable from user-mode core-dumps
> 5. presentation
> a. output can be processed w/grep,less,...
>
> B. Secondary Requirements (nice to have)
> 1. ease of use
> a. compatible with/convertable from existing calls
> b. run-time definition of new event records
> 2. configurability
> a. size/rotation rules per sub-system
> b. separate in-memory/on-disk capture levels
>
> II Decisions to be made
>
> A. Capture Circumstances
> 1. some subset of procedure calls
> (I'm opposed to this, but it is an option)
> 2. explicit event logging calls
>
> B. Capture Format
> 1. ASCII text
> 2. per-event binary format
> 3. binary header + ASCII text
>
> C. Synchronization
> 1. per-process vs per-thread buffers
>
> D. Flushing
> 1. last writer flushes vs dedicated thread
> 2. single- vs double-bufferred output
>
> E. Available open source candidates

I'd still opt for the ring-buffer where all kinds of information is 
being dumped in. A separate reader/analyser can get this information out 
of the ring and write logs of it our do performance counting.

Currently there is no statistics information about OSD's as well. From 
log entries you can also generate statistics, the amount of IOps a 
specific OSD has to process, the number of PG operations, etc, etc.

I'd still suggest to take a look at how Varnish did this with their 
varnishlog and varnishncsa tools.

That works for us with 10k req/sec and we can do fully debugging without 
performance impact.

Just my $2c

Wido

>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

