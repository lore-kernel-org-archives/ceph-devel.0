From: Samuel Just <sjust@redhat.com>
Subject: Re: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 11:33:30 -0800
Message-ID: <CAN=+7FV1aFxmT8E_-=G4+OuOG=VotWV7PQv45zL3v3+mjDYbrQ@mail.gmail.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
	<20151203172508.GB13420@ultraspiritum.redhat.com>
	<CO1PR02MB208C446A80363743FC5D341F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
	<CAN=+7FU1z9w=dDZ8+qbvKu-_ucYEU8K0eKS99Pd6Ku=A=t2gWg@mail.gmail.com>
	<CO1PR02MB208B0C5A0B6995CC4EE87F5F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
	<1575682875.28391996.1449169755619.JavaMail.zimbra@redhat.com>
	<20151203191233.GA17144@ultraspiritum.redhat.com>
	<CAN=+7FVC5QU7Gz6qq9PPeVv3Nvkq0c0cbVNNcC+Rz-j7OcnHxQ@mail.gmail.com>
	<1928144476.28418457.1449170995351.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33833 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbbLCTdb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 14:33:31 -0500
Received: by ioir85 with SMTP id r85so92435992ioi.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 11:33:30 -0800 (PST)
In-Reply-To: <1928144476.28418457.1449170995351.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Well, yeah we are, it's just the actual Transaction structure which
wouldn't be dynamic -- the buffers and many other fields would still
hit the allocator.
-Sam

On Thu, Dec 3, 2015 at 11:29 AM, Casey Bodley <cbodley@redhat.com> wrote:
>
> ----- Original Message -----
>> Eh, Sage had a point that Transaction has a bunch of little fields
>> which would have to be filled in -- its move constructor would be less
>> trivial than unique_ptr's.
>> -Sam
>
> It's true that the move ctor has to do work. I counted 18 fields, half of
> which are integers, and the rest have move ctors themselves. But the cpu
> is good at integers. The win here is that you're not hitting the allocator
> in the fast path.
>
> Casey
>
>>
>> On Thu, Dec 3, 2015 at 11:12 AM, Adam C. Emerson <aemerson@redhat.com> wrote:
>> > On 03/12/2015, Casey Bodley wrote:
>> > [snip]
>> >> The queue_transactions() interface could take a container of Transactions,
>> >> rather than pointers to Transactions, and the ObjectStore would move them
>> >> out of the container into whatever representation it prefers.
>> > [snip]
>> >
>> > Or a pointer and count (or we could steal array_view from GSL). That way we
>> > could pass in any continguous range (std::vector or even a std::array or
>> > regular C style array allocated on the stack.)
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
