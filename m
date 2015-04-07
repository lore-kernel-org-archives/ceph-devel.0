From: Ta Ba Tuan <tuantb@vccloud.vn>
Subject: Re: [ceph-users] How to unset lfor setting (from cache pool)
Date: Tue, 07 Apr 2015 09:43:10 +0700
Message-ID: <5523443E.4010506@vccloud.vn>
References: <55225007.7040404@vccloud.vn> <CAC6JEv86h8Fp-rogMyFO1AKMqpsCPzohXfEF0HwgfJtrWONHgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from static.vdc.vn ([123.30.242.142]:57613 "EHLO smtp.vccloud.vn"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752984AbbDGCnX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 Apr 2015 22:43:23 -0400
In-Reply-To: <CAC6JEv86h8Fp-rogMyFO1AKMqpsCPzohXfEF0HwgfJtrWONHgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I understand, Thank Gregory Farnum for your explaining


--
Tuantaba
Ha Noi-VietNam

On 07/04/2015 00:54, Gregory Farnum wrote:
> On Mon, Apr 6, 2015 at 2:21 AM, Ta Ba Tuan <tuantb@vccloud.vn> wrote:
>> Hi all,
>>
>> I have ever to setup the cache-pool for my pool.
>> But had some proplems about cache-pool running, so I removed the cache pool
>> from My CEPH Cluster.
>>
>> The DATA pool currently don't use cache pool, but "lfor" setting still be
>> appeared.
>> lfor seems is a setting, not flag.
>>
>> pool 3 'data_pool' replicated size 3 min_size 1 crush_ruleset 4 object_hash
>> rjenkins pg_num 4098 pgp_num 4098 last_change 145235 lfor 75731 flags
>> hashpspool stripe_width 0
>>
>> How to unset lfor?,  and  After unsetting lofr, My pool activities OK?
> "lfor" is not a config option; it's "last force op resend" and the
> value is an OSDMap epoch. You can see some details about exactly what
> it means in the v0.80.2 changelog.
> -Greg
>
>> Thanks!
>> --
>> Tuantaba
>> Ha Noi-VietNam.
>>
>>
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>

