From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH v2] os/LevelDBStore: tune LevelDB data blocking options to
 be more suitable for PGStat values
Date: Wed, 10 Apr 2013 17:39:15 -0700
Message-ID: <CAPYLRzhaRg42eSOyQMGKLfQoyj81CriHKfsgXb2VnGGRhY2U6g@mail.gmail.com>
References: <1365180692-5233-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:43109 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab3DKAjR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Apr 2013 20:39:17 -0400
Received: by mail-we0-f170.google.com with SMTP id z2so826676wey.29
        for <ceph-devel@vger.kernel.org>; Wed, 10 Apr 2013 17:39:15 -0700 (PDT)
In-Reply-To: <1365180692-5233-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Jim,
I took this patch as a base for setting up config options which people
can tune manually and have pushed those changes to wip-leveldb-config.
Thanks very much for figuring out how to set up the cache et al!

For now I restructured quite a bit of the data ingestion, and I took
your defaults for the monitor on the write buffer, block size, and
compression, but I left the cache off. These also don't apply to the
OSDs at all. In order to enable more experimentation I do pass through
the options though:
OPTION(mon_ldb_write_buffer_size, OPT_U64, 32*1024*1024) // monitor's
leveldb write buffer size
OPTION(mon_ldb_cache_size, OPT_U64, 0) // monitor's leveldb cache size
OPTION(mon_ldb_block_size, OPT_U64, 4*1024*1024) // monitor's leveldb block size
OPTION(mon_ldb_bloom_size, OPT_INT, 0) // monitor's leveldb bloom bits per entry
OPTION(mon_ldb_max_open_files, OPT_INT, 0) // monitor's leveldb max open files
OPTION(mon_ldb_compression, OPT_BOOL, false) // monitor's leveldb uses
compression
(and similar ones for osd_ldb_*).

If you have the opportunity to verify that these patches work for you
(in particular I'm wondering if the OSDs need any more tuning on their
end which was being masked by your global changes) that would be
wonderful. :)
Thanks,
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Fri, Apr 5, 2013 at 9:51 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> As reported in this thread
>    http://www.spinics.net/lists/ceph-devel/msg13777.html
> starting in v0.59 a new filesystem with ~55,000 PGs would not start after
> a period of ~30 minutes.  By comparison, the same filesystem configuration
> would start in ~1 minute for v0.58.
>
> The issue is that starting in v0.59, LevelDB is used for the monitor
> data store.  For moderate to large numbers of PGs, the length of a PGStat value
> stored via LevelDB is best measured in megabytes.  The default tunings for
> LevelDB data blocking seem tuned for values with lengths measured in tens or
> hundreds of bytes.
>
> With the data blocking tuning provided by this patch, here's a comparison
> of filesystem startup times for v0.57, v0.58, and v0.59:
>
>       55,392 PGs   221,568 PGs
> v0.57   1m 07s        9m 42s
> v0.58   1m 04s       11m 44s
> v0.59      48s        3m 30s
>
> Note that this patch turns off LevelDB's compression by default.  The
> block tuning from this patch with compression enabled made no improvement
> in the new filesystem startup time for v0.59, for either PG count tested.
> I'll note that at 55,392 PGs the PGStat length is ~20 MB; perhaps that
> value length interacts poorly with LevelDB's compression at this block size.
>
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> ---
>  src/common/config_opts.h |    4 ++++
>  src/os/LevelDBStore.cc   |    9 +++++++++
>  src/os/LevelDBStore.h    |    3 +++
>  3 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/src/common/config_opts.h b/src/common/config_opts.h
> index 9d42961..e8f491e 100644
> --- a/src/common/config_opts.h
> +++ b/src/common/config_opts.h
> @@ -181,6 +181,10 @@ OPTION(paxos_propose_interval, OPT_DOUBLE, 1.0)  // gather updates for this long
>  OPTION(paxos_min_wait, OPT_DOUBLE, 0.05)  // min time to gather updates for after period of inactivity
>  OPTION(paxos_trim_tolerance, OPT_INT, 30) // number of extra proposals tolerated before trimming
>  OPTION(paxos_trim_disabled_max_versions, OPT_INT, 100) // maximum amount of versions we shall allow passing by without trimming
> +OPTION(leveldb_block_size, OPT_U64, 4 * 1024 * 1024)  // leveldb unit of caching, compression (in bytes)
> +OPTION(leveldb_write_buffer_size, OPT_U64, 32 * 1024 * 1024) // leveldb unit of I/O (in bytes)
> +OPTION(leveldb_cache_size, OPT_U64, 256 * 1024 * 1024) // leveldb data cache size (in bytes)
> +OPTION(leveldb_compression_enabled, OPT_BOOL, false)
>  OPTION(clock_offset, OPT_DOUBLE, 0) // how much to offset the system clock in Clock.cc
>  OPTION(auth_cluster_required, OPT_STR, "cephx")   // required of mon, mds, osd daemons
>  OPTION(auth_service_required, OPT_STR, "cephx")   // required by daemons of clients
> diff --git a/src/os/LevelDBStore.cc b/src/os/LevelDBStore.cc
> index 3d94096..0d41564 100644
> --- a/src/os/LevelDBStore.cc
> +++ b/src/os/LevelDBStore.cc
> @@ -14,13 +14,22 @@ using std::string;
>
>  int LevelDBStore::init(ostream &out, bool create_if_missing)
>  {
> +  db_cache = leveldb::NewLRUCache(g_conf->leveldb_cache_size);
> +
>    leveldb::Options options;
>    options.create_if_missing = create_if_missing;
> +  options.write_buffer_size = g_conf->leveldb_write_buffer_size;
> +  options.block_size = g_conf->leveldb_block_size;
> +  options.block_cache = db_cache;
> +  if (!g_conf->leveldb_compression_enabled)
> +    options.compression = leveldb::kNoCompression;
>    leveldb::DB *_db;
>    leveldb::Status status = leveldb::DB::Open(options, path, &_db);
>    db.reset(_db);
>    if (!status.ok()) {
>      out << status.ToString() << std::endl;
> +    delete db_cache;
> +    db_cache = NULL;
>      return -EINVAL;
>    } else
>      return 0;
> diff --git a/src/os/LevelDBStore.h b/src/os/LevelDBStore.h
> index 7f0e154..8199a41 100644
> --- a/src/os/LevelDBStore.h
> +++ b/src/os/LevelDBStore.h
> @@ -14,18 +14,21 @@
>  #include "leveldb/db.h"
>  #include "leveldb/write_batch.h"
>  #include "leveldb/slice.h"
> +#include "leveldb/cache.h"
>
>  /**
>   * Uses LevelDB to implement the KeyValueDB interface
>   */
>  class LevelDBStore : public KeyValueDB {
>    string path;
> +  leveldb::Cache *db_cache;
>    boost::scoped_ptr<leveldb::DB> db;
>
>    int init(ostream &out, bool create_if_missing);
>
>  public:
>    LevelDBStore(const string &path) : path(path) {}
> +  ~LevelDBStore() { delete db_cache; }
>
>    /// Opens underlying db
>    int open(ostream &out) {
> --
> 1.7.8.2
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
