From: Luis Henriques <lhenriques@suse.com>
Subject: Re: cephfs quotas
Date: Thu, 19 Oct 2017 12:08:34 +0100
Message-ID: <20171019110834.6a7wkeoe36bupwe6@hermes.olymp>
References: <20171018101122.pfz7e27l32e34b2f@jf_suse_laptop>
 <CALe9h7dun71gFiAqn-1673spDRv95-+VHYWJWWE4CghvdXhjzg@mail.gmail.com>
 <20171018123244.u6qir3pxpjlxqp2o@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47449 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752705AbdJSLIh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 19 Oct 2017 07:08:37 -0400
Content-Disposition: inline
In-Reply-To: <20171018123244.u6qir3pxpjlxqp2o@jf_suse_laptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>

On Wed, Oct 18, 2017 at 02:32:44PM +0200, Jan Fajerski wrote:
> On Wed, Oct 18, 2017 at 12:27:18PM +0100, John Spray wrote:
> > On Wed, Oct 18, 2017 at 11:11 AM, Jan Fajerski <jfajerski@suse.com> wrote:
<snip>
> > > We'd like to hear criticism and comments from the community, before a more
> > > in-depth CDM discussion.
> > 
> > Interesting!
> > 
> > My immediate thoughts:
> > - The key element for implement kclient support is to implement a
> > mechanism whereby the clients do not have to backwards-traverse from a
> > file to find the nearest ancestor with a quota set.  I think that if
> > implementing a voucher-based approach, you'd still have to do this
> > work in addition to implementing the voucher system (the vouchers
> > would basically be the security layer on top of the refactor of
> > quotas)
> > - The simple voucher approach is not sufficient for doing efficient
> > quotas on arbitrary ancestor directories: the OSD doesn't know what
> > directory a file is in, so how can it know whether a particular
> > voucher is valid for writes to a particular file?  The hack to make it
> > work would be to issue vouchers individually for each inode, but then
> > clients can overshoot their quota very far by opening many files at
> > once.
> The idea is that the MDS is doing the traversing before issuing a voucher. I
> certainly oversimplified on the voucher description. In the paper a voucher
> carries a user id to tie the voucher to a set quota. In Ceph's current quota
> scheme this would have to be a "quota realm" (as named below). I hadn't yet
> thought about how an OSD can verify that the voucher can be spend on this
> particular piece of data.

Ok, I must admit that my initial (naïve) idea was to actually have a
voucher per inode (including directories, as you would need these for
preventing users to exceed the max_files limit).  This would allow the
clients to simply ignore the quota realms at all, as the MDS would be
taking care all the details -- the MDS would be responsible for figuring
out the inode quota realm and decide whether to grant a voucher to the
client or not.

However, as you pointed out, a voucher per inode would be a bad idea --
not only the clients could easily overshoot their quota very quickly but
the overall performance would likely suffer a lot with a much more verbose
protocol.

So, I agree that even in a voucher-based approach the client will still
require to figure out which quota realm it belongs to.  And this is where
the MDS requires to provide support for this new 'quota realm' concept.

My initial thought on this would be that each inode would need to start
including info about its quota realm.  This could also be a bit expensive,
though: simply setting quotas on a directory would require touching
*every* inode recursively!  And this would be needed for moving
directories/files between different quota realms.

Unfortunately, I don't really know how an OSD would figure out if a
voucher could be used in a specific write operation :-(  I assumed,
probably incorrectly, that this would be possible using the quota realm
info that could be included in a voucher.

> > - In the reconciliation phase, the awkward part would be calculating
> > the actual size of the data in the quota-enforced directory, as the
> > vouchers could have been used for either overwrites or appends.  The
> > OSD voucher refunds would have to do something like tracking the
> > highest offset written in the file, and they would need passing back
> > up to the MDS so that it could accurately update its statistics about
> > the directory, perhaps.
> Can the OSD not determine the amount that was used of the voucher, i.e.
> overwrite vs. append? And yes ideally a client hand back unused vouchers.
> Otherwise the MDS can reclaim them after they timed out (say in case of a
> crashed client)

The client can also truncate files.  And if we keep the same quota model
(max_files and max_bytes), there are other operations: delete files,
create new files, and links.  Some of these operations that require quota
checks can probably be handled by the MDS only, though.

> > - From reading the PDF link, it seems like they are not implementing
> > directory quotas, but per-client (or group of client) quotas.
> > 
> > I imagine that implementing directory quotas in a secure way would
> > require a more complex scheme, where the client would have to be able
> > to prove to the OSD which "quota realm" (i.e. ancestor dir with a
> > quota set) a particular inode belonged to.  You could potentially
> > issue such a token when granting write caps on a file: for files that
> > the client is allowed to write, it would get a signed token from the
> > MDS saying that the client may write, and also saying which quota
> > realm the file is in.  Then, the client would send that in addition to
> > a quota voucher for that particular realm, and the OSD would look at
> > both the token and the voucher.
> I had just assumed such a token would be part of the voucher. But
> essentially what you describe here is what we had in mind. My lack of Ceph
> knowledge probably hindered a more sensible description.
> > 
> > This is related to ideas about doing broader OSD-side enforcement of
> > e.g. permissions: the MDS could issue tokens that said exactly what
> > the client is allowed to do with specific inodes, rather than clients
> > having free reign over everything in the data pool.
> > 
> > It would be ideal to find a design that decouples the security
> > enforcement aspect from the overall protocol aspect as much as
> > possible.  That way we could have an initial implementation that adds
> > quota support to the kernel client (introducing quota realm concept
> > but not actually passing tokens around), then work on the optional
> > crypto enforcement piece separately.

Basically you're suggesting that an initial implementation should be
identical to the one currently available on the fuse-client, except that
it would be using quota realms instead of the backward-traverse.  Do you
think this will allow us to easily extend it in the future for a
voucher-based approach?  Although I'm inclined to agree with that, my
major concern is that it could introduce constraints I'm not considering
at the moment, and that these constraints could make it difficult to
evolve from there (breaking backward compatibility is a major regression,
specially in kernel ;-)

Cheers,
--
Luís
