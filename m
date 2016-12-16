From: Casey Bodley <cbodley@redhat.com>
Subject: Re: the question of way to modify bucket metadata
Date: Fri, 16 Dec 2016 11:34:55 -0500
Message-ID: <32268d70-aca3-b880-8841-24270c5ca708@redhat.com>
References: <CANzRsYzgN9p317ge10cDQE+qXqYEyOQ3r7zLYgWYGXgrphM2Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33586 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934030AbcLPQe6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2016 11:34:58 -0500
Received: by mail-qt0-f172.google.com with SMTP id p16so89437653qta.0
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2016 08:34:57 -0800 (PST)
In-Reply-To: <CANzRsYzgN9p317ge10cDQE+qXqYEyOQ3r7zLYgWYGXgrphM2Aw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Scott Jing <scott.jing152@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>


On 12/16/2016 09:20 AM, Scott Jing wrote:
> Hi,
>
> I'm Wenjun Jing from China Mobile(suzhou). Recently ceph multisite is
> applied to our production onest, short for Object-Orient Storage
> System,
> which is a object storage production based on ceph. Needless to say,
> the feature of active-active is awesome! But there are also some
> features
> which may not be supported very well and the community is improving
> them constantly. So we want to discuss with you to comfirm the roadmap
> of them.
>
> This is the fact that if creating bucket on the secondary
> zone/zonegroup. The request would send to meta master and the bucket
> will be created
> on meta master firstly, then it will be created locally.
>
> Some metadata/feature of bucket in the process upper is not synced to
> secondary zone or zonegroup. For instance, the bucket acl and bucket
> versionning cannot be modified on the slave zone/zonegroup, which has
> been fixed in the jewel. Now, we want to ack you to get the
> development
> direction(way) of the bucket metadata to modify.
>
> The below are some ways which I've thought out currently.
>
> 1. All the bucket metadata will be modified in the meta master firstly
> and then modify the metadata
> locally according to the status retured from meta master. Considering
> this way, some metadata (eg. creation time)
> may not consistent with the meta master, which doesn't improve user experience.
>
> 2. All the bucket metadata will be modified in the meta master firstly
> and sync the changed bucket metadata to slave zone or zonegroup.
>
> 3. The other alternative way to handle this situation? Could you
> discribe to me detailedly?
>
> Once the upper way could be comfirmed Definitely, we can make some
> contribution to the community.
>
> Look forward to your kind reply.
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi,

#2 is the current strategy for updates, but there's been some discussion 
about this related to the fix for bucket versioning at 
https://github.com/ceph/ceph/pull/12444. The issue here is that if you 
enable bucket versioning on a non-master zone, the change is not 
reflected on that zone until the background sync process reads it from 
the metadata master.

That pull request changes RGWSetBucketVersioning to use strategy #1, but 
as you point out, this can lead to inconsistent metadata. It also 
introduces the potential to overwrite the results of other operations 
applied on the metadata master.

I think the ideal solution would involve getting the updated metadata 
from the master (either in the reply to our forwarded request, or with a 
separate request to /admin/metadata) and writing that locally. We'd just 
have to make sure that this write respects the same object versioning 
requirements as other updates from metadata sync - I think 
RGWBucketInstanceMetadataHandler::put() takes care of for us, but it 
needs to be tested.

I created an issue to track this at http://tracker.ceph.com/issues/18292.

Thanks,
Casey
