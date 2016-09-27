From: Jeff Layton <jlayton@redhat.com>
Subject: Re: libcephfs API changes for credential rework
Date: Tue, 27 Sep 2016 15:53:21 -0400
Message-ID: <1475006001.2652.103.camel@redhat.com>
References: <1474987148.2652.31.camel@redhat.com>
         <alpine.DEB.2.11.1609271501090.19850@piezo.us.to>
         <1474997941.2652.94.camel@redhat.com>
         <CAJ4mKGYB1XBuPQiaVVLFQ1mC3XCMrju40=3iyHidMrWVrJrdPA@mail.gmail.com>
         <1475003402.2652.98.camel@redhat.com>
         <CAJ4mKGanmvTy+u7g8=fgXgqTyyQVv_FP4wKqDMpkFn3+SsFm4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34919 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753284AbcI0TxX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Sep 2016 15:53:23 -0400
Received: by mail-yw0-f169.google.com with SMTP id i129so14640332ywe.2
        for <ceph-devel@vger.kernel.org>; Tue, 27 Sep 2016 12:53:23 -0700 (PDT)
In-Reply-To: <CAJ4mKGanmvTy+u7g8=fgXgqTyyQVv_FP4wKqDMpkFn3+SsFm4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 2016-09-27 at 12:13 -0700, Gregory Farnum wrote:
> On Tue, Sep 27, 2016 at 12:10 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > On Tue, 2016-09-27 at 11:17 -0700, Gregory Farnum wrote:
> > > 
> > > On Tue, Sep 27, 2016 at 10:39 AM, Jeff Layton <jlayton@redhat.com> wrote:
> > > > 
> > > > 
> > > > On Tue, 2016-09-27 at 15:13 +0000, Sage Weil wrote:
> > > > > 
> > > > > 
> > > > > On Tue, 27 Sep 2016, Jeff Layton wrote:
> > > > > > 
> > > > > > 
> > > > > > (tl;dr: we need to make some changes to the libcephfs API to allow
> > > > > >  proper credential handling. What's the right approach to take?)
> > > > > > 
> > > > > > Greg Farnum has posted a pull request to rework how credentials are
> > > > > > handled in cephfs:
> > > > > > 
> > > > > >     https://github.com/ceph/ceph/pull/11218
> > > > > > 
> > > > > > ...the patch pile is rather large, but the upshot is basically to
> > > > > > change the code not to carve out '-1' in the uid and gid ranges, and to
> > > > > > allow callers to pass down lists of supplementary groups. This is
> > > > > > mainly needed for nfs-ganesha, but it also allows ceph-fuse to delegate
> > > > > > permissions checks to the MDS.
> > > > > > 
> > > > > > That PR adds most of the low-level plumbing that's needed, but we still
> > > > > > need to expose this capability to applications via libcephfs. Many
> > > > > > libcephfs calls either take "int uid, int gid" or don't allow the
> > > > > > caller to send down creds at all.
> > > > > > 
> > > > > > I think what we'll want to do is allow applications to create a new
> > > > > > credential object and pass that down to the library in some fashion.
> > > > > > The question is: what's the best way to handle those API changes?
> > > > > > 
> > > > > > We have several options here:
> > > > > > 
> > > > > > 1) make a clean break with the old API: just change the arguments to
> > > > > > the existing functions, bump the library's major version and set the
> > > > > > "age" field in it to 0. If you built against old headers, it'll fail to
> > > > > > load the library at runtime. This is clearly the simplest option, but
> > > > > > requires everyone to rebuild applications that were built against the
> > > > > > old headers.
> > > > > 
> > > > > I think this is the way to go.  We'd bump the SONAME (libcephfs2!).  The
> > > > > packaging infrastructure is such that you can have the old version of the
> > > > > package (libcephfs1) installed at the same time as libcephfs2 (and
> > > > > -devel), so stuff that's linked to the old API can still work and
> > > > > coexist with stuff linked to the new one.  The only restriction (on debian
> > > > > at least; I assume in rpm-land it is the same) is that you can only have
> > > > > one version of the -dev package (headers) installed at a time, so you can
> > > > > only compile new code against one version at a time.
> > > > > 
> > > > > IIRC with the SONAME stuff you can specify the oldest compatible
> > > > > version.  We can take the lazy route and skip #2 below and make that 2 as
> > > > > well, which would mean installing libcephfs1 and libcephfs2 concurrently
> > > > > for compatibility.
> > > > > 
> > > > > It seems like the key downside here is that any project building against
> > > > > libcephfs that isn't updated will not be able to use newer versions of the
> > > > > client until they move to the new API...
> > > > > 
> > > > > sage
> > > > > 
> > > > 
> > > > This brings up another point...
> > > > 
> > > > When I added the struct ceph_statx interfaces, I left the old struct
> > > > stat interfaces intact. So we now have ceph_statx and ceph_ll_getattrx,
> > > > etc. If we're making a clean API break where we change args on existing
> > > > function names, then we don't really need those new calls.
> > > > 
> > > > Anyone have objections to me just converting the old struct stat based
> > > > functions to use struct ceph_statx instead, and dumping the new
> > > > function prototypes that I added?
> > > > 
> > > > It'll mean some code churn in the short term, but I think it'll make
> > > > for a simpler API later.
> > > 
> > > Yeah, that makes sense as long as we're going incompatible.
> > > 
> > > Here's another question, though: should we actually copy the source
> > > code to create libcephfs2, and generate libcephfs1 through the
> > > Luminous release to give anybody who is running stuff out there a
> > > window to change over smoothly? I don't expect we'd need to actually
> > > change the libcephfs1 source code; certainly it won't take much...
> > > -Greg
> > 
> > Sure, I don't think it'd be too hard to do that, just a little shim
> > layer on top of the new API.
> > 
> > Here's another thing too though. We have both java and python bindings
> > in the tree as well. They don't really deal with creds, but they do
> > wrap ceph_stat() and friends...should I convert those over to use the
> > statx-based APIs as well?
> 
> I dunno about the python ones. The Java API is really only used by our
> Hadoop bindings AFAIK so it'd be dictated by that system's needs. I
> imagine we'd want to swap them to use our new interfaces for ease of
> maintenance, but if it's simpler we don't need to swap out their
> exterior APIs to expose statx until there's demand?

Maybe, but it might be good to go ahead and convert them too.

The older interfaces were pretty heavy on the caps requirements. The
ceph_statx APIs allow clients to get away with only the caps they need
for the fields that they are interested in. I imagine hadoop workloads
might benefit from that.

Fixing the bindings themselves looks pretty simple, but I'd need
someone else to drive fixing hadoop and the python consumers of them.

-- 
Jeff Layton <jlayton@redhat.com>
