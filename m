From: John Spray <john.spray@redhat.com>
Subject: Re: vstart runner for cephfs tests
Date: Thu, 23 Jul 2015 13:37:19 +0100
Message-ID: <55B0DFFF.7010402@redhat.com>
References: <55B0BB59.7010806@redhat.com> <55B0D687.1040403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52862 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436AbbGWMhU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Jul 2015 08:37:20 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 77D82C300F
	for <ceph-devel@vger.kernel.org>; Thu, 23 Jul 2015 12:37:20 +0000 (UTC)
In-Reply-To: <55B0D687.1040403@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, ceph-devel@vger.kernel.org



On 23/07/15 12:56, Mark Nelson wrote:
> I had similar thoughts on the benchmarking side, which is why I 
> started writing cbt a couple years ago.  I needed the ability to 
> quickly spin up clusters and run benchmarks on arbitrary sets of 
> hardware.  The outcome isn't perfect, but it's been extremely useful 
> for running benchmarks and sort of exists as a half-way point between 
> vstart and teuthology.
>
> The basic idea is that you give it a yaml file that looks a little bit 
> like a teuthology yaml file and cbt will (optionally) build a cluster 
> across a number of user defined nodes with pdsh, start various 
> monitoring tools (this is ugly right now, I'm working on making it 
> modular), and then sweep through user defined benchmarks and sets of 
> parameter spaces.  I have a separate tool that will sweep through ceph 
> parameters, create ceph.conf files for each space, and run cbt with 
> each one, but the eventual goal is to integrate that into cbt itself.
>
> Though I never really intended it to run functional tests, I just 
> added something like looks very similar to the rados suite so I can 
> benchmark ceph_test_rados for the new community lab hardware. I 
> already had a mechanism to inject OSD down/out up/in events, so with a 
> bit of squinting it can give you a very rough approximation of a 
> workload using the osd thrasher.  If you are interested, I'd be game 
> to see if we could integrate your cephfs tests as well (I eventually 
> wanted to add cephfs benchmark capabilities anyway).

Cool - my focus is very much on tightening the code-build-test loop for 
developers, but I can see us needing to extend that into a 
code-build-test-bench loop as we do performance work on cephfs in the 
future.  Does cbt rely on having ceph packages built, or does it blast 
the binaries directly from src/ onto the test nodes?

John
