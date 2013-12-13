From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: CEPH Erasure Encoding + OSD Scalability
Date: Fri, 13 Dec 2013 15:47:49 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE6AB62C@PLOXCHG03.cern.ch>
References: <-7369304096744919226@unknownmsgid>
 <3472A07E6605974CBC9BC573F1BC02E4A527147E@PLOXCHG03.cern.ch>
 <523C40B7.5060902@dachary.org>
 <alpine.DEB.2.00.1309200835110.25752@cobra.newdream.net>
 <523C7CAF.1020101@dachary.org>,<523DB725.2070104@dachary.org>,<3472A07E6605974CBC9BC573F1BC02E4A52727FF@PLOXCHG03.cern.ch>
 <3472A07E6605974CBC9BC573F1BC02E4AE69CCB4@PLOXCHG03.cern.ch>
 <52826E2D.2040503@dachary.org>
 <52A5F3A1.503@dachary.org>,<52A6D41A.3060205@dachary.org>
 <3472A07E6605974CBC9BC573F1BC02E4AE6A9C22@PLOXCHG03.cern.ch>
 <52A85A6C.9050709@dachary.org>,<52A861FB.6000901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:49051 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318Ab3LMPry convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Dec 2013 10:47:54 -0500
In-Reply-To: <52A861FB.6000901@inktank.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>, Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic, 

I (re-)pushed/fixed wip-bpc-01 in my GIT repository.

There is one commit of general interest to 'galois.c' which gives me a factor 1.5 speed improvement (I exchanged the region XOR loop with vector operations if available) in the Jerasure code base.

I have also replaced the parity implementation to use SSE registers (via assembler) ... (seen in snapraid) which gives a factor 2.5 for the BPC part ... 

I needed to add a test for this in arch/intel.c like it was for the crc32c register .

Cheers Andreas.

________________________________________
From: Mark Nelson [mark.nelson@inktank.com]
Sent: 11 December 2013 14:00
To: Loic Dachary
Cc: Andreas Joachim Peters; ceph-devel@vger.kernel.org
Subject: Re: CEPH Erasure Encoding + OSD Scalability

On 12/11/2013 06:28 AM, Loic Dachary wrote:
>
>
> On 11/12/2013 10:49, Andreas Joachim Peters wrote:> Hi Loic,
>> I am a little bit confused which kind of tool you actually want. You want a simple benchmark to check for degradation or you want a full profiler tool?
>>
>
> I was not sure, hence the confusion.
>
>> Most of the external tools have the problem that you measure the whole thing including buffer allocation and initialization. We probably don't want to measure how long it takes to allocate memory and write random numbers into it.
>>
>> I would just o:
>>
>> < prepare memory>
>> <take CPU/realtime>
>> < run algorithm >
>> <take CPU/realtime>
>> < print result>
>>
>
> Ok, I'll do that.
>
> I'm glad I learnt about the other tools in the process, even if only to conclude that they are not needed.

Certainly things like perf are useful for profiling but may be overkill
in the general case depending on what you are trying to do.  Collectl is
pretty low overhead though if you are just looking for per-process CPU
utilization stats.

>
> Cheers
>
>> Now one can also add to run the perf-stat tool after <prepare memory> and start it from within the test program pointing to the PID running <run alogorithm>, so the benchmark would be:
>>
>> < prepare memory>
>> < take CPU/realtime>
>> < fork=>"perf stat -p <mypid>";
>> < run algorithm n times>
>> < take CPU/realtime>
>> < SIGINT to fork>
>> < print results>
>>
>> As an extension one could also add to have <run algorithm> with <n> threads in a thread pool.
>>
>> Cheers Andreas.
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

