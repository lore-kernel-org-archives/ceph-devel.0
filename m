From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] enable mds rejoin with active inodes' old parent
 xattrs
Date: Thu, 22 Aug 2013 08:16:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308220815120.12506@cobra.newdream.net>
References: <orvc2ytei1.fsf@livre.home> <CAAM7YAk+1pZsn8=f-Z+wxzm+4-zkKQCN52gVTWot6e_OmHDSTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55972 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab3HVPQy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Aug 2013 11:16:54 -0400
In-Reply-To: <CAAM7YAk+1pZsn8=f-Z+wxzm+4-zkKQCN52gVTWot6e_OmHDSTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Alexandre Oliva <oliva@gnu.org>, ceph-devel <ceph-devel@vger.kernel.org>

Applied this to next and opened http://tracker.ceph.com/issues/6087 so we 
don't forget to backport it.

Is there any other change we want to make?  We could make the fetch code 
write the directory backpointers if they are not already present, which 
would at least clean up the dir objects (as they are touched).  :/

sage



On Thu, 22 Aug 2013, Yan, Zheng wrote:
> On Thu, Aug 22, 2013 at 2:40 PM, Alexandre Oliva <oliva@gnu.org> wrote:
> > When the parent xattrs of active inodes that the mds attempts to open
> > during rejoin lack pool info (struct_v < 5), this field will be filled
> > in with -1, causing the mds to retry fetching a backtrace with a pool
> > number that matches the expected value, which fails and causes the
> > err==-ENOENT branch to be taken and retry pool 1, which succeeds, but
> > with pool -1, and so keeps on bouncing between the two retry cases
> > forever.
> >
> > This patch arranges for the mds to go along with pool -1 instead of
> > insisting that it be refetched, enabling it to complete recovery
> > instead of eating cpu, network bandwidth and metadata osd's resources
> > like there's no tomorrow, in what AFAICT is an infinite and very busy
> > loop.
> >
> > This is not a new problem: I've had it even before upgrading from
> > Cuttlefish to Dumpling, I'd just never managed to track it down, and
> > force-unmounting the filesystem and then restarting the mds was an
> > easier (if inconvenient) work-around, particularly because it always
> > hit when the filesystem was under active, heavy-ish use (or there
> > wouldn't be much reason for caps recovery ;-)
> >
> My fault, I didn't do serious upgrade test for my code.  Thank you for nail
> the issue down.
> 
> >
> > There are two issues not addressed in this patch, however.  One is
> > that nothing seems to proactively update the parent xattr when it is
> > found to be outdated, so it remains out of date forever.  Not even
> > renaming top-level directories causes the xattrs to be recursively
> > rewritten.  AFAICT that's a bug.
> 
> This is not bug. Only the tail entry of the path encoded in the parent xattrs
> need to be updated. (the entry for inode's parent directory)
> 
> >
> > The other is that inodes that don't have a parent xattr (created by
> > even older versions of ceph) are reported as non-existing in the mds
> > rejoin message, because the absence of the parent xattr is signaled as
> > a missing inode (?failed to reconnect caps for missing inodes?).  I
> > suppose this may cause more serious recovery problems.
> 
> Cuttlefish also has this issue, it just does not print the error message
> to console.
> 
> >
> > I suppose a global pass over the filesystem tree updating parent
> > xattrs that are out-of-date would be desirable, if we find any parent
> > xattrs still lacking current information; it might make sense to
> > activate it as a background thread from the backtrace decoding
> > function, when it finds a parent xattr that's too out-of-date, or as a
> > separate client (ceph-fsck?).
> >
> > Signed-off-by: Alexandre Oliva <oliva@gnu.org>
> > ---
> >  src/mds/MDCache.cc |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> > index e592dde..b6c37aec 100644
> > --- a/src/mds/MDCache.cc
> > +++ b/src/mds/MDCache.cc
> > @@ -7940,7 +7940,7 @@ void MDCache::_open_ino_backtrace_fetched(inodeno_t ino, bufferlist& bl, int err
> >    inode_backtrace_t backtrace;
> >    if (err == 0) {
> >      ::decode(backtrace, bl);
> > -    if (backtrace.pool != info.pool) {
> > +    if (backtrace.pool != info.pool && backtrace.pool != -1) {
> >        dout(10) << " old object in pool " << info.pool
> >                << ", retrying pool " << backtrace.pool << dendl;
> >        info.pool = backtrace.pool;
> >
> 
> Reviewed-by: Yan, Zheng <zheng.z.yan@intel.com>
> 
> Regards
> Yan, Zheng
> 
> > --
> > Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> > You must be the change you wish to see in the world. -- Gandhi
> > Be Free! -- http://FSFLA.org/   FSF Latin America board member
> > Free Software Evangelist      Red Hat Brazil Compiler Engineer
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
