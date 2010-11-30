From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] Expose Ceph data location information to Hadoop
Date: Tue, 30 Nov 2010 09:50:32 -0800
Message-ID: <666B47ED-BD76-4344-9728-C95165BD8483@cs.ucsc.edu>
References: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu> <E76027BB-6C82-45D7-813A-E5B850FB5E09@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:47003 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab0K3Ruo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 12:50:44 -0500
In-Reply-To: <E76027BB-6C82-45D7-813A-E5B850FB5E09@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Alex=E2=80=8E_Nelson?= <ajnelson@cs.ucsc.edu>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org, Joe Buck <buck@soe.ucsc.edu>, Carlos Maltzahn <carlosm@soe.ucsc.edu>

> I didn't follow your numeric examples above---I missed how you mapped Offsets to Object Numbers---but I follow you on striping meaning different data locations for what Hadoop would think would be one Ceph object in one place.
I didn't explicitly describe the mapping algorithm, but it can be found in the function "ceph_calc_file_object_mapping(...)" in the kernel client. If you execute the algorithm with the parameters in my example you can reproduce the mapping I presented.

>> 
>> The more natural (and general) solution is to consider the stripe unit to be the _unit_ of Hadoop blocks, not entire objects. When stripe unit and block size are the same the result is analogous to HDFS's treatment of blocks.
> I agree with you, and push forward one more step:  Ceph and Hadoop should just think of a block/object as the same size.
Per Sage's response, Hadoop block can be equal to Ceph stripe unit.


> One of the TODO's is exposing Ceph's object size to Hadoop, and that "read" interface for block size will probably need to expand to a "write" interface to reduce confusion with folks configuring Hadoop to use a block size of N bytes.
How is configured block size relevant in Hadoop? This seems to me to be specific to HDFS. The analogy would be to configure the file layout parameters in Ceph.

> After writing this code, I do like seeing the words "scrap" and "JNI" so close in the same sentence.  That's more up to the Hadoop community, though; I don't know how well-accepted JNA is in their code base.
One solution might be a lazily populated sysfs interface for retrieving object information for a given file, circumventing the problem Java has calling IOCTLs. But that's another conversation.

> The ioctl struct ceph_ioctl_dataloc already returns the primary copy's object offset for an input file offset, though I think it would be a little more useful if it included replica offsets.
I can submit a patch for this. Sage, I remember you mentioning that reading from replicas might pose (scalability?) problems. Any thoughts on this?