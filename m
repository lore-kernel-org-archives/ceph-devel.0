From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH] ceph: allocate the accurate extra bytes for the session
 features
Date: Wed, 8 Jan 2020 12:02:50 +0800
Message-ID: <8888cffb-fc98-5bf0-32c9-d9c803d8431c@redhat.com>
References: <20200103025950.27659-1-xiubli@redhat.com>
 <86323475453efb218f04642297439fd22f567a56.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40978 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725908AbgAHEDD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jan 2020 23:03:03 -0500
In-Reply-To: <86323475453efb218f04642297439fd22f567a56.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: sage@redhat.com, idryomov@gmail.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/1/6 23:23, Jeff Layton wrote:
> On Thu, 2020-01-02 at 21:59 -0500, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> The totally bytes maybe potentially larger than 8.
>>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/mds_client.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index ad9573b7e115..aa49e8557599 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -1067,20 +1067,20 @@ static struct ceph_msg *create_session_msg(u32 op, u64 seq)
>>   	return msg;
>>   }
>>   
>> +static const unsigned char feature_bits[] = CEPHFS_FEATURES_CLIENT_SUPPORTED;
>>   static void encode_supported_features(void **p, void *end)
>>   {
>> -	static const unsigned char bits[] = CEPHFS_FEATURES_CLIENT_SUPPORTED;
>> -	static const size_t count = ARRAY_SIZE(bits);
>> +	static const size_t count = ARRAY_SIZE(feature_bits);
>>   
>>   	if (count > 0) {
>>   		size_t i;
>> -		size_t size = ((size_t)bits[count - 1] + 64) / 64 * 8;
>> +		size_t size = ((size_t)feature_bits[count - 1] + 64) / 64 * 8;
> The bug looks real, though it's not really a problem until we get to
> flag 65.

When the flag bit >= 64, it will be a problem.

flag bit in [0, 63] we need only one word size.

>   Note too that this calculation relies on having the highest
> feature bit value as the last element of the array. That's probably
> worth a comment in mds_client.h so we don't screw that up later.
>
> Also, I think this would be better expressed using DIV_ROUND_UP, and
> since we have this calculation in two places, maybe do something like:
>
>      #define FEATURE_WORDS  (DIV_ROUND_UP(feature_bits[count - 1], 64) * 8)

Here it should be (DIV_ROUND_UP(feature_bits[count - 1] + 1, 64) * 8).


>
> ...and then plug that macro into both places.
>
>>   		BUG_ON(*p + 4 + size > end);
>>   		ceph_encode_32(p, size);
>>   		memset(*p, 0, size);
>>   		for (i = 0; i < count; i++)
>> -			((unsigned char*)(*p))[i / 8] |= 1 << (bits[i] % 8);
>> +			((unsigned char*)(*p))[i / 8] |= 1 << (feature_bits[i] % 8);
>>   		*p += size;
>>   	} else {
>>   		BUG_ON(*p + 4 > end);
>> @@ -1101,6 +1101,7 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
>>   	int metadata_key_count = 0;
>>   	struct ceph_options *opt = mdsc->fsc->client->options;
>>   	struct ceph_mount_options *fsopt = mdsc->fsc->mount_options;
>> +	size_t size, count;
>>   	void *p, *end;
>>   
>>   	const char* metadata[][2] = {
>> @@ -1118,8 +1119,13 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
>>   			strlen(metadata[i][1]);
>>   		metadata_key_count++;
>>   	}
>> +
>>   	/* supported feature */
>> -	extra_bytes += 4 + 8;
>> +	size = 0;
>> +	count = ARRAY_SIZE(feature_bits);
>> +	if (count > 0)
>> +		size = ((size_t)feature_bits[count - 1] + 64) / 64 * 8;
>> +	extra_bytes += 4 + size;
>>   
>>   	/* Allocate the message */
>>   	msg = ceph_msg_new(CEPH_MSG_CLIENT_SESSION, sizeof(*h) + extra_bytes,
>> @@ -1139,7 +1145,7 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
>>   	 * Serialize client metadata into waiting buffer space, using
>>   	 * the format that userspace expects for map<string, string>
>>   	 *
>> -	 * ClientSession messages with metadata are v2
>> +	 * ClientSession messages with metadata are v3
>>   	 */
>>   	msg->hdr.version = cpu_to_le16(3);
>>   	msg->hdr.compat_version = cpu_to_le16(1);
