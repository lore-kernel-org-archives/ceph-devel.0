From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v6 2/9] ceph: add caps perf metric for each session
Date: Mon, 17 Feb 2020 21:50:05 +0800
Message-ID: <1ef3bb02-a208-818d-dda6-84af8bf26f2d@redhat.com>
References: <20200210053407.37237-1-xiubli@redhat.com>
 <20200210053407.37237-3-xiubli@redhat.com>
 <c4c0dc74b34e234bef78aca99c1e31e051c1c72d.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32422 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728091AbgBQNuT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Feb 2020 08:50:19 -0500
In-Reply-To: <c4c0dc74b34e234bef78aca99c1e31e051c1c72d.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/2/17 21:27, Jeff Layton wrote:
> On Mon, 2020-02-10 at 00:34 -0500, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> This will fulfill the cap hit/mis metric stuff per-superblock,
>> it will count the hit/mis counters based each inode, and if one
>> inode's 'issued & ~revoking == mask' will mean a hit, or a miss.
>>
>> item          total           miss            hit
>> -------------------------------------------------
>> caps          295             107             4119
>>
>> []
[...]
>>   
>> @@ -346,13 +346,16 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>>   	    !ceph_test_mount_opt(fsc, NOASYNCREADDIR) &&
>>   	    ceph_snap(inode) != CEPH_SNAPDIR &&
>>   	    __ceph_dir_is_complete_ordered(ci) &&
>> -	    __ceph_caps_issued_mask(ci, CEPH_CAP_FILE_SHARED, 1)) {
>> +	    (ret = __ceph_caps_issued_mask(ci, CEPH_CAP_FILE_SHARED, 1))) {
>>   		int shared_gen = atomic_read(&ci->i_shared_gen);
>> +		__ceph_caps_metric(ci, CEPH_CAP_XATTR_SHARED);
> Why is this dealing with Xs caps when you've checked Fs?

Good catch.

This might just copied from some where and forgot to change it. Will fix it.

>
>>   		spin_unlock(&ci->i_ceph_lock);
>>   		err = __dcache_readdir(file, ctx, shared_gen);
>>   		if (err != -EAGAIN)
>>   			return err;
>>   	} else {
>> +		if (ret != -1)
>> +			__ceph_caps_metric(ci, CEPH_CAP_XATTR_SHARED);
> Ditto.

Here too.

Thanks.
Xiubo
