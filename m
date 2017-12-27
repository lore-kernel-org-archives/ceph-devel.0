From: Jeegn Chen <jeegnchen@gmail.com>
Subject: Re: RGW RFC: Multiple-Data-Pool Support for a Bucket
Date: Wed, 27 Dec 2017 12:44:44 +0800
Message-ID: <CAFZHTObqvWL2DG4TGKW=Q4ja5S7bhxh6g-ApmstAX5=tAkUZ5A@mail.gmail.com>
References: <CAFZHTOYnOQgVsmsGXPL8dBwA-_Gc5q3fZ5V1CjfzRtQbs=tvgg@mail.gmail.com>
 <robbat2-20171226T185704-299365896Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35450 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdL0Eoq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Dec 2017 23:44:46 -0500
Received: by mail-pg0-f47.google.com with SMTP id q20so18448388pgv.2
        for <ceph-devel@vger.kernel.org>; Tue, 26 Dec 2017 20:44:46 -0800 (PST)
In-Reply-To: <robbat2-20171226T185704-299365896Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Robin

Reply in inline.

Thanks,
Jeegn

2017-12-27 3:00 GMT+08:00 Robin H. Johnson <robbat2@gentoo.org>:
> On Tue, Dec 26, 2017 at 09:48:26AM +0800, Jeegn Chen wrote:
>> In the daily use of Ceph RGW cluster, we find some pain points when
>> using current one-bucket-one-data-pool implementation.
>> I guess one-bucket-multiple-data-pools may help (See the appended
>> detailed proposal).
>> What do you think?
> Overall I like
>
> Queries/concerns:
> - How would this interact w/ the bucket policy lifecycle code?
[Jeegn]: My understanding is that current lifecycle code will list all
objects in a bucket and delete the out-of-date object. Only the
deletion logic is related, which is covered by GC-related change.

> - How would this interact w/ existing placement policy in bucket
>   creation?
[Jeegn]: The multiple-pool-support needs data_layout_type in
RGWZonePlacementInfo to have value SPLITTED (new) while the default
value of data_layout_type is UNIFIED(old). So the existing bucket
placement is assumed to have UNIFIED in data_layout_type . To enable
this functionality, the admin need to create the new placement policy
with  SPLITTED data_layout_type set explicitly. Only the bucket
created from SPLITTED placement policy will follow the new behavior
pattern.

> - At the rgw-admin layer, what tooling should exist to migrate objects
>   between pools for a given bucket?
[Jeegn]: I don't expect the objects to be migrated between pools.Old
objects uploaded before the tail_pool switch will remain in the
original pool until they are deleted explicitly, which is the same
behavior in CephFS.

>
> --
> Robin Hugh Johnson
> Gentoo Linux: Dev, Infra Lead, Foundation Asst. Treasurer
> E-Mail   : robbat2@gentoo.org
> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
