From: Samuel Just <sjust@redhat.com>
Subject: Re: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 11:14:55 -0800
Message-ID: <CAN=+7FVC5QU7Gz6qq9PPeVv3Nvkq0c0cbVNNcC+Rz-j7OcnHxQ@mail.gmail.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
	<alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
	<CO1PR02MB2087E3AF3553B6269FBC10DF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
	<20151203172508.GB13420@ultraspiritum.redhat.com>
	<CO1PR02MB208C446A80363743FC5D341F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
	<CAN=+7FU1z9w=dDZ8+qbvKu-_ucYEU8K0eKS99Pd6Ku=A=t2gWg@mail.gmail.com>
	<CO1PR02MB208B0C5A0B6995CC4EE87F5F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
	<1575682875.28391996.1449169755619.JavaMail.zimbra@redhat.com>
	<20151203191233.GA17144@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37054 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbbLCTO4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 14:14:56 -0500
Received: by igcto18 with SMTP id to18so19407877igc.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 11:14:56 -0800 (PST)
In-Reply-To: <20151203191233.GA17144@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Samuel Just <sjust@redhat.com>, Sage Weil <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Eh, Sage had a point that Transaction has a bunch of little fields
which would have to be filled in -- its move constructor would be less
trivial than unique_ptr's.
-Sam

On Thu, Dec 3, 2015 at 11:12 AM, Adam C. Emerson <aemerson@redhat.com> wrote:
> On 03/12/2015, Casey Bodley wrote:
> [snip]
>> The queue_transactions() interface could take a container of Transactions,
>> rather than pointers to Transactions, and the ObjectStore would move them
>> out of the container into whatever representation it prefers.
> [snip]
>
> Or a pointer and count (or we could steal array_view from GSL). That way we
> could pass in any continguous range (std::vector or even a std::array or
> regular C style array allocated on the stack.)
