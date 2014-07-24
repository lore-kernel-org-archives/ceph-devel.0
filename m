From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 6/8] rbd: update mapping size only on refresh
Date: Thu, 24 Jul 2014 17:46:21 +0400
Message-ID: <CALFYKtAGMmBvb-ujedZK_rctH5XDMGwVR262jVwbev9GQsbD8A@mail.gmail.com>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
	<1406191369-6746-7-git-send-email-ilya.dryomov@inktank.com>
	<53D10941.2050205@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:50796 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758830AbaGXNqW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 09:46:22 -0400
Received: by mail-qa0-f46.google.com with SMTP id v10so2935585qac.5
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 06:46:22 -0700 (PDT)
In-Reply-To: <53D10941.2050205@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jul 24, 2014 at 5:25 PM, Alex Elder <elder@ieee.org> wrote:
> On 07/24/2014 03:42 AM, Ilya Dryomov wrote:
>> There is no sense in trying to update the mapping size before it's even
>> been set.
>
> It took me a bit to follow this.  But basically there is
> no mapping unless it's mapped.  So previously this was
> updating the mapping information even for unmapped
> parent (or other) images.  There's no need to update
> the mapping size for a snapshot--it'll never change.
>
> Is that right?  If not, please advise; otherwise:

No.  Previously it was updating the mapping size both on the inital map
and on refresh (of the base image).  Doing that on the inital map
doesn't make sense: not only struct rbd_mapping fields aren't properly
initialized at that point - rbd_dev_mapping_set() is called much later
in the map sequence, snap_id isn't initialized either (at least in the
format 2 case, I haven't looked too closely at the format 1 case).  And
just in general, trying to update something before it had a chance to
change is bogus..

Thanks,

                Ilya
