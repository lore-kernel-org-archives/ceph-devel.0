From: Wido den Hollander <wido@widodh.nl>
Subject: Re: proposed C API for librados
Date: Thu, 24 Feb 2011 09:06:02 +0100
Message-ID: <1298534762.2423.114.camel@wido-laptop.pcextreme.nl>
References: <AANLkTi=qvZjPOHkZbPem0TPjovGiqNo7Arq=q2YqEWDS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:37912 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab1BXIGQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 03:06:16 -0500
In-Reply-To: <AANLkTi=qvZjPOHkZbPem0TPjovGiqNo7Arq=q2YqEWDS@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

Hi,

On Wed, 2011-02-23 at 22:09 -0800, Colin McCabe wrote:

> #define LIBRADOS_VERSION(maj, min, extra) ((maj << 16) + (min << 8) + extra)
> 
> #define LIBRADOS_VERSION_CODE LIBRADOS_VERSION(LIBRADOS_VER_MAJOR,
> LIBRADOS_VER_MINOR, LIBRADOS_VER_EXTRA)
> 
> #define LIBRADOS_SUPPORTS_WATCH 1

A few months ago I proposed a "librados-config" binary:
http://tracker.newdream.net/issues/334

$ librados-config --features
SUPPORTS_WATCH

This binary right now only supports --vernum and --version, but adding
"--features" would he useful imho.

> struct rados_pool_stat_t {
>   uint64_t num_bytes;    // in bytes
>   uint64_t num_kb;       // in KB

See my other post, why bytes and kb?

> /* Reopens the log file.
>  * You must do this after changing the logging configuration.
>  * It is also good practice to call this from your SIGHUP signal
> handler, so that users can send you
>  * a SIGHUP to reopen the log.
>  */
> void rados_reopen_log(rados_t cluster);
> 

What about syslog? Does librados support logging to syslog? Or only to
file?

In the future I foresee end-user using phprados, the python bindings or
other extensions/bindings which gives them direct RADOS access, but they
do not have full access to the system.

Would a buffer in librados be a extra option? A buffer which you could
read where you are able to find the last X log messages. We could have:

void rados_get_last_logmsg(rados_t cluster, char *buf);

buf would than be filled with the last log messages, very usefull if you
don't have full system access.

Other than that, the new API seems sane to me.

Wido


> /* Returns a configuration value as a string.
>  * If len is positive, that is the maximum number of bytes we'll write into the
>  * buffer. If len == -1, we'll call malloc() and set *buf.
>  * Returns 0 on success, error code otherwise. Returns ENAMETOOLONG if the
>  * buffer is too short. */
> int rados_conf_get(rados_t cluster, const char *option, char *buf, int len);
> int rados_conf_get_alloc(rados_t cluster, const char *option, char **buf);
> 
> /* pools */
> int rados_pool_open(rados_t cluster, const char *name, rados_pool_t *pool);
> int rados_pool_close(rados_pool_t pool);
> int rados_pool_lookup(rados_t cluster, const char *name);
> 
> int rados_pool_stat(rados_pool_t pool, struct rados_pool_stat_t *stats);
> 
> void rados_snap_set_read(rados_pool_t pool, rados_snap_t snap);
> int rados_snap_set_write_context(rados_pool_t pool, rados_snap_t seq,
> rados_snap_t *snaps, int num_snaps);
> 
> int rados_pool_create(rados_t cluster, const char *name);
> int rados_pool_create_with_auid(rados_t cluster, const char *name,
> uint64_t auid);
> int rados_pool_create_with_crush_rule(rados_t cluster, const char
> *name, __u8 crush_rule);
> int rados_pool_create_with_all(rados_t cluster, const char *name, uint64_t auid,
> 			       __u8 crush_rule);
> int rados_pool_delete(rados_pool_t pool);
> int rados_pool_set_auid(rados_pool_t pool, uint64_t auid);
> 
> /* objects */
> int rados_objects_list_open(rados_pool_t pool, rados_list_ctx_t *ctx);
> int rados_objects_list_next(rados_list_ctx_t ctx, const char **entry);
> void rados_objects_list_close(rados_list_ctx_t ctx);
> 
> 
> /* snapshots */
> int rados_pool_snap_create(rados_pool_t pool, const char *snapname);
> int rados_pool_snap_remove(rados_pool_t pool, const char *snapname);
> int rados_pool_snap_rollback_object(rados_pool_t pool, const char *oid,
> 			  const char *snapname);
> int rados_pool_selfmanaged_snap_create(rados_pool_t pool, uint64_t *snapid);
> int rados_pool_selfmanaged_snap_remove(rados_pool_t pool, uint64_t snapid);
> int rados_pool_snap_list(rados_pool_t pool, rados_snap_t *snaps, int maxlen);
> int rados_pool_snap_lookup(rados_pool_t pool, const char *name,
> rados_snap_t *id);
> int rados_pool_snap_get_name(rados_pool_t pool, rados_snap_t id, char
> *name, int maxlen);
> 
> /* sync io */
> uint64_t rados_get_last_version(rados_pool_t pool);
> 
> int rados_write(rados_pool_t pool, const char *oid, off_t off, const
> char *buf, size_t len);
> int rados_write_full(rados_pool_t pool, const char *oid, off_t off,
> const char *buf, size_t len);
> int rados_read(rados_pool_t pool, const char *oid, off_t off, char
> *buf, size_t len);
> int rados_remove(rados_pool_t pool, const char *oid);
> int rados_trunc(rados_pool_t pool, const char *oid, size_t size);
> 
> /* attrs */
> int rados_getxattr(rados_pool_t pool, const char *o, const char *name,
> char *buf, size_t len);
> int rados_setxattr(rados_pool_t pool, const char *o, const char *name,
> const char *buf, size_t len);
> int rados_rmxattr(rados_pool_t pool, const char *o, const char *name);
> 
> /* misc */
> int rados_stat(rados_pool_t pool, const char *o, uint64_t *psize,
> time_t *pmtime);
> int rados_tmap_update(rados_pool_t pool, const char *o, const char
> *cmdbuf, size_t cmdbuflen);
> int rados_exec(rados_pool_t pool, const char *oid, const char *cls,
> const char *method,
> 	       const char *in_buf, size_t in_len, char *buf, size_t out_len);
> 
> /* async io */
> typedef void *rados_completion_t;
> typedef void (*rados_callback_t)(rados_completion_t cb, void *arg);
> 
> int rados_aio_create_completion(void *cb_arg, rados_callback_t
> cb_complete, rados_callback_t cb_safe,
> 				rados_completion_t *pc);
> int rados_aio_wait_for_complete(rados_completion_t c);
> int rados_aio_wait_for_safe(rados_completion_t c);
> int rados_aio_is_complete(rados_completion_t c);
> int rados_aio_is_safe(rados_completion_t c);
> int rados_aio_get_return_value(rados_completion_t c);
> uint64_t rados_aio_get_obj_ver(rados_completion_t c);
> void rados_aio_release(rados_completion_t c);
> int rados_aio_write(rados_pool_t pool, const char *oid,
> 		    off_t off, const char *buf, size_t len,
> 		    rados_completion_t completion);
> int rados_aio_write_full(rados_pool_t pool, const char *oid,
> 			 off_t off, const char *buf, size_t len,
> 			 rados_completion_t completion);
> int rados_aio_read(rados_pool_t pool, const char *oid,
> 		   off_t off, char *buf, size_t len,
> 		   rados_completion_t completion);
> 
> /* watch/notify */
> typedef void (*rados_watchcb_t)(uint8_t opcode, uint64_t ver, void *arg);
> int rados_watch(rados_pool_t pool, const char *o, uint64_t ver,
> uint64_t *handle,
>                 rados_watchcb_t watchcb, void *arg);
> int rados_unwatch(rados_pool_t pool, const char *o, uint64_t handle);
> int rados_notify(rados_pool_t pool, const char *o, uint64_t ver);
> 
> #ifdef __cplusplus
> }
> #endif
> 
> #endif
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

