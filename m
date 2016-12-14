From: Casey Bodley <cbodley@redhat.com>
Subject: Re: how to delete a zone in rgw?
Date: Wed, 14 Dec 2016 09:32:09 -0500
Message-ID: <326e0d82-6ca7-a1fd-37da-0dd820a8c5c4@redhat.com>
References: <CACKY0b8JR0ytBcp7NC+J7k8rvZ2TCXxP8xhTA2jt0MvrBJmSCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:34112 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755266AbcLNOcz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2016 09:32:55 -0500
Received: by mail-qt0-f170.google.com with SMTP id n6so25034406qtd.1
        for <ceph-devel@vger.kernel.org>; Wed, 14 Dec 2016 06:32:11 -0800 (PST)
In-Reply-To: <CACKY0b8JR0ytBcp7NC+J7k8rvZ2TCXxP8xhTA2jt0MvrBJmSCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>, ceph-devel@vger.kernel.org


On 12/14/2016 08:42 AM, liuchang0812 wrote:
> radosgw-admin provides zone list/get/set only. Should we implement delete?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

There is a 'zone delete' command in radosgw-admin that does this.

Note that if the zone is still part of a zonegroup in the current 
period, you should remove it with 'zonegroup remove' and commit the 
period before deleting to zone itself.

Casey
