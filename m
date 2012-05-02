From: Clint Byrum <clint@fewbar.com>
Subject: Re: weighted distributed processing.
Date: Wed, 02 May 2012 15:42:51 -0700
Message-ID: <1335996860-sup-4969@fewbar.com>
References: <4FA18F2D.3020007@usask.ca> <4FA1AFA3.9000300@artefactual.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from xenclint.srihosting.com ([65.98.207.160]:34910 "EHLO
	xen.spamaps.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab2EBXE1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 May 2012 19:04:27 -0400
In-reply-to: <4FA1AFA3.9000300@artefactual.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joseph Perry <joseph@artefactual.com>
Cc: archivematica <archivematica@googlegroups.com>, gearman <gearman@googlegroups.com>, ceph-devel <ceph-devel@vger.kernel.org>

Excerpts from Joseph Perry's message of Wed May 02 15:05:23 -0700 2012:
> Hello All,
> First off, I'm sending this email to three discussion groups:
> gearman@googlegroups.com - distributed processing library
> ceph-devel@vger.kernel.org - distributed file system
> archivematica@googlegroups.com - my project's discussion list, a 
> distributed processing system.
> 
> I'd like to start a discussion about something I'll refer to as weighted 
> distributed task based processing.
> Presently, we are using gearman's library's to meet our distributed 
> processing needs. The majority of our processing is file based, and our 
> processing stations are accessing the files over an nfs share. We are 
> looking at replacing the nfs server share with a distributed file 
> systems, like ceph.
> 
> It occurs to me that our processing times could theoretically be reduced 
> by by assigning tasks to processing clients where the file resides, over 
> places where it would need to be copied over the network. In order for 
> this to happen, the gearman server would need to get file location 
> information from the ceph system.
> 

If I understand the design of CEPH completely, it spreads I/O at the
block level, not the file level.

So there is little point in weighting since it seeks to spread the whole
file across all the machines/block devices in the cluster. Even if you
do ask ceph "which servers is file X on", which I'm sure it could tell
you, You will end up with high weights for most of the servers, and no
real benefit.

In this scenario, you're just better off having a really powerful network
and CEPH will balance the I/O enough that you can scale out the I/O
independently of the compute resources. This seems like a huge win, as
I don't believe most workloads scale at a 1:1 I/O:CPU ratio. 10Gigabit
switches are still not super cheap, but they are probably cheaper than
software engineer hours.

If your network is not up to the task of transferring all those blocks
around, you probably need to focus instead on something that keeps whole
files in a certain place. One such system would be MogileFS. This has a
database with a list of keys that say where the data lives, and in fact
the protocol the MogileFS tracker uses will tell you all the places a
key lives. You could then place a hint in the payload and have 2 levels
of workers. The pseudo becomes:

-workers register two queues. 'dispatch_foo', and 'do_foo_$hostname'
-client sends task w/ filename to 'dispatch_foo' 
-dispatcher looks at filename, asks mogile where the file is, looks at
recent queue lengths in gearman, and decides whether or not it is enough
of a win to direct the job to the host where the file is, or to farm it
out to somewhere that is less busy.

This will take a lot of poking at to get tuned right, but it should be
tunable to a single number, the ratio of localized queue length versus
non-localized queue length.

> pseudo:
> gearman client creates a task & includes a weight, of type ceph file
> gearman server identifies the file & polls the ceph system for clients 
> that have this file
> ceph system returns a list of clients that have the file locally
> gearman assigns the task
> .    if there is a client available for processing that has the file locally
> .        assign it there
> .        (that client has local access to the file, still on the ceph 
> system)
> .    else
> .        assign to other client
> .        (that processing client will pull the file from the ceph system 
> over the network)
> 
> 
> I call it a weighted distributed processing system, because it reminds 
> me of a weighted die: The outcome is influenced to a certain direction 
> (in the task assignment).
> 
> I wanted to start this as a discussion, rather than filing feature 
> requests, because of the complex nature of the requests, and the nicer 
> medium for feedback, clarification and refinement.
> 
> I'd be very interested to hear feedback on the idea,
> Joseph Perry
