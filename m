From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: CEPH Erasure Encoding + OSD Scalability
Date: Wed, 11 Dec 2013 09:49:05 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE6A9C22@PLOXCHG03.cern.ch>
References: <-7369304096744919226@unknownmsgid>
 <3472A07E6605974CBC9BC573F1BC02E4A527147E@PLOXCHG03.cern.ch>
 <523C40B7.5060902@dachary.org>
 <alpine.DEB.2.00.1309200835110.25752@cobra.newdream.net>
 <523C7CAF.1020101@dachary.org>,<523DB725.2070104@dachary.org>,<3472A07E6605974CBC9BC573F1BC02E4A52727FF@PLOXCHG03.cern.ch>
 <3472A07E6605974CBC9BC573F1BC02E4AE69CCB4@PLOXCHG03.cern.ch>
 <52826E2D.2040503@dachary.org>
 <52A5F3A1.503@dachary.org>,<52A6D41A.3060205@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:30417 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab3LKJtL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 04:49:11 -0500
In-Reply-To: <52A6D41A.3060205@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic, 
I am a little bit confused which kind of tool you actually want. You want a simple benchmark to check for degradation or you want a full profiler tool?

Most of the external tools have the problem that you measure the whole thing including buffer allocation and initialization. We probably don't want to measure how long it takes to allocate memory and write random numbers into it. 

I would just do:

< prepare memory>
<take CPU/realtime>
< run algorithm >
<take CPU/realtime>
< print result>

Now one can also add to run the perf-stat tool after <prepare memory> and start it from within the test program pointing to the PID running <run alogorithm>, so the benchmark would be:

< prepare memory>
< take CPU/realtime>
< fork=>"perf stat -p <mypid>";
< run algorithm n times>
< take CPU/realtime>
< SIGINT to fork>
< print results>

As an extension one could also add to have <run algorithm> with <n> threads in a thread pool.

Cheers Andreas.



