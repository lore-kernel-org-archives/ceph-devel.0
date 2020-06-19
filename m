From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v2 3/5] ceph: check the METRIC_COLLECT feature before
 sending metrics
Date: Fri, 19 Jun 2020 08:39:03 +0800
Message-ID: <cd142805-9d96-61c5-c8bd-9b2cc0c4d395@redhat.com>
References: <1592481599-7851-1-git-send-email-xiubli@redhat.com>
 <1592481599-7851-4-git-send-email-xiubli@redhat.com>
 <00a99a4873e2bb1dbfff995c2ff49fdbe5ea5aaf.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45520 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725912AbgFSAjO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Jun 2020 20:39:14 -0400
In-Reply-To: <00a99a4873e2bb1dbfff995c2ff49fdbe5ea5aaf.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com
Cc: zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/6/18 22:43, Jeff Layton wrote:
> On Thu, 2020-06-18 at 07:59 -0400, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> Skip the MDS sessions if they don't support the metric collection,
>> or the MDSs will close the socket connections directly when it get
>> an unknown type message.
>>
>> URL: https://tracker.ceph.com/issues/43215
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/mds_client.h | 4 +++-
>>   fs/ceph/metric.c     | 8 ++++++++
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>> index bcb3892..3c65ac1 100644
>> --- a/fs/ceph/mds_client.h
>> +++ b/fs/ceph/mds_client.h
>> @@ -28,8 +28,9 @@ enum ceph_feature_type {
>>   	CEPHFS_FEATURE_LAZY_CAP_WANTED,
>>   	CEPHFS_FEATURE_MULTI_RECONNECT,
>>   	CEPHFS_FEATURE_DELEG_INO,
>> +	CEPHFS_FEATURE_METRIC_COLLECT,
>>   
>> -	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_DELEG_INO,
>> +	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_METRIC_COLLECT,
>>   };
>>   
>>   /*
>> @@ -43,6 +44,7 @@ enum ceph_feature_type {
>>   	CEPHFS_FEATURE_LAZY_CAP_WANTED,		\
>>   	CEPHFS_FEATURE_MULTI_RECONNECT,		\
>>   	CEPHFS_FEATURE_DELEG_INO,		\
>> +	CEPHFS_FEATURE_METRIC_COLLECT,		\
>>   						\
>>   	CEPHFS_FEATURE_MAX,			\
>>   }
>> diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
>> index 27cb541..4267b46 100644
>> --- a/fs/ceph/metric.c
>> +++ b/fs/ceph/metric.c
>> @@ -127,6 +127,14 @@ static void metric_delayed_work(struct work_struct *work)
>>   			continue;
>>   		}
>>   
>> +		/*
>> +		 * Skip it if MDS doesn't support the metric collection,
>> +		 * or the MDS will close the session's socket connection
>> +		 * directly when it get this message.
>> +		 */
>> +		if (!test_bit(CEPHFS_FEATURE_METRIC_COLLECT, &s->s_features))
>> +			continue;
>> +
>>   		/* Only send the metric once in any available session */
>>   		ret = ceph_mdsc_send_metrics(mdsc, s, nr_caps);
>>   		ceph_put_mds_session(s);
> This should probably be moved ahead of, or folded into the previous
> patch to prevent a regression should someone land in between them when
> bisecting.

Yeah, make sense, let's fold it into the previous one.

Thanks.
