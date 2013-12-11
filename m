From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Wed, 11 Dec 2013 07:00:43 -0600
Message-ID: <52A861FB.6000901@inktank.com>
References: <-7369304096744919226@unknownmsgid> <3472A07E6605974CBC9BC573F1BC02E4A527147E@PLOXCHG03.cern.ch> <523C40B7.5060902@dachary.org> <alpine.DEB.2.00.1309200835110.25752@cobra.newdream.net> <523C7CAF.1020101@dachary.org>,<523DB725.2070104@dachary.org>,<3472A07E6605974CBC9BC573F1BC02E4A52727FF@PLOXCHG03.cern.ch> <3472A07E6605974CBC9BC573F1BC02E4AE69CCB4@PLOXCHG03.cern.ch> <52826E2D.2040503@dachary.org> <52A5F3A1.503@dachary.org>,<52A6D41A.3060205@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE6A9C22@PLOXCHG03.cern.ch> <52A85A6C.9050709@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:52582 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab3LKNAg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 08:00:36 -0500
Received: by mail-ig0-f177.google.com with SMTP id uy17so733618igb.4
        for <ceph-devel@vger.kernel.org>; Wed, 11 Dec 2013 05:00:36 -0800 (PST)
In-Reply-To: <52A85A6C.9050709@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

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

