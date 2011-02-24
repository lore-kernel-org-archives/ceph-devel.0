From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: C++ api for librados 0.25
Date: Wed, 23 Feb 2011 23:11:24 -0800
Message-ID: <AANLkTin3gXaBv1y+MPEvJVxNYVhtJdkqtzf+1vp=XApw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54546 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755779Ab1BXHL2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 02:11:28 -0500
Received: by bwz15 with SMTP id 15so775131bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Feb 2011 23:11:27 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Here is the proposed C++ API for librados 0.25.
The main changes are that I created class Pool, class Snap, and the
ObjectIterator interface.

These represent the obvious concepts. Some of the stuff that is now
inlined because of laziness will be moved into the cpp file where it
belongs later. This is just to give an idea of the interface.

Colin


=====================================================
#ifndef __LIBRADOS_HPP
#define __LIBRADOS_HPP

#include <stdbool.h>
#include <string>
#include <list>
#include <map>
#include <vector>
#include "buffer.h"

#include "librados.h"

class RadosClient;
class Context;

namespace librados {

  using ceph::bufferlist;

  typedef void *list_ctx_t;
  typedef void *pool_t;
  typedef uint64_t snap_t;
  typedef uint64_t auid_t;

  struct statfs_t {
    uint64_t kb, kb_used, kb_avail;
    uint64_t num_objects;
  };

  struct pool_stat_t {
    uint64_t num_bytes;    // in bytes
    uint64_t num_kb;       // in KB
    uint64_t num_objects;
    uint64_t num_object_clones;
    uint64_t num_object_copies;  // num_objects * num_replicas
    uint64_t num_objects_missing_on_primary;
    uint64_t num_objects_unfound;
    uint64_t num_objects_degraded;
    uint64_t num_rd, num_rd_kb, num_wr, num_wr_kb;
  };

  typedef void *completion_t;
  typedef void (*callback_t)(completion_t cb, void *arg);

  struct SnapContext {
    snap_t seq;
    std::vector<snap_t> snaps;
  };


class ObjectIterator : public std::iterator
<std::forward_iterator_tag, std::string>
{
public:
  ObjectIterator(Pool *pool, rados_list_ctx_t ctx)
    : pool(pool_), ctx(ctx_)
  {
  }

  bool operator==(const ObjectIterator& rhs) const {
    return (pool == rhs.pool) && (ctx == rhs.ctx);
  }

  bool operator!=(const ObjectIterator& rhs) const {
    return (pool != rhs.pool) || (ctx != rhs.ctx);
  }

  const std::string& operator*() {
    return cur_obj;
  }

  // Preincrement
  ObjectIterator &operator++() {
    get_next();
    return *this;
  }

  // Postincrement
  ObjectIterator &operator++(int) {
    ObjectIterator ret(*this);
    get_next();
    return ret;
  }

private:
  void get_next() {
    const char *entry;
    int ret = rados_objects_list_next(ctx, &entry);
    if (ret == -ENOENT) {
      *this = __EndObjectIterator;
      return;
    }
    else if (ret) {
      ostringstream oss;
      oss << "rados_objects_list_next returned " << ret;
      throw std::runtime_error(oss.str());
    }

    cur_obj = entry;
  }

  Pool *pool;
  rados_list_ctx_t *ctx;
  std::string cur_obj;
};

extern const ObjectIterator __EndObjectIterator;

class WatchCtx {
public:
  virtual void notify(uint8_t opcode, uint64_t ver) = 0;
};

class Snap
{
public:
  Snap() : snap(CEPH_NOSNAP) {}

  // Get the name of this snapshot
  const std::string &get_name() const;

  // Get the timestamp of this snapshot
  int get_stamp(time_t &t) const;

  // Remove this snapshot (see also Pool::snap_remove())
  int remove();

private:
  std::string name;
  snap_t snap;
};

class Pool
{
public:
  Pool(Rados *rados_, pool_t *pool_);
  ~Pool();
  void close();

  int set_auid(uint64_t auid_);
  int stat(struct pool_stat_t *stats) const;

  int create(const std::string& oid, bool exclusive);
  int write(const std::string& oid, off_t off, bufferlist& bl, size_t len);
  int write_full(const std::string& oid, bufferlist& bl);
  int read(const std::string& oid, off_t off, bufferlist& bl, size_t len);
  int remove(const std::string& oid);
  int trunc(const std::string& oid, size_t size);
  int mapext(const std::string& o, off_t off, size_t len,
std::map<off_t, size_t>& m);
  int sparse_read(const std::string& o, off_t off, size_t len,
std::map<off_t, size_t>& m, bufferlist& bl);
  int getxattr(const std::string& oid, const char *name, bufferlist& bl);
  int setxattr(const std::string& oid, const char *name, bufferlist& bl);
  int rmxattr(const std::string& oid, const char *name);
  int getxattrs(const std::string& oid, std::map<std::string,
bufferlist>& attrset);
  int stat(const std::string& oid, uint64_t *psize, time_t *pmtime);
  int exec(const std::string& oid, const char *cls, const char *method,
	   bufferlist& inbl, bufferlist& outbl);
  int tmap_update(const std::string& oid, bufferlist& cmdbl);

  void snap_set_read_context(Snap &snap);
  int snap_set_write_context(Snap &snap, const std::vector<Snap>& snaps);

  // Create a snapshot with a given name
  int snap_create(const char *snapname);

  // Look up a snapshot by name.
  // Returns 0 on success; error code otherwise
  int snap_lookup(const char *snapname, Snap &snap);

  // Remove a snapshot from this pool
  int snap_remove(const char *snapname);

  int snap_list(pool_t pool, std::vector<Snap> &snaps);

  // Rolls back an object to the snapshot 'snapname'
  int snap_rollback_object(const std::string& oid, const char *snapname);

  int selfmanaged_snap_create(pool_t pool, uint64_t *snapid);
  int selfmanaged_snap_remove(pool_t pool, uint64_t snapid);
  int selfmanaged_snap_rollback_object(pool_t pool, const std::string& oid,
				       SnapContext& snapc, uint64_t snapid);

  uint64_t get_last_version();

  PoolIterator objects_begin();
  PoolIterator objects_begin_filtered(bufferlist& filter, bufferlist
*extra_info);
  PoolIterator objects_end();

  // watch/notify
  int watch(const std::string& o, uint64_t ver, uint64_t *handle,
	    librados::Rados::WatchCtx *ctx);
  int unwatch(const std::string& o, uint64_t handle);
  int notify(const std::string& o, uint64_t ver);
  void set_notify_timeout(uint32_t timeout);

  /* assert version for next sync operations */
  void set_assert_version(uint64_t ver);

private:
  /* We don't allow assignment or copying */
  Pool(const Pool& rhs);
  const Pool& operator=(const Pool& rhs);

  Rados *rados;
  pool_t *pool;
};

class Rados
{
  RadosClient *client;
public:
  static void version(int *major, int *minor, int *extra);

  Rados();
  ~Rados();

  int init(const char * const id);
  int connect();
  void destroy();
  int conf_read_file(const char * const path);
  int conf_set(const char *option, const char *value);
  void reopen_log();
  int conf_get(const char *option, std::string &val);

  int pool_create(const char *name);
  int pool_create(const char *name, uint64_t auid);
  int pool_create(const char *name, uint64_t auid, __u8 crush_rule);
  int pool_delete(const char *name);
  int pool_open(const char *name, Pool *pool);
  int pool_lookup(const char *name);

  /* listing objects */
  int list_pools(std::list<std::string>& v);
  int get_pool_stats(std::list<std::string>& v,
		     std::map<std::string,pool_stat_t>& stats);
  int get_fs_stats(statfs_t& result);


  // -- aio --
  struct AioCompletion {
    void *pc;
    AioCompletion(void *_pc) : pc(_pc) {}
    int set_complete_callback(void *cb_arg, callback_t cb);
    int set_safe_callback(void *cb_arg, callback_t cb);
    int wait_for_complete();
    int wait_for_safe();
    bool is_complete();
    bool is_safe();
    int get_return_value();
    int get_version();
    void release();
  };

  int aio_read(pool_t pool, const std::string& oid, off_t off,
bufferlist *pbl, size_t len,
	       AioCompletion *c);
  int aio_sparse_read(pool_t pool, const std::string& oid, off_t off,
		      std::map<off_t,size_t> *m, bufferlist *data_bl, size_t len,
		      AioCompletion *c);
  int aio_write(pool_t pool, const std::string& oid, off_t off, const
bufferlist& bl, size_t len,
		AioCompletion *c);

  AioCompletion *aio_create_completion();
  AioCompletion *aio_create_completion(void *cb_arg, callback_t
cb_complete, callback_t cb_safe);

private:
  /* We don't allow assignment or copying */
  Rados(const Rados& rhs);
  const Rados& operator=(const Rados& rhs);
};

}

#endif
