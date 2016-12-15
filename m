From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Consistency problem with multiple rgws
Date: Thu, 15 Dec 2016 11:08:50 -0500
Message-ID: <2f77e909-96e8-f883-0222-9a97cd7ee39e@redhat.com>
References: <9193cf3c-3970-56d9-759a-c160626fb27a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33286 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbcLOQIx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2016 11:08:53 -0500
Received: by mail-qk0-f176.google.com with SMTP id t184so7444266qkd.0
        for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2016 08:08:52 -0800 (PST)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id i19sm1364101qte.8.2016.12.15.08.08.51
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2016 08:08:51 -0800 (PST)
In-Reply-To: <9193cf3c-3970-56d9-759a-c160626fb27a@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

oops, the list bounced my reply because of html


-------- Forwarded Message --------
Subject: 	Re: Consistency problem with multiple rgws
Date: 	Thu, 15 Dec 2016 11:05:03 -0500
From: 	Casey Bodley <cbodley@redhat.com>
To: 	18896724396 <zhang_shaowen@139.com>, yehuda <yehuda@redhat.com>
CC: 	ceph-devel <ceph-devel@vger.kernel.org>, 郭占东 
<guozhandong@cmss.chinamobile.com>, lvshuhua 
<lvshuhua@cmss.chinamobile.com>



Hi,

On 12/15/2016 02:55 AM, 18896724396 wrote:
> Hi,
> We have two RGWs in master zone and two RGWs in slave zone. We use 
> cosbench to upload 50,000 objs to a single bucket. After the data sync 
> is finished, the bucket stats is not the same between master and slave 
> zone.
The data sync may take a while with that many objects. How are you 
verifying that data sync finished? Have you tried 'radosgw-admin bucket 
sync status --bucket=<name>'?
> Then we test the same case with one RGW in master zone and slave zone, 
> the stats is also not same. At last we test with one RGW and modify 
> the config rgw_num_rados_handles to 1(we set it 2 before), and this 
> time the stats is same and correct. Though multiple RGWs still have 
> the problem.
> According to the code, I find that when we update bucket index, rgw 
> will call cls_rgw_bucket_complete_op to update the bucket stats and at 
> last osd will call rgw_bucket_complete_op. In this function, osd first 
> read the bucket header, and then update the stats, last it write the 
> head back. So I think two concurrent request to update the stats may 
> lead to the consistency problem. And maybe some other operation also 
> have the same problem. How could we solve the consistency problem?
The osd guarantees that two operations in the same placement group won't 
run concurrently, so this kind of logic in cls should be safe. How far 
off are the bucket stats? Can you share some example output?
>
> Best regards.
> Zhang Shaowen

Thanks,
Casey
