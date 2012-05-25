From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: RBD format changes and layering
Date: Fri, 25 May 2012 16:07:37 -0700
Message-ID: <4FC010B9.3030101@inktank.com>
References: <4FBEBECD.6040403@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57324 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756796Ab2EYXHk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 May 2012 19:07:40 -0400
Received: by pbbrp8 with SMTP id rp8so2314153pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 25 May 2012 16:07:40 -0700 (PDT)
In-Reply-To: <4FBEBECD.6040403@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On 05/24/2012 04:05 PM, Josh Durgin wrote:
> 1) making sure parent images are not deleted when children still
> refer to them

Yehuda and Tv and I talked about this more, and came up with a simpler
design that doesn't require the security changes or writing anything
to the parent.

Each image (and snapshot) has a 'preserved' flag that means it is 
read-only and cannot be deleted without explicitly declaring it
deletable. Something like:

   $ rbd preserve pool/image
   $ rbd rm pool/image
   Error: image is preserved. If you really know what you're doing, 
unpreserve it.
   $ rbd unpreserve pool/image
   $ rbd rm pool/image

Images or snapshots that don't have the preserved flag set can't be
cloned. Images or snapshots that do have it set can't be deleted until
it is unset.

To answer the question 'does this image have children', we can have an
object in the child's pool that maintains info about which children
exist in that pool (rbd_clones). This could be an omap with keys of
(parent pool id, parent image id, parent snap name, child image id,
child snap name) and empty values, or keys with the parent info and
values consisting of lists of child info.

To check whether children exist, you can iterate over
all the pools and check the rbd_clones object in each one.
Since the number of pools is relatively small, this isn't
very expensive. If the pool is deleted, by definition all the children 
in it are deleted.

With separate namespaces in the future, this will be a bit more
expensive, but it's only needed at base image deletion time,
which is relatively rare. Deleting the image itself already
requires an I/O per object, so this is probably not the slow
part anyway.

Yehuda, Tv, did I miss anything?

Josh
