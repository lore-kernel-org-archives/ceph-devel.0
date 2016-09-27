From: Sage Weil <sage@newdream.net>
Subject: Re: libcephfs API changes for credential rework
Date: Tue, 27 Sep 2016 15:13:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609271501090.19850@piezo.us.to>
References: <1474987148.2652.31.camel@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1285147600-1474989198=:19850"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56226 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbcI0PNT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Sep 2016 11:13:19 -0400
In-Reply-To: <1474987148.2652.31.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Gregory Farnum <gfarnum@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1285147600-1474989198=:19850
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 27 Sep 2016, Jeff Layton wrote:
> (tl;dr: we need to make some changes to the libcephfs API to allow
>  proper credential handling. What's the right approach to take?)
> 
> Greg Farnum has posted a pull request to rework how credentials are
> handled in cephfs:
> 
>     https://github.com/ceph/ceph/pull/11218
> 
> ...the patch pile is rather large, but the upshot is basically to
> change the code not to carve out '-1' in the uid and gid ranges, and to
> allow callers to pass down lists of supplementary groups. This is
> mainly needed for nfs-ganesha, but it also allows ceph-fuse to delegate
> permissions checks to the MDS.
> 
> That PR adds most of the low-level plumbing that's needed, but we still
> need to expose this capability to applications via libcephfs. Many
> libcephfs calls either take "int uid, int gid" or don't allow the
> caller to send down creds at all.
> 
> I think what we'll want to do is allow applications to create a new
> credential object and pass that down to the library in some fashion.
> The question is: what's the best way to handle those API changes?
> 
> We have several options here:
> 
> 1) make a clean break with the old API: just change the arguments to
> the existing functions, bump the library's major version and set the
> "age" field in it to 0. If you built against old headers, it'll fail to
> load the library at runtime. This is clearly the simplest option, but
> requires everyone to rebuild applications that were built against the
> old headers.

I think this is the way to go.  We'd bump the SONAME (libcephfs2!).  The 
packaging infrastructure is such that you can have the old version of the 
package (libcephfs1) installed at the same time as libcephfs2 (and 
-devel), so stuff that's linked to the old API can still work and 
coexist with stuff linked to the new one.  The only restriction (on debian 
at least; I assume in rpm-land it is the same) is that you can only have 
one version of the -dev package (headers) installed at a time, so you can 
only compile new code against one version at a time.

IIRC with the SONAME stuff you can specify the oldest compatible 
version.  We can take the lazy route and skip #2 below and make that 2 as 
well, which would mean installing libcephfs1 and libcephfs2 concurrently 
for compatibility.

It seems like the key downside here is that any project building against 
libcephfs that isn't updated will not be able to use newer versions of the 
client until they move to the new API...

sage



> 
> 2) create a "parallel" API that takes pointers to UserPerm objects, and
> add new new calls for them. The old API then becomes a wrapper around
> the new code. This would work, but it's more work -- we'd need to add a
> whole swath of new calls that take this pointer. This has the advantage
> of allowing existing programs to continue working through a lib
> upgrade. For this, we'd bump the major lib version, and "age" field to
> indicate that the library has a new API, but is backward compatible
> with the old one. If we want to go this route, how should the new
> functions be named?
> 
> 3) get tricky with global and thread local variables. Add calls to
> allow users to set libcephfs creds at the process and thread level.
> When the API is called, we'll check to see if creds have been installed
> in either spot and use those if they're present. If they're not, then
> we'll grab them from the current task (much like we do today). This is
> somewhat analogous to using setuid/setgid/setgroups before making a
> syscall. It's less intuitive than option #2 and requires callers to
> manage their creds carefully, but means that we don't need to explode
> out the API _and_ preserves the ability to run programs built against
> the old headers.
> 
> It's a fair bit of work any way we approach it, so I want to be clear
> on a direction before I dive in too deeply.
> 
> Thoughts?
> -- 
> Jeff Layton <jlayton@redhat.com>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-1285147600-1474989198=:19850--
