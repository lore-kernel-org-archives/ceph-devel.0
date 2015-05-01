From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 02/10] ceph: add start/finish encoding helpers
Date: Fri, 01 May 2015 14:53:59 -0500
Message-ID: <5543D9D7.3040403@ieee.org>
References: <1430258747-12506-1-git-send-email-mchristi@redhat.com> <1430258747-12506-3-git-send-email-mchristi@redhat.com> <55421E77.1040707@ieee.org> <5543D66C.8020003@redhat.com> <5543D85D.8070704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33038 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbbEATyD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 May 2015 15:54:03 -0400
Received: by iecrt8 with SMTP id rt8so95904270iec.0
        for <ceph-devel@vger.kernel.org>; Fri, 01 May 2015 12:54:02 -0700 (PDT)
In-Reply-To: <5543D85D.8070704@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>, ceph-devel@vger.kernel.org

On 05/01/2015 02:47 PM, Mike Christie wrote:
> On 05/01/2015 02:39 PM, Mike Christie wrote:
>> On 04/30/2015 07:22 AM, Alex Elder wrote:
>>>> +/**
>>>> + * ceph_start_decoding_compat - decode block with legacy support for
>>>> older schemes
>>>> + * @p: buffer to decode
>>>> + * @end: end of decode buffer
>>>> + * @curr_ver: current version of the encoding that the code
>>>> supports/encode
>>>> + * @compat_ver: oldest version that includes a __u8 compat version field
>>>> + * @len_ver: oldest version that includes a __u32 length wrapper
>>>> + * @len: buffer to return len of data in buffer
>>>> + */
>>>> +static inline int ceph_start_decoding_compat(void **p, void *end, u8
>>>> curr_ver,
>>>> +                         u8 compat_ver, u8 len_ver, u32 *len)
>>>> +{
>>>> +    u8 struct_ver, struct_compat;
>>>> +
>>>> +    ceph_decode_8_safe(p, end, struct_ver, fail);
>>>> +    if (struct_ver >= curr_ver) {
>>>
>>> It seems to me it doesn't matter whether the current code
>>> supports the struct compat version or not.  What matters
>>> is whether the encoded header contains the compat field
>>> or not.  I'm not sure what determines that.
>>
>> I am not sure if I understood this comment.
>>
>> I thought different structs got the compat field in different versions.
>> So, I was concerned about a case where we might get a old struct sent to
>> us. If the compat field was added to some struct_abc in version 2 and
>> that is what we support in the kernel, but some old osd sent us a struct
>> that was version 1, then we do not want to do the compat check below.
>>
> 
> Doh! I wrote the above mail, then realized what you meant.

OK good...  And I should have known what determines
whether the header contains the compat field, but
I was already a little confused about what I was
looking at...

					-Alex

> I think I should have checked the compat_ver passed into the version above.
> 
> if (struct_ver >= compat_ver) {
> 	ceph_decode_8_safe(p, end, struct_compat, fail);
> 	if (curr_ver < struct_compat)
> 
>>
>>>
>>>> +        ceph_decode_8_safe(p, end, struct_compat, fail);
>>>> +        if (curr_ver < struct_compat)
>>>> +            return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (struct_ver >= len_ver) {
>>>> +        ceph_decode_32_safe(p, end, *len, fail);
>>>> +    } else {
>>>> +        *len = 0;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +fail:
>>>> +    return -ERANGE;
>>>> +}
>>>> +
>>>> +
>>>>   #define ceph_encode_need(p, end, n, bad)            \
>>>>       do {                            \
>>>>           if (!likely(ceph_has_room(p, end, n)))        \
>>>>
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 

