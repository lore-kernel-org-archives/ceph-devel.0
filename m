From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] os/LevelDBStore: tune LevelDB data blocking options to
 be more suitable for PGStat values
Date: Fri, 5 Apr 2013 08:06:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304050800040.5844@cobra.newdream.net>
References: <1365115079-158190-1-git-send-email-jaschut@sandia.gov> <alpine.DEB.2.00.1304042142380.10899@cobra.newdream.net> <515EE0E3.4080109@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55938 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161922Ab3DEPGI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 11:06:08 -0400
In-Reply-To: <515EE0E3.4080109@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>, sam.just@inktank.com
Cc: ceph-devel@vger.kernel.org

On Fri, 5 Apr 2013, Jim Schutt wrote:
> On 04/04/2013 10:44 PM, Sage Weil wrote:
> > Fantastic work tracking this down, Jim!
> > 
> > Looking at the Riak docs on tuning leveldb, it looks like a large write 
> > buffer size is definitely a good idea.  The block size of 4MB is 
> > significantly larger than what they recommend, though.. if we go this big 
> > we also need to make the cache size larger (it defaults to 8MB?). 
> 
> I wondered about that, but the change in performance with
> just these simple changes was so drastic that I thought
> it was a good immediate change, with further tuning to
> follow.
> 
> Although, I just tested startup, not actually running such
> a filesystem.  Perhaps I missed the effects of insufficient
> caching.
> 
> I ended up picking 4 MB because the 55K PG case has PGStat
> values that are 20 MB in length, so it still takes 5 blocks
> to store one.  Plus, I'd really like to be running at 256K
> or 512K PGs to get the data uniformity across OSDs that I'm
> after.
> 
> Perhaps these need to be config options - I just hated to add
> more, when it would be hard for a user to discover that's the
> thing that needed tuning to solve some particular performance
> issue.  I'm hoping we can find one set of values that work well
> for everyone.

I think the best option is to figure out the defaults that will work for 
everyone, but still make config options.  I suspect there will be users 
that need to tune for less memory.

leveldb_block_size, leveldb_write_buffer_size, etc.
 
> > Did you 
> > try with a large write buffer but a smaller block size (like 256K or 
> > 512K)?
> 
> I did try a 256K block size with an 8 MB write buffer, also with
> no compression.  That caused the 55K PGs case to make much more
> progress towards starting, but it still failed to come up - I
> forget the details of what went awry.
> 
> > 
> > I think either a larger cache or a smaller block size is okay, but 4MB 
> > with an 8MB cache means only 2 blocks cached, which sounds non-ideal.
> 
> I can try fixing up a larger cache - I'll need to dig in
> a little to figure out how to do it, so it might take me
> a little while.  How big do you think it should be, given
> that the large PG count cases I'm after might have PGStat
> data lengths that are many tens of MB?
> 
> 64 MB? 256 MB?  Tunable?

The default is only 8MB, but this can safely go up to several gigs.  I 
think 256 MB sounds like a reasonable default...

Sam, want to weigh in?

> Also, I wondered about whether the writes need to be
> sync'd?  Do these tunings change your mind about whether
> that's needed?

The sync parameters shouldn't need to be changed.  os/FileStore.cc is 
calling the sync when we do an overall filestore sync prior to a commit 
point or btrfs snapshot.

sage


> 
> > 
> > Thanks!
> > sage
> > 
> > 
> > On Thu, 4 Apr 2013, Jim Schutt wrote:
> > 
> >> As reported in this thread
> >>    http://www.spinics.net/lists/ceph-devel/msg13777.html
> >> starting in v0.59 a new filesystem with ~55,000 PGs would not start after
> >> a period of ~30 minutes.  By comparison, the same filesystem configuration
> >> would start in ~1 minute for v0.58.
> >>
> >> The issue is that starting in v0.59, LevelDB is used for the monitor
> >> data store.  For moderate to large numbers of PGs, the length of a PGStat value
> >> stored via LevelDB is best measured in megabytes.  The default tunings for
> >> LevelDB data blocking seem tuned for values with lengths measured in tens or
> >> hundreds of bytes.
> >>
> >> With the data blocking tuning provided by this patch, here's a comparison
> >> of filesystem startup times for v0.57, v0.58, and v0.59:
> >>
> >>       55,392 PGs   221,568 PGs
> >> v0.57   1m 07s        9m 42s
> >> v0.58   1m 04s       11m 44s
> >> v0.59      45s        4m 17s
> >>
> >> Note that this patch turns off LevelDB's compression.  The block
> >> tuning from this patch with compression enabled made no improvement
> >> in the new filesystem startup time for v0.59, for either PG count
> >> tested.  I'll note that at 55,392 PGs the PGStat length is ~20 MB;
> >> perhaps that value length interacts pooly with LevelDB's compression
> 
> s/pooly/poorly/
> 
> Thanks -- Jim
> 
> >> at this block size.
> >>
> >> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> >> ---
> >>  src/os/LevelDBStore.cc |    3 +++
> >>  1 files changed, 3 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/src/os/LevelDBStore.cc b/src/os/LevelDBStore.cc
> >> index 3d94096..1b6ae7d 100644
> >> --- a/src/os/LevelDBStore.cc
> >> +++ b/src/os/LevelDBStore.cc
> >> @@ -16,6 +16,9 @@ int LevelDBStore::init(ostream &out, bool create_if_missing)
> >>  {
> >>    leveldb::Options options;
> >>    options.create_if_missing = create_if_missing;
> >> +  options.write_buffer_size = 32 * 1024 * 1024;
> >> +  options.block_size = 4 * 1024 * 1024;
> >> +  options.compression = leveldb::kNoCompression;
> >>    leveldb::DB *_db;
> >>    leveldb::Status status = leveldb::DB::Open(options, path, &_db);
> >>    db.reset(_db);
> >> -- 
> >> 1.7.8.2
> >>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
