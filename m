From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: have rbd_obj_method_sync() return transfer count
Date: Mon, 22 Apr 2013 17:00:33 -0700
Message-ID: <5175CF21.8010006@inktank.com>
References: <51745771.5020009@inktank.com> <5175B261.9090802@inktank.com> <5175CA3C.5080207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:56526 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab3DWABT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 20:01:19 -0400
Received: by mail-pd0-f170.google.com with SMTP id 10so25454pdi.29
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 17:01:18 -0700 (PDT)
In-Reply-To: <5175CA3C.5080207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/22/2013 04:39 PM, Alex Elder wrote:
> On 04/22/2013 04:57 PM, Josh Durgin wrote:
>> A couple small things below. With those fixed:
>>
>> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
>>
>> On 04/21/2013 02:17 PM, Alex Elder wrote:
>>> Callers of rbd_obj_method_sync() don't know how many bytes of data
>>> got returned by the class method call.  As a result, they have been
>>> assuming enough got returned to decode whatever was expected.
>>>
>>> This isn't safe.  We know how many bytes got transferred, so have
>>> rbd_obj_method_sync() return that amount (rather than just 0) if
>>> the call is successful.
>
> . . .
>
>>> @@ -3709,9 +3714,9 @@ static int rbd_dev_v2_parent_info(struct
>>> rbd_device *rbd_dev)
>>>        if (ret < 0)
>>>            goto out_err;
>>>
>>> -    ret = -ERANGE;
>>>        p = reply_buf;
>>>        end = reply_buf + size;
>
> You didn't mention this, but now that I look at this I
> managed to screw up the point of this patch in this spot.
> The above line should (and will) be:
>           end = reply_buf + ret;
> (That was why the "ret = -ERANGE" had to be moved to begin
> with.)  I did it right in one similar spot elsewhere in
> the patch.
>
>>> +    ret = -ERANGE;
>>
>> maybe check for the full parent_spec here? even if there's no parent,
>> a complete parent_spec should be returned.
>
> I'm not sure I understand this comment.
>
> As it stands, we allocate a local parent_spec structure, and
> that gets filled based on what comes back from the "get_parent"
> method call.  If anything goes wrong, we discard the parent
> spec and return an error.  Only when all goes well do we assign
>      rbd_dev->parent_spec = parent_spec;
> (and the same goes for the overlap).  ceph_extract_encoded_string()
> will return an error if it ends up short, and the other things
> that extract values also check for length.

Ok, that makes sense now.

> Is that what you were referring to--return either a complete
> one or none?  Or was there something else?

I meant that the class method should always return a complete 
parent_spec, so the response length should be checked. Letting
ceph_extract_encoded_string() check the correct length like you 
mentioned is fine.

