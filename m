From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [PATCH] osd: Do not subtract object overlaps from cache usage
Date: Thu, 27 Apr 2017 11:25:11 -0700
Message-ID: <CAJ4mKGYQEcgPJBGS5oofpU96Fcb1_M_vAj30fW9J92pswrYLLw@mail.gmail.com>
References: <d343aaa4-58f3-437b-276e-4a15ea4f209b@suse.com> <20170424151527.10888-1-mkoutny@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:37111 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164000AbdD0SZO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Apr 2017 14:25:14 -0400
Received: by mail-it0-f52.google.com with SMTP id x188so19607860itb.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Apr 2017 11:25:13 -0700 (PDT)
In-Reply-To: <20170424151527.10888-1-mkoutny@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Apr 24, 2017 at 8:15 AM, Michal Koutný <mkoutny@suse.com> wrote:
> Hi,
> this is a followup of my question [1] which I partially answered by looking at
> code history -- semantics of num_bytes isn't meant to include objects
> overlapping areas. However, this results in underestimating of space
> occupied on a cache tier proportional to the number of (overlapping) clone
> objects stored there.
>
> Could you please comment on the patch below if it's a right avenue to address
> this misaccounting problem. (This is rather for a discussion, I plan to submit
> a regular PR afterwards.)

Broadly speaking this seems like a sane approach. You're correct that
the OSD tries to not count overlapping space, but that's not accurate
on FileStore (sorry your previous email lost everybody's notice), and
it would be good to have a solution for that.

It might go better to query via the ObjectStore interface whether
clones are space-minimized or duplicates and make some higher-level
choices based on that; not really sure. I'd send in a PR where it can
be more easily discussed. :)
-Greg


>
> Thanks,
> Michal
>
>
> [1] http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-April/017288.html
>
> ---
>
> PG group field num_bytes does not include space that is part of clone
> object overlaps. Introduce a new field num_bytes_overlap that stands for
> this space only, so that it can be used to strictly limit cache tier
> usage with object storage backends that do not support storing overlaps
> efficiently.
> ---
>  src/osd/PrimaryLogPG.cc | 15 ++++++++++++++-
>  src/osd/PrimaryLogPG.h  |  1 +
>  src/osd/osd_types.cc    |  9 ++++++++-
>  src/osd/osd_types.h     |  6 +++++-
>  4 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/src/osd/PrimaryLogPG.cc b/src/osd/PrimaryLogPG.cc
> index 2f15999..12c02a0 100644
> --- a/src/osd/PrimaryLogPG.cc
> +++ b/src/osd/PrimaryLogPG.cc
> @@ -6407,6 +6407,7 @@ void PrimaryLogPG::make_writeable(OpContext *ctx)
>        ctx->delta_stats.num_objects_omap++;
>      if (snap_oi->is_cache_pinned())
>        ctx->delta_stats.num_objects_pinned++;
> +    ctx->delta_stats.num_bytes_overlap += ctx->obs->oi.size;
>      ctx->delta_stats.num_object_clones++;
>      ctx->new_snapset.clones.push_back(coid.snap);
>      ctx->new_snapset.clone_size[coid.snap] = ctx->obs->oi.size;
> @@ -6439,8 +6440,10 @@ void PrimaryLogPG::make_writeable(OpContext *ctx)
>      if (is_present_clone(last_clone_oid)) {
>        interval_set<uint64_t> &newest_overlap = ctx->new_snapset.clone_overlap.rbegin()->second;
>        ctx->modified_ranges.intersection_of(newest_overlap);
> -      // modified_ranges is still in use by the clone
> +      // modified_ranges is still in use by the clone (but not in accounted overlap)
>        add_interval_usage(ctx->modified_ranges, ctx->delta_stats);
> +      sub_interval_usage(ctx->modified_ranges, ctx->delta_stats);
> +
>        newest_overlap.subtract(ctx->modified_ranges);
>      }
>    }
> @@ -6479,6 +6482,13 @@ void PrimaryLogPG::add_interval_usage(interval_set<uint64_t>& s, object_stat_sum
>    }
>  }
>
> +void PrimaryLogPG::sub_interval_usage(interval_set<uint64_t>& s, object_stat_sum_t& delta_stats)
> +{
> +  for (interval_set<uint64_t>::const_iterator p = s.begin(); p != s.end(); ++p) {
> +    delta_stats.num_bytes_overlap -= p.get_len();
> +  }
> +}
> +
>  void PrimaryLogPG::complete_disconnect_watches(
>    ObjectContextRef obc,
>    const list<watch_disconnect_t> &to_disconnect)
> @@ -12250,6 +12260,9 @@ bool PrimaryLogPG::agent_choose_mode(bool restart, OpRequestRef op)
>      num_user_objects = 0;
>
>    uint64_t num_user_bytes = info.stats.stats.sum.num_bytes;
> +  // TODO should go depend on osd->store
> +  uint64_t overlap_bytes = info.stats.stats.sum.num_bytes_overlap;
> +  num_user_bytes += overlap_bytes;
>    uint64_t unflushable_bytes = info.stats.stats.sum.num_bytes_hit_set_archive;
>    num_user_bytes -= unflushable_bytes;
>    uint64_t num_overhead_bytes = osd->store->estimate_objects_overhead(num_user_objects);
> diff --git a/src/osd/PrimaryLogPG.h b/src/osd/PrimaryLogPG.h
> index 3d92e3b9..a802da1 100644
> --- a/src/osd/PrimaryLogPG.h
> +++ b/src/osd/PrimaryLogPG.h
> @@ -1095,6 +1095,7 @@ protected:
>                                    uint64_t length, bool count_bytes,
>                                    bool force_changesize=false);
>    void add_interval_usage(interval_set<uint64_t>& s, object_stat_sum_t& st);
> +  void sub_interval_usage(interval_set<uint64_t>& s, object_stat_sum_t& st);
>
>
>    enum class cache_result_t {
> diff --git a/src/osd/osd_types.cc b/src/osd/osd_types.cc
> index 2cce17e..25aaad6 100644
> --- a/src/osd/osd_types.cc
> +++ b/src/osd/osd_types.cc
> @@ -1846,6 +1846,7 @@ ostream& operator<<(ostream& out, const pg_pool_t& p)
>  void object_stat_sum_t::dump(Formatter *f) const
>  {
>    f->dump_int("num_bytes", num_bytes);
> +  f->dump_int("num_bytes_overlap", num_bytes_overlap);
>    f->dump_int("num_objects", num_objects);
>    f->dump_int("num_object_clones", num_object_clones);
>    f->dump_int("num_object_copies", num_object_copies);
> @@ -1883,11 +1884,12 @@ void object_stat_sum_t::dump(Formatter *f) const
>
>  void object_stat_sum_t::encode(bufferlist& bl) const
>  {
> -  ENCODE_START(15, 3, bl);
> +  ENCODE_START(16, 3, bl);
>  #if defined(CEPH_LITTLE_ENDIAN)
>    bl.append((char *)(&num_bytes), sizeof(object_stat_sum_t));
>  #else
>    ::encode(num_bytes, bl);
> +  ::encode(num_bytes_overlap, bl);
>    ::encode(num_objects, bl);
>    ::encode(num_object_clones, bl);
>    ::encode(num_object_copies, bl);
> @@ -1941,6 +1943,8 @@ void object_stat_sum_t::decode(bufferlist::iterator& bl)
>        uint64_t num_kb;
>        ::decode(num_kb, bl);
>      }
> +    if (struct_v >= 16)
> +      ::decode(num_bytes_overlap, bl);
>      ::decode(num_objects, bl);
>      ::decode(num_object_clones, bl);
>      ::decode(num_object_copies, bl);
> @@ -2078,6 +2082,7 @@ void object_stat_sum_t::generate_test_instances(list<object_stat_sum_t*>& o)
>  void object_stat_sum_t::add(const object_stat_sum_t& o)
>  {
>    num_bytes += o.num_bytes;
> +  num_bytes_overlap += o.num_bytes_overlap;
>    num_objects += o.num_objects;
>    num_object_clones += o.num_object_clones;
>    num_object_copies += o.num_object_copies;
> @@ -2116,6 +2121,7 @@ void object_stat_sum_t::add(const object_stat_sum_t& o)
>  void object_stat_sum_t::sub(const object_stat_sum_t& o)
>  {
>    num_bytes -= o.num_bytes;
> +  num_bytes_overlap -= o.num_bytes_overlap;
>    num_objects -= o.num_objects;
>    num_object_clones -= o.num_object_clones;
>    num_object_copies -= o.num_object_copies;
> @@ -2155,6 +2161,7 @@ bool operator==(const object_stat_sum_t& l, const object_stat_sum_t& r)
>  {
>    return
>      l.num_bytes == r.num_bytes &&
> +    l.num_bytes_overlap == r.num_bytes_overlap &&
>      l.num_objects == r.num_objects &&
>      l.num_object_clones == r.num_object_clones &&
>      l.num_object_copies == r.num_object_copies &&
> diff --git a/src/osd/osd_types.h b/src/osd/osd_types.h
> index 0d22975..59b29e0 100644
> --- a/src/osd/osd_types.h
> +++ b/src/osd/osd_types.h
> @@ -1577,6 +1577,7 @@ struct object_stat_sum_t {
>     * adding/removing fields!
>     **************************************************************************/
>    int64_t num_bytes;    // in bytes
> +  int64_t num_bytes_overlap;  // date in clone objects overlaps
>    int64_t num_objects;
>    int64_t num_object_clones;
>    int64_t num_object_copies;  // num_objects * num_replicas
> @@ -1612,7 +1613,7 @@ struct object_stat_sum_t {
>    int64_t num_objects_missing;
>
>    object_stat_sum_t()
> -    : num_bytes(0),
> +    : num_bytes(0), num_bytes_overlap(0),
>        num_objects(0), num_object_clones(0), num_object_copies(0),
>        num_objects_missing_on_primary(0), num_objects_degraded(0),
>        num_objects_unfound(0),
> @@ -1643,6 +1644,7 @@ struct object_stat_sum_t {
>    void floor(int64_t f) {
>  #define FLOOR(x) if (x < f) x = f
>      FLOOR(num_bytes);
> +    FLOOR(num_bytes_overlap);
>      FLOOR(num_objects);
>      FLOOR(num_object_clones);
>      FLOOR(num_object_copies);
> @@ -1689,6 +1691,7 @@ struct object_stat_sum_t {
>      }                                           \
>
>      SPLIT(num_bytes);
> +    SPLIT(num_bytes_overlap);
>      SPLIT(num_objects);
>      SPLIT(num_object_clones);
>      SPLIT(num_object_copies);
> @@ -1745,6 +1748,7 @@ struct object_stat_sum_t {
>      static_assert(
>        sizeof(object_stat_sum_t) ==
>          sizeof(num_bytes) +
> +        sizeof(num_bytes_overlap) +
>          sizeof(num_objects) +
>          sizeof(num_object_clones) +
>          sizeof(num_object_copies) +
> --
> 2.10.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
