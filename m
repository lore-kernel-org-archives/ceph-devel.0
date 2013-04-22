From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: have rbd_obj_method_sync() return transfer count
Date: Mon, 22 Apr 2013 18:39:40 -0500
Message-ID: <5175CA3C.5080207@inktank.com>
References: <51745771.5020009@inktank.com> <5175B261.9090802@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:51006 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab3DVXjm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 19:39:42 -0400
Received: by mail-ia0-f181.google.com with SMTP id k38so22817iah.40
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 16:39:42 -0700 (PDT)
In-Reply-To: <5175B261.9090802@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/22/2013 04:57 PM, Josh Durgin wrote:
> A couple small things below. With those fixed:
> 
> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
> 
> On 04/21/2013 02:17 PM, Alex Elder wrote:
>> Callers of rbd_obj_method_sync() don't know how many bytes of data
>> got returned by the class method call.  As a result, they have been
>> assuming enough got returned to decode whatever was expected.
>>
>> This isn't safe.  We know how many bytes got transferred, so have
>> rbd_obj_method_sync() return that amount (rather than just 0) if
>> the call is successful.

. . .

>> @@ -3709,9 +3714,9 @@ static int rbd_dev_v2_parent_info(struct
>> rbd_device *rbd_dev)
>>       if (ret < 0)
>>           goto out_err;
>>
>> -    ret = -ERANGE;
>>       p = reply_buf;
>>       end = reply_buf + size;

You didn't mention this, but now that I look at this I
managed to screw up the point of this patch in this spot.
The above line should (and will) be:
         end = reply_buf + ret;
(That was why the "ret = -ERANGE" had to be moved to begin
with.)  I did it right in one similar spot elsewhere in
the patch.

>> +    ret = -ERANGE;
> 
> maybe check for the full parent_spec here? even if there's no parent,
> a complete parent_spec should be returned.

I'm not sure I understand this comment.

As it stands, we allocate a local parent_spec structure, and
that gets filled based on what comes back from the "get_parent"
method call.  If anything goes wrong, we discard the parent
spec and return an error.  Only when all goes well do we assign
    rbd_dev->parent_spec = parent_spec;
(and the same goes for the overlap).  ceph_extract_encoded_string()
will return an error if it ends up short, and the other things
that extract values also check for length.

Is that what you were referring to--return either a complete
one or none?  Or was there something else?

>>       ceph_decode_64_safe(&p, end, parent_spec->pool_id, out_err);
>>       if (parent_spec->pool_id == CEPH_NOPOOL)
>>           goto out;    /* No parent?  No problem. */

. . .

>> @@ -4605,7 +4612,7 @@ static int rbd_dev_v1_probe(struct rbd_device
>> *rbd_dev)
>>       /* Version 1 images have no parent (no layering) */
>>
>>       rbd_dev->parent_spec = NULL;
>> -    rbd_dev->parent_overlap = 0;
>> +    rbd_dev->parent_overlap =40;
> 
> extraneous 4

Yes I spotted this and already fixed it in my own branch but
thought it was too small and obvious to warrant a re-post.

>>
>>       rbd_dev->image_format = 1;
. . .



