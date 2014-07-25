From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 6/8] rbd: update mapping size only on refresh
Date: Fri, 25 Jul 2014 08:31:46 -0500
Message-ID: <53D25C42.4080807@ieee.org>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>	<1406191369-6746-7-git-send-email-ilya.dryomov@inktank.com>	<53D10941.2050205@ieee.org>	<CALFYKtAGMmBvb-ujedZK_rctH5XDMGwVR262jVwbev9GQsbD8A@mail.gmail.com> <CALFYKtB1HZow3SDZxryWdyAmF8Vj1WYSTf5BQB4MkaVhgxrBgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:41889 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbaGYNbp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 09:31:45 -0400
Received: by mail-ig0-f180.google.com with SMTP id l13so766636iga.13
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 06:31:44 -0700 (PDT)
In-Reply-To: <CALFYKtB1HZow3SDZxryWdyAmF8Vj1WYSTf5BQB4MkaVhgxrBgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 07/24/2014 10:10 AM, Ilya Dryomov wrote:
> On Thu, Jul 24, 2014 at 5:46 PM, Ilya Dryomov <ilya.dryomov@inktank.com> wrote:
>> On Thu, Jul 24, 2014 at 5:25 PM, Alex Elder <elder@ieee.org> wrote:
>>> On 07/24/2014 03:42 AM, Ilya Dryomov wrote:
>>>> There is no sense in trying to update the mapping size before it's even
>>>> been set.
>>>
>>> It took me a bit to follow this.  But basically there is
>>> no mapping unless it's mapped.  So previously this was
>>> updating the mapping information even for unmapped
>>> parent (or other) images.  There's no need to update
>>> the mapping size for a snapshot--it'll never change.
>>>
>>> Is that right?  If not, please advise; otherwise:
>>
>> No.  Previously it was updating the mapping size both on the inital map
>> and on refresh (of the base image).  Doing that on the inital map
>> doesn't make sense: not only struct rbd_mapping fields aren't properly
>> initialized at that point - rbd_dev_mapping_set() is called much later
>> in the map sequence, snap_id isn't initialized either (at least in the
>> format 2 case, I haven't looked too closely at the format 1 case).  And
>> just in general, trying to update something before it had a chance to
>> change is bogus..
> 
> BTW, while we are on the subject of struct rbd_mapping, is there any
> particular reason to keep around both the base image values and actual
> mapping values?  I am tempted to change the mapping sequence so that 1)
> snap context is read in immediately after watch setup, before anything
> else is done, 2) supplied snap name is resolved into an id and 3) the
> actual (i.e. based on snap_id) mapping size, features, parent_overlap,
> etc are read in directly into struct rbd_image_header.  That would
> allow to rip struct rbd_mapping entirely and make the code more clear.

The rbd_mapping structure started out well-intentioned but
over time it seems clear it hasn't added the value it was
intended to add.  Here's where it got created:
    f84344f rbd: separate mapping info in rbd_dev
The only original field that survives is read_only.  There's
no harm at all in just moving the fields in that structure
out into the rbd_device structure.

Preserving the base image size in the header structure is
an artifact of the version 1 code, where it held the last
version of the on-disk header data.  The version 2 code
maintains it for consistency.

You could eliminate that I suppose.  I think the result
would require rbd_header_from_disk() to know about the
mapping rather than doing a simple conversion of data
from one form to another.

I say try it, and if you like the result I probably will too...

					-Alex


> Thanks,
> 
>                 Ilya
> 

