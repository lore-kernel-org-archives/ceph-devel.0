From: David Disseldorp <ddiss@suse.de>
Subject: Compare And Write against unwritten ranges
Date: Tue, 26 Jul 2016 14:14:09 +0200
Message-ID: <20160726141409.14135a00@echidna.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39843 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755437AbcGZMOL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 Jul 2016 08:14:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Mike,

Returning to the OSD cmpext functionality in
https://github.com/ceph/ceph/pull/8911 , I'm wondering how such
requests should be handled against unwritten ranges.

Currently an OSD will return -EINVAL to the client, as the short read
will be caught via:
https://github.com/ceph/ceph/pull/8911/commits/440895ea9f2604756c9f3c81e5c4ec5ca40401d7#diff-72747d40a424e7b5404366b557ff12a3R3722
-EINVAL then means that krbd will return an error for the corresponding
client I/O.

For read requests, rbd_img_obj_request_read_callback() handles
zero-filling read buffers that cover unwritten RBD ranges. For SCSI
Compare And Write the OSD is responsible for atomicity, so zero-filling
on the client side is problematic.
One potential option could be to add a truncate/zero operation to the
Compare And Write compound request, or optionally support truncate_seq
and truncate_size parameters in cmpext. Any thoughts/suggestions on the
approach here?

FWIW, I'm using the following test to trigger this from the client side:
https://github.com/sahlberg/libiscsi/pull/213/commits/e6f2ce306cf8706b666ec088fc74219bc52ea8cf

Cheers, David
