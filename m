From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: mon config storage (config-key vs config)
Date: Mon, 8 Jan 2018 09:51:02 +0100
Message-ID: <3f6e4a31-a0e5-d0c6-7b28-ee501081139c@corp.ovh.com>
References: <alpine.DEB.2.11.1801052100410.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 11.mo302.mail-out.ovh.net ([37.187.190.78]:34847 "EHLO
        11.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755998AbeAHIvB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jan 2018 03:51:01 -0500
In-Reply-To: <alpine.DEB.2.11.1801052100410.24931@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 18-01-05 10:13 PM, Sage Weil wrote:
> This brings up another longstanding issue: most of our config options have
> a daemon type prefix in the name, e.g. osd_objectstore, mds_cache_size, or
> (more confusingly) things like mon_osd_full_ratio and
> osd_crush_chooseleaf_type (both mon options that affect the mon's initial
> OSDMap creation only).  Is there a way we can realistically rename some of
> these options, perhaps as part of the ceph.conf -> mon config transition?
> Then we would end up with configs more like
> 
>   mon/crush_chooseleaf_type = foo
>   mon/initial_osd_full_ratio = ...
>   mds/cache_size = ...
>   osd/objectstore = bluestore
> 
> and so on.

Maybe it's worth implementing some sort of automatic renaming and outputting 
deprecation warnings? I imagine it'd be easier for everyone if both forms 
would work just fine, but the old form would spew a bunch of warnings, like

* WARNING: "osd objectstore" is deprecated, you should change your config to 
use "osd/objectstore" instead.

Warnings always annoy admins and they'll clean them up eventually, the other 
benefit is that the sky won't fall for anybody upgrading to new config.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
