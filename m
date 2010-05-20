From: Blue Swirl <blauwirbel@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Thu, 20 May 2010 20:31:49 +0000
Message-ID: <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>
References: <20100519192222.GD61706@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20100519192222.GD61706@ncolin.muc.de>
Sender: kvm-owner@vger.kernel.org
To: Christian Brunner <chb@muc.de>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, May 19, 2010 at 7:22 PM, Christian Brunner <chb@muc.de> wrote:
> The attached patch is a block driver for the distributed file system
> Ceph (http://ceph.newdream.net/). This driver uses librados (which
> is part of the Ceph server) for direct access to the Ceph object
> store and is running entirely in userspace. Therefore it is
> called "rbd" - rados block device.
>
> To compile the driver a recent version of ceph (>=3D 0.20.1) is neede=
d
> and you have to "--enable-rbd" when running configure.
>
> Additional information is available on the Ceph-Wiki:
>
> http://ceph.newdream.net/wiki/Kvm-rbd


I have no idea whether it makes sense to add Ceph (no objection
either). I have some minor comments below.

>
> ---
> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A03 +
> =C2=A0Makefile.objs =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0block/rados.h =C2=A0 =C2=A0 | =C2=A0376 +++++++++++++++++++++++=
+++++++++++
> =C2=A0block/rbd.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0585 ++++++++++++++++++=
+++++++++++++++++++++++++++++++++++
> =C2=A0block/rbd_types.h | =C2=A0 48 +++++
> =C2=A0configure =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 27 +++
> =C2=A06 files changed, 1040 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 block/rados.h
> =C2=A0create mode 100644 block/rbd.c
> =C2=A0create mode 100644 block/rbd_types.h
>
> diff --git a/Makefile b/Makefile
> index eb9e02b..b1ab3e9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -27,6 +27,9 @@ configure: ;
> =C2=A0$(call set-vpath, $(SRC_PATH):$(SRC_PATH)/hw)
>
> =C2=A0LIBS+=3D-lz $(LIBS_TOOLS)
> +ifdef CONFIG_RBD
> +LIBS+=3D-lrados
> +endif
>
> =C2=A0ifdef BUILD_DOCS
> =C2=A0DOCS=3Dqemu-doc.html qemu-tech.html qemu.1 qemu-img.1 qemu-nbd.=
8
> diff --git a/Makefile.objs b/Makefile.objs
> index acbaf22..85791ac 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -18,6 +18,7 @@ block-nested-y +=3D parallels.o nbd.o blkdebug.o
> =C2=A0block-nested-$(CONFIG_WIN32) +=3D raw-win32.o
> =C2=A0block-nested-$(CONFIG_POSIX) +=3D raw-posix.o
> =C2=A0block-nested-$(CONFIG_CURL) +=3D curl.o
> +block-nested-$(CONFIG_RBD) +=3D rbd.o
>
> =C2=A0block-obj-y +=3D =C2=A0$(addprefix block/, $(block-nested-y))
>
> diff --git a/block/rados.h b/block/rados.h
> new file mode 100644
> index 0000000..6cde9a1
> --- /dev/null
> +++ b/block/rados.h
> @@ -0,0 +1,376 @@
> +#ifndef __RADOS_H
> +#define __RADOS_H

IIRC underscores here may conflict with system header use. Please use
something like QEMU_BLOCK_RADOS_H.

> +
> +/*
> + * Data types for the Ceph distributed object storage layer RADOS
> + * (Reliable Autonomic Distributed Object Store).
> + */
> +
> +
> +
> +/*
> + * osdmap encoding versions
> + */
> +#define CEPH_OSDMAP_INC_VERSION =C2=A0 =C2=A0 5
> +#define CEPH_OSDMAP_INC_VERSION_EXT 5
> +#define CEPH_OSDMAP_VERSION =C2=A0 =C2=A0 =C2=A0 =C2=A0 5
> +#define CEPH_OSDMAP_VERSION_EXT =C2=A0 =C2=A0 5
> +
> +/*
> + * fs id
> + */
> +struct ceph_fsid {
> + =C2=A0 =C2=A0 =C2=A0 unsigned char fsid[16];

Too large indent, please check also elsewhere.

> +};
> +
> +static inline int ceph_fsid_compare(const struct ceph_fsid *a,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct ceph_fsi=
d *b)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return memcmp(a, b, sizeof(*a));
> +}
> +
> +/*
> + * ino, object, etc.
> + */
> +typedef __le64 ceph_snapid_t;

Please use uint64_t and le_to_cpu()/cpu_to_le().

> +#define CEPH_SNAPDIR ((__u64)(-1)) =C2=A0/* reserved for hidden .sna=
p dir */

Likewise, uint64_t is the standard type. Also other places.

> +#define CEPH_NOSNAP =C2=A0((__u64)(-2)) =C2=A0/* "head", "live" revi=
sion */
> +#define CEPH_MAXSNAP ((__u64)(-3)) =C2=A0/* largest valid snapid */
> +
> +struct ceph_timespec {
> + =C2=A0 =C2=A0 =C2=A0 __le32 tv_sec;
> + =C2=A0 =C2=A0 =C2=A0 __le32 tv_nsec;
> +} __attribute__ ((packed));
> +
> +
> +/*
> + * object layout - how objects are mapped into PGs
> + */
> +#define CEPH_OBJECT_LAYOUT_HASH =C2=A0 =C2=A0 1
> +#define CEPH_OBJECT_LAYOUT_LINEAR =C2=A0 2
> +#define CEPH_OBJECT_LAYOUT_HASHINO =C2=A03
> +
> +/*
> + * pg layout -- how PGs are mapped onto (sets of) OSDs
> + */
> +#define CEPH_PG_LAYOUT_CRUSH =C2=A00
> +#define CEPH_PG_LAYOUT_HASH =C2=A0 1
> +#define CEPH_PG_LAYOUT_LINEAR 2
> +#define CEPH_PG_LAYOUT_HYBRID 3
> +
> +
> +/*
> + * placement group.
> + * we encode this into one __le64.
> + */
> +struct ceph_pg {
> + =C2=A0 =C2=A0 =C2=A0 __le16 preferred; /* preferred primary osd */
> + =C2=A0 =C2=A0 =C2=A0 __le16 ps; =C2=A0 =C2=A0 =C2=A0 =C2=A0/* place=
ment seed */
> + =C2=A0 =C2=A0 =C2=A0 __le32 pool; =C2=A0 =C2=A0 =C2=A0/* object poo=
l */
> +} __attribute__ ((packed));
> +
> +/*
> + * pg_pool is a set of pgs storing a pool of objects
> + *
> + * =C2=A0pg_num -- base number of pseudorandomly placed pgs
> + *
> + * =C2=A0pgp_num -- effective number when calculating pg placement. =
=C2=A0this
> + * is used for pg_num increases. =C2=A0new pgs result in data being =
"split"
> + * into new pgs. =C2=A0for this to proceed smoothly, new pgs are int=
iially
> + * colocated with their parents; that is, pgp_num doesn't increase
> + * until the new pgs have successfully split. =C2=A0only _then_ are =
the new
> + * pgs placed independently.
> + *
> + * =C2=A0lpg_num -- localized pg count (per device). =C2=A0replicas =
are randomly
> + * selected.
> + *
> + * =C2=A0lpgp_num -- as above.
> + */
> +#define CEPH_PG_TYPE_REP =C2=A0 =C2=A0 1
> +#define CEPH_PG_TYPE_RAID4 =C2=A0 2
> +#define CEPH_PG_POOL_VERSION 2
> +struct ceph_pg_pool {
> + =C2=A0 =C2=A0 =C2=A0 __u8 type; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* CEPH_PG_TYPE_* */
> + =C2=A0 =C2=A0 =C2=A0 __u8 size; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* number of osds in each pg */
> + =C2=A0 =C2=A0 =C2=A0 __u8 crush_ruleset; =C2=A0 =C2=A0 =C2=A0 /* cr=
ush placement rule */
> + =C2=A0 =C2=A0 =C2=A0 __u8 object_hash; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* hash mapping object name to ps */
> + =C2=A0 =C2=A0 =C2=A0 __le32 pg_num, pgp_num; =C2=A0 /* number of pg=
's */
> + =C2=A0 =C2=A0 =C2=A0 __le32 lpg_num, lpgp_num; /* number of localiz=
ed pg's */
> + =C2=A0 =C2=A0 =C2=A0 __le32 last_change; =C2=A0 =C2=A0 =C2=A0 /* mo=
st recent epoch changed */

Is the intent here that one uint32_t is implicitly added for padding
or is the structure really unaligned? I'd make the padding explicit to
be sure.

> + =C2=A0 =C2=A0 =C2=A0 __le64 snap_seq; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* seq for per-pool snapshot */
> + =C2=A0 =C2=A0 =C2=A0 __le32 snap_epoch; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* epoch of last snap */
> + =C2=A0 =C2=A0 =C2=A0 __le32 num_snaps;
> + =C2=A0 =C2=A0 =C2=A0 __le32 num_removed_snap_intervals; /* if non-e=
mpty, NO per-pool snaps */

Unaligned?

> + =C2=A0 =C2=A0 =C2=A0 __le64 auid; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 /* who owns the pg */
> +} __attribute__ ((packed));
> +
> +/*
> + * stable_mod func is used to control number of placement groups.
> + * similar to straight-up modulo, but produces a stable mapping as b
> + * increases over time. =C2=A0b is the number of bins, and bmask is =
the
> + * containing power of 2 minus 1.
> + *
> + * b <=3D bmask and bmask=3D(2**n)-1
> + * e.g., b=3D12 -> bmask=3D15, b=3D123 -> bmask=3D127
> + */
> +static inline int ceph_stable_mod(int x, int b, int bmask)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if ((x & bmask) < b)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return x & bmask;
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return x & (bmask =
>> 1);

Please check CODING_STYLE for brace use.

> +}
> +
> +/*
> + * object layout - how a given object should be stored.
> + */
> +struct ceph_object_layout {
> + =C2=A0 =C2=A0 =C2=A0 struct ceph_pg ol_pgid; =C2=A0 /* raw pg, with=
 _full_ ps precision. */
> + =C2=A0 =C2=A0 =C2=A0 __le32 ol_stripe_unit; =C2=A0 =C2=A0/* for per=
-object parity, if any */
> +} __attribute__ ((packed));
> +
> +/*
> + * compound epoch+version, used by storage layer to serialize mutati=
ons
> + */
> +struct ceph_eversion {
> + =C2=A0 =C2=A0 =C2=A0 __le32 epoch;

Unaligned?

> + =C2=A0 =C2=A0 =C2=A0 __le64 version;
> +} __attribute__ ((packed));
> +
> +/*
> + * osd map bits
> + */
> +
> +/* status bits */
> +#define CEPH_OSD_EXISTS 1
> +#define CEPH_OSD_UP =C2=A0 =C2=A0 2
> +
> +/* osd weights. =C2=A0fixed point value: 0x10000 =3D=3D 1.0 ("in"), =
0 =3D=3D "out" */
> +#define CEPH_OSD_IN =C2=A00x10000
> +#define CEPH_OSD_OUT 0
> +
> +
> +/*
> + * osd map flag bits
> + */
> +#define CEPH_OSDMAP_NEARFULL (1<<0) =C2=A0/* sync writes (near ENOSP=
C) */
> +#define CEPH_OSDMAP_FULL =C2=A0 =C2=A0 (1<<1) =C2=A0/* no data write=
s (ENOSPC) */
> +#define CEPH_OSDMAP_PAUSERD =C2=A0(1<<2) =C2=A0/* pause all reads */
> +#define CEPH_OSDMAP_PAUSEWR =C2=A0(1<<3) =C2=A0/* pause all writes *=
/
> +#define CEPH_OSDMAP_PAUSEREC (1<<4) =C2=A0/* pause recovery */
> +
> +/*
> + * osd ops
> + */
> +#define CEPH_OSD_OP_MODE =C2=A0 =C2=A0 =C2=A0 0xf000
> +#define CEPH_OSD_OP_MODE_RD =C2=A0 =C2=A00x1000
> +#define CEPH_OSD_OP_MODE_WR =C2=A0 =C2=A00x2000
> +#define CEPH_OSD_OP_MODE_RMW =C2=A0 0x3000
> +#define CEPH_OSD_OP_MODE_SUB =C2=A0 0x4000
> +
> +#define CEPH_OSD_OP_TYPE =C2=A0 =C2=A0 =C2=A0 0x0f00
> +#define CEPH_OSD_OP_TYPE_LOCK =C2=A00x0100
> +#define CEPH_OSD_OP_TYPE_DATA =C2=A00x0200
> +#define CEPH_OSD_OP_TYPE_ATTR =C2=A00x0300
> +#define CEPH_OSD_OP_TYPE_EXEC =C2=A00x0400
> +#define CEPH_OSD_OP_TYPE_PG =C2=A0 =C2=A00x0500
> +
> +enum {
> + =C2=A0 =C2=A0 =C2=A0 /** data **/
> + =C2=A0 =C2=A0 =C2=A0 /* read */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_READ =C2=A0 =C2=A0 =C2=A0=3D CEPH_=
OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 1,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_STAT =C2=A0 =C2=A0 =C2=A0=3D CEPH_=
OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_DATA | 2,
> +
> + =C2=A0 =C2=A0 =C2=A0 /* fancy read */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_MASKTRUNC =3D CEPH_OSD_OP_MODE_RD =
| CEPH_OSD_OP_TYPE_DATA | 4,
> +
> + =C2=A0 =C2=A0 =C2=A0 /* write */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_WRITE =C2=A0 =C2=A0 =3D CEPH_OSD_O=
P_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 1,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_WRITEFULL =3D CEPH_OSD_OP_MODE_WR =
| CEPH_OSD_OP_TYPE_DATA | 2,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_TRUNCATE =C2=A0=3D CEPH_OSD_OP_MOD=
E_WR | CEPH_OSD_OP_TYPE_DATA | 3,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_ZERO =C2=A0 =C2=A0 =C2=A0=3D CEPH_=
OSD_OP_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 4,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_DELETE =C2=A0 =C2=A0=3D CEPH_OSD_O=
P_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 5,
> +
> + =C2=A0 =C2=A0 =C2=A0 /* fancy write */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_APPEND =C2=A0 =C2=A0=3D CEPH_OSD_O=
P_MODE_WR | CEPH_OSD_OP_TYPE_DATA | 6,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_STARTSYNC =3D CEPH_OSD_OP_MODE_WR =
| CEPH_OSD_OP_TYPE_DATA | 7,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_SETTRUNC =C2=A0=3D CEPH_OSD_OP_MOD=
E_WR | CEPH_OSD_OP_TYPE_DATA | 8,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_TRIMTRUNC =3D CEPH_OSD_OP_MODE_WR =
| CEPH_OSD_OP_TYPE_DATA | 9,
> +
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_TMAPUP =C2=A0=3D CEPH_OSD_OP_MODE_=
RMW | CEPH_OSD_OP_TYPE_DATA | 10,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_TMAPPUT =3D CEPH_OSD_OP_MODE_WR | =
CEPH_OSD_OP_TYPE_DATA | 11,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_TMAPGET =3D CEPH_OSD_OP_MODE_RD | =
CEPH_OSD_OP_TYPE_DATA | 12,
> +
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_CREATE =C2=A0=3D CEPH_OSD_OP_MODE_=
WR | CEPH_OSD_OP_TYPE_DATA | 13,
> +
> + =C2=A0 =C2=A0 =C2=A0 /** attrs **/
> + =C2=A0 =C2=A0 =C2=A0 /* read */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_GETXATTR =C2=A0=3D CEPH_OSD_OP_MOD=
E_RD | CEPH_OSD_OP_TYPE_ATTR | 1,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_GETXATTRS =3D CEPH_OSD_OP_MODE_RD =
| CEPH_OSD_OP_TYPE_ATTR | 2,
> +
> + =C2=A0 =C2=A0 =C2=A0 /* write */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_SETXATTR =C2=A0=3D CEPH_OSD_OP_MOD=
E_WR | CEPH_OSD_OP_TYPE_ATTR | 1,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_SETXATTRS =3D CEPH_OSD_OP_MODE_WR =
| CEPH_OSD_OP_TYPE_ATTR | 2,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_RESETXATTRS =3D CEPH_OSD_OP_MODE_W=
R|CEPH_OSD_OP_TYPE_ATTR | 3,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_RMXATTR =C2=A0 =3D CEPH_OSD_OP_MOD=
E_WR | CEPH_OSD_OP_TYPE_ATTR | 4,
> +
> + =C2=A0 =C2=A0 =C2=A0 /** subop **/
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_PULL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D CEPH_OSD_OP_MODE_SUB | 1,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_PUSH =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D CEPH_OSD_OP_MODE_SUB | 2,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_BALANCEREADS =C2=A0 =3D CEPH_OSD_O=
P_MODE_SUB | 3,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_UNBALANCEREADS =3D CEPH_OSD_OP_MOD=
E_SUB | 4,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_SCRUB =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D CEPH_OSD_OP_MODE_SUB | 5,
> +
> + =C2=A0 =C2=A0 =C2=A0 /** lock **/
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_WRLOCK =C2=A0 =C2=A0=3D CEPH_OSD_O=
P_MODE_WR | CEPH_OSD_OP_TYPE_LOCK | 1,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_WRUNLOCK =C2=A0=3D CEPH_OSD_OP_MOD=
E_WR | CEPH_OSD_OP_TYPE_LOCK | 2,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_RDLOCK =C2=A0 =C2=A0=3D CEPH_OSD_O=
P_MODE_WR | CEPH_OSD_OP_TYPE_LOCK | 3,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_RDUNLOCK =C2=A0=3D CEPH_OSD_OP_MOD=
E_WR | CEPH_OSD_OP_TYPE_LOCK | 4,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_UPLOCK =C2=A0 =C2=A0=3D CEPH_OSD_O=
P_MODE_WR | CEPH_OSD_OP_TYPE_LOCK | 5,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_DNLOCK =C2=A0 =C2=A0=3D CEPH_OSD_O=
P_MODE_WR | CEPH_OSD_OP_TYPE_LOCK | 6,
> +
> + =C2=A0 =C2=A0 =C2=A0 /** exec **/
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_CALL =C2=A0 =C2=A0=3D CEPH_OSD_OP_=
MODE_RD | CEPH_OSD_OP_TYPE_EXEC | 1,
> +
> + =C2=A0 =C2=A0 =C2=A0 /** pg **/
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_PGLS =C2=A0 =C2=A0 =C2=A0=3D CEPH_=
OSD_OP_MODE_RD | CEPH_OSD_OP_TYPE_PG | 1,
> +};
> +
> +static inline int ceph_osd_op_type_lock(int op)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return (op & CEPH_OSD_OP_TYPE) =3D=3D CEPH_OSD=
_OP_TYPE_LOCK;
> +}
> +static inline int ceph_osd_op_type_data(int op)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return (op & CEPH_OSD_OP_TYPE) =3D=3D CEPH_OSD=
_OP_TYPE_DATA;
> +}
> +static inline int ceph_osd_op_type_attr(int op)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return (op & CEPH_OSD_OP_TYPE) =3D=3D CEPH_OSD=
_OP_TYPE_ATTR;
> +}
> +static inline int ceph_osd_op_type_exec(int op)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return (op & CEPH_OSD_OP_TYPE) =3D=3D CEPH_OSD=
_OP_TYPE_EXEC;
> +}
> +static inline int ceph_osd_op_type_pg(int op)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return (op & CEPH_OSD_OP_TYPE) =3D=3D CEPH_OSD=
_OP_TYPE_PG;
> +}
> +
> +static inline int ceph_osd_op_mode_subop(int op)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return (op & CEPH_OSD_OP_MODE) =3D=3D CEPH_OSD=
_OP_MODE_SUB;
> +}
> +static inline int ceph_osd_op_mode_read(int op)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return (op & CEPH_OSD_OP_MODE) =3D=3D CEPH_OSD=
_OP_MODE_RD;
> +}
> +static inline int ceph_osd_op_mode_modify(int op)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return (op & CEPH_OSD_OP_MODE) =3D=3D CEPH_OSD=
_OP_MODE_WR;
> +}
> +
> +#define CEPH_OSD_TMAP_HDR 'h'
> +#define CEPH_OSD_TMAP_SET 's'
> +#define CEPH_OSD_TMAP_RM =C2=A0'r'
> +
> +extern const char *ceph_osd_op_name(int op);
> +
> +
> +/*
> + * osd op flags
> + *
> + * An op may be READ, WRITE, or READ|WRITE.
> + */
> +enum {
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_FLAG_ACK =3D 1, =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* want (or is) "ack" ack */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_FLAG_ONNVRAM =3D 2, =C2=A0 =C2=A0 =C2=
=A0/* want (or is) "onnvram" ack */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_FLAG_ONDISK =3D 4, =C2=A0 =C2=A0 =C2=A0=
 /* want (or is) "ondisk" ack */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_FLAG_RETRY =3D 8, =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* resend attempt */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_FLAG_READ =3D 16, =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* op may read */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_FLAG_WRITE =3D 32, =C2=A0 =C2=A0 =C2=A0=
 /* op may write */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_FLAG_ORDERSNAP =3D 64, =C2=A0 /* EOLD=
SNAP if snapc is out of order */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_FLAG_PEERSTAT =3D 128, =C2=A0 /* msg =
includes osd_peer_stat */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_FLAG_BALANCE_READS =3D 256,
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_FLAG_PARALLELEXEC =3D 512, /* execute=
 op in parallel */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_FLAG_PGOP =3D 1024, =C2=A0 =C2=A0 =C2=
=A0/* pg op, no object */
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_FLAG_EXEC =3D 2048, =C2=A0 =C2=A0 =C2=
=A0/* op may exec */
> +};
> +
> +enum {
> + =C2=A0 =C2=A0 =C2=A0 CEPH_OSD_OP_FLAG_EXCL =3D 1, =C2=A0 =C2=A0 =C2=
=A0/* EXCL object create */
> +};
> +
> +#define EOLDSNAPC =C2=A0 =C2=A0ERESTART =C2=A0/* ORDERSNAP flag set;=
 writer has old snapc*/
> +#define EBLACKLISTED ESHUTDOWN /* blacklisted */

Are these used somewhere? Maybe these could clash with system errnos.

> +
> +/*
> + * an individual object operation. =C2=A0each may be accompanied by =
some data
> + * payload
> + */
> +struct ceph_osd_op {
> + =C2=A0 =C2=A0 =C2=A0 __le16 op; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* CEPH_OSD_OP_* */

Unaligned?

> + =C2=A0 =C2=A0 =C2=A0 __le32 flags; =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CE=
PH_OSD_FLAG_* */
> + =C2=A0 =C2=A0 =C2=A0 union {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __le64 offset, length;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __le64 truncate_size;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __le32 truncate_seq;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } __attribute__ ((=
packed)) extent;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __le32 name_len;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __le32 value_len;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } __attribute__ ((=
packed)) xattr;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __u8 class_len;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __u8 method_len;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __u8 argc;

Unaligned?

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __le32 indata_len;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } __attribute__ ((=
packed)) cls;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 __le64 cookie, count;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } __attribute__ ((=
packed)) pgls;
> + =C2=A0 =C2=A0 =C2=A0 };
> + =C2=A0 =C2=A0 =C2=A0 __le32 payload_len;
> +} __attribute__ ((packed));
> +
> +/*
> + * osd request message header. =C2=A0each request may include multip=
le
> + * ceph_osd_op object operations.
> + */
> +struct ceph_osd_request_head {
> + =C2=A0 =C2=A0 =C2=A0 __le32 client_inc; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* client incarnation */
> + =C2=A0 =C2=A0 =C2=A0 struct ceph_object_layout layout; =C2=A0/* pgi=
d */

Unaligned on 64 bit hosts?

> + =C2=A0 =C2=A0 =C2=A0 __le32 osdmap_epoch; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 /* client's osdmap epoch */
> +
> + =C2=A0 =C2=A0 =C2=A0 __le32 flags;
> +
> + =C2=A0 =C2=A0 =C2=A0 struct ceph_timespec mtime; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* for mutations only */
> + =C2=A0 =C2=A0 =C2=A0 struct ceph_eversion reassert_version; /* if w=
e are replaying op */
> +
> + =C2=A0 =C2=A0 =C2=A0 __le32 object_len; =C2=A0 =C2=A0 /* length of =
object name */
> +
> + =C2=A0 =C2=A0 =C2=A0 __le64 snapid; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
snapid to read */

Unaligned?

> + =C2=A0 =C2=A0 =C2=A0 __le64 snap_seq; =C2=A0 =C2=A0 =C2=A0 /* write=
r's snap context */
> + =C2=A0 =C2=A0 =C2=A0 __le32 num_snaps;
> +
> + =C2=A0 =C2=A0 =C2=A0 __le16 num_ops;
> + =C2=A0 =C2=A0 =C2=A0 struct ceph_osd_op ops[]; =C2=A0/* followed by=
 ops[], obj, ticket, snaps */

Unaligned?

> +} __attribute__ ((packed));
> +
> +struct ceph_osd_reply_head {
> + =C2=A0 =C2=A0 =C2=A0 __le32 client_inc; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* client incarnation */
> + =C2=A0 =C2=A0 =C2=A0 __le32 flags;
> + =C2=A0 =C2=A0 =C2=A0 struct ceph_object_layout layout;
> + =C2=A0 =C2=A0 =C2=A0 __le32 osdmap_epoch;

Unaligned on 64 bit hosts?

> + =C2=A0 =C2=A0 =C2=A0 struct ceph_eversion reassert_version; /* for =
replaying uncommitted */
> +
> + =C2=A0 =C2=A0 =C2=A0 __le32 result; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* result code */
> +
> + =C2=A0 =C2=A0 =C2=A0 __le32 object_len; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* length of object name */
> + =C2=A0 =C2=A0 =C2=A0 __le32 num_ops;
> + =C2=A0 =C2=A0 =C2=A0 struct ceph_osd_op ops[0]; =C2=A0/* ops[], obj=
ect */

Unaligned on 64 bit hosts?

> +} __attribute__ ((packed));
> +
> +
> +#endif
> diff --git a/block/rbd.c b/block/rbd.c
> new file mode 100644
> index 0000000..eedae50
> --- /dev/null
> +++ b/block/rbd.c
> @@ -0,0 +1,585 @@
> +/*
> + * QEMU Block driver for RADOS (Ceph)
> + *
> + * Copyright (C) 2010 Christian Brunner <chb@muc.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. =
=C2=A0See
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu-common.h"
> +#include <sys/types.h>
> +#include <stdbool.h>
> +
> +#include <qemu-common.h>
> +
> +#include "rbd_types.h"
> +#include "rados.h"
> +#include "module.h"
> +#include "block_int.h"
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <rados/librados.h>
> +
> +#include <signal.h>
> +
> +/*
> + * When specifying the image filename use:
> + *
> + * rbd:poolname/devicename
> + *
> + * poolname must be the name of an existing rados pool
> + *
> + * devicename is the basename for all objects used to
> + * emulate the raw device.
> + *
> + * Metadata information (image size, ...) is stored in an
> + * object with the name "devicename.rbd".
> + *
> + * The raw device is split into 4MB sized objects by default.
> + * The sequencenumber is encoded in a 12 byte long hex-string,
> + * and is attached to the devicename, separated by a dot.
> + * e.g. "devicename.1234567890ab"
> + *
> + */
> +
> +#define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
> +
> +typedef struct RBDAIOCB {
> + =C2=A0 =C2=A0BlockDriverAIOCB common;
> + =C2=A0 =C2=A0QEMUBH *bh;
> + =C2=A0 =C2=A0int ret;
> + =C2=A0 =C2=A0QEMUIOVector *qiov;
> + =C2=A0 =C2=A0char *bounce;
> + =C2=A0 =C2=A0int write;
> + =C2=A0 =C2=A0int64_t sector_num;
> + =C2=A0 =C2=A0int aiocnt;
> + =C2=A0 =C2=A0int error;
> +} RBDAIOCB;
> +
> +typedef struct RADOSCB {
> + =C2=A0 =C2=A0int rcbid;
> + =C2=A0 =C2=A0RBDAIOCB *acb;
> + =C2=A0 =C2=A0int done;
> + =C2=A0 =C2=A0int64_t segsize;
> + =C2=A0 =C2=A0char *buf;
> +} RADOSCB;
> +
> +typedef struct RBDRVRBDState {
> + =C2=A0 =C2=A0rados_pool_t pool;
> + =C2=A0 =C2=A0char name[RBD_MAX_OBJ_NAME_SIZE];
> + =C2=A0 =C2=A0int name_len;
> + =C2=A0 =C2=A0uint64_t size;
> + =C2=A0 =C2=A0uint64_t objsize;
> +} RBDRVRBDState;
> +
> +typedef struct rbd_obj_header_ondisk RbdHeader1;
> +
> +static int rbd_parsename(const char *filename, char *pool, char *nam=
e)
> +{
> + =C2=A0 =C2=A0const char *rbdname;
> + =C2=A0 =C2=A0char *p, *n;
> + =C2=A0 =C2=A0int l;
> +
> + =C2=A0 =C2=A0if (!strstart(filename, "rbd:", &rbdname)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0pstrcpy(pool, 2 * RBD_MAX_SEG_NAME_SIZE, rbdname);
> + =C2=A0 =C2=A0p =3D strchr(pool, '/');
> + =C2=A0 =C2=A0if (p =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0*p =3D '\0';
> + =C2=A0 =C2=A0n =3D ++p;
> +
> + =C2=A0 =C2=A0l =3D strlen(n);
> +
> + =C2=A0 =C2=A0if (l > RBD_MAX_OBJ_NAME_SIZE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "object name to long\n")=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> + =C2=A0 =C2=A0} else if (l <=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "object name to short\n"=
);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0strcpy(name, n);

pstrcpy(name, l, n);

> +
> + =C2=A0 =C2=A0return l;
> +}
> +
> +static int create_tmap_op(uint8_t op, const char *name, char **tmap_=
desc)
> +{
> + =C2=A0 =C2=A0uint32_t len =3D strlen(name);
> + =C2=A0 =C2=A0uint32_t total_len =3D 1 + (sizeof(uint32_t) + len) + =
sizeof(uint32_t); =C2=A0 =C2=A0 =C2=A0 /* encoding op + name + empty bu=
ffer */
> + =C2=A0 =C2=A0char *desc;
> +
> + =C2=A0 =C2=A0desc =3D qemu_malloc(total_len);
> + =C2=A0 =C2=A0if (!desc) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;
> + =C2=A0 =C2=A0}

qemu_malloc won't return NULL, the check is not useful.

> +
> + =C2=A0 =C2=A0*tmap_desc =3D desc;
> +
> + =C2=A0 =C2=A0*desc =3D op;
> + =C2=A0 =C2=A0desc++;
> + =C2=A0 =C2=A0memcpy(desc, &len, sizeof(len));
> + =C2=A0 =C2=A0desc +=3D sizeof(len);
> + =C2=A0 =C2=A0memcpy(desc, name, len);
> + =C2=A0 =C2=A0desc +=3D len;
> + =C2=A0 =C2=A0len =3D 0;
> + =C2=A0 =C2=A0memcpy(desc, &len, sizeof(len));
> + =C2=A0 =C2=A0desc +=3D sizeof(len);
> +
> + =C2=A0 =C2=A0return desc - *tmap_desc;
> +}
> +
> +static void free_tmap_op(char *tmap_desc)
> +{
> + =C2=A0 =C2=A0qemu_free(tmap_desc);
> +}
> +
> +static int rbd_register_image(rados_pool_t pool, const char *name)
> +{
> + =C2=A0 =C2=A0char *tmap_desc;
> + =C2=A0 =C2=A0const char *dir =3D RBD_DIRECTORY;
> + =C2=A0 =C2=A0int ret;
> +
> + =C2=A0 =C2=A0ret =3D create_tmap_op(CEPH_OSD_TMAP_SET, name, &tmap_=
desc);
> + =C2=A0 =C2=A0if (ret < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0ret =3D rados_tmap_update(pool, dir, tmap_desc, ret);
> + =C2=A0 =C2=A0free_tmap_op(tmap_desc);
> +
> + =C2=A0 =C2=A0return ret;
> +}
> +
> +static int rbd_create(const char *filename, QEMUOptionParameter *opt=
ions)
> +{
> + =C2=A0 =C2=A0int64_t bytes =3D 0;
> + =C2=A0 =C2=A0int64_t objsize;
> + =C2=A0 =C2=A0uint64_t size;
> + =C2=A0 =C2=A0time_t mtime;
> + =C2=A0 =C2=A0uint8_t obj_order =3D RBD_DEFAULT_OBJ_ORDER;
> + =C2=A0 =C2=A0char pool[RBD_MAX_SEG_NAME_SIZE];
> + =C2=A0 =C2=A0char n[RBD_MAX_SEG_NAME_SIZE];
> + =C2=A0 =C2=A0char name[RBD_MAX_SEG_NAME_SIZE];
> + =C2=A0 =C2=A0RbdHeader1 header;
> + =C2=A0 =C2=A0rados_pool_t p;
> + =C2=A0 =C2=A0int name_len;
> + =C2=A0 =C2=A0int ret;
> +
> + =C2=A0 =C2=A0if ((name_len =3D rbd_parsename(filename, pool, name))=
 < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", name, RBD_S=
UFFIX);
> +
> + =C2=A0 =C2=A0/* Read out options */
> + =C2=A0 =C2=A0while (options && options->name) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(options->name, BLOCK_OPT_SIZ=
E)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bytes =3D options->value.n=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!strcmp(options->name, BLOCK_=
OPT_CLUSTER_SIZE)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (options->value.n) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0objsize =3D =
options->value.n;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!objsize=
 || ((objsize - 1) & objsize)) { =C2=A0 =C2=A0/* not a power of 2? */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
fprintf(stderr, "obj size needs to be power of 2\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (objsize =
< 4096) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
fprintf(stderr, "obj size too small\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (obj_ord=
er =3D 0; obj_order < 64; obj_order++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if (objsize =3D=3D 1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
objsize >>=3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0options++;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0memset(&header, 0, sizeof(header));
> + =C2=A0 =C2=A0pstrcpy(header.text, sizeof(header.text), rbd_text);
> + =C2=A0 =C2=A0pstrcpy(header.signature, sizeof(header.signature), rb=
d_signature);
> + =C2=A0 =C2=A0pstrcpy(header.version, sizeof(header.version), rbd_ve=
rsion);
> + =C2=A0 =C2=A0header.image_size =3D bytes;
> + =C2=A0 =C2=A0cpu_to_le64s((uint64_t *) & header.image_size);
> + =C2=A0 =C2=A0header.obj_order =3D obj_order;
> + =C2=A0 =C2=A0header.crypt_type =3D RBD_CRYPT_NONE;
> + =C2=A0 =C2=A0header.comp_type =3D RBD_COMP_NONE;
> + =C2=A0 =C2=A0header.snap_seq =3D 0;
> + =C2=A0 =C2=A0header.snap_count =3D 0;
> + =C2=A0 =C2=A0cpu_to_le32s(&header.snap_count);
> +
> + =C2=A0 =C2=A0if (rados_initialize(0, NULL) < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "error initializing\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0if (rados_open_pool(pool, &p)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "error opening pool %s\n=
", pool);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0/* check for existing rbd header file */
> + =C2=A0 =C2=A0ret =3D rados_stat(p, n, &size, &mtime);
> + =C2=A0 =C2=A0if (ret =3D=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=3D-EEXIST;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto done;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0/* create header file */
> + =C2=A0 =C2=A0ret =3D rados_write(p, n, 0, (const char *)&header, si=
zeof(header));
> + =C2=A0 =C2=A0if (ret < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto done;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0ret =3D rbd_register_image(p, name);
> +done:
> + =C2=A0 =C2=A0rados_close_pool(p);
> + =C2=A0 =C2=A0rados_deinitialize();
> +
> + =C2=A0 =C2=A0return ret;
> +}
> +
> +static int rbd_open(BlockDriverState *bs, const char *filename, int =
flags)
> +{
> + =C2=A0 =C2=A0RBDRVRBDState *s =3D bs->opaque;
> + =C2=A0 =C2=A0char pool[RBD_MAX_SEG_NAME_SIZE];
> + =C2=A0 =C2=A0char n[RBD_MAX_SEG_NAME_SIZE];
> + =C2=A0 =C2=A0char hbuf[4096];
> +
> + =C2=A0 =C2=A0if ((s->name_len =3D rbd_parsename(filename, pool, s->=
name)) < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> + =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s%s", s->name, RB=
D_SUFFIX);
> +
> + =C2=A0 =C2=A0if (rados_initialize(0, NULL) < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "error initializing\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0if (rados_open_pool(pool, &s->pool)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "error opening pool %s\n=
", pool);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0if (rados_read(s->pool, n, 0, hbuf, 4096) < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "error reading header fr=
om %s\n", s->name);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;
> + =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0if (!strncmp(hbuf + 64, rbd_signature, 4)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strncmp(hbuf + 68, rbd_version, 8))=
 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RbdHeader1 *header;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0header =3D (RbdHeader1 *) =
hbuf;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0le64_to_cpus((uint64_t *) =
& header->image_size);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->size =3D header->image_=
size;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->objsize =3D 1 << header=
->obj_order;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "Unknown i=
mage version %s\n", hbuf + 68);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0} else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "Invalid header signatur=
e %s\n", hbuf + 64);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0return 0;
> +}
> +
> +static void rbd_close(BlockDriverState *bs)
> +{
> + =C2=A0 =C2=A0RBDRVRBDState *s =3D bs->opaque;
> +
> + =C2=A0 =C2=A0rados_close_pool(s->pool);
> + =C2=A0 =C2=A0rados_deinitialize();
> +}
> +
> +static int rbd_rw(BlockDriverState *bs, int64_t sector_num,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8=
_t *buf, int nb_sectors, int write)
> +{
> + =C2=A0 =C2=A0RBDRVRBDState *s =3D bs->opaque;
> + =C2=A0 =C2=A0char n[RBD_MAX_SEG_NAME_SIZE];
> +
> + =C2=A0 =C2=A0int64_t segnr, segoffs, segsize, r;
> + =C2=A0 =C2=A0int64_t off, size;
> +
> + =C2=A0 =C2=A0off =3D sector_num * 512;
> + =C2=A0 =C2=A0size =3D nb_sectors * 512;
> + =C2=A0 =C2=A0segnr =3D (int64_t) (off / s->objsize);
> + =C2=A0 =C2=A0segoffs =3D (int64_t) (off % s->objsize);
> + =C2=A0 =C2=A0segsize =3D (int64_t) (s->objsize - segoffs);
> +
> + =C2=A0 =C2=A0while (size > 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size < segsize) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0segsize =3D size;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%=
012llx", s->name,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (long long =
unsigned int)segnr);

Please use PRIx64 instead of llx, the cast won't be needed then. Also e=
lsewhere.

> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (write) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((r =3D rados_write(s->=
pool, n, segoffs, (const char *)buf,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0segsize)) < =
0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D rados_read(s->pool, =
n, segoffs, (char *)buf, segsize);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r =3D=3D -ENOENT) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(buf, =
0, segsize);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (r < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return(r);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (r < segsize) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(buf +=
 r, 0, segsize - r);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D segsize;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0buf +=3D segsize;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0size -=3D segsize;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0segoffs =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0segsize =3D s->objsize;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0segnr++;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0return (0);
> +}
> +
> +static int rbd_read(BlockDriverState *bs, int64_t sector_num,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
uint8_t *buf, int nb_sectors)
> +{
> + =C2=A0 =C2=A0return rbd_rw(bs, sector_num, buf, nb_sectors, 0);
> +}
> +
> +static int rbd_write(BlockDriverState *bs, int64_t sector_num,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const uint8_t *buf, int nb_sectors)
> +{
> + =C2=A0 =C2=A0return rbd_rw(bs, sector_num, (uint8_t *) buf, nb_sect=
ors, 1);
> +}
> +
> +static void rbd_aio_cancel(BlockDriverAIOCB *blockacb)
> +{
> + =C2=A0 =C2=A0RBDAIOCB *acb =3D (RBDAIOCB *) blockacb;
> + =C2=A0 =C2=A0qemu_bh_delete(acb->bh);
> + =C2=A0 =C2=A0acb->bh =3D NULL;
> + =C2=A0 =C2=A0qemu_aio_release(acb);
> +}
> +
> +static AIOPool rbd_aio_pool =3D {
> + =C2=A0 =C2=A0.aiocb_size =3D sizeof(RBDAIOCB),
> + =C2=A0 =C2=A0.cancel =3D rbd_aio_cancel,
> +};
> +
> +/* This is the callback function for rados_aio_read and _write */
> +static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
> +{
> + =C2=A0 =C2=A0RBDAIOCB *acb =3D rcb->acb;
> + =C2=A0 =C2=A0int64_t r;
> + =C2=A0 =C2=A0int i;
> +
> + =C2=A0 =C2=A0acb->aiocnt--;
> + =C2=A0 =C2=A0r =3D rados_aio_get_return_value(c);
> + =C2=A0 =C2=A0rados_aio_release(c);
> + =C2=A0 =C2=A0if (acb->write) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acb->ret =3D r;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acb->error =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!acb->error) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acb->ret +=3D rcb->segsize=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0} else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r =3D=3D -ENOENT) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(rcb->buf, 0, rcb->s=
egsize);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!acb->error) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acb->ret +=3D=
 rcb->segsize;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (r < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acb->ret =3D r;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acb->error =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (r < rcb->segsize) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(rcb->buf + r, 0, rc=
b->segsize - r);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!acb->error) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acb->ret +=3D=
 rcb->segsize;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!acb->error) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acb->ret +=3D r;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0qemu_free(rcb);
> + =C2=A0 =C2=A0i =3D 0;
> + =C2=A0 =C2=A0if (!acb->aiocnt && acb->bh) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_bh_schedule(acb->bh);
> + =C2=A0 =C2=A0}
> +}
> +
> +/* Callback when all queued rados_aio requests are complete */
> +static void rbd_aio_bh_cb(void *opaque)
> +{
> + =C2=A0 =C2=A0RBDAIOCB *acb =3D opaque;
> +
> + =C2=A0 =C2=A0if (!acb->write) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_iovec_from_buffer(acb->qiov, acb->b=
ounce, acb->qiov->size);
> + =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0qemu_vfree(acb->bounce);
> + =C2=A0 =C2=A0acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 :=
 acb->ret));
> + =C2=A0 =C2=A0qemu_bh_delete(acb->bh);
> + =C2=A0 =C2=A0acb->bh =3D NULL;
> + =C2=A0 =C2=A0qemu_aio_release(acb);
> +}
> +
> +static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 int64_t sector_num,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 QEMUIOVector *qiov,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 int nb_sectors,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 BlockDriverCompletionFunc *cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 void *opaque, int write)
> +{
> + =C2=A0 =C2=A0RBDAIOCB *acb;
> + =C2=A0 =C2=A0RADOSCB *rcb;
> + =C2=A0 =C2=A0rados_completion_t c;
> + =C2=A0 =C2=A0char n[RBD_MAX_SEG_NAME_SIZE];
> + =C2=A0 =C2=A0int64_t segnr, segoffs, segsize, last_segnr;
> + =C2=A0 =C2=A0int64_t off, size;
> + =C2=A0 =C2=A0char *buf;
> +
> + =C2=A0 =C2=A0RBDRVRBDState *s =3D bs->opaque;
> +
> + =C2=A0 =C2=A0acb =3D qemu_aio_get(&rbd_aio_pool, bs, cb, opaque);
> + =C2=A0 =C2=A0acb->write =3D write;
> + =C2=A0 =C2=A0acb->qiov =3D qiov;
> + =C2=A0 =C2=A0acb->bounce =3D qemu_blockalign(bs, qiov->size);
> + =C2=A0 =C2=A0acb->aiocnt =3D 0;
> + =C2=A0 =C2=A0acb->ret =3D 0;
> + =C2=A0 =C2=A0acb->error =3D 0;
> +
> + =C2=A0 =C2=A0if (!acb->bh) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0acb->bh =3D qemu_bh_new(rbd_aio_bh_cb, a=
cb);
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0if (write) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_iovec_to_buffer(acb->qiov, acb->bou=
nce);
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0buf =3D acb->bounce;
> +
> + =C2=A0 =C2=A0off =3D sector_num * 512;
> + =C2=A0 =C2=A0size =3D nb_sectors * 512;
> + =C2=A0 =C2=A0segnr =3D (int64_t) (off / s->objsize);
> + =C2=A0 =C2=A0segoffs =3D (int64_t) (off % s->objsize);
> + =C2=A0 =C2=A0segsize =3D (int64_t) (s->objsize - segoffs);
> +
> + =C2=A0 =C2=A0last_segnr =3D ((off + size - 1) / s->objsize);
> + =C2=A0 =C2=A0acb->aiocnt =3D (last_segnr - segnr) + 1;
> +
> + =C2=A0 =C2=A0while (size > 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (size < segsize) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0segsize =3D size;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%=
012llx", s->name,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (long long =
unsigned int)segnr);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcb =3D qemu_malloc(sizeof(RADOSCB));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcb->done =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcb->acb =3D acb;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcb->segsize =3D segsize;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcb->buf =3D buf;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (write) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rados_aio_create_completio=
n(rcb, NULL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(=
rados_callback_t) rbd_finish_aiocb, &c);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rados_aio_write(s->pool, n=
, segoffs, buf, segsize, c);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rados_aio_create_completio=
n(rcb, (rados_callback_t) rbd_finish_aiocb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0N=
ULL, &c);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rados_aio_read(s->pool, n,=
 segoffs, buf, segsize, c);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0buf +=3D segsize;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0size -=3D segsize;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0segoffs =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0segsize =3D s->objsize;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0segnr++;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0return &acb->common;
> +}
> +
> +static BlockDriverAIOCB *rbd_aio_readv(BlockDriverState *bs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t=
 sector_num, QEMUIOVector *qiov,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int nb_=
sectors,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BlockDr=
iverCompletionFunc *cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *o=
paque)
> +{
> + =C2=A0 =C2=A0return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sect=
ors, cb, opaque, 0);
> +}
> +
> +static BlockDriverAIOCB *rbd_aio_writev(BlockDriverState *bs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
nt64_t sector_num, QEMUIOVector *qiov,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
nt nb_sectors,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0B=
lockDriverCompletionFunc *cb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v=
oid *opaque)
> +{
> + =C2=A0 =C2=A0return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sect=
ors, cb, opaque, 1);
> +}
> +
> +static int rbd_getinfo(BlockDriverState *bs, BlockDriverInfo *bdi)
> +{
> + =C2=A0 =C2=A0RBDRVRBDState *s =3D bs->opaque;
> + =C2=A0 =C2=A0bdi->cluster_size =3D s->objsize;
> + =C2=A0 =C2=A0return 0;
> +}
> +
> +static int64_t rbd_getlength(BlockDriverState *bs)
> +{
> + =C2=A0 =C2=A0RBDRVRBDState *s =3D bs->opaque;
> +
> + =C2=A0 =C2=A0return s->size;
> +}
> +
> +static QEMUOptionParameter rbd_create_options[] =3D {
> + =C2=A0 =C2=A0{
> + =C2=A0 =C2=A0 .name =3D BLOCK_OPT_SIZE,
> + =C2=A0 =C2=A0 .type =3D OPT_SIZE,
> + =C2=A0 =C2=A0 .help =3D "Virtual disk size"
> + =C2=A0 =C2=A0},
> + =C2=A0 =C2=A0{
> + =C2=A0 =C2=A0 .name =3D BLOCK_OPT_CLUSTER_SIZE,
> + =C2=A0 =C2=A0 .type =3D OPT_SIZE,
> + =C2=A0 =C2=A0 .help =3D "RBD object size"
> + =C2=A0 =C2=A0},
> + =C2=A0 =C2=A0{NULL}
> +};
> +
> +static BlockDriver bdrv_rbd =3D {
> + =C2=A0 =C2=A0.format_name =3D "rbd",
> + =C2=A0 =C2=A0.instance_size =3D sizeof(RBDRVRBDState),
> + =C2=A0 =C2=A0.bdrv_open =3D rbd_open,
> + =C2=A0 =C2=A0.bdrv_read =3D rbd_read,
> + =C2=A0 =C2=A0.bdrv_write =3D rbd_write,
> + =C2=A0 =C2=A0.bdrv_close =3D rbd_close,
> + =C2=A0 =C2=A0.bdrv_create =3D rbd_create,
> + =C2=A0 =C2=A0.bdrv_get_info =3D rbd_getinfo,
> + =C2=A0 =C2=A0.create_options =3D rbd_create_options,
> + =C2=A0 =C2=A0.bdrv_getlength =3D rbd_getlength,
> + =C2=A0 =C2=A0.protocol_name =3D "rbd",
> +
> + =C2=A0 =C2=A0.bdrv_aio_readv =3D rbd_aio_readv,
> + =C2=A0 =C2=A0.bdrv_aio_writev =3D rbd_aio_writev,
> +};
> +
> +static void bdrv_rbd_init(void)
> +{
> + =C2=A0 =C2=A0bdrv_register(&bdrv_rbd);
> +}
> +
> +block_init(bdrv_rbd_init);
> diff --git a/block/rbd_types.h b/block/rbd_types.h
> new file mode 100644
> index 0000000..dfd5aa0
> --- /dev/null
> +++ b/block/rbd_types.h
> @@ -0,0 +1,48 @@
> +#ifndef _FS_CEPH_RBD
> +#define _FS_CEPH_RBD

QEMU_BLOCK_RBD?

> +
> +#include <linux/types.h>

Can you use standard includes, like <sys/types.h> or <inttypes.h>? Are
Ceph libraries used in other systems than Linux?

> +
> +/*
> + * rbd image 'foo' consists of objects
> + * =C2=A0 foo.rbd =C2=A0 =C2=A0 =C2=A0- image metadata
> + * =C2=A0 foo.00000000
> + * =C2=A0 foo.00000001
> + * =C2=A0 ... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- data
> + */
> +
> +#define RBD_SUFFIX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ".rbd"
> +#define RBD_DIRECTORY =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "rbd_direct=
ory"
> +
> +#define RBD_DEFAULT_OBJ_ORDER =C2=A022 =C2=A0 /* 4MB */
> +
> +#define RBD_MAX_OBJ_NAME_SIZE =C2=A096
> +#define RBD_MAX_SEG_NAME_SIZE =C2=A0128
> +
> +#define RBD_COMP_NONE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
> +#define RBD_CRYPT_NONE =C2=A0 =C2=A0 =C2=A0 =C2=A0 0
> +
> +static const char rbd_text[] =3D "<<< Rados Block Device Image >>>\n=
";
> +static const char rbd_signature[] =3D "RBD";
> +static const char rbd_version[] =3D "001.001";
> +
> +struct rbd_obj_snap_ondisk {
> + =C2=A0 =C2=A0 =C2=A0 __le64 id;
> + =C2=A0 =C2=A0 =C2=A0 __le64 image_size;
> +} __attribute__((packed));
> +
> +struct rbd_obj_header_ondisk {
> + =C2=A0 =C2=A0 =C2=A0 char text[64];
> + =C2=A0 =C2=A0 =C2=A0 char signature[4];
> + =C2=A0 =C2=A0 =C2=A0 char version[8];
> + =C2=A0 =C2=A0 =C2=A0 __le64 image_size;

Unaligned? Is the disk format fixed?

> + =C2=A0 =C2=A0 =C2=A0 __u8 obj_order;
> + =C2=A0 =C2=A0 =C2=A0 __u8 crypt_type;
> + =C2=A0 =C2=A0 =C2=A0 __u8 comp_type;

Unaligned?

> + =C2=A0 =C2=A0 =C2=A0 __le32 snap_seq;
> + =C2=A0 =C2=A0 =C2=A0 __le32 snap_count;
> + =C2=A0 =C2=A0 =C2=A0 __le64 snap_names_len;

Unaligned?

> + =C2=A0 =C2=A0 =C2=A0 struct rbd_obj_snap_ondisk snaps[0];
> +} __attribute__((packed));
> +
> +#endif
> diff --git a/configure b/configure
> index 36d028f..d07a7e5 100755
> --- a/configure
> +++ b/configure
> @@ -299,6 +299,7 @@ pkgversion=3D""
> =C2=A0check_utests=3D"no"
> =C2=A0user_pie=3D"no"
> =C2=A0zero_malloc=3D""
> +rbd=3D"no"
>
> =C2=A0# OS specific
> =C2=A0if check_define __linux__ ; then
> @@ -660,6 +661,8 @@ for opt do
> =C2=A0 ;;
> =C2=A0 --enable-vhost-net) vhost_net=3D"yes"
> =C2=A0 ;;
> + =C2=A0--enable-rbd) rbd=3D"yes"
> + =C2=A0;;
> =C2=A0 *) echo "ERROR: unknown option $opt"; show_help=3D"yes"
> =C2=A0 ;;
> =C2=A0 esac
> @@ -826,6 +829,7 @@ echo " =C2=A0--enable-docs =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0enable documentation build"
> =C2=A0echo " =C2=A0--disable-docs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
disable documentation build"
> =C2=A0echo " =C2=A0--disable-vhost-net =C2=A0 =C2=A0 =C2=A0disable vh=
ost-net acceleration support"
> =C2=A0echo " =C2=A0--enable-vhost-net =C2=A0 =C2=A0 =C2=A0 enable vho=
st-net acceleration support"
> +echo " =C2=A0--enable-rbd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e=
nable building the rados block device (rbd)"
> =C2=A0echo ""
> =C2=A0echo "NOTE: The object files are built at the place where confi=
gure is launched"
> =C2=A0exit 1
> @@ -1569,6 +1573,25 @@ if test "$mingw32" !=3D yes -a "$pthread" =3D =
no; then
> =C2=A0fi
>
> =C2=A0##########################################
> +# rbd probe
> +if test "$rbd" !=3D "no" ; then
> + =C2=A0cat > $TMPC <<EOF
> +#include <stdio.h>
> +#include <rados/librados.h>
> +int main(void) { rados_initialize(0, NULL); return 0; }
> +EOF
> + =C2=A0if compile_prog "" "-lrados -lcrypto" ; then
> + =C2=A0 =C2=A0rbd=3Dyes
> + =C2=A0 =C2=A0LIBS=3D"$LIBS -lrados -lcrypto"
> + =C2=A0else
> + =C2=A0 =C2=A0if test "$rbd" =3D "yes" ; then
> + =C2=A0 =C2=A0 =C2=A0feature_not_found "rados block device"
> + =C2=A0 =C2=A0fi
> + =C2=A0 =C2=A0rbd=3Dno
> + =C2=A0fi
> +fi
> +
> +##########################################
> =C2=A0# linux-aio probe
>
> =C2=A0if test "$linux_aio" !=3D "no" ; then
> @@ -2031,6 +2054,7 @@ echo "preadv support =C2=A0 =C2=A0$preadv"
> =C2=A0echo "fdatasync =C2=A0 =C2=A0 =C2=A0 =C2=A0 $fdatasync"
> =C2=A0echo "uuid support =C2=A0 =C2=A0 =C2=A0$uuid"
> =C2=A0echo "vhost-net support $vhost_net"
> +echo "rbd support =C2=A0 =C2=A0 =C2=A0 $rbd"
>
> =C2=A0if test $sdl_too_old =3D "yes"; then
> =C2=A0echo "-> Your SDL version is too old - please upgrade to have S=
DL support"
> @@ -2260,6 +2284,9 @@ echo "CONFIG_UNAME_RELEASE=3D\"$uname_release\"=
" >> $config_host_mak
> =C2=A0if test "$zero_malloc" =3D "yes" ; then
> =C2=A0 echo "CONFIG_ZERO_MALLOC=3Dy" >> $config_host_mak
> =C2=A0fi
> +if test "$rbd" =3D "yes" ; then
> + =C2=A0echo "CONFIG_RBD=3Dy" >> $config_host_mak
> +fi
>
> =C2=A0# USB host support
> =C2=A0case "$usb" in
> --
> 1.7.0.4
>
>
>
