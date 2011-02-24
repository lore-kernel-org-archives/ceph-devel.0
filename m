From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: proposed C API for librados
Date: Wed, 23 Feb 2011 22:57:30 -0800
Message-ID: <AANLkTikhrQkwMaEf_4495KZn22QrQ7u4hxVo8Mn4tx1R@mail.gmail.com>
References: <AANLkTi=qvZjPOHkZbPem0TPjovGiqNo7Arq=q2YqEWDS@mail.gmail.com>
	<4D65FCD6.1070100@ormod.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47530 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932547Ab1BXG5c convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 01:57:32 -0500
Received: by bwz15 with SMTP id 15so768592bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Feb 2011 22:57:30 -0800 (PST)
In-Reply-To: <4D65FCD6.1070100@ormod.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannu Valtonen <me@ormod.com>
Cc: ceph-devel@vger.kernel.org

Yeah, should add something like that. Maybe something like this:

int rados_pool_list(rados_t cluster, char ***pools)
void rados_pool_list_free(char **pools)

Also should rename
rados_snap_set_read -> rados_snap_set_read_context for consistency.

Colin


On Wed, Feb 23, 2011 at 10:38 PM, Hannu Valtonen <me@ormod.com> wrote:
> On 2/24/11 8:09 AM, Colin McCabe wrote:
> Hi,
>
> If you're having a stab at this, could you please add a librados C ap=
i for
> listing of pools at the same time. (it's available on the C++ side bu=
t would
> be great to have on the C side for Python bindings)
>
>
>> Hi all,
>>
>> We're trying to finalize the API for librados for the 0.25 release.
>> This is the C API we're looking at.
>>
>> cheers,
>> Colin
>>
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> #ifndef CEPH_LIBRADOS_H
>> #define CEPH_LIBRADOS_H
>>
>> #ifdef __cplusplus
>> extern "C" {
>> #endif
>>
>> #include<netinet/in.h>
>> #include<linux/types.h>
>> #include<string.h>
>>
>> #ifndef CEPH_OSD_TMAP_SET
>> #define CEPH_OSD_TMAP_HDR 'h'
>> #define CEPH_OSD_TMAP_SET 's'
>> #define CEPH_OSD_TMAP_RM =A0'r'
>> #endif
>>
>> #define LIBRADOS_VER_MAJOR 0
>> #define LIBRADOS_VER_MINOR 25
>> #define LIBRADOS_VER_EXTRA 0
>>
>> #define LIBRADOS_VERSION(maj, min, extra) ((maj<< =A016) + (min<< =A0=
8) +
>> extra)
>>
>> #define LIBRADOS_VERSION_CODE LIBRADOS_VERSION(LIBRADOS_VER_MAJOR,
>> LIBRADOS_VER_MINOR, LIBRADOS_VER_EXTRA)
>>
>> #define LIBRADOS_SUPPORTS_WATCH 1
>>
>> typedef void *rados_t;
>> typedef void *rados_pool_t;
>> typedef void *rados_list_ctx_t;
>> typedef uint64_t rados_snap_t;
>>
>> struct rados_pool_stat_t {
>> =A0 uint64_t num_bytes; =A0 =A0// in bytes
>> =A0 uint64_t num_kb; =A0 =A0 =A0 // in KB
>> =A0 uint64_t num_objects;
>> =A0 uint64_t num_object_clones;
>> =A0 uint64_t num_object_copies; =A0// num_objects * num_replicas
>> =A0 uint64_t num_objects_missing_on_primary;
>> =A0 uint64_t num_objects_unfound;
>> =A0 uint64_t num_objects_degraded;
>> =A0 uint64_t num_rd, num_rd_kb,num_wr, num_wr_kb;
>> };
>>
>> struct rados_statfs_t {
>> =A0 uint64_t kb, kb_used, kb_avail;
>> =A0 uint64_t num_objects;
>> };
>>
>>
>> void rados_version(int *major, int *minor, int *extra);
>>
>> /* initialization */
>> int rados_create(rados_t *cluster, const char * const id);
>>
>> /* Connect to the cluster */
>> int rados_connect(rados_t cluster);
>>
>> /* destroy the cluster instance */
>> void rados_destroy(rados_t cluster);
>>
>> /* Config
>> =A0*
>> =A0* Functions for manipulating the Ceph configuration at runtime.
>> =A0* After changing the Ceph configuration, you should call rados_co=
nf_apply
>> to
>> =A0* ensure that the changes have been applied.
>> =A0*/
>> int rados_conf_read_file(rados_t cluster, const char *path);
>>
>> /* Sets a configuration value from a string.
>> =A0* Returns 0 on success, error code otherwise. */
>> int rados_conf_set(rados_t cluster, const char *option, const char
>> *value);
>>
>> /* Reopens the log file.
>> =A0* You must do this after changing the logging configuration.
>> =A0* It is also good practice to call this from your SIGHUP signal
>> handler, so that users can send you
>> =A0* a SIGHUP to reopen the log.
>> =A0*/
>> void rados_reopen_log(rados_t cluster);
>>
>> /* Returns a configuration value as a string.
>> =A0* If len is positive, that is the maximum number of bytes we'll w=
rite
>> into the
>> =A0* buffer. If len =3D=3D -1, we'll call malloc() and set *buf.
>> =A0* Returns 0 on success, error code otherwise. Returns ENAMETOOLON=
G if the
>> =A0* buffer is too short. */
>> int rados_conf_get(rados_t cluster, const char *option, char *buf, i=
nt
>> len);
>> int rados_conf_get_alloc(rados_t cluster, const char *option, char *=
*buf);
>>
>> /* pools */
>> int rados_pool_open(rados_t cluster, const char *name, rados_pool_t
>> *pool);
>> int rados_pool_close(rados_pool_t pool);
>> int rados_pool_lookup(rados_t cluster, const char *name);
>>
>> int rados_pool_stat(rados_pool_t pool, struct rados_pool_stat_t *sta=
ts);
>>
>> void rados_snap_set_read(rados_pool_t pool, rados_snap_t snap);
>> int rados_snap_set_write_context(rados_pool_t pool, rados_snap_t seq=
,
>> rados_snap_t *snaps, int num_snaps);
>>
>> int rados_pool_create(rados_t cluster, const char *name);
>> int rados_pool_create_with_auid(rados_t cluster, const char *name,
>> uint64_t auid);
>> int rados_pool_create_with_crush_rule(rados_t cluster, const char
>> *name, __u8 crush_rule);
>> int rados_pool_create_with_all(rados_t cluster, const char *name, ui=
nt64_t
>> auid,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __u8 cru=
sh_rule);
>> int rados_pool_delete(rados_pool_t pool);
>> int rados_pool_set_auid(rados_pool_t pool, uint64_t auid);
>>
>> /* objects */
>> int rados_objects_list_open(rados_pool_t pool, rados_list_ctx_t *ctx=
);
>> int rados_objects_list_next(rados_list_ctx_t ctx, const char **entry=
);
>> void rados_objects_list_close(rados_list_ctx_t ctx);
>>
>>
>> /* snapshots */
>> int rados_pool_snap_create(rados_pool_t pool, const char *snapname);
>> int rados_pool_snap_remove(rados_pool_t pool, const char *snapname);
>> int rados_pool_snap_rollback_object(rados_pool_t pool, const char *o=
id,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *snapn=
ame);
>> int rados_pool_selfmanaged_snap_create(rados_pool_t pool, uint64_t
>> *snapid);
>> int rados_pool_selfmanaged_snap_remove(rados_pool_t pool, uint64_t
>> snapid);
>> int rados_pool_snap_list(rados_pool_t pool, rados_snap_t *snaps, int
>> maxlen);
>> int rados_pool_snap_lookup(rados_pool_t pool, const char *name,
>> rados_snap_t *id);
>> int rados_pool_snap_get_name(rados_pool_t pool, rados_snap_t id, cha=
r
>> *name, int maxlen);
>>
>> /* sync io */
>> uint64_t rados_get_last_version(rados_pool_t pool);
>>
>> int rados_write(rados_pool_t pool, const char *oid, off_t off, const
>> char *buf, size_t len);
>> int rados_write_full(rados_pool_t pool, const char *oid, off_t off,
>> const char *buf, size_t len);
>> int rados_read(rados_pool_t pool, const char *oid, off_t off, char
>> *buf, size_t len);
>> int rados_remove(rados_pool_t pool, const char *oid);
>> int rados_trunc(rados_pool_t pool, const char *oid, size_t size);
>>
>> /* attrs */
>> int rados_getxattr(rados_pool_t pool, const char *o, const char *nam=
e,
>> char *buf, size_t len);
>> int rados_setxattr(rados_pool_t pool, const char *o, const char *nam=
e,
>> const char *buf, size_t len);
>> int rados_rmxattr(rados_pool_t pool, const char *o, const char *name=
);
>>
>> /* misc */
>> int rados_stat(rados_pool_t pool, const char *o, uint64_t *psize,
>> time_t *pmtime);
>> int rados_tmap_update(rados_pool_t pool, const char *o, const char
>> *cmdbuf, size_t cmdbuflen);
>> int rados_exec(rados_pool_t pool, const char *oid, const char *cls,
>> const char *method,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *in_buf, size_t in_len, char =
*buf, size_t
>> out_len);
>>
>> /* async io */
>> typedef void *rados_completion_t;
>> typedef void (*rados_callback_t)(rados_completion_t cb, void *arg);
>>
>> int rados_aio_create_completion(void *cb_arg, rados_callback_t
>> cb_complete, rados_callback_t cb_safe,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rados=
_completion_t *pc);
>> int rados_aio_wait_for_complete(rados_completion_t c);
>> int rados_aio_wait_for_safe(rados_completion_t c);
>> int rados_aio_is_complete(rados_completion_t c);
>> int rados_aio_is_safe(rados_completion_t c);
>> int rados_aio_get_return_value(rados_completion_t c);
>> uint64_t rados_aio_get_obj_ver(rados_completion_t c);
>> void rados_aio_release(rados_completion_t c);
>> int rados_aio_write(rados_pool_t pool, const char *oid,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0off_t off, const char *buf, s=
ize_t len,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rados_completion_t completion=
);
>> int rados_aio_write_full(rados_pool_t pool, const char *oid,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 off_t off, const cha=
r *buf, size_t len,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rados_completion_t c=
ompletion);
>> int rados_aio_read(rados_pool_t pool, const char *oid,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 off_t off, char *buf, size_t len=
,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rados_completion_t completion);
>>
>> /* watch/notify */
>> typedef void (*rados_watchcb_t)(uint8_t opcode, uint64_t ver, void *=
arg);
>> int rados_watch(rados_pool_t pool, const char *o, uint64_t ver,
>> uint64_t *handle,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rados_watchcb_t watchcb, void *arg);
>> int rados_unwatch(rados_pool_t pool, const char *o, uint64_t handle)=
;
>> int rados_notify(rados_pool_t pool, const char *o, uint64_t ver);
>>
>> #ifdef __cplusplus
>> }
>> #endif
>>
>> #endif
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
