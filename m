From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: Best insertion point for storage shim
Date: Fri, 31 Aug 2012 11:59:43 -0400
Message-ID: <038F2DC9-0576-4372-BA5C-BD5B196934A4@ornl.gov>
References: <00b201cd8210$077de070$1679a150$@netmass.com>
 <alpine.DEB.2.00.1208240938070.29719@cobra.newdream.net>
 <002f01cd8786$31b62340$952269c0$@netmass.com>
 <CADvuQRFoReXqk0h2f_RpG-T9KJHV2p-7zzh4ceo6jqcC0BQDtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta01.ornl.gov ([128.219.14.70]:49011 "EHLO mta01.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754378Ab2HaP7q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 11:59:46 -0400
In-Reply-To: <CADvuQRFoReXqk0h2f_RpG-T9KJHV2p-7zzh4ceo6jqcC0BQDtw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Stephen Perkins <perkins@netmass.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Aug 31, 2012, at 11:15 AM, Tommi Virtanen wrote:

> On Fri, Aug 31, 2012 at 10:37 AM, Stephen Perkins <perkins@netmass.com> wrote:
>> Would this require 2 clusters because of the need to have RADOS keep N
>> copies on one and 1 copy on the other?
> 
> That's doable with just multiple RADOS pools, no need for multiple clusters.
> 
> And CephFS is even able to pick what pool to put a file in, at the
> time of its creation (see set_layout).

I think what he is looking for is not to bring data to a client to convert from replication to/from erasure coding, but to have the servers do it based on some metric _or_ have the client indicate which file needs to be converted and have the servers do the work.

I believe what you are saying is that I can have a directory using the replicated pool and another directory (or sub-directory) that uses the coding pool. The client would then copy the file from one directory to the other. The question becomes "Who does the erasure encoding?". The client (read back from the replica pool and write to the erasure pool) or the servers (copy data to the erasure pool and calculate on the servers)?

Scott