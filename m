From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 6/8] rbd: update mapping size only on refresh
Date: Thu, 24 Jul 2014 12:59:34 -0500
Message-ID: <53D14986.70004@ieee.org>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>	<1406191369-6746-7-git-send-email-ilya.dryomov@inktank.com>	<53D10941.2050205@ieee.org> <CALFYKtAGMmBvb-ujedZK_rctH5XDMGwVR262jVwbev9GQsbD8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:62867 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757637AbaGXR7f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 13:59:35 -0400
Received: by mail-ig0-f182.google.com with SMTP id c1so2976850igq.9
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 10:59:34 -0700 (PDT)
In-Reply-To: <CALFYKtAGMmBvb-ujedZK_rctH5XDMGwVR262jVwbev9GQsbD8A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 07/24/2014 08:46 AM, Ilya Dryomov wrote:
> On Thu, Jul 24, 2014 at 5:25 PM, Alex Elder <elder@ieee.org> wrote:
>> On 07/24/2014 03:42 AM, Ilya Dryomov wrote:
>>> There is no sense in trying to update the mapping size before it's even
>>> been set.
>>
>> It took me a bit to follow this.  But basically there is
>> no mapping unless it's mapped.  So previously this was
>> updating the mapping information even for unmapped
>> parent (or other) images.  There's no need to update
>> the mapping size for a snapshot--it'll never change.
>>
>> Is that right?  If not, please advise; otherwise:
> 
> No.  Previously it was updating the mapping size both on the inital map
> and on refresh (of the base image).  Doing that on the inital map
> doesn't make sense: not only struct rbd_mapping fields aren't properly
> initialized at that point - rbd_dev_mapping_set() is called much later
> in the map sequence, snap_id isn't initialized either (at least in the
> format 2 case, I haven't looked too closely at the format 1 case).  And
> just in general, trying to update something before it had a chance to
> change is bogus..

OK, now I see it.  Hopefully this makes sense.  Here is how it
was previously structured:

  rbd_add()
    do_rbd_add()
     |rbd_dev_image_probe()
     |  rbd_dev_header_info()
     |    rbd_dev_v1_header_info()    or    rbd_dev_v2_header_info()
     |      rbd_header_from_disk()            <update mapping>
     |        <update mapping>
     |  . . .
     |rbd_dev_device_setup()
     |  rbd_dev_mapping_set()

So neither rbd_header_from_disk() nor rbd_dev_v2_header_info()
should be using the values in the rbd_dev->mapping field during
initial image probe, because they have not yet been initialized
at that point.

Meanwhile, the only reason we need to *update* a mapping size
is if we learn it may have changed, which will be covered by a
refresh, so doing so in rbd_dev_refresh() makes sense.  And
as long as you know whether it's mapping the base image you
might as well do the rbd_exists_validate() call conditionally.

OK, this all looks good and makes good sense to me.
Thank you for explaining it.

Reviewed-by: Alex Elder <elder@linaro.org>


> 
> Thanks,
> 
>                 Ilya
> 

