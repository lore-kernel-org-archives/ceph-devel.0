From: David Zafman <dzafman@redhat.com>
Subject: Re: OSD shows UP while it's not
Date: Wed, 11 May 2016 12:12:48 -0700
Message-ID: <03d3a676-257a-afb9-3d5c-bdf03437054f@redhat.com>
References: <1462965005.13078.29.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57509 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932072AbcEKTMv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 May 2016 15:12:51 -0400
In-Reply-To: <1462965005.13078.29.camel@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gonzalo Aguilar Delgado <gaguilar.delgado@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>


This is caused because once the last osd is down, there is nobody left 
to tell the mon that it went down.

Try using "ceph osd down 3" to manually notify the mon and see if you 
can do what you want.

David

On 5/11/16 4:10 AM, Gonzalo Aguilar Delgado wrote:
> Hello,
>
> I found I cannot out down all my OSDs from the cluster.
> root@blue-compute:/var/log# ceph osd tree
> ID WEIGHT  TYPE NAME                 UP/DOWN REWEIGHT PRIMARY-AFFINITY
> -1 1.00000 root default
> -4 1.00000     rack rack-1
> -2 1.00000         host blue-compute
>   0 1.00000             osd.0            down        0          1.00000
>   2 1.00000             osd.2            down        0          1.00000
> -3 1.00000         host red-compute
>   1 1.00000             osd.1            down        0          1.00000
>   3 0.50000             osd.3              up        0          1.00000
>   4 1.00000             osd.4            down        0          1.00000
>
>
>
>      osdmap e2516: 5 osds: 1 up, 0 in; 153 remapped pgs
>
>
>
> osd.3 up   out weight 0 up_from 2424 up_thru 2442 down_at 2423
> last_clean_interval [2361,2420) 172.16.0.100:6806/4554
> 172.16.0.100:6807/4554 172.16.0.100:6808/4554 172.16.0.100:6809/4554
> exists,up 8dd085d4-0b50-4c80-a0ca-c5bc4ad972f7
>
>
> Everything is down. But 3 seems to be up. Why?
>
> At OS level is also down.
>
> root@red-compute:/var/log/ceph# ps ax | grep ceph
>   1937 ?        Ssl    0:00 /usr/bin/ceph-mon -f --cluster ceph --id
> red-compute --setuser ceph --setgroup ceph
> 27225 pts/0    S+     0:00 grep ceph
>
>
> Why I cannot remove it?
>
>
> Best regards,
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

