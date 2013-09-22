From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH 0/3] ceph: fixes for directory fragment
Date: Sun, 22 Sep 2013 12:33:00 +0800
Message-ID: <CAAM7YA=72+BuSsvUWGeQKYQBJLrKPtkoDL5MLq2CyLQ-kjF9iQ@mail.gmail.com>
References: <1379717080-15626-1-git-send-email-zheng.z.yan@intel.com>
	<alpine.DEB.2.00.1309212100010.19555@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:38333 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab3IVEdD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Sep 2013 00:33:03 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so1703167lbd.40
        for <ceph-devel@vger.kernel.org>; Sat, 21 Sep 2013 21:33:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309212100010.19555@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org

On Sun, Sep 22, 2013 at 12:01 PM, Sage Weil <sage@inktank.com> wrote:
> These look good.
>
> I would *really* like to get some tests into ceph-qa-suite that cover
> multi-mds, multi-mds thrashing, and mds frag = true.  Eventulaly also 'mds
> thrash frags = true' (is this what you're testing with?).
>
> sage

my conf for the directory fragment feaure
---
mds bal_frag = 1
mds bal_split_bits = 2
mds bal_split_size = 256
mds bal_merge_size = 32

I test these patches by running blogbench and a script that
create/delete 500k file in a directory.
Besides the mds is restarted every two miniutes.

Regards
Yan, Zheng

>
>
> On Sat, 21 Sep 2013, Yan, Zheng wrote:
>
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> This patch series is also in:
>>   https://github.com/ceph/ceph-client.git wip-dirfrag
>>
>> The MDS counterpart is in:
>>   https://github.com/ceph/ceph.git wip-dirfrag
>>
>> Regards
>> Yan, Zheng
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
