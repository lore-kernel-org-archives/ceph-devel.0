From: Gregory Farnum <greg@inktank.com>
Subject: Re: Deterministic thrashing
Date: Mon, 7 Apr 2014 10:16:30 -0700
Message-ID: <CAPYLRzjXAMB6VmM2pBiJwEtSN5bmqD2uROHm7HYpAYi8ooMjDw@mail.gmail.com>
References: <53412C8E.2070504@dachary.org>
	<CAPYLRzh4LhWS5VE8yur=5uQUB_T5F66VHeXNkgj+j_LCBTE1eA@mail.gmail.com>
	<5342DCD7.7020001@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33683 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356AbaDGRQb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Apr 2014 13:16:31 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so6643258qgd.29
        for <ceph-devel@vger.kernel.org>; Mon, 07 Apr 2014 10:16:30 -0700 (PDT)
In-Reply-To: <5342DCD7.7020001@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Apr 7, 2014 at 10:13 AM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 07/04/2014 18:55, Gregory Farnum wrote:
>> This would be really nice but there are unfortunately even more
>> hiccups than you've noted here:
>> 1) Thrashing is both time and disk access sensitive, and hardware differs
>> 2) The teuthology thrashing is triggered largely based on PG state
>> events (eg, "all PGs are clean, so restart an OSD")
>> 3) The actual failures tend to involve a combination of PG state and
>> inbound client operations, and I can't think of any realistic way to
>> coordinate those.
>>
>> Those problems look technically insurmountable to me, but maybe I'm
>> missing something?
>
> There is no easy way to use the logs / events to significantly reduce the randomness of the workload ? I honestly have no clue ;-)

I don't think so, no. :( We'd have to somehow order every event in the
system while not losing any of the system race conditions that were
previously triggered!
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
