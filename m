From: Sage Weil <sage@newdream.net>
Subject: =?UTF-8?Q?Re=3A_a_question_about_=E2=80=9Clease_issued_to_client=E2=80=9D_in_ceph_mds?=
Date: Wed, 30 Aug 2017 13:50:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708301346450.3491@piezo.novalocal>
References: <CACd4YjdHJJpGdtOQ_qDr0sLT4=suUFCHX+_QGbeKn2YoNg3mxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45905 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751358AbdH3NuK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Aug 2017 09:50:10 -0400
In-Reply-To: <CACd4YjdHJJpGdtOQ_qDr0sLT4=suUFCHX+_QGbeKn2YoNg3mxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Meyers Mark <markmeyers.mmy@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 30 Aug 2017, Meyers Mark wrote:
> Hi:
> 
>         I want to ask a question about "lease issued to client".
> 
>         In ceph source, src/mds/Locker.cc: Locker::issue_client_lease:
> 
> 
>         if(... &&
> 
>                (!diri->filelock.can_lease(client) &&
> 
>                 (diri->get_client_cap_pending(client) &
> (CEPH_CAP_FILE_SHARED | CEPH_CAP_FILE_EXCL)) == 0) &&
> 
>                  dn->lock.can_lease(client)) {
> 
>                 ...
> 
>                 // issue a dentry lease
> 
>                ClientLease *l = dn->add_client_lease(client, session);
> 
>                 ...
> 
>                 LeaseStat e;
> 
>                 ...
> 
>                 e.duration_ms = (int)(1000 *
> mdcache->client_lease_durations[pool]);
> 
>                 ...
> 
>         } else {
> 
>                 // null lease
> 
>                 LeaseStat e;
> 
>                 ...
> 
>                 e.duration_ms = 0;
>                 ...
> 
>         }
> 
>         So my understanding is:
> 
>         If parent directory has no lease, but has CEPH_CAP_FILE_SHARED
> mask, then the dentry can get a lease of 30s(caculated from
> duration_ms).

Actually if it *doesn't* have the FILE_SHARED cap, then we issue a 
per-dentry lease.

Per-dentry leases are fine, but not as efficient as a single bit on an 
entire directory indicating that the entire directory won't change.  Since 
most directories are static, this is an efficient way for clients to cache 
(and trust their cache).  If there are some modifications in the 
directory or for some other reason the MDS can't issue a the 
directory-wide lease (FILE_SHARED cap bit), then we issue per-dentry 
leases.

>         Else if in other conditions, then the dentry get a lease of 0s.
> 
>         I am confused here, in what situation does the parent
> directory and the child dentry share a lease?
> 
>         And in what situation does the child dentry have no
> lease(lease of zero seconds?)?

If there are locks on the dentry due to a modification in flight, we don't 
issue a lease.  This ensures that things like rename, unlink, etc. can 
make progress.

sage
