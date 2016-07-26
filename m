From: Mike Christie <mchristi@redhat.com>
Subject: Re: Compare And Write against unwritten ranges
Date: Tue, 26 Jul 2016 13:29:03 -0500
Message-ID: <5797ABEF.1040101@redhat.com>
References: <20160726141409.14135a00@echidna.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43839 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757929AbcGZS3F (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 Jul 2016 14:29:05 -0400
In-Reply-To: <20160726141409.14135a00@echidna.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/26/2016 07:14 AM, David Disseldorp wrote:
> Hi Mike,
> 
> Returning to the OSD cmpext functionality in
> https://github.com/ceph/ceph/pull/8911 , I'm wondering how such
> requests should be handled against unwritten ranges.
> 
> Currently an OSD will return -EINVAL to the client, as the short read
> will be caught via:
> https://github.com/ceph/ceph/pull/8911/commits/440895ea9f2604756c9f3c81e5c4ec5ca40401d7#diff-72747d40a424e7b5404366b557ff12a3R3722
> -EINVAL then means that krbd will return an error for the corresponding
> client I/O.
> 
> For read requests, rbd_img_obj_request_read_callback() handles
> zero-filling read buffers that cover unwritten RBD ranges. For SCSI
> Compare And Write the OSD is responsible for atomicity, so zero-filling
> on the client side is problematic.
> One potential option could be to add a truncate/zero operation to the
> Compare And Write compound request, or optionally support truncate_seq
> and truncate_size parameters in cmpext. Any thoughts/suggestions on the
> approach here?

We have a similar problem if the data needed to be copyup'd right? I
think the multi-op route might be nice because it could work for both cases.

Did you already try the multi op zero/truncate approach? Did you have to
make changes to the OSD code too?

A long while back, I was working on the copyup part of the problem but I
hit another problem. It was something like the copyup's write would
succeed, but when the cmpext op does the read it will fail still. If I
sent it down as a multi-op, some other bits/structs on the OSD side
needed to be updated before I could do the cmpext op. I cannot find the
patches and I never submitted because I had just hacked it in for
testing. Did you hit something similar?
