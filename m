From: Luis Henriques <lhenriques@suse.com>
Subject: Re: cephfs quotas
Date: Thu, 19 Oct 2017 12:23:07 +0100
Message-ID: <20171019112307.hn4ckrkb234ns2og@hermes.olymp>
References: <20171018101122.pfz7e27l32e34b2f@jf_suse_laptop>
 <CALe9h7dun71gFiAqn-1673spDRv95-+VHYWJWWE4CghvdXhjzg@mail.gmail.com>
 <CAJ4mKGZaQ=i6uWiebw+wB=NUmo959Q=TLhgNs98WDApJMZieJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbdJSLXO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 19 Oct 2017 07:23:14 -0400
Content-Disposition: inline
In-Reply-To: <CAJ4mKGZaQ=i6uWiebw+wB=NUmo959Q=TLhgNs98WDApJMZieJw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>

On Wed, Oct 18, 2017 at 02:44:13PM -0700, Gregory Farnum wrote:
> On Wed, Oct 18, 2017 at 4:27 AM, John Spray <jspray@redhat.com> wrote:
> > On Wed, Oct 18, 2017 at 11:11 AM, Jan Fajerski <jfajerski@suse.com> wrote:
<snip>
> > My immediate thoughts:
> >  - The key element for implement kclient support is to implement a
> > mechanism whereby the clients do not have to backwards-traverse from a
> > file to find the nearest ancestor with a quota set.  I think that if
> > implementing a voucher-based approach, you'd still have to do this
> > work in addition to implementing the voucher system (the vouchers
> > would basically be the security layer on top of the refactor of
> > quotas)
> >  - The simple voucher approach is not sufficient for doing efficient
> > quotas on arbitrary ancestor directories: the OSD doesn't know what
> > directory a file is in, so how can it know whether a particular
> > voucher is valid for writes to a particular file?  The hack to make it
> > work would be to issue vouchers individually for each inode, but then
> > clients can overshoot their quota very far by opening many files at
> > once.
> 
> I'm not sure we need to focus on the existing directory-based quotas:
> the reason we chose that model is because uid-based quotas did not
> seem feasible. If this work does make them feasible, why not use the
> model people are familiar with? (Bonus: if different UIDs map to
> different namespaces, it's very easy for the OSDs to check they are
> valid for a given object.)

Correct, this could be used to move to a BSD-like quotas implementation,
where we could have 'user', 'group' and the more recent 'project' quotas
(which pretty much corresponds to the cephfs directory-based quotas).

Obviously, a challenge would be to ensure consistent user/group IDs across
the different clients.

> That said, (without having read the papers) I'm a little skeptical it
> will work. I've seen several "low-cost" abstractions that have hidden
> global state computations which turn out to be very costly once you
> exceed a threshold number of nodes.
> 
> 
> > - In the reconciliation phase, the awkward part would be calculating
> > the actual size of the data in the quota-enforced directory, as the
> > vouchers could have been used for either overwrites or appends.  The
> > OSD voucher refunds would have to do something like tracking the
> > highest offset written in the file, and they would need passing back
> > up to the MDS so that it could accurately update its statistics about
> > the directory, perhaps.
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
> >
> > This is related to ideas about doing broader OSD-side enforcement of
> > e.g. permissions: the MDS could issue tokens that said exactly what
> > the client is allowed to do with specific inodes, rather than clients
> > having free reign over everything in the data pool.
> 
> Yeah, we've read a number of papers relevant to this topic. They were
> generally focused on access permissions rather than quotas, though,
> and generally had higher costs than are claimed here. I'm not sure if
> any of them are extensible to quota enforcement; I tend to think not.
> (They mostly involved the MDS signing statements with a timeout
> granting access to the client holding them, but not feeding from the
> OSD back to the MDS.)

Just out of curiosity, is there any work being done on ceph to implement
this OSD permissions enforcement?

> See especially "Macaroons: Cookies with Contextual Caveats for
> Decentralized Authorization in the Cloud". "Scalable Security for
> Petascale Parallel File Systems" was interesting but I think pretty
> much superseded by macaroons. "Horus: Fine-Grained Encryption-Based
> Security for Large-Scale Storage" was very different, but has the
> "security" tag in my database program and might be more useful for
> quotas, as it is about accessing file ranges rather than inodes.

Interesting weekend literature, thanks!

Cheers,
--
Luís
