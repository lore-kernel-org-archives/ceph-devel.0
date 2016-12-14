From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: how to delete a zone in rgw?
Date: Wed, 14 Dec 2016 22:56:29 +0800
Message-ID: <CACKY0b8XUpT5yjBFQ9B-v29HSiCiZ44xh-FPX0dxkzxg5MxvvA@mail.gmail.com>
References: <CACKY0b8JR0ytBcp7NC+J7k8rvZ2TCXxP8xhTA2jt0MvrBJmSCA@mail.gmail.com>
 <326e0d82-6ca7-a1fd-37da-0dd820a8c5c4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33365 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756216AbcLNO4k (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2016 09:56:40 -0500
Received: by mail-qk0-f195.google.com with SMTP id x190so3366732qkb.0
        for <ceph-devel@vger.kernel.org>; Wed, 14 Dec 2016 06:56:30 -0800 (PST)
In-Reply-To: <326e0d82-6ca7-a1fd-37da-0dd820a8c5c4@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: ceph-devel@vger.kernel.org

Oh, sorry, I'm using 0.94. Thanks for your response

2016-12-14 22:32 GMT+08:00 Casey Bodley <cbodley@redhat.com>:
>
> On 12/14/2016 08:42 AM, liuchang0812 wrote:
>>
>> radosgw-admin provides zone list/get/set only. Should we implement delete?
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> There is a 'zone delete' command in radosgw-admin that does this.
>
> Note that if the zone is still part of a zonegroup in the current period,
> you should remove it with 'zonegroup remove' and commit the period before
> deleting to zone itself.
>
> Casey
