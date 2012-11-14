From: Aleksey Samarin <nrg3tik@gmail.com>
Subject: Re: ceph cluster hangs when rebooting one node
Date: Wed, 14 Nov 2012 13:50:28 +0400
Message-ID: <CAFjNkqSyDTttexDCfFXsHAkykeYtypJWXRCEYDg3B42BvUuu3w@mail.gmail.com>
References: <50A1101A.4070401@profihost.ag>
	<alpine.DEB.2.00.1211120710330.2293@cobra.newdream.net>
	<50A114B5.30104@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42951 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932782Ab2KNJu3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 04:50:29 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so284424iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 01:50:28 -0800 (PST)
In-Reply-To: <50A114B5.30104@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello!

I have the same problem. After switching off the second node, the
cluster hangs, there is some solution?

All the best, Alex!

2012/11/12 Stefan Priebe - Profihost AG <s.priebe@profihost.ag>:
> Am 12.11.2012 16:11, schrieb Sage Weil:
>
>> On Mon, 12 Nov 2012, Stefan Priebe - Profihost AG wrote:
>>>
>>> Hello list,
>>>
>>> i was checking what happens if i reboot a ceph node.
>>>
>>> Sadly if i reboot one node, the whole ceph cluster hangs and no I/O is
>>> possible.
>>
>>
>> If you are using the current master, the new 'min_size' may be biting you;
>> ceph osd dump | grep ^pool and see if you see min_size for your pools.
>> You can change that back to the norma behavior with
>
>
> No i don't see any min size:
>
> # ceph osd dump | grep ^pool
> pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 1344
> pgp_num 1344 last_change 1 owner 0 crash_replay_interval 45
> pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_num
> 1344 pgp_num 1344 last_change 1 owner 0
> pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 1344
> pgp_num 1344 last_change 1 owner 0
> pool 3 'kvmpool1' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num
> 3000 pgp_num 3000 last_change 958 owner 0
>
>
>>   ceph osd pool set <poolname> min_size 1
>
> Yes this helps! But min_size is still not shown in ceph osd dump. Also when
> i reboot a node it takes up to 10s-20s until all osds from this node are set
> to failed and the I/O starts again. Should i issue an ceph osd out command
> before?
>
> But i had already this set for all my rules in my crushmap
>         min_size 1
>         max_size 2
>
> in my crushmap for each rule.
>
>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
