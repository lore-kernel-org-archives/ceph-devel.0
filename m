From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [EXTERNAL] Re: OSDMonitor: don't allow creation of pools
 with > 65535 pgs
Date: Fri, 14 Dec 2012 10:41:27 -0700
Message-ID: <50CB64C7.4020301@sandia.gov>
References: <50CB488E.3090005@sandia.gov> <50CB5AFC.3070802@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:57995 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622Ab2LNRls (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 12:41:48 -0500
In-Reply-To: <50CB5AFC.3070802@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: Greg Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/14/2012 09:59 AM, Joao Eduardo Luis wrote:
> On 12/14/2012 03:41 PM, Jim Schutt wrote:
>> Hi,
>>
>> I'm looking at commit e3ed28eb2 in the next branch,
>> and I have a question.
>>
>> Shouldn't the limit be pg_num > 65536, because
>> PGs are numbered 0 thru pg_num-1?
>>
>> If not, what am I missing?
>>
>> FWIW, up through yesterday I've been using the next branch and this:
>>
>>    ceph osd pool set data pg_num 65536 --allow-experimental-feature
>>    ceph osd pool set metadata pg_num 65536 --allow-experimental-feature
>>    ceph osd pool set data pgp_num 65536 --allow-experimental-feature
>>    ceph osd pool set metadata pgp_num 65536 --allow-experimental-feature
>>
>> using cephfs clients, and have seen no trouble with
>> misdirected ops, etc.
>>
>> -- Jim
>>
> 
> Hi Jim,
> 
> To the best of my knowledge, one of the things that triggered the
> required hard cap on the number of pgs was that the kernel side is
> still limited to 16 bits, despite that on the osd side this is no
> longer true.
> 

I believe the culprit is the "ps" member of struct ceph_pg,
which stores what is eventually used as the PG id as __le16.

> I'm not familiar with what's going on on the kernel side, but if
> there's a slight chance that we are indeed keeping the 'pg_num' on a
> 16-bit variable, then that value must be capped to 65535. If that's
> not the case and we're just limited by the pg's number/id, then I
> guess that accepting up to 65636 would be fine (0..65535).

struct ceph_pg_pool in the kernel stores pg_num and friends
as __le32.

> 
> Just in case I'll look into this and further implications.

Cool, thanks.

-- Jim

> 
> Thanks.
> 
>   -Joao
> 
> 
> 
> 


