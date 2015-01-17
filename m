From: Wido den Hollander <wido@42on.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Sat, 17 Jan 2015 14:11:12 +0100
Message-ID: <54BA5F70.9050005@42on.com>
References: <54B7D2D6.4020503@42on.com> <m9chio$3lp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:43375 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425AbbAQNLO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 17 Jan 2015 08:11:14 -0500
In-Reply-To: <m9chio$3lp$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>, ceph-devel@vger.kernel.org

On 01/17/2015 03:31 AM, Alex Elsayed wrote:
> Wido den Hollander wrote:
> 
> <snip>
>> Is it a sane thing to look at 'features' which pools could have? Other
>> features which might be set on a pool:
>>
>> - Read Only (all write operations return -EPERM)
>> - Delete Protected
> 
> There's another pool feature I'd find very useful: a WORM flag, that permits 
> only create & append (at the RADOS level, not the RBD level as was an 
> Emperor blueprint).
> 

Yes, that seems like a good addition. If we introduce the system of
'flags' for pools such a flag could be implemented as well.

> In particular, I'd _love_ being able to make something that takes Postgres 
> WAL logs and puts them in such a pool, providing real guarantees re: 
> consistency. Similarly, audit logs and such for compliance.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
