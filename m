From: Joe Buck <buck@soe.ucsc.edu>
Subject: Re: [PATCH] Expose Ceph data location information to Hadoop
Date: Tue, 30 Nov 2010 12:25:49 -0800
Message-ID: <835174BE-AE8C-4733-BA39-546F6848101A@soe.ucsc.edu>
References: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu> <E76027BB-6C82-45D7-813A-E5B850FB5E09@cs.ucsc.edu> <666B47ED-BD76-4344-9728-C95165BD8483@cs.ucsc.edu> <Pine.LNX.4.64.1011300957080.30759@cobra.newdream.net> <922E2470-F2F4-4F5B-A41A-12F233779DCF@cs.ucsc.edu> <Pine.LNX.4.64.1011301049590.30759@cobra.newdream.net> <97159B5A-4B38-4251-B376-8033C8A5E599@cs.ucsc.edu> <9DEABEC1-48A1-466D-9942-C0D8A199EF96@soe.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:60814 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab0K3Ubw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 15:31:52 -0500
In-Reply-To: <9DEABEC1-48A1-466D-9942-C0D8A199EF96@soe.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Carlos Maltzahn <carlosm@soe.ucsc.edu>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, Sage Weil <sage@newdream.net>, =?utf-8?Q?Alex=E2=80=8E_Nelson?= <ajnelson@cs.ucsc.edu>, Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org

Having been in the code in Hadoop, each input split (a chunk of data to be processed), has with it a set of hosts to run on. But, that list is not a hard limit, rather it's merely a strong suggestion. Hadoop will work, in the sense that the map() and reduce() functions will execute and results will be produced, with no locality information. But, the whole point of Hadoop is to do in-situ processing so we want to give Hadoop the most opportunities to place the job on  host that has the data locally as we can.
Having only one host specified per block of data, as I assume Alex's implementation did from this discussion, then it's a lot more likely that a non-local host would read the data. Enabling Hadoop reads from replicas would make the load balancing a lot more efficient in terms of reads being local.

-Joe Buck

On Nov 30, 2010, at 11:48 AM, Carlos Maltzahn wrote:

> 
> On Nov 30, 2010, at 11:04 AM, Noah Watkins wrote:
> 
>>> Are we sure JNI is a real problem?  It really seems like the right tool 
>>> for the job.  Greg seems to remember them asking who would maintain the 
>>> (non-java) JNI bits, but even if that's us and not them (which is probably 
>>> the way to go anyway), I don't see that that's a problem.
>> 
>> Yeh, it's sort of a wash. A nice goal would be to have a patch that allowed Hadoop to not require any additional components (i.e. JNI packages) from the Ceph repository. Given that the Ceph infrastructure will be installed anyway in the case of Hadoop, it's a bit of a toss up.
>> 
>> -n
>> 
>>> Let's start with just providing the primary replica, at least until we 
>>> find out whether hadoop takes advantage of additional ones (does HDFS read 
>>> from the local non-primary replica?).
>> 
>> I believe that Hadoop will schedule a map job on at a local replica for load balancing, or to duplicate the work when a map is running slowly. Joe, can you confirm this?
> 
> Let me chime in: I believe Hadoop is scheduling by a combination of load and locality (and maybe other variables). I think the more choices we give to the task manager to satisfy both load and locality requirements, the better it will perform. Allowing Hadoop to see all replicas will allow us to verify the tradeoff between mapper performance and cost of additional replication.

