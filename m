From: Jan Fajerski <jfajerski@suse.com>
Subject: cephfs quotas
Date: Wed, 18 Oct 2017 12:11:22 +0200
Message-ID: <20171018101122.pfz7e27l32e34b2f@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:48573 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936792AbdJRKL3 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 18 Oct 2017 06:11:29 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Luis Henriques <lhenriques@suse.com>, Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>

Hi list,
A while ago this list saw a little discussion about quota support for the cephfs 
kernel client. The result was that instead of adding kernel support for the 
current implementation, a new quota implementation would be the preferred 
solution. Here we would like to propose such an implementation.

The objective is to implement quotas such that the implementation scales well, 
it can be implemented in ceph-fuse, the kernel client and libcephfs based 
clients and are enforceable without relying on client cooperation. The latter 
suggests that ceph daemon(s) must be involved in checking quota limits. We think 
that an approach as described in "Quota Enforcement for High-Performance 
Distributed Storage Systems" by Pollack et al. 
(https://www.ssrc.ucsc.edu/pub/pollack07-msst.html) can provide a good blueprint 
for such an implementation. This approach enforces quota limits with the help of 
vouchers. At a very high level this system works by one or more quota servers 
(in our case MDSs) issuing vouchers carrying (among other things) an expiration 
timestamp, an amount, a uid and a (cryptographic) signature to clients. An MDS 
can track how much space it has given out by tracking the vouchers it issues. A 
client can spend these vouchers on OSDs by sending them along with a write 
request. The OSD can verify a valid voucher by the signature. It will deduct the 
amount of written data from the voucher and might return the voucher if the 
voucher was not used up in full.  The client can return the remaining amount or 
it can give it back to the MDS.  Client failures and misbehaving clients are 
handled through a periodical reconciliation phase where the MDSs and OSDs 
reconciles issued and used vouchers. Vouchers held by a failed client can be 
detected by the expiration timestamp attached to the vouchers. Any unused and 
invalid vouchers can be reclaimed by an MDS. Clients that try to cheat by 
spending the same voucher on multiple OSDs are detected by the uid of the 
voucher. This means that adversarial clients can exceed the quota, but will be 
caught within a limited time period. The signature ensure that clients can not 
fabricate valid vouchers.  For a much better and much more detailed description 
please refer to the paper.

This approach has been implemented in Ceph before as described here 
http://drona.csa.iisc.ernet.in/~gopi/docs/amarnath-MSc.pdf. We could however not 
find the source code for this and it seemingly didn't find its way in to the 
current code base.
The virtues of a protocol like this are that it can scale well, since there is 
no central entity that keeps a global state of the quotas, while still being 
able to enforce (somewhat) hard quotas.
On the downside there is a protocol overhead that impacts performance. Research 
and reports on implementations suggest that this overhead can be kept fairly 
small though (2% performance penalty or less). Furthermore additional state must 
be kept on MDSs, OSDs and clients. Such a solution also adds considerable 
complexity to all involved components.

We'd like to hear criticism and comments from the community, before a more 
in-depth CDM discussion.

Best,
Luis and Jan
