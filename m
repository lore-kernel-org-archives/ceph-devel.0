From: Jevon Qiao <scaleqiao@gmail.com>
Subject: Re: [PATCH] hw/9pfs: Add CephFS support in VirtFS
Date: Tue, 15 Mar 2016 22:33:47 +0800
Message-ID: <56E81D4B.5050200@gmail.com>
References: <1457971368-1335-1-git-send-email-scaleqiao@gmail.com>
 <20160315135246.GA26802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33958 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbcCOOd4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Mar 2016 10:33:56 -0400
Received: by mail-pf0-f171.google.com with SMTP id x3so31342240pfb.1
        for <ceph-devel@vger.kernel.org>; Tue, 15 Mar 2016 07:33:55 -0700 (PDT)
In-Reply-To: <20160315135246.GA26802@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: gkurz@linux.vnet.ibm.com, berrange@redhat.com, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com, sage@newdream.net, gfarnum@redhat.com, haomaiwang@gmail.com

Hi Michael,

Thank you for the comment below.
On 15/3/16 21:52, Michael S. Tsirkin wrote:
> On Tue, Mar 15, 2016 at 12:02:48AM +0800, Jevon Qiao wrote:
>> diff --git a/hw/9pfs/9p-cephfs.c b/hw/9pfs/9p-cephfs.c
>> new file mode 100644
>> index 0000000..e2d659d
>> --- /dev/null
>> +++ b/hw/9pfs/9p-cephfs.c
>> @@ -0,0 +1,836 @@
>> +/*
>> + * 9p cephfs callback
>> + *
>> + * Copyright UnitedStack, Corp. 2016
>> + *
>> + * Authors:
>> + *    Jevon Qiao <scaleqiao@gmail.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2.  See
>> + * the COPYING file in the top-level directory.
> We generally prefer v2 or later.
Ok, I'll update the copyright version in the next revision.

Regards,
Jevon
>> + *
>> + */
>> +

