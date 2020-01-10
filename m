From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v2 1/8] ceph: add global dentry lease metric support
Date: Fri, 10 Jan 2020 10:41:27 +0800
Message-ID: <c9bd266d-36e4-5834-d38a-65fe807e7da3@redhat.com>
References: <20200108104152.28468-1-xiubli@redhat.com>
 <20200108104152.28468-2-xiubli@redhat.com>
 <d5e5040b7c177a6c8d66d8b68f4b965721693f85.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35985 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730886AbgAJCli (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jan 2020 21:41:38 -0500
In-Reply-To: <d5e5040b7c177a6c8d66d8b68f4b965721693f85.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/1/9 21:52, Jeff Layton wrote:
> On Wed, 2020-01-08 at 05:41 -0500, xiubli@redhat.com wrote:
[...]
>> @@ -1589,13 +1595,14 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
>>   		}
>>   	}
>>   
>> +	mdsc = ceph_sb_to_client(dir->i_sb)->mdsc;
>>   	if (!valid) {
>> -		struct ceph_mds_client *mdsc =
>> -			ceph_sb_to_client(dir->i_sb)->mdsc;
>>   		struct ceph_mds_request *req;
>>   		int op, err;
>>   		u32 mask;
>>   
>> +		percpu_counter_inc(&mdsc->metric.d_lease_mis);
>> +
>>   		if (flags & LOOKUP_RCU)
>>   			return -ECHILD;
>>   
> So suppose we're doing an RCU walk, and call d_revalidate and the dentry
> is invalid. We'll bump the counter here, but then return -ECHILD and the
> kernel will do the d_revalidate all over again with refwalk, and we bump
> the counter again.
>
> Won't that end up double-counting the cache miss? Or is that intended
> here?

Yeah, we should count it once. Will fix it in the next version.

Thanks,
