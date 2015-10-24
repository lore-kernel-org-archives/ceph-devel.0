From: Sage Weil <sage@newdream.net>
Subject: Re: Lock contention in do_rule
Date: Fri, 23 Oct 2015 18:09:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510231806220.16833@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F31764194@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48301 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbbJXBJv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Oct 2015 21:09:51 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F31764194@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 24 Oct 2015, Somnath Roy wrote:
> Hi Sage,
> We are seeing the following mapper_lock is heavily contended and commenting out this lock is improving performance ~10 % (in the short circuit path).
> This is called for every io from osd_is_valid_op_target().
> I looked into the code ,but, couldn't understand the purpose of the lock , it seems redundant to me , could you please confirm ?
> 
> 
> void do_rule(int rule, int x, vector<int>& out, int maxout,
>                const vector<__u32>& weight) const {
>     Mutex::Locker l(mapper_lock);
>     int rawout[maxout];
>     int scratch[maxout * 3];
>     int numrep = crush_do_rule(crush, rule, x, rawout, maxout, &weight[0], weight.size(), scratch);
>     if (numrep < 0)
>       numrep = 0;
>     out.resize(numrep);
>     for (int i=0; i<numrep; i++)
>       out[i] = rawout[i];
>   }

It's needed because of this:

https://github.com/ceph/ceph/blob/master/src/crush/crush.h#L137
https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L88

This is clearly not the greatest approach.  I think what we need is a 
cache that is provided by the caller (which would be annoying an awkward 
because it's not linked directly to the bucket in question, and would not 
be shared between threads) or crush upcalls that take the lock only when 
in the perm path (which is relatively rare).  I'd lean toward the 
latter, but we need to be careful about it since this code is shared with 
the kernel and it needs to work there as well.  Probably we just need to 
define two callbacks for lock and unlock on the struct crush_map?  

sage
