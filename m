From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Speed up 'rbd rm'
Date: Thu, 30 May 2013 12:23:07 +1000
Message-ID: <20130530022307.GA27809@onthe.net.au>
References: <20130529055942.GA3977@onthe.net.au>
 <51A65523.10107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:54859 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966953Ab3E3CXO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 May 2013 22:23:14 -0400
Content-Disposition: inline
In-Reply-To: <51A65523.10107@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Wed, May 29, 2013 at 12:21:07PM -0700, Josh Durgin wrote:
> On 05/28/2013 10:59 PM, Chris Dunlop wrote:
>> I see there's a new commit to speed up an 'rbd rm':
>>
>> http://tracker.ceph.com/projects/ceph/repository/revisions/40956410169709c32a282d9b872cb5f618a48926
>>
>> Is it safe to cherry-pick this commit on top of 0.56.6 (or, if not, v0.61.2) to speed up the remove?
> 
> You'll need 537386d906b8c0e395433461dcb03a82eb33f34f as well. It should
> apply cleanly to 0.61.2, and probably 0.56.6 too.

Thanks. I'll see how I go, I may just leave the 'rm' running all
weekend rather than futzing around recompiling ceph and getting
off the mainline track.

Perhaps as a low-churn high-impact (for those that need it) change,
this is a candidate to be back-patched into 0.61.3 and perhaps 0.56.7 ?

Cheers,

Chris.
