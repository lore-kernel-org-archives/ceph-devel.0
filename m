From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: Re: recommended rocksdb/rockswal sizes when using SSD/HDD
Date: Wed, 2 Aug 2017 16:37:13 -0500
Message-ID: <5a83d5a2-12cf-23ad-0b32-b8e2bcb266c0@gmail.com>
References: <3D48D7F6-6383-4F9F-9728-6CB6263D0E32@teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35684 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdHBVhP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Aug 2017 17:37:15 -0400
Received: by mail-io0-f171.google.com with SMTP id m88so78349iod.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Aug 2017 14:37:15 -0700 (PDT)
In-Reply-To: <3D48D7F6-6383-4F9F-9728-6CB6263D0E32@teradata.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "McFarland, Bruce" <Bruce.McFarland@Teradata.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Bruce,

As of right now the WAL should be big enough to hold 4 256MB logs, ie at 
least 1GB.  There's not much point in making it significantly bigger 
than that, though you certainly can.

The DB size is up to you.  The more space you give it, the more likely 
that you won't end up with metadata rolling over onto the disk.  The 
amount of metadata generated it dependent on many different factors 
(whether or not CRCs are being stored, the min_alloc size, hwo many 
extents have been allocated, the number of objects, etc).  Generally the 
more you can give it the better.

Mark

On 08/02/2017 04:26 PM, McFarland, Bruce wrote:
> I’m using SDD for the rocksdb/rockswal partitions and putting the data on HDD’s. What is the recommended sizing for these partitions. I’ve read various sizes discussed on the perf call and know that the code defaults of 128MB for rocksdb is small and limits performance. What are the recommended sizes for these partitions?
> 
> Thanks,
> Bruce
> 
