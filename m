From: John Spray <jspray@redhat.com>
Subject: Re: cephfs quotas
Date: Wed, 18 Oct 2017 12:27:18 +0100
Message-ID: <CALe9h7dun71gFiAqn-1673spDRv95-+VHYWJWWE4CghvdXhjzg@mail.gmail.com>
References: <20171018101122.pfz7e27l32e34b2f@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:47287 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbdJRL1l (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Oct 2017 07:27:41 -0400
Received: by mail-wm0-f46.google.com with SMTP id t69so9411911wmt.2
        for <ceph-devel@vger.kernel.org>; Wed, 18 Oct 2017 04:27:40 -0700 (PDT)
In-Reply-To: <20171018101122.pfz7e27l32e34b2f@jf_suse_laptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Luis Henriques <lhenriques@suse.com>, Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>

On Wed, Oct 18, 2017 at 11:11 AM, Jan Fajerski <jfajerski@suse.com> wrote:
> Hi list,
> A while ago this list saw a little discussion about quota support for the
> cephfs kernel client. The result was that instead of adding kernel support
> for the current implementation, a new quota implementation would be the
> preferred solution. Here we would like to propose such an implementation.
>
> The objective is to implement quotas such that the implementation scales
> well, it can be implemented in ceph-fuse, the kernel client and libcephfs
> based clients and are enforceable without relying on client cooperation. The
> latter suggests that ceph daemon(s) must be involved in checking quota
> limits. We think that an approach as described in "Quota Enforcement for
> High-Performance Distributed Storage Systems" by Pollack et al.
> (https://www.ssrc.ucsc.edu/pub/pollack07-msst.html) can provide a good
> blueprint for such an implementation. This approach enforces quota limits
> with the help of vouchers. At a very high level this system works by one or
> more quota servers (in our case MDSs) issuing vouchers carrying (among other
> things) an expiration timestamp, an amount, a uid and a (cryptographic)
> signature to clients. An MDS can track how much space it has given out by
> tracking the vouchers it issues. A client can spend these vouchers on OSDs
> by sending them along with a write request. The OSD can verify a valid
> voucher by the signature. It will deduct the amount of written data from the
> voucher and might return the voucher if the voucher was not used up in full.
> The client can return the remaining amount or it can give it back to the
> MDS.  Client failures and misbehaving clients are handled through a
> periodical reconciliation phase where the MDSs and OSDs reconciles issued
> and used vouchers. Vouchers held by a failed client can be detected by the
> expiration timestamp attached to the vouchers. Any unused and invalid
> vouchers can be reclaimed by an MDS. Clients that try to cheat by spending
> the same voucher on multiple OSDs are detected by the uid of the voucher.
> This means that adversarial clients can exceed the quota, but will be caught
> within a limited time period. The signature ensure that clients can not
> fabricate valid vouchers.  For a much better and much more detailed
> description please refer to the paper.
>
> This approach has been implemented in Ceph before as described here
> http://drona.csa.iisc.ernet.in/~gopi/docs/amarnath-MSc.pdf. We could however
> not find the source code for this and it seemingly didn't find its way in to
> the current code base.
> The virtues of a protocol like this are that it can scale well, since there
> is no central entity that keeps a global state of the quotas, while still
> being able to enforce (somewhat) hard quotas.
> On the downside there is a protocol overhead that impacts performance.
> Research and reports on implementations suggest that this overhead can be
> kept fairly small though (2% performance penalty or less). Furthermore
> additional state must be kept on MDSs, OSDs and clients. Such a solution
> also adds considerable complexity to all involved components.
>
> We'd like to hear criticism and comments from the community, before a more
> in-depth CDM discussion.

Interesting!

My immediate thoughts:
 - The key element for implement kclient support is to implement a
mechanism whereby the clients do not have to backwards-traverse from a
file to find the nearest ancestor with a quota set.  I think that if
implementing a voucher-based approach, you'd still have to do this
work in addition to implementing the voucher system (the vouchers
would basically be the security layer on top of the refactor of
quotas)
 - The simple voucher approach is not sufficient for doing efficient
quotas on arbitrary ancestor directories: the OSD doesn't know what
directory a file is in, so how can it know whether a particular
voucher is valid for writes to a particular file?  The hack to make it
work would be to issue vouchers individually for each inode, but then
clients can overshoot their quota very far by opening many files at
once.
- In the reconciliation phase, the awkward part would be calculating
the actual size of the data in the quota-enforced directory, as the
vouchers could have been used for either overwrites or appends.  The
OSD voucher refunds would have to do something like tracking the
highest offset written in the file, and they would need passing back
up to the MDS so that it could accurately update its statistics about
the directory, perhaps.
- From reading the PDF link, it seems like they are not implementing
directory quotas, but per-client (or group of client) quotas.

I imagine that implementing directory quotas in a secure way would
require a more complex scheme, where the client would have to be able
to prove to the OSD which "quota realm" (i.e. ancestor dir with a
quota set) a particular inode belonged to.  You could potentially
issue such a token when granting write caps on a file: for files that
the client is allowed to write, it would get a signed token from the
MDS saying that the client may write, and also saying which quota
realm the file is in.  Then, the client would send that in addition to
a quota voucher for that particular realm, and the OSD would look at
both the token and the voucher.

This is related to ideas about doing broader OSD-side enforcement of
e.g. permissions: the MDS could issue tokens that said exactly what
the client is allowed to do with specific inodes, rather than clients
having free reign over everything in the data pool.

It would be ideal to find a design that decouples the security
enforcement aspect from the overall protocol aspect as much as
possible.  That way we could have an initial implementation that adds
quota support to the kernel client (introducing quota realm concept
but not actually passing tokens around), then work on the optional
crypto enforcement piece separately.

John




>
> Best,
> Luis and Jan
