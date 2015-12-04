From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 20:43:58 -0500
Message-ID: <20151204014358.GA7239@ultraspiritum.redhat.com>
References: <1575682875.28391996.1449169755619.JavaMail.zimbra@redhat.com>
 <20151203191233.GA17144@ultraspiritum.redhat.com>
 <CAN=+7FVC5QU7Gz6qq9PPeVv3Nvkq0c0cbVNNcC+Rz-j7OcnHxQ@mail.gmail.com>
 <1928144476.28418457.1449170995351.JavaMail.zimbra@redhat.com>
 <CAN=+7FV1aFxmT8E_-=G4+OuOG=VotWV7PQv45zL3v3+mjDYbrQ@mail.gmail.com>
 <291788535.28463587.1449173661550.JavaMail.zimbra@redhat.com>
 <alpine.DEB.2.00.1512031303010.19170@cobra.newdream.net>
 <1814262106.28521757.1449177794388.JavaMail.zimbra@redhat.com>
 <CAN=+7FX3goZteU+niLf5gXpVBq0yFxi6Gkqux5FZbvJNpQieJw@mail.gmail.com>
 <CO1PR02MB208F2A592CD7CF75DF71346F40C0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58929 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754406AbbLDBoA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 20:44:00 -0500
Content-Disposition: inline
In-Reply-To: <CO1PR02MB208F2A592CD7CF75DF71346F40C0@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Samuel Just <sjust@redhat.com>, Casey Bodley <cbodley@redhat.com>, Sage Weil <sweil@redhat.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/12/2015, Somnath Roy wrote:
[snip]
> ##### Test Shared Smart ptr ######
> micros_used for shared ptr: 27105354

One thing to keep in mind is that, if there are any cases where we really DO
want to use shared_ptr, if we find ourselves assigning a new pointer then
releasing an old one, it's better to std::move from one to the other, since it
doesn't have to use locking/atomics to fiddle with the refcount in that case.
But if we can avoid them, all the better.


[snip]
> 2. I have also measured the cost of list::push_back etc. , all is expected.. if I replace list with vector again I am getting *some benefit* , which is also expected I guess.

If we have some idea how many elements we expect/want to hold, calling reserve
will get all our allocations done all at once rather than dipping into the heap
multiple times.

> I am not seeing any conclusion on the interface change...Here is my understanding so far..
> 
> 1. For the method like apply_transaction() which is taking Transaction reference now, I will not be changing the interface , instead will do an extra copy to create unique_ptr inside.
> 
> 2. For all the cases taking Transaction* , I will change that to TransactionRef&&
> 
> 3. The queue_transactions() will be changed to vector< TransactionRef> instead of list< Transaction*>
> 
> Let me know if I am missing anything..

My understanding is that in some cases we might not want to use the heap. (For
example, if we're executing a transaction synchronously rather than enqueing
it.) And to make Transaction movable. Then we would not build a
std::vector<TransactionRef>, what we would build instead is
std::vector<Transaction>

In this case, we should probably have everything just take Transaction&& (so the
caller can expect to have the contents of the transaction moved out.

We might also want to consider building a transaction in place. I know I
saw one constructor that takes bufferlist. If there are other cases where
we could benefit from just passing in arguments and having the transaction
built right into the vector (with emplace_back), that would be even
better than constructing it on the stack and moving it in to the vector.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
