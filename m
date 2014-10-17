From: Sebastien Ponce <sebastien.ponce@cern.ch>
Subject: Re: Possible bug when getting batched xattrs
Date: Fri, 17 Oct 2014 13:01:18 +0200
Message-ID: <1413543678.1245.17.camel@sebmain.cern.ch>
References: <5440E131.2020501@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:35257 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbaJQLAQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 17 Oct 2014 07:00:16 -0400
In-Reply-To: <5440E131.2020501@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joaquim Rocha <joaquim.rocha@cern.ch>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I can confirm that head of master has the same behavior.

On top, having had a look at the osd code (name ly ReplicatedPG.cc
around line 4756 in master), it seems to be intended : we are in a for
loop going through the operations and executing them and the code says :
  if (result < 0)
      break;
So we exit the loop on the first error and do not execute the remaining
ops.

Sebastien


On Fri, 2014-10-17 at 11:28 +0200, Joaquim Rocha wrote:
> Hi,
> 
> I need to get a list of xattrs from one object (so I'm batching them in 
> one ObjectReadOperation) but I don't know in advance if all of those 
> xattrs exist.
> 
> I was expecting to figure out the ones that don't exist from the return 
> code of each getxattr call but I have however noticed that as soon one 
> nonexistent xattr is processed, its return code gets correctly set to 
> -ENODATA but the remaining xattrs are never checked. And what is worse, 
> the remaining getxattr op's return codes get assigned to 0.
> 
> I am attaching a small test case I've quickly written that proves the 
> case. (I am using Ceph 0.80.5)
> 
> Could you confirm that this is not the intended behavior (that all read 
> op's calls should be processed)?
> 
> 
> Thank you in advance,
> 
> --
> Joaquim Rocha
> http://www.joaquimrocha.com


