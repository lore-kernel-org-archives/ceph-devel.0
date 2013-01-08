From: Gregory Farnum <greg@inktank.com>
Subject: Re: Adjusting replicas on argonaut
Date: Tue, 8 Jan 2013 14:23:17 -0800
Message-ID: <CAPYLRzi=po0r6Om=EA-rosffvkpGV38PbHee8mxg96kLKMhxnw@mail.gmail.com>
References: <CADAfL_gk43_CQsEWY7Nn0uibLneGox5cdUj0g_1+LWOUNWth+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:37273 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab3AHWXS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 17:23:18 -0500
Received: by mail-qa0-f46.google.com with SMTP id r4so178023qaq.12
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jan 2013 14:23:17 -0800 (PST)
In-Reply-To: <CADAfL_gk43_CQsEWY7Nn0uibLneGox5cdUj0g_1+LWOUNWth+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bryan Stillwell <bstillwell@photobucket.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

What are your CRUSH rules? Depending on how you set this cluster up,
it might not be placing more than one replica in a single host, and
you've only got two hosts so it couldn't satisfy your request for 3
copies.
-Greg

On Tue, Jan 8, 2013 at 2:11 PM, Bryan Stillwell
<bstillwell@photobucket.com> wrote:
> I tried increasing the number of metadata replicas from 2 to 3 on my
> test cluster with the following command:
>
> ceph osd pool set metadata size 3
>
>
> Afterwards it appears that all the metadata placement groups switch to
> a degraded state and doesn't seem to be attempting to recover:
>
> 2013-01-08 14:49:37.352735 mon.0 [INF] pgmap v156393: 1920 pgs: 1280
> active+clean, 640 active+degraded; 903 GB data, 1820 GB used, 2829 GB
> / 4650 GB avail; 1255/486359 degraded (0.258%)
>
>
> Does anything need to be done after increasing the number of replicas?
>
> Here's what the OSD tree looks like:
>
> root@a1:~# ceph osd tree
> dumped osdmap tree epoch 1303
> # id    weight  type name       up/down reweight
> -1      4.99557 pool default
> -3      4.99557         rack unknownrack
> -2      2.49779                 host b1
> 0       0.499557                                osd.0   up      1
> 1       0.499557                                osd.1   up      1
> 2       0.499557                                osd.2   up      1
> 3       0.499557                                osd.3   up      1
> 4       0.499557                                osd.4   up      1
> -4      2.49779                 host b2
> 5       0.499557                                osd.5   up      1
> 6       0.499557                                osd.6   up      1
> 7       0.499557                                osd.7   up      1
> 8       0.499557                                osd.8   up      1
> 9       0.499557                                osd.9   up      1
>
>
> Thanks,
> Bryan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
