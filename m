From: David Disseldorp <ddiss@suse.de>
Subject: Re: Compare And Write against unwritten ranges
Date: Wed, 27 Jul 2016 14:57:44 +0200
Message-ID: <20160727145744.048f1fe3@echidna.suse.de>
References: <20160726141409.14135a00@echidna.suse.de>
	<5797ABEF.1040101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34919 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144AbcG0M5q (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 Jul 2016 08:57:46 -0400
In-Reply-To: <5797ABEF.1040101@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks for the feedback Mike...

On Tue, 26 Jul 2016 13:29:03 -0500, Mike Christie wrote:

> On 07/26/2016 07:14 AM, David Disseldorp wrote:
> > Hi Mike,
> > 
> > Returning to the OSD cmpext functionality in
> > https://github.com/ceph/ceph/pull/8911 , I'm wondering how such
> > requests should be handled against unwritten ranges.
> > 
> > Currently an OSD will return -EINVAL to the client, as the short read
> > will be caught via:
> > https://github.com/ceph/ceph/pull/8911/commits/440895ea9f2604756c9f3c81e5c4ec5ca40401d7#diff-72747d40a424e7b5404366b557ff12a3R3722
> > -EINVAL then means that krbd will return an error for the corresponding
> > client I/O.
> > 
> > For read requests, rbd_img_obj_request_read_callback() handles
> > zero-filling read buffers that cover unwritten RBD ranges. For SCSI
> > Compare And Write the OSD is responsible for atomicity, so zero-filling
> > on the client side is problematic.
> > One potential option could be to add a truncate/zero operation to the
> > Compare And Write compound request, or optionally support truncate_seq
> > and truncate_size parameters in cmpext. Any thoughts/suggestions on the
> > approach here?
> 
> We have a similar problem if the data needed to be copyup'd right? I

Similar, but different - copyup should be handled via the
rbd_img_obj_parent_read_full() logic in rbd_img_obj_request_submit().

> think the multi-op route might be nice because it could work for both cases.
> 
> Did you already try the multi op zero/truncate approach? Did you have to
> make changes to the OSD code too?

I'm working on a multi-op prototype now, and will send you the patches
when done. I don't expect any changes on the OSD side.

> A long while back, I was working on the copyup part of the problem but I
> hit another problem. It was something like the copyup's write would
> succeed, but when the cmpext op does the read it will fail still. If I
> sent it down as a multi-op, some other bits/structs on the OSD side
> needed to be updated before I could do the cmpext op. I cannot find the
> patches and I never submitted because I had just hacked it in for
> testing. Did you hit something similar?

Yeah, I've seen issues with copyup+cmpext+write, but am treating that
as a separate problem for now.

Cheers, David
