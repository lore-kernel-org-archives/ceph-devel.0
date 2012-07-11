From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 04/16] libceph: define ceph_extract_encoded_string()
Date: Wed, 11 Jul 2012 14:14:58 -0500
Message-ID: <4FFDD0B2.1010406@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8727.7050106@inktank.com> <CAC-hyiFrftSudtCUHaGwWyrzMBoAcm-uzRK4Bz7f-crO+dbfBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f52.google.com ([209.85.213.52]:56424 "EHLO
	mail-yw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191Ab2GKTPA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 15:15:00 -0400
Received: by yhpp61 with SMTP id p61so1852979yhp.11
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 12:14:59 -0700 (PDT)
In-Reply-To: <CAC-hyiFrftSudtCUHaGwWyrzMBoAcm-uzRK4Bz7f-crO+dbfBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/11/2012 12:20 PM, Yehuda Sadeh wrote:
> On Wed, Jul 11, 2012 at 7:01 AM, Alex Elder <elder@inktank.com> wrote:
>> This adds a new utility routine which will return a dynamically-
>> allocated buffer containing a string that has been decoded from ceph
>> over-the-wire format.  It also returns the length of the string
>> if the address of a size variable is supplied to receive it.
>>
>> For now, no gfp_flags parameter is defined (GFP_KERNEL is used) but
>> it could be easily be added if needed.
>>
> 
> I'd rather have it upfront, will help avoiding future errors.

I actually wanted to do exactly that before I sent it but I
forgot.  I guess I got all caught up in the excitement.

>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>  include/linux/ceph/decode.h |   29 +++++++++++++++++++++++++++++
>>  1 files changed, 29 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
>> index 7ead11fc..7759164 100644
>> --- a/include/linux/ceph/decode.h
>> +++ b/include/linux/ceph/decode.h
>> @@ -80,6 +80,35 @@ static inline size_t ceph_decode_string(void **p,
>> char *s, size_t size)
>>  }
>>
>>  /*
>> + * Allocate a buffer big enough to hold the wire-encoded string, and
>> + * decode the string into it.  The resulting string will always be
>> + * terminated with '\0'.  If successful, *p will be advanced
>> + * past the decoded data.  Also, if lenp is not a null pointer, the
>> + * length (not including the terminating '\0') will be recorded in
>> + * it.  Note that a zero-length string is a valid return value.
>> + *
>> + * Returns a pointer to the newly-allocated string buffer, or a
>> + * null pointer if memory could not be allocated for the result.
>> + * Neither of the arguments is updated if NULL is returned.
>> + */
>> +static inline char *ceph_extract_encoded_string(void **p, size_t *lenp)
>> +{
>> +       size_t len;
>> +       char *buf;
>> +
>> +       len = ceph_decode_string(p, NULL, 0);
>> +       buf = kmalloc(len + 1, GFP_KERNEL);
>> +       if (!buf)
>> +               return NULL;
>> +
>> +       (void) ceph_decode_string(p, buf, len + 1);
>> +       if (lenp)
>> +               *lenp = len;
>> +
>> +       return buf;
>> +}
>> +
>> +/*
> 
> We don't make an effort here to check whether encoded string buffer is
> valid. While we may be checking it somewhere up the stack, this seem
> like a generic enough function that could be naively used. Either make
> it clear that it's an internal function, or make it check p bounds.

Are you saying I should have the caller provide the length of the
buffer, and ensure we don't exceed it?

Should I assume that applies to the previous patch also?

In any case, I will rework it, but I want to make sure I understand
what you're saying.

					-Alex

>>   * bounds check input.
>>   */
>>  static inline int ceph_has_room(void **p, void *end, size_t n)
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


