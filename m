From: Casey Bodley <cbodley@redhat.com>
Subject: Re: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 14:29:55 -0500 (EST)
Message-ID: <1928144476.28418457.1449170995351.JavaMail.zimbra@redhat.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com> <20151203172508.GB13420@ultraspiritum.redhat.com> <CO1PR02MB208C446A80363743FC5D341F40D0@CO1PR02MB208.namprd02.prod.outlook.com> <CAN=+7FU1z9w=dDZ8+qbvKu-_ucYEU8K0eKS99Pd6Ku=A=t2gWg@mail.gmail.com> <CO1PR02MB208B0C5A0B6995CC4EE87F5F40D0@CO1PR02MB208.namprd02.prod.outlook.com> <1575682875.28391996.1449169755619.JavaMail.zimbra@redhat.com> <20151203191233.GA17144@ultraspiritum.redhat.com> <CAN=+7FVC5QU7Gz6qq9PPeVv3Nvkq0c0cbVNNcC+Rz-j7OcnHxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:48531 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbbLCT35 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 14:29:57 -0500
In-Reply-To: <CAN=+7FVC5QU7Gz6qq9PPeVv3Nvkq0c0cbVNNcC+Rz-j7OcnHxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, ceph-devel@vger.kernel.org


----- Original Message -----
> Eh, Sage had a point that Transaction has a bunch of little fields
> which would have to be filled in -- its move constructor would be less
> trivial than unique_ptr's.
> -Sam

It's true that the move ctor has to do work. I counted 18 fields, half of
which are integers, and the rest have move ctors themselves. But the cpu
is good at integers. The win here is that you're not hitting the allocator
in the fast path.

Casey

> 
> On Thu, Dec 3, 2015 at 11:12 AM, Adam C. Emerson <aemerson@redhat.com> wrote:
> > On 03/12/2015, Casey Bodley wrote:
> > [snip]
> >> The queue_transactions() interface could take a container of Transactions,
> >> rather than pointers to Transactions, and the ObjectStore would move them
> >> out of the container into whatever representation it prefers.
> > [snip]
> >
> > Or a pointer and count (or we could steal array_view from GSL). That way we
> > could pass in any continguous range (std::vector or even a std::array or
> > regular C style array allocated on the stack.)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
