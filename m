From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: enforce parent overlap
Date: Mon, 22 Apr 2013 15:43:16 -0500
Message-ID: <5175A0E4.5090201@inktank.com>
References: <51737A55.7040602@inktank.com> <517582C1.2020809@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:39500 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127Ab3DVUnT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 16:43:19 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so7689937iec.14
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 13:43:18 -0700 (PDT)
In-Reply-To: <517582C1.2020809@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/22/2013 01:34 PM, Josh Durgin wrote:
>> +     * We need to zero anything beyond the parent overlap
>> +     * boundary.  Since rbd_img_obj_request_read_callback()
>> +     * will zero anything beyond the end of a short read, an
>> +     * easy way to do this is to pretend the data from the
>> +     * parent came up short--ending at the overlap boundary.
>> +     */

Sorry, I missed this one.

>> +    rbd_assert(obj_request->img_offset < U64_MAX - obj_request->length);
>> +    obj_end = obj_request->img_offset + obj_request->length;
>> +    rbd_dev = obj_request->img_request->rbd_dev;
>> +    if (obj_end > rbd_dev->parent_overlap) {
> 
> Shouldn't this be >=, since the overlap is a size?

Does the overlap define the maximum byte offste included in
the overlap, or does it define the first offset not included?

If it's the former, then I agree with you (and it's not
what I thought).

					-Alex

>> +        u64 xferred = 0;
>> +
>> +        if (obj_request->img_offset < rbd_dev->parent_overlap)
>> +            xferred = rbd_dev->parent_overlap -
>> +                    obj_request->img_offset;
>> +
>> +        obj_request->xferred = min(img_request->xferred, xferred);
>> +    } else { 

