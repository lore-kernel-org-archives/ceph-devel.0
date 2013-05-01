From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/4] rbd: get rid of the snapshot list
Date: Tue, 30 Apr 2013 17:57:51 -0700
Message-ID: <5180688F.1020703@inktank.com>
References: <517FBBF0.9020904@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:49677 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933787Ab3EAA6s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 20:58:48 -0400
Received: by mail-pd0-f176.google.com with SMTP id r10so590825pdi.21
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 17:58:47 -0700 (PDT)
In-Reply-To: <517FBBF0.9020904@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/30/2013 05:41 AM, Alex Elder wrote:
> An rbd device structure maintains a list of snapshot
> structures whose purpose is to cache the name, size,
> and features associated with a snapshot id.  The main
> reason it was needed was related to the presence of
> Linux device information for snapshots, which we
> no longer have.  We can look up the name, etc. "on
> the fly" about as easily as we can using the list,
> and getting rid of this list means we can eliminate
> a substantial bit of code.
>
> The final patch in this series gets rid of the snapshot
> list and the rbd_snap structure.  The first three put
> in place replacement functionality that doesn't require
> the list.
>
> 					-Alex
>
> [PATCH 1/4] rbd: look up snapshot name in names buffer
> [PATCH 2/4] rbd: use snap_id not index to look up snap info
> [PATCH 3/4] rbd: define rbd_snap_size() and rbd_snap_features()
> [PATCH 4/4] rbd: kill off the snapshot list

These patches look good, but bring up two things that should be 
addressed in later patches.

1) inefficient snapshot id lookup for format 2 images

We're sending a single request for each snapshot id in the snapshot
context. There could potentially be a very large number of snapshots
there, hundreds or even thousands, which would slow down mapping
a snapshot quite a bit. Aggregating this into a request with multiple
ops so we get, perhaps, up to 500 snapshot names at a time would
make this a lot faster.

2) mapped snapshots never clear the EXISTS flag

Now that we're not keeping a snapshot list, we don't check whether
the snapshot we mapped continues to exist. Since we know the snapshot
id, we just need to see if it's still present in the updated snapshot
context.

These aren't critical though, so this patch series looks good as is:
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
