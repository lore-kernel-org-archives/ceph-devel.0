From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH]  fs/ceph: make logical calculation functions return bool
Date: Fri, 25 Mar 2016 16:31:48 +0800
Message-ID: <7341F3B8-5F38-4D4C-A373-8DDD6472FC23@redhat.com>
References: <1458886795-10694-1-git-send-email-zhangzhuoyu@cmss.chinamobile.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35892 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568AbcCYIb5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Mar 2016 04:31:57 -0400
In-Reply-To: <1458886795-10694-1-git-send-email-zhangzhuoyu@cmss.chinamobile.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, idryomov@gmail.com, linux-kernel@vger.kernel.org


> On Mar 25, 2016, at 14:19, Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile=
=2Ecom> wrote:
>=20
> This patch makes serverl logical caculation functions return bool to
> improve readability due to these particular functions only using 0/1 =
as
> their return value.
>=20
> No functional change.
>=20
> Signed-off-by: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>
> ---
> fs/ceph/cache.c                |  2 +-
> fs/ceph/dir.c                  |  2 +-
> fs/ceph/super.h                |  2 +-
> include/linux/ceph/ceph_frag.h | 12 ++++++------
> include/linux/ceph/decode.h    |  2 +-
> include/linux/ceph/osdmap.h    |  6 +++---
> include/linux/ceph/rados.h     | 16 ++++++++--------
> net/ceph/ceph_common.c         |  2 +-
> 8 files changed, 22 insertions(+), 22 deletions(-)
>=20
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index 834f9f3..1f3a3f6 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -238,7 +238,7 @@ static void ceph_vfs_readpage_complete_unlock(str=
uct page *page, void *data, int
> 	unlock_page(page);
> }
>=20
> -static inline int cache_valid(struct ceph_inode_info *ci)
> +static inline bool cache_valid(struct ceph_inode_info *ci)
> {
> 	return ((ceph_caps_issued(ci) & CEPH_CAP_FILE_CACHE) &&
> 		(ci->i_fscache_gen =3D=3D ci->i_rdcache_gen));
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 26be849..7eed41e 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -584,7 +584,7 @@ struct dentry *ceph_finish_lookup(struct ceph_mds=
_request *req,
> 	return dentry;
> }
>=20
> -static int is_root_ceph_dentry(struct inode *inode, struct dentry *d=
entry)
> +static bool is_root_ceph_dentry(struct inode *inode, struct dentry *=
dentry)
> {
> 	return ceph_ino(inode) =3D=3D CEPH_INO_ROOT &&
> 		strncmp(dentry->d_name.name, ".ceph", 5) =3D=3D 0;
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index b82f507..db88fef 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -415,7 +415,7 @@ static inline u64 ceph_snap(struct inode *inode)
> 	return ceph_inode(inode)->i_vino.snap;
> }
>=20
> -static inline int ceph_ino_compare(struct inode *inode, void *data)
> +static inline bool ceph_ino_compare(struct inode *inode, void *data)

This one is for ilookup5.  ilookup5() wants function pointer "int (*tes=
t)(struct inode *, void *)=E2=80=9D.  The rest change looks good.

Regards
Yan, Zheng


> {
> 	struct ceph_vino *pvino =3D (struct ceph_vino *)data;
> 	struct ceph_inode_info *ci =3D ceph_inode(inode);
> diff --git a/include/linux/ceph/ceph_frag.h b/include/linux/ceph/ceph=
_frag.h
> index 5babb8e..44e6067 100644
> --- a/include/linux/ceph/ceph_frag.h
> +++ b/include/linux/ceph/ceph_frag.h
> @@ -40,11 +40,11 @@ static inline __u32 ceph_frag_mask_shift(__u32 f)
> 	return 24 - ceph_frag_bits(f);
> }
>=20
> -static inline int ceph_frag_contains_value(__u32 f, __u32 v)
> +static inline bool ceph_frag_contains_value(__u32 f, __u32 v)
> {
> 	return (v & ceph_frag_mask(f)) =3D=3D ceph_frag_value(f);
> }
> -static inline int ceph_frag_contains_frag(__u32 f, __u32 sub)
> +static inline bool ceph_frag_contains_frag(__u32 f, __u32 sub)
> {
> 	/* is sub as specific as us, and contained by us? */
> 	return ceph_frag_bits(sub) >=3D ceph_frag_bits(f) &&
> @@ -56,12 +56,12 @@ static inline __u32 ceph_frag_parent(__u32 f)
> 	return ceph_frag_make(ceph_frag_bits(f) - 1,
> 			 ceph_frag_value(f) & (ceph_frag_mask(f) << 1));
> }
> -static inline int ceph_frag_is_left_child(__u32 f)
> +static inline bool ceph_frag_is_left_child(__u32 f)
> {
> 	return ceph_frag_bits(f) > 0 &&
> 		(ceph_frag_value(f) & (0x1000000 >> ceph_frag_bits(f))) =3D=3D 0;
> }
> -static inline int ceph_frag_is_right_child(__u32 f)
> +static inline bool ceph_frag_is_right_child(__u32 f)
> {
> 	return ceph_frag_bits(f) > 0 &&
> 		(ceph_frag_value(f) & (0x1000000 >> ceph_frag_bits(f))) =3D=3D 1;
> @@ -86,11 +86,11 @@ static inline __u32 ceph_frag_make_child(__u32 f,=
 int by, int i)
> 	return ceph_frag_make(newbits,
> 			 ceph_frag_value(f) | (i << (24 - newbits)));
> }
> -static inline int ceph_frag_is_leftmost(__u32 f)
> +static inline bool ceph_frag_is_leftmost(__u32 f)
> {
> 	return ceph_frag_value(f) =3D=3D 0;
> }
> -static inline int ceph_frag_is_rightmost(__u32 f)
> +static inline bool ceph_frag_is_rightmost(__u32 f)
> {
> 	return ceph_frag_value(f) =3D=3D ceph_frag_mask(f);
> }
> diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.=
h
> index a6ef9cc..19e9932 100644
> --- a/include/linux/ceph/decode.h
> +++ b/include/linux/ceph/decode.h
> @@ -47,7 +47,7 @@ static inline void ceph_decode_copy(void **p, void =
*pv, size_t n)
> /*
>  * bounds check input.
>  */
> -static inline int ceph_has_room(void **p, void *end, size_t n)
> +static inline bool ceph_has_room(void **p, void *end, size_t n)
> {
> 	return end >=3D *p && n <=3D end - *p;
> }
> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.=
h
> index 561ea89..bbf66b7 100644
> --- a/include/linux/ceph/osdmap.h
> +++ b/include/linux/ceph/osdmap.h
> @@ -137,19 +137,19 @@ static inline void ceph_oid_copy(struct ceph_ob=
ject_id *dest,
> 	dest->name_len =3D src->name_len;
> }
>=20
> -static inline int ceph_osd_exists(struct ceph_osdmap *map, int osd)
> +static inline bool ceph_osd_exists(struct ceph_osdmap *map, int osd)
> {
> 	return osd >=3D 0 && osd < map->max_osd &&
> 	       (map->osd_state[osd] & CEPH_OSD_EXISTS);
> }
>=20
> -static inline int ceph_osd_is_up(struct ceph_osdmap *map, int osd)
> +static inline bool ceph_osd_is_up(struct ceph_osdmap *map, int osd)
> {
> 	return ceph_osd_exists(map, osd) &&
> 	       (map->osd_state[osd] & CEPH_OSD_UP);
> }
>=20
> -static inline int ceph_osd_is_down(struct ceph_osdmap *map, int osd)
> +static inline bool ceph_osd_is_down(struct ceph_osdmap *map, int osd=
)
> {
> 	return !ceph_osd_is_up(map, osd);
> }
> diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
> index 2f822dc..d6d4852 100644
> --- a/include/linux/ceph/rados.h
> +++ b/include/linux/ceph/rados.h
> @@ -313,36 +313,36 @@ __CEPH_FORALL_OSD_OPS(GENERATE_ENUM_ENTRY)
> #undef GENERATE_ENUM_ENTRY
> };
>=20
> -static inline int ceph_osd_op_type_lock(int op)
> +static inline bool ceph_osd_op_type_lock(int op)
> {
> 	return (op & CEPH_OSD_OP_TYPE) =3D=3D CEPH_OSD_OP_TYPE_LOCK;
> }
> -static inline int ceph_osd_op_type_data(int op)
> +static inline bool ceph_osd_op_type_data(int op)
> {
> 	return (op & CEPH_OSD_OP_TYPE) =3D=3D CEPH_OSD_OP_TYPE_DATA;
> }
> -static inline int ceph_osd_op_type_attr(int op)
> +static inline bool ceph_osd_op_type_attr(int op)
> {
> 	return (op & CEPH_OSD_OP_TYPE) =3D=3D CEPH_OSD_OP_TYPE_ATTR;
> }
> -static inline int ceph_osd_op_type_exec(int op)
> +static inline bool ceph_osd_op_type_exec(int op)
> {
> 	return (op & CEPH_OSD_OP_TYPE) =3D=3D CEPH_OSD_OP_TYPE_EXEC;
> }
> -static inline int ceph_osd_op_type_pg(int op)
> +static inline bool ceph_osd_op_type_pg(int op)
> {
> 	return (op & CEPH_OSD_OP_TYPE) =3D=3D CEPH_OSD_OP_TYPE_PG;
> }
> -static inline int ceph_osd_op_type_multi(int op)
> +static inline bool ceph_osd_op_type_multi(int op)
> {
> 	return (op & CEPH_OSD_OP_TYPE) =3D=3D CEPH_OSD_OP_TYPE_MULTI;
> }
>=20
> -static inline int ceph_osd_op_mode_subop(int op)
> +static inline bool ceph_osd_op_mode_subop(int op)
> {
> 	return (op & CEPH_OSD_OP_MODE) =3D=3D CEPH_OSD_OP_MODE_SUB;
> }
> -static inline int ceph_osd_op_mode_read(int op)
> +static inline bool ceph_osd_op_mode_read(int op)
> {
> 	return (op & CEPH_OSD_OP_MODE_RD) &&
> 		op !=3D CEPH_OSD_OP_CALL;
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 58fbfe1..81733c0 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -559,7 +559,7 @@ EXPORT_SYMBOL(ceph_destroy_client);
> /*
>  * true if we have the mon map (and have thus joined the cluster)
>  */
> -static int have_mon_and_osd_map(struct ceph_client *client)
> +static bool have_mon_and_osd_map(struct ceph_client *client)
> {
> 	return client->monc.monmap && client->monc.monmap->epoch &&
> 	       client->osdc.osdmap && client->osdc.osdmap->epoch;
> --=20
> 1.8.3.1
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
