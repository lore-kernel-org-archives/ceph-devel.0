From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: master build failure with boost 1.60
Date: Wed, 9 Mar 2016 12:15:21 +0100
Message-ID: <56E005C9.8020201@digiware.nl>
References: <20160307144944.GA21590@pxe-sup5.sup.suse.de>
 <CAANLjFq3bC+-3LZ4PzyqY5W5pSfHGVQp=BAW986M67P2g8K+dA@mail.gmail.com>
 <86io0wrn1s.fsf@linux-stsn.suse>
 <20160309105811.GB21590@pxe-sup5.sup.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:33139 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058AbcCILP3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 Mar 2016 06:15:29 -0500
In-Reply-To: <20160309105811.GB21590@pxe-sup5.sup.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Robert LeBlanc <robert@leblancnet.us>

On 9-3-2016 11:58, Karol Mroz wrote:
> On Wed, Mar 09, 2016 at 10:57:35AM +0100, Abhishek L wrote:
>>
>> Robert LeBlanc writes:
>>
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA256
>>>
>>> Karol,
>>>
>>> I think I may have already resolved this with a patch I was already
>>> working on. Can you pull in https://github.com/ceph/ceph/pull/7984 and
>>> see if it resolves the issue?
>>
>> I tried applying 7984 atop of current master, it was still failing, on
>> similar errors with WeightedPriorityQueue, here is a log http://ix.io/pYl
>>
>
> Hi Robert,
>
> +1 here as well, with the same failure as seen in Abhishek's log above.
>

Not to rain on anybody's parade but this is currently what FreeBSD offers
me in packages:
boost-all-1.55.0               The "meta-port" for boost libraries
boost-docs-1.55.0              Documentation for libraries from boost.org
boost-jam-1.55.0               Build tool from the boost.org
boost-libs-1.55.0_9            Free portable C++ libraries (without 
Boost.Python)

The CentOS7 I'm running has:
#define BOOST_LIB_VERSION "1_53"

So I guess you will have to provide alternatives for code snippets that 
depend
on 1.60 stuff?

--WjW
