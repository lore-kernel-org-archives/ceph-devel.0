From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 1/5] ceph: fix wrong check in ceph_renew_caps()
Date: Thu, 6 Apr 2017 08:04:00 +0800
Message-ID: <3C2BBFBD-AF48-406D-9AB8-0E1334A52E89@redhat.com>
References: <20170405013019.5032-1-zyan@redhat.com>
 <1491401787.18658.6.camel@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756357AbdDFAED (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 5 Apr 2017 20:04:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6FF8A2A9D
        for <ceph-devel@vger.kernel.org>; Thu,  6 Apr 2017 00:04:02 +0000 (UTC)
In-Reply-To: <1491401787.18658.6.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: ceph-devel@vger.kernel.org


> On 5 Apr 2017, at 22:16, Jeff Layton <jlayton@redhat.com> wrote:
> 
> On Wed, 2017-04-05 at 09:30 +0800, Yan, Zheng wrote:
>> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>> ---
>> fs/ceph/file.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index 579a16c..0480492 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -123,7 +123,7 @@ int ceph_renew_caps(struct inode *inode)
>> 	spin_lock(&ci->i_ceph_lock);
>> 	wanted = __ceph_caps_file_wanted(ci);
>> 	if (__ceph_is_any_real_caps(ci) &&
>> -	    (!(wanted & CEPH_CAP_ANY_WR) == 0 || ci->i_auth_cap)) {
>> +	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap)) {
>> 		int issued = __ceph_caps_issued(ci, NULL);
>> 		spin_unlock(&ci->i_ceph_lock);
>> 		dout("renew caps %p want %s issued %s updating mds_wanted\n",
> 
> That certainly looks more like what was intended, but I'm still a
> little unclear on why we have so much special casing in all of this
> caps handling.
> 
> Why do we skip ceph_check_caps if we want CEPH_CAP_ANY_WR?

It’s for multiple active mds setup. client can request read caps from any mds (that replicates the inode). client need to request write caps from auth mds.

Regards
Yan, Zheng 

> -- 
> Jeff Layton <jlayton@redhat.com>

