From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Lock contention in do_rule
Date: Sat, 24 Oct 2015 02:02:14 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F3176430D@SACMBXIP02.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F31764194@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1510231806220.16833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0060.outbound.protection.outlook.com ([157.56.110.60]:2370
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751440AbbJXCCT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Oct 2015 22:02:19 -0400
In-Reply-To: <alpine.DEB.2.00.1510231806220.16833@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks for the clarification Sage..
I don't have much knowledge on this part , but, what I understood by going through the code is the following..

1. Client calculates the pg->osd map by executing the same functions.

2. Request coming to OSDs and OSDs are executing the same functions again to check if mapping still is the same or not. If something changed and it is not the right OSD to execute the request it error out.

3. So, the lock is to protect against the bucket perm attribute write from multiple threads..

Some ideas :

1. The lock itself may not be expensive but it is held in the beginning of do_rule. If we take the lock in much more granular level like in bucket_perm_choose() , it could be a gain..If it is a possibility , we can test this out.

2. May be checking it from a messenger thread is having an effect, what if we move the check in the OSD worker thread  ?

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]
Sent: Friday, October 23, 2015 6:10 PM
To: Somnath Roy
Cc: ceph-devel@vger.kernel.org
Subject: Re: Lock contention in do_rule

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

This is clearly not the greatest approach.  I think what we need is a cache that is provided by the caller (which would be annoying an awkward because it's not linked directly to the bucket in question, and would not be shared between threads) or crush upcalls that take the lock only when in the perm path (which is relatively rare).  I'd lean toward the latter, but we need to be careful about it since this code is shared with the kernel and it needs to work there as well.  Probably we just need to define two callbacks for lock and unlock on the struct crush_map?

sage

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

