From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH] Wireshark dissector updated, work with the current
 development tree of wireshark. The way I patched it is not really clean, but
 it can be useful if some people quickly need to inspect ceph network flows.
Date: Tue, 1 May 2012 10:59:45 -0700
Message-ID: <CAC-hyiHaWb47nvbicnbizSDpfRJD9T+QJYHSfe++M5k4xZiufw@mail.gmail.com>
References: <1335363830-1748-1-git-send-email-prognant@oodrive.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50334 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758469Ab2EAR7s convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 May 2012 13:59:48 -0400
Received: by bkcji2 with SMTP id ji2so1095958bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 May 2012 10:59:46 -0700 (PDT)
In-Reply-To: <1335363830-1748-1-git-send-email-prognant@oodrive.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pierre Rognant <prognant@oodrive.fr>
Cc: ceph-devel@vger.kernel.org

Hi,

this is really awesome, thanks.

   Sorry for the late response. We got another wireshark update
out-of-list a few weeks ago, and I assumed it was the same one.
Comparing them both now, it is obvious that these are completely two
different implementations. Both require cleanups, and from what I can
tell need extra work to get them upstream (that is, upstream to
wireshark). I'll try to push both into branches so that the work is
not lost and is readily useful.

The extra work that needs to be done and that the original dissector
suffered from is (AFAIR) that we dereference structures directly,
which shouldn't be done according to the wireshark style guide. I'm
not too sure now whether we do it all around or on just packed
structures, and whether it matters if it's the latter, but that should
be looked into. It'd be nice if someone could pick that up and work
through whatever is needed to get it upstream.

Thanks,
Yehuda

On Wed, Apr 25, 2012 at 7:23 AM, Pierre Rognant <prognant@oodrive.fr> w=
rote:
>
> From: Pierre Rognant <prognant@oodrive.com>
>
> ---
> =A0wireshark/ceph/ceph_fs.h =A0 =A0 | =A0213 +++++++++++++++-----
> =A0wireshark/ceph/crc32c.h =A0 =A0 =A0| =A0 =A02 +-
> =A0wireshark/ceph/msgr.h =A0 =A0 =A0 =A0| =A0 67 +++++--
> =A0wireshark/ceph/packet-ceph.c | =A0461
> ++++++++++++++++++++++++++++++++++--------
> =A0wireshark/ceph/rados.h =A0 =A0 =A0 | =A0100 +++++++--
> =A0wireshark/ceph/sctp_crc32.c =A0| =A0 27 ++-
> =A0wireshark/wireshark.patch =A0 =A0| =A0 26 +--
> =A07 files changed, 695 insertions(+), 201 deletions(-)
>
> diff --git a/wireshark/ceph/ceph_fs.h b/wireshark/ceph/ceph_fs.h
> index 41a941c..b8c6069 100644
> --- a/wireshark/ceph/ceph_fs.h
> +++ b/wireshark/ceph/ceph_fs.h
> @@ -16,40 +16,37 @@
> =A0#include "rados.h"
>
> =A0/*
> - * Ceph release version
> - */
> -#define CEPH_VERSION_MAJOR 0
> -#define CEPH_VERSION_MINOR 16
> -#define CEPH_VERSION_PATCH 1
> -
> -#define CEPH_STRINGIFY_(x) #x
> -#define CEPH_STRINGIFY(x) CEPH_STRINGIFY_(x)
> -#define CEPH_MAKE_VERSION(x, y, z) CEPH_STRINGIFY(x) "."
> CEPH_STRINGIFY(y) \
> - =A0 =A0 =A0 "." CEPH_STRINGIFY(z)
> -#define CEPH_VERSION CEPH_MAKE_VERSION(CEPH_VERSION_MAJOR, \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0CEPH_VERSION_MINOR,
> CEPH_VERSION_PATCH)
> -
> -/*
> =A0* subprotocol versions. =A0when specific messages types or high-le=
vel
> =A0* protocols change, bump the affected components. =A0we keep rev
> =A0* internal cluster protocols separately from the public,
> =A0* client-facing protocol.
> =A0*/
> -#define CEPH_OSD_PROTOCOL =A0 =A0 7 /* cluster internal */
> -#define CEPH_MDS_PROTOCOL =A0 =A0 9 /* cluster internal */
> +#define CEPH_OSD_PROTOCOL =A0 =A0 8 /* cluster internal */
> +#define CEPH_MDS_PROTOCOL =A0 =A012 /* cluster internal */
> =A0#define CEPH_MON_PROTOCOL =A0 =A0 5 /* cluster internal */
> -#define CEPH_OSDC_PROTOCOL =A0 20 /* server/client */
> -#define CEPH_MDSC_PROTOCOL =A0 29 /* server/client */
> +#define CEPH_OSDC_PROTOCOL =A0 24 /* server/client */
> +#define CEPH_MDSC_PROTOCOL =A0 32 /* server/client */
> =A0#define CEPH_MONC_PROTOCOL =A0 15 /* server/client */
>
>
> =A0#define CEPH_INO_ROOT =A01
> +#define CEPH_INO_CEPH =A02 =A0 =A0 =A0 =A0/* hidden .ceph dir */
>
> =A0/* arbitrary limit on max # of monitors (cluster of 3 is typical) =
*/
> =A0#define CEPH_MAX_MON =A0 31
>
>
> -unsigned int ceph_full_name_hash(const char *name, unsigned int len)=
;
> +/*
> + * feature bits
> + */
> +#define CEPH_FEATURE_UID =A0 =A0 =A0 =A0 =A0 =A0(1<<0)
> +#define CEPH_FEATURE_NOSRCADDR =A0 =A0 =A0(1<<1)
> +#define CEPH_FEATURE_MONCLOCKCHECK =A0(1<<2)
> +#define CEPH_FEATURE_FLOCK =A0 =A0 =A0 =A0 =A0(1<<3)
> +#define CEPH_FEATURE_SUBSCRIBE2 =A0 =A0 (1<<4)
> +#define CEPH_FEATURE_MONNAMES =A0 =A0 =A0 (1<<5)
> +#define CEPH_FEATURE_RECONNECT_SEQ =A0(1<<6)
> +#define CEPH_FEATURE_DIRLAYOUTHASH =A0(1<<7)
>
>
> =A0/*
> @@ -62,10 +59,10 @@ struct ceph_file_layout {
> =A0 =A0 =A0 =A0__le32 fl_stripe_count; =A0 =A0/* over this many objec=
ts */
> =A0 =A0 =A0 =A0__le32 fl_object_size; =A0 =A0 /* until objects are th=
is big, then move
> to
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0new objects */
> - =A0 =A0 =A0 __le32 fl_cas_hash; =A0 =A0 =A0 =A0/* 0 =3D none; 1 =3D=
 sha256 */
> + =A0 =A0 =A0 __le32 fl_cas_hash; =A0 =A0 =A0 =A0/* UNUSED. =A00 =3D =
none; 1 =3D sha256 */
>
> =A0 =A0 =A0 =A0/* pg -> disk layout */
> - =A0 =A0 =A0 __le32 fl_object_stripe_unit; =A0/* for per-object pari=
ty, if any */
> + =A0 =A0 =A0 __le32 fl_object_stripe_unit; =A0/* UNUSED. =A0for per-=
object parity,
> if any */
>
> =A0 =A0 =A0 =A0/* object -> pg layout */
> =A0 =A0 =A0 =A0__le32 fl_pg_preferred; /* preferred primary for pg (-=
1 for none)
> */
> @@ -76,6 +73,26 @@ struct ceph_file_layout {
>
> =A0int ceph_file_layout_is_valid(const struct ceph_file_layout *layou=
t);
>
> +struct ceph_dir_layout {
> + =A0 =A0 =A0 __u8 =A0 dl_dir_hash; =A0 /* see ceph_hash.h for ids */
> + =A0 =A0 =A0 __u8 =A0 dl_unused1;
> + =A0 =A0 =A0 __u16 =A0dl_unused2;
> + =A0 =A0 =A0 __u32 =A0dl_unused3;
> +} __attribute__ ((packed));
> +
> +/* crypto algorithms */
> +#define CEPH_CRYPTO_NONE 0x0
> +#define CEPH_CRYPTO_AES =A00x1
> +
> +#define CEPH_AES_IV "cephsageyudagreg"
> +
> +/* security/authentication protocols */
> +#define CEPH_AUTH_UNKNOWN =A0 =A0 =A00x0
> +#define CEPH_AUTH_NONE =A0 =A0 =A0 =A0 0x1
> +#define CEPH_AUTH_CEPHX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2
> +
> +#define CEPH_AUTH_UID_DEFAULT ((__u64) -1)
> +
>
> =A0/*********************************************
> =A0* message layer
> @@ -92,12 +109,12 @@ int ceph_file_layout_is_valid(const struct
> ceph_file_layout *layout);
> =A0/* client <-> monitor */
> =A0#define CEPH_MSG_MON_MAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04
> =A0#define CEPH_MSG_MON_GET_MAP =A0 =A0 =A0 =A0 =A0 =A05
> -#define CEPH_MSG_CLIENT_MOUNT =A0 =A0 =A0 =A0 =A0 10
> -#define CEPH_MSG_CLIENT_MOUNT_ACK =A0 =A0 =A0 11
> =A0#define CEPH_MSG_STATFS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 13
> =A0#define CEPH_MSG_STATFS_REPLY =A0 =A0 =A0 =A0 =A0 14
> =A0#define CEPH_MSG_MON_SUBSCRIBE =A0 =A0 =A0 =A0 =A015
> =A0#define CEPH_MSG_MON_SUBSCRIBE_ACK =A0 =A0 =A016
> +#define CEPH_MSG_AUTH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A017
> +#define CEPH_MSG_AUTH_REPLY =A0 =A0 =A0 =A0 =A0 =A018
>
> =A0/* client <-> mds */
> =A0#define CEPH_MSG_MDS_MAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A021
> @@ -113,10 +130,35 @@ int ceph_file_layout_is_valid(const struct
> ceph_file_layout *layout);
> =A0#define CEPH_MSG_CLIENT_SNAP =A0 =A0 =A0 =A0 =A0 =A00x312
> =A0#define CEPH_MSG_CLIENT_CAPRELEASE =A0 =A0 =A00x313
>
> +/* pool ops */
> +#define CEPH_MSG_POOLOP_REPLY =A0 =A0 =A0 =A0 =A0 48
> +#define CEPH_MSG_POOLOP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 49
> +
> +
> =A0/* osd */
> -#define CEPH_MSG_OSD_MAP =A0 =A0 =A0 =A0 =A041
> -#define CEPH_MSG_OSD_OP =A0 =A0 =A0 =A0 =A0 42
> -#define CEPH_MSG_OSD_OPREPLY =A0 =A0 =A043
> +#define CEPH_MSG_OSD_MAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A041
> +#define CEPH_MSG_OSD_OP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 42
> +#define CEPH_MSG_OSD_OPREPLY =A0 =A0 =A0 =A0 =A0 =A043
> +#define CEPH_MSG_WATCH_NOTIFY =A0 =A0 =A0 =A0 =A0 44
> +
> +
> +/* watch-notify operations */
> +enum {
> + =A0WATCH_NOTIFY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 1, /* notifying watcher */
> + =A0WATCH_NOTIFY_COMPLETE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0=3D 2, /* notifier notified
> when done */
> +};
> +
> +
> +/* pool operations */
> +enum {
> + =A0POOL_OP_CREATE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0=
x01,
> + =A0POOL_OP_DELETE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0=
x02,
> + =A0POOL_OP_AUID_CHANGE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0x03,
> + =A0POOL_OP_CREATE_SNAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0x11,
> + =A0POOL_OP_DELETE_SNAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 0x12,
> + =A0POOL_OP_CREATE_UNMANAGED_SNAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D=
 0x21,
> + =A0POOL_OP_DELETE_UNMANAGED_SNAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D=
 0x22,
> +};
>
> =A0struct ceph_mon_request_header {
> =A0 =A0 =A0 =A0__le64 have_version;
> @@ -127,7 +169,6 @@ struct ceph_mon_request_header {
> =A0struct ceph_mon_statfs {
> =A0 =A0 =A0 =A0struct ceph_mon_request_header monhdr;
> =A0 =A0 =A0 =A0struct ceph_fsid fsid;
> - =A0 =A0 =A0 __le64 tid;
> =A0} __attribute__ ((packed));
>
> =A0struct ceph_statfs {
> @@ -137,11 +178,35 @@ struct ceph_statfs {
>
> =A0struct ceph_mon_statfs_reply {
> =A0 =A0 =A0 =A0struct ceph_fsid fsid;
> - =A0 =A0 =A0 __le64 tid;
> =A0 =A0 =A0 =A0__le64 version;
> =A0 =A0 =A0 =A0struct ceph_statfs st;
> =A0} __attribute__ ((packed));
>
> +const char *ceph_pool_op_name(int op);
> +
> +struct ceph_mon_poolop {
> + =A0 =A0 =A0 struct ceph_mon_request_header monhdr;
> + =A0 =A0 =A0 struct ceph_fsid fsid;
> + =A0 =A0 =A0 __le32 pool;
> + =A0 =A0 =A0 __le32 op;
> + =A0 =A0 =A0 __le64 auid;
> + =A0 =A0 =A0 __le64 snapid;
> + =A0 =A0 =A0 __le32 name_len;
> +} __attribute__ ((packed));
> +
> +struct ceph_mon_poolop_reply {
> + =A0 =A0 =A0 struct ceph_mon_request_header monhdr;
> + =A0 =A0 =A0 struct ceph_fsid fsid;
> + =A0 =A0 =A0 __le32 reply_code;
> + =A0 =A0 =A0 __le32 epoch;
> + =A0 =A0 =A0 char has_data;
> + =A0 =A0 =A0 char data[0];
> +} __attribute__ ((packed));
> +
> +struct ceph_mon_unmanaged_snap {
> + =A0 =A0 =A0 __le64 snapid;
> +} __attribute__ ((packed));
> +
> =A0struct ceph_osd_getmap {
> =A0 =A0 =A0 =A0struct ceph_mon_request_header monhdr;
> =A0 =A0 =A0 =A0struct ceph_fsid fsid;
> @@ -157,11 +222,18 @@ struct ceph_client_mount {
> =A0 =A0 =A0 =A0struct ceph_mon_request_header monhdr;
> =A0} __attribute__ ((packed));
>
> +#define CEPH_SUBSCRIBE_ONETIME =A0 =A01 =A0/* i want only 1 update a=
fter have
> */
> +
> =A0struct ceph_mon_subscribe_item {
> - =A0 =A0 =A0 __le64 have_version; =A0 =A0__le64 have;
> + =A0 =A0 =A0 __le64 have_version; =A0 =A0__le64 have;
> =A0 =A0 =A0 =A0__u8 onetime;
> =A0} __attribute__ ((packed));
>
> +struct ceph_mon_subscribe_ack {
> + =A0 =A0 =A0 __le32 duration; =A0 =A0 =A0 =A0 /* seconds */
> + =A0 =A0 =A0 struct ceph_fsid fsid;
> +} __attribute__ ((packed));
> +
> =A0/*
> =A0* mds states
> =A0* =A0 > 0 -> in
> @@ -194,16 +266,18 @@ extern const char *ceph_mds_state_name(int s);
> =A0* =A0- they also define the lock ordering by the MDS
> =A0* =A0- a few of these are internal to the mds
> =A0*/
> -#define CEPH_LOCK_DN =A0 =A0 =A0 =A0 =A01
> -#define CEPH_LOCK_ISNAP =A0 =A0 =A0 2
> -#define CEPH_LOCK_IVERSION =A0 =A04 =A0 =A0 /* mds internal */
> -#define CEPH_LOCK_IFILE =A0 =A0 =A0 8 =A0 =A0 /* mds internal */
> -#define CEPH_LOCK_IAUTH =A0 =A0 =A0 32
> -#define CEPH_LOCK_ILINK =A0 =A0 =A0 64
> -#define CEPH_LOCK_IDFT =A0 =A0 =A0 =A0128 =A0 /* dir frag tree */
> -#define CEPH_LOCK_INEST =A0 =A0 =A0 256 =A0 /* mds internal */
> -#define CEPH_LOCK_IXATTR =A0 =A0 =A0512
> -#define CEPH_LOCK_INO =A0 =A0 =A0 =A0 2048 =A0/* immutable inode bit=
s; not a lock
> */
> +#define CEPH_LOCK_DVERSION =A0 =A01
> +#define CEPH_LOCK_DN =A0 =A0 =A0 =A0 =A02
> +#define CEPH_LOCK_ISNAP =A0 =A0 =A0 16
> +#define CEPH_LOCK_IVERSION =A0 =A032 =A0 =A0/* mds internal */
> +#define CEPH_LOCK_IFILE =A0 =A0 =A0 64
> +#define CEPH_LOCK_IAUTH =A0 =A0 =A0 128
> +#define CEPH_LOCK_ILINK =A0 =A0 =A0 256
> +#define CEPH_LOCK_IDFT =A0 =A0 =A0 =A0512 =A0 /* dir frag tree */
> +#define CEPH_LOCK_INEST =A0 =A0 =A0 1024 =A0/* mds internal */
> +#define CEPH_LOCK_IXATTR =A0 =A0 =A02048
> +#define CEPH_LOCK_IFLOCK =A0 =A0 =A04096 =A0/* advisory file locks *=
/
> +#define CEPH_LOCK_INO =A0 =A0 =A0 =A0 8192 =A0/* immutable inode bit=
s; not a lock
> */
>
> =A0/* client_session ops */
> =A0enum {
> @@ -239,11 +313,15 @@ enum {
> =A0 =A0 =A0 =A0CEPH_MDS_OP_GETATTR =A0 =A0=3D 0x00101,
> =A0 =A0 =A0 =A0CEPH_MDS_OP_LOOKUPHASH =3D 0x00102,
> =A0 =A0 =A0 =A0CEPH_MDS_OP_LOOKUPPARENT =3D 0x00103,
> + =A0 =A0 =A0 CEPH_MDS_OP_LOOKUPINO =A0=3D 0x00104,
>
> =A0 =A0 =A0 =A0CEPH_MDS_OP_SETXATTR =A0 =3D 0x01105,
> =A0 =A0 =A0 =A0CEPH_MDS_OP_RMXATTR =A0 =A0=3D 0x01106,
> =A0 =A0 =A0 =A0CEPH_MDS_OP_SETLAYOUT =A0=3D 0x01107,
> =A0 =A0 =A0 =A0CEPH_MDS_OP_SETATTR =A0 =A0=3D 0x01108,
> + =A0 =A0 =A0 CEPH_MDS_OP_SETFILELOCK=3D 0x01109,
> + =A0 =A0 =A0 CEPH_MDS_OP_GETFILELOCK=3D 0x00110,
> + =A0 =A0 =A0 CEPH_MDS_OP_SETDIRLAYOUT=3D0x0110a,
>
> =A0 =A0 =A0 =A0CEPH_MDS_OP_MKNOD =A0 =A0 =A0=3D 0x01201,
> =A0 =A0 =A0 =A0CEPH_MDS_OP_LINK =A0 =A0 =A0 =3D 0x01202,
> @@ -253,7 +331,7 @@ enum {
> =A0 =A0 =A0 =A0CEPH_MDS_OP_RMDIR =A0 =A0 =A0=3D 0x01221,
> =A0 =A0 =A0 =A0CEPH_MDS_OP_SYMLINK =A0 =A0=3D 0x01222,
>
> - =A0 =A0 =A0 CEPH_MDS_OP_CREATE =A0 =A0 =3D 0x00301,
> + =A0 =A0 =A0 CEPH_MDS_OP_CREATE =A0 =A0 =3D 0x01301,
> =A0 =A0 =A0 =A0CEPH_MDS_OP_OPEN =A0 =A0 =A0 =3D 0x00302,
> =A0 =A0 =A0 =A0CEPH_MDS_OP_READDIR =A0 =A0=3D 0x00305,
>
> @@ -290,6 +368,7 @@ union ceph_mds_request_args {
> =A0 =A0 =A0 =A0struct {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__le32 frag; =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /* which dir fragment */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__le32 max_entries; =A0 =A0 =A0 =A0 =A0=
/* how many dentries to grab
> */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __le32 max_bytes;
> =A0 =A0 =A0 =A0} __attribute__ ((packed)) readdir;
> =A0 =A0 =A0 =A0struct {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__le32 mode;
> @@ -313,13 +392,22 @@ union ceph_mds_request_args {
> =A0 =A0 =A0 =A0struct {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct ceph_file_layout layout;
> =A0 =A0 =A0 =A0} __attribute__ ((packed)) setlayout;
> + =A0 =A0 =A0 struct {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __u8 rule; /* currently fcntl or flock =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __u8 type; /* shared, exclusive, remove=
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __le64 pid; /* process id requesting th=
e lock */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __le64 pid_namespace;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __le64 start; /* initial location to lo=
ck */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __le64 length; /* num bytes to lock fro=
m start */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __u8 wait; /* will caller wait for lock=
 to become
> available? */
> + =A0 =A0 =A0 } __attribute__ ((packed)) filelock_change;
> =A0} __attribute__ ((packed));
>
> =A0#define CEPH_MDS_FLAG_REPLAY =A0 =A0 =A0 =A01 =A0/* this is a repl=
ayed op */
> =A0#define CEPH_MDS_FLAG_WANT_DENTRY =A0 2 =A0/* want dentry in reply=
 */
>
> =A0struct ceph_mds_request_head {
> - =A0 =A0 =A0 __le64 tid, oldest_client_tid;
> + =A0 =A0 =A0 __le64 oldest_client_tid;
> =A0 =A0 =A0 =A0__le32 mdsmap_epoch; =A0 =A0 =A0 =A0 =A0 /* on client =
*/
> =A0 =A0 =A0 =A0__le32 flags; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* CE=
PH_MDS_FLAG_* */
> =A0 =A0 =A0 =A0__u8 num_retry, num_fwd; =A0 =A0 =A0 /* count retry, f=
wd attempts */
> @@ -342,7 +430,6 @@ struct ceph_mds_request_release {
>
> =A0/* client reply */
> =A0struct ceph_mds_reply_head {
> - =A0 =A0 =A0 __le64 tid;
> =A0 =A0 =A0 =A0__le32 op;
> =A0 =A0 =A0 =A0__le32 result;
> =A0 =A0 =A0 =A0__le32 mdsmap_epoch;
> @@ -392,7 +479,7 @@ struct ceph_mds_reply_inode {
> =A0 =A0 =A0 =A0struct ceph_timespec rctime;
> =A0 =A0 =A0 =A0struct ceph_frag_tree_head fragtree; =A0/* (must be at=
 end of struct)
> */
> =A0} __attribute__ ((packed));
> -/* followed by frag array, then symlink string, then xattr blob */
> +/* followed by frag array, symlink string, dir layout, xattr blob */
>
> =A0/* reply_lease follows dname, and reply_inode */
> =A0struct ceph_mds_reply_lease {
> @@ -408,6 +495,23 @@ struct ceph_mds_reply_dirfrag {
> =A0 =A0 =A0 =A0__le32 dist[];
> =A0} __attribute__ ((packed));
>
> +#define CEPH_LOCK_FCNTL =A0 =A01
> +#define CEPH_LOCK_FLOCK =A0 =A02
> +
> +#define CEPH_LOCK_SHARED =A0 1
> +#define CEPH_LOCK_EXCL =A0 =A0 2
> +#define CEPH_LOCK_UNLOCK =A0 4
> +
> +struct ceph_filelock {
> + =A0 =A0 =A0 __le64 start;/* file offset to start lock at */
> + =A0 =A0 =A0 __le64 length; /* num bytes to lock; 0 for all followin=
g start */
> + =A0 =A0 =A0 __le64 client; /* which client holds the lock */
> + =A0 =A0 =A0 __le64 pid; /* process id holding the lock on the clien=
t */
> + =A0 =A0 =A0 __le64 pid_namespace;
> + =A0 =A0 =A0 __u8 type; /* shared lock, exclusive lock, or unlock */
> +} __attribute__ ((packed));
> +
> +
> =A0/* file access modes */
> =A0#define CEPH_FILE_MODE_PIN =A0 =A0 =A0 =A00
> =A0#define CEPH_FILE_MODE_RD =A0 =A0 =A0 =A0 1
> @@ -436,9 +540,10 @@ int ceph_flags_to_mode(int flags);
> =A0#define CEPH_CAP_SAUTH =A0 =A0 =A02
> =A0#define CEPH_CAP_SLINK =A0 =A0 =A04
> =A0#define CEPH_CAP_SXATTR =A0 =A0 6
> -#define CEPH_CAP_SFILE =A0 =A0 =A08 =A0 /* goes at the end (uses >2 =
cap bits) */
> +#define CEPH_CAP_SFILE =A0 =A0 =A08
> +#define CEPH_CAP_SFLOCK =A0 =A020
>
> -#define CEPH_CAP_BITS =A0 =A0 =A0 16
> +#define CEPH_CAP_BITS =A0 =A0 =A0 22
>
> =A0/* composed values */
> =A0#define CEPH_CAP_AUTH_SHARED =A0(CEPH_CAP_GSHARED =A0<< CEPH_CAP_S=
AUTH)
> @@ -456,6 +561,9 @@ int ceph_flags_to_mode(int flags);
> =A0#define CEPH_CAP_FILE_BUFFER =A0 (CEPH_CAP_GBUFFER =A0 << CEPH_CAP=
_SFILE)
> =A0#define CEPH_CAP_FILE_WREXTEND (CEPH_CAP_GWREXTEND << CEPH_CAP_SFI=
LE)
> =A0#define CEPH_CAP_FILE_LAZYIO =A0 (CEPH_CAP_GLAZYIO =A0 << CEPH_CAP=
_SFILE)
> +#define CEPH_CAP_FLOCK_SHARED =A0(CEPH_CAP_GSHARED =A0 << CEPH_CAP_S=
=46LOCK)
> +#define CEPH_CAP_FLOCK_EXCL =A0 =A0(CEPH_CAP_GEXCL =A0 =A0 << CEPH_C=
AP_SFLOCK)
> +
>
> =A0/* cap masks (for getattr) */
> =A0#define CEPH_STAT_CAP_INODE =A0 =A0CEPH_CAP_PIN
> @@ -491,7 +599,8 @@ int ceph_flags_to_mode(int flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CEPH_CAP_F=
ILE_EXCL)
> =A0#define CEPH_CAP_ANY_WR =A0 (CEPH_CAP_ANY_EXCL | CEPH_CAP_ANY_FILE=
_WR)
> =A0#define CEPH_CAP_ANY =A0 =A0 =A0(CEPH_CAP_ANY_RD | CEPH_CAP_ANY_EX=
CL | \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CEPH_CAP_ANY_FIL=
E_WR | CEPH_CAP_PIN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CEPH_CAP_ANY_FIL=
E_WR | CEPH_CAP_FILE_LAZYIO | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CEPH_CAP_PIN)
>
> =A0#define CEPH_CAP_LOCKS (CEPH_LOCK_IFILE | CEPH_LOCK_IAUTH |
> CEPH_LOCK_ILINK | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CEPH_LOCK_IXATTR)
> @@ -528,7 +637,6 @@ struct ceph_mds_caps {
> =A0 =A0 =A0 =A0__le32 migrate_seq;
> =A0 =A0 =A0 =A0__le64 snap_follows;
> =A0 =A0 =A0 =A0__le32 snap_trace_len;
> - =A0 =A0 =A0 __le64 client_tid; =A0 =A0 =A0 =A0 =A0/* for FLUSH(SNAP=
) -> FLUSH(SNAP)_ACK
> */
>
> =A0 =A0 =A0 =A0/* authlock */
> =A0 =A0 =A0 =A0__le32 uid, gid, mode;
> @@ -582,12 +690,21 @@ struct ceph_mds_cap_reconnect {
> =A0 =A0 =A0 =A0__le64 cap_id;
> =A0 =A0 =A0 =A0__le32 wanted;
> =A0 =A0 =A0 =A0__le32 issued;
> + =A0 =A0 =A0 __le64 snaprealm;
> + =A0 =A0 =A0 __le64 pathbase; =A0 =A0 =A0 =A0/* base ino for our pat=
h to this ino */
> + =A0 =A0 =A0 __le32 flock_len; =A0 =A0 =A0 /* size of flock state bl=
ob, if any */
> +} __attribute__ ((packed));
> +/* followed by flock blob */
> +
> +struct ceph_mds_cap_reconnect_v1 {
> + =A0 =A0 =A0 __le64 cap_id;
> + =A0 =A0 =A0 __le32 wanted;
> + =A0 =A0 =A0 __le32 issued;
> =A0 =A0 =A0 =A0__le64 size;
> =A0 =A0 =A0 =A0struct ceph_timespec mtime, atime;
> =A0 =A0 =A0 =A0__le64 snaprealm;
> =A0 =A0 =A0 =A0__le64 pathbase; =A0 =A0 =A0 =A0/* base ino for our pa=
th to this ino */
> =A0} __attribute__ ((packed));
> -/* followed by encoded string */
>
> =A0struct ceph_mds_snaprealm_reconnect {
> =A0 =A0 =A0 =A0__le64 ino; =A0 =A0 /* snap realm base */
> diff --git a/wireshark/ceph/crc32c.h b/wireshark/ceph/crc32c.h
> index 13df359..e3cf8ff 100644
> --- a/wireshark/ceph/crc32c.h
> +++ b/wireshark/ceph/crc32c.h
> @@ -5,7 +5,7 @@
> =A0extern "C" {
> =A0#endif
>
> -uint32_t crc32c_le(uint32_t crc, unsigned char const *data, unsigned
> length);
> +uint32_t ceph_crc32c_le(uint32_t crc, unsigned char const *data, uns=
igned
> length);
>
> =A0#ifdef __cplusplus
> =A0}
> diff --git a/wireshark/ceph/msgr.h b/wireshark/ceph/msgr.h
> index 2f61704..2604e1a 100644
> --- a/wireshark/ceph/msgr.h
> +++ b/wireshark/ceph/msgr.h
> @@ -1,6 +1,10 @@
> =A0#ifndef CEPH_MSGR_H
> =A0#define CEPH_MSGR_H
>
> +#ifdef __cplusplus
> +#include <sys/socket.h> // for struct sockaddr_storage
> +#endif
> +
> =A0/*
> =A0* Data types for message passing layer used by Ceph.
> =A0*/
> @@ -21,7 +25,7 @@
> =A0* whenever the wire protocol changes. =A0try to keep this string l=
ength
> =A0* constant.
> =A0*/
> -#define CEPH_BANNER "ceph v022"
> +#define CEPH_BANNER "ceph v027"
> =A0#define CEPH_BANNER_MAX_LEN 30
>
>
> @@ -46,33 +50,25 @@ struct ceph_entity_name {
> =A0 =A0 =A0 =A0__le64 num;
> =A0} __attribute__ ((packed));
>
> -#define CEPH_ENTITY_TYPE_MON =A0 =A01
> -#define CEPH_ENTITY_TYPE_MDS =A0 =A02
> -#define CEPH_ENTITY_TYPE_OSD =A0 =A03
> -#define CEPH_ENTITY_TYPE_CLIENT 4
> +#define CEPH_ENTITY_TYPE_MON =A0 =A00x01
> +#define CEPH_ENTITY_TYPE_MDS =A0 =A00x02
> +#define CEPH_ENTITY_TYPE_OSD =A0 =A00x04
> +#define CEPH_ENTITY_TYPE_CLIENT 0x08
> +#define CEPH_ENTITY_TYPE_AUTH =A0 0x20
> +
> +#define CEPH_ENTITY_TYPE_ANY =A0 =A00xFF
> +
> +extern const char *ceph_entity_type_name(int type);
>
> =A0/*
> =A0* entity_addr -- network address
> =A0*/
> =A0struct ceph_entity_addr {
> - =A0 =A0 =A0 __le32 erank; =A0/* entity's rank in process */
> + =A0 =A0 =A0 __le32 type;
> =A0 =A0 =A0 =A0__le32 nonce; =A0/* unique id for process (e.g. pid) *=
/
> =A0 =A0 =A0 =A0struct sockaddr_storage in_addr;
> =A0} __attribute__ ((packed));
>
> -static inline bool ceph_entity_addr_is_local(const struct
> ceph_entity_addr *a,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0const struct ceph_entity_addr
> *b)
> -{
> - =A0 =A0 =A0 return a->nonce =3D=3D b->nonce &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcmp(&a->in_addr, &b->in_addr, sizeof=
(a->in_addr)) =3D=3D 0;
> -}
> -
> -static inline bool ceph_entity_addr_equal(const struct ceph_entity_a=
ddr
> *a,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 const struct ceph_entity_addr
> *b)
> -{
> - =A0 =A0 =A0 return memcmp(a, b, sizeof(*a)) =3D=3D 0;
> -}
> -
> =A0struct ceph_entity_inst {
> =A0 =A0 =A0 =A0struct ceph_entity_name name;
> =A0 =A0 =A0 =A0struct ceph_entity_addr addr;
> @@ -93,24 +89,32 @@ struct ceph_entity_inst {
> =A0#define CEPH_MSGR_TAG_ACK =A0 =A0 =A0 =A0 =A0 8 =A0/* message ack =
*/
> =A0#define CEPH_MSGR_TAG_KEEPALIVE =A0 =A0 9 =A0/* just a keepalive b=
yte! */
> =A0#define CEPH_MSGR_TAG_BADPROTOVER =A010 =A0/* bad protocol version=
 */
> +#define CEPH_MSGR_TAG_BADAUTHORIZER 11 /* bad authorizer */
> +#define CEPH_MSGR_TAG_FEATURES =A0 =A0 =A012 /* insufficient feature=
s */
> +#define CEPH_MSGR_TAG_SEQ =A0 =A0 =A0 =A0 =A0 13 /* 64-bit int follo=
ws with seen
> seq number */
>
>
> =A0/*
> =A0* connection negotiation
> =A0*/
> =A0struct ceph_msg_connect {
> + =A0 =A0 =A0 __le64 features; =A0 =A0 /* supported feature bits */
> =A0 =A0 =A0 =A0__le32 host_type; =A0 =A0/* CEPH_ENTITY_TYPE_* */
> =A0 =A0 =A0 =A0__le32 global_seq; =A0 /* count connections initiated =
by this host */
> =A0 =A0 =A0 =A0__le32 connect_seq; =A0/* count connections initiated =
in this session
> */
> =A0 =A0 =A0 =A0__le32 protocol_version;
> + =A0 =A0 =A0 __le32 authorizer_protocol;
> + =A0 =A0 =A0 __le32 authorizer_len;
> =A0 =A0 =A0 =A0__u8 =A0flags; =A0 =A0 =A0 =A0 /* CEPH_MSG_CONNECT_* *=
/
> =A0} __attribute__ ((packed));
>
> =A0struct ceph_msg_connect_reply {
> =A0 =A0 =A0 =A0__u8 tag;
> + =A0 =A0 =A0 __le64 features; =A0 =A0 /* feature bits for this sessi=
on */
> =A0 =A0 =A0 =A0__le32 global_seq;
> =A0 =A0 =A0 =A0__le32 connect_seq;
> =A0 =A0 =A0 =A0__le32 protocol_version;
> + =A0 =A0 =A0 __le32 authorizer_len;
> =A0 =A0 =A0 =A0__u8 flags;
> =A0} __attribute__ ((packed));
>
> @@ -120,8 +124,9 @@ struct ceph_msg_connect_reply {
> =A0/*
> =A0* message header
> =A0*/
> -struct ceph_msg_header {
> +struct ceph_msg_header_old {
> =A0 =A0 =A0 =A0__le64 seq; =A0 =A0 =A0 /* message seq# for this sessi=
on */
> + =A0 =A0 =A0 __le64 tid; =A0 =A0 =A0 /* transaction id */
> =A0 =A0 =A0 =A0__le16 type; =A0 =A0 =A0/* message type */
> =A0 =A0 =A0 =A0__le16 priority; =A0/* priority. =A0higher value =3D=3D=
 higher priority */
> =A0 =A0 =A0 =A0__le16 version; =A0 /* version of message encoding */
> @@ -133,10 +138,30 @@ struct ceph_msg_header {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 receiver: mas=
k against ~PAGE_MASK */
>
> =A0 =A0 =A0 =A0struct ceph_entity_inst src, orig_src;
> - =A0 =A0 =A0 __le32 dst_erank;
> + =A0 =A0 =A0 __le32 reserved;
> + =A0 =A0 =A0 __le32 crc; =A0 =A0 =A0 /* header crc32c */
> +} __attribute__ ((packed));
> +
> +
> +struct ceph_msg_header {
> + =A0 =A0 =A0 __le64 seq; =A0 =A0 =A0 /* message seq# for this sessio=
n */
> + =A0 =A0 =A0 __le64 tid; =A0 =A0 =A0 /* transaction id */
> + =A0 =A0 =A0 __le16 type; =A0 =A0 =A0/* message type */
> + =A0 =A0 =A0 __le16 priority; =A0/* priority. =A0higher value =3D=3D=
 higher priority */
> + =A0 =A0 =A0 __le16 version; =A0 /* version of message encoding */
> +
> + =A0 =A0 =A0 __le32 front_len; /* bytes in main payload */
> + =A0 =A0 =A0 __le32 middle_len;/* bytes in middle payload */
> + =A0 =A0 =A0 __le32 data_len; =A0/* bytes of data payload */
> + =A0 =A0 =A0 __le16 data_off; =A0/* sender: include full offset;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0receiver: ma=
sk against ~PAGE_MASK */
> +
> + =A0 =A0 =A0 struct ceph_entity_name src;
> + =A0 =A0 =A0 __le32 reserved;
> =A0 =A0 =A0 =A0__le32 crc; =A0 =A0 =A0 /* header crc32c */
> =A0} __attribute__ ((packed));
>
> +
> =A0#define CEPH_MSG_PRIO_LOW =A0 =A0 64
> =A0#define CEPH_MSG_PRIO_DEFAULT 127
> =A0#define CEPH_MSG_PRIO_HIGH =A0 =A0196
> diff --git a/wireshark/ceph/packet-ceph.c b/wireshark/ceph/packet-cep=
h.c
> index 754478d..5acdd43 100644
> --- a/wireshark/ceph/packet-ceph.c
> +++ b/wireshark/ceph/packet-ceph.c
> @@ -18,18 +18,21 @@
> =A0# include "config.h"
> =A0#endif
>
> +
> =A0#include <stdio.h>
> =A0#include <glib.h>
> =A0#include <epan/packet.h>
> +#include <epan/tvbuff.h>
> +#include <epan/tvbuff-int.h>
> +
> =A0#include <epan/dissectors/packet-tcp.h>
>
> =A0#include "types.h"
> -
> =A0#include "crc32c.h"
> -
> =A0#include <string.h>
>
> =A0#define PROTO_TAG_CEPH "CEPH"
> +#define AUTH_LEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 174
>
> =A0/* Wireshark ID of the CEPH protocol */
> =A0static int proto_ceph =3D -1;
> @@ -69,6 +72,14 @@ static guint32 global_ceph_max_mon_port =3D 6799;
> =A0#define PROTO_ADD_TEXT(type, s, field, modifier)\
> =A0 =A0 =A0 =A0proto_tree_add_text(tree, tvb, offset + offsetof(type,=
 field),
> sizeof(s->field), "" #field ": " modifier, s->field);
>
> +#define PROTO_ADD_SIMPLE_TEXT(tree,getter,format,var)\
> + =A0 =A0 =A0 do { \
> + =A0 =A0 =A0 =A0 =A0 var =3D getter(tvb,offset); \
> + =A0 =A0 =A0 =A0 =A0 proto_tree_add_text(tree, tvb, offset, sizeof(v=
ar), format,
> var);\
> + =A0 =A0 =A0 =A0 =A0 offset +=3D sizeof(var); \
> + =A0 =A0 =A0 } while(0)
> +
> +
> =A0#define PROTO_ADD_ITEM(tree, type, hf, s, field) \
> =A0 =A0 =A0 =A0proto_tree_add_item(tree, hf, tvb, offset + offsetof(t=
ype, field),
> sizeof(s->field), TRUE);
>
> @@ -91,6 +102,11 @@ static const value_string packettypenames[] =3D {
> =A0 =A0 =A0 =A0{ 11, "Client Mount Ack" },
> =A0 =A0 =A0 =A0{ 12, "Client Unmount" },
> =A0 =A0 =A0 =A0{ 13, "Statfs" },
> + =A0 =A0 =A0 { 14, "Statfs Reply" },
> + =A0 =A0 =A0 { 15, "Mon Subscribe" },
> + =A0 =A0 =A0 { 16, "Mon Subscribe Ack" },
> + =A0 =A0 =A0 { 17, "Authentication" },
> + =A0 =A0 =A0 { 18, "Authentication reply" },
> =A0 =A0 =A0 =A0{ 20, "MDS Get Map" },
> =A0 =A0 =A0 =A0{ 21, "MDS Map" },
> =A0 =A0 =A0 =A0{ 22, "Client Session" },
> @@ -101,10 +117,14 @@ static const value_string packettypenames[] =3D=
 {
> =A0 =A0 =A0 =A0{ 0x310, "Client Caps" },
> =A0 =A0 =A0 =A0{ 0x311, "Client Lease" },
> =A0 =A0 =A0 =A0{ 0x312, "Client Snap" },
> + =A0 =A0 =A0 { 0x313, "Client Cap Release" },
> =A0 =A0 =A0 =A0{ 40, "OSD Get Map" },
> =A0 =A0 =A0 =A0{ 41, "OSD Map" },
> =A0 =A0 =A0 =A0{ 42, "OSD Op" },
> =A0 =A0 =A0 =A0{ 43, "OSD Op Reply" },
> + =A0 =A0 =A0 { 44, "Watch Notify" },
> + =A0 =A0 =A0 { 48, "Poolop Reply" },
> + =A0 =A0 =A0 { 49, "Poolop" },
> =A0 =A0 =A0 =A0{ 0, NULL }
> =A0};
>
> @@ -168,7 +188,11 @@ static gint hf_ceph_footer_flags =3D -1;
> =A0static gint hf_ceph_footer_front_crc =3D -1;
> =A0static gint hf_ceph_footer_middle_crc =3D -1;
> =A0static gint hf_ceph_footer_data_crc =3D -1;
> -
> +static gint hf_ceph_monmap =3D -1;
> +static gint hf_ceph_mdsmap =3D -1;
> +static gint hf_ceph_mdsnode =3D -1;
> +static gint hf_ceph_auth_reply =3D -1;
> +static gint hf_ceph_pgpools =3D -1;
>
> =A0/* These are the ids of the subtrees that we may be creating */
> =A0static gint ett_ceph =3D -1;
> @@ -183,6 +207,65 @@ static gint ett_ceph_data =3D -1;
> =A0static gint ett_ceph_footer =3D -1;
>
>
> +const char *ceph_cap_op_name(int op)
> +{
> + =A0 =A0 =A0 =A0char* plop =3D malloc(16*sizeof(char));
> + =A0 =A0 =A0 =A0sprintf(plop,"%i",op);
> + =A0 =A0 =A0 =A0switch (op) {
> + =A0 =A0 =A0 =A0case CEPH_CAP_OP_GRANT: return "grant";
> + =A0 =A0 =A0 =A0case CEPH_CAP_OP_REVOKE: return "revoke";
> + =A0 =A0 =A0 =A0case CEPH_CAP_OP_TRUNC: return "trunc";
> + =A0 =A0 =A0 =A0case CEPH_CAP_OP_EXPORT: return "export";
> + =A0 =A0 =A0 =A0case CEPH_CAP_OP_IMPORT: return "import";
> + =A0 =A0 =A0 =A0case CEPH_CAP_OP_UPDATE: return "update";
> + =A0 =A0 =A0 =A0case CEPH_CAP_OP_DROP: return "drop";
> + =A0 =A0 =A0 =A0case CEPH_CAP_OP_FLUSH: return "flush";
> + =A0 =A0 =A0 =A0case CEPH_CAP_OP_FLUSH_ACK: return "flush_ack";
> + =A0 =A0 =A0 =A0case CEPH_CAP_OP_FLUSHSNAP: return "flushsnap";
> + =A0 =A0 =A0 =A0case CEPH_CAP_OP_FLUSHSNAP_ACK: return "flushsnap_ac=
k";
> + =A0 =A0 =A0 =A0case CEPH_CAP_OP_RELEASE: return "release";
> + =A0 =A0 =A0 =A0case CEPH_CAP_OP_RENEW: return "renew";
> + =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0return plop;
> +}
> +
> +const char *ceph_mds_op_name(int op)
> +{
> + =A0char* plop =3D malloc(16*sizeof(char));
> + =A0 =A0 =A0 =A0 sprintf(plop,"%i",op);
> + =A0 =A0 =A0 =A0switch (op) {
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_LOOKUP: =A0return "lookup";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_LOOKUPHASH: =A0return "lookuphash";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_LOOKUPPARENT: =A0return "lookuppare=
nt";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_LOOKUPINO: =A0return "lookupino";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_GETATTR: =A0return "getattr";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_SETXATTR: return "setxattr";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_SETATTR: return "setattr";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_RMXATTR: return "rmxattr";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_SETLAYOUT: return "setlayou";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_SETDIRLAYOUT: return "setdirlayout"=
;
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_READDIR: return "readdir";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_MKNOD: return "mknod";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_LINK: return "link";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_UNLINK: return "unlink";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_RENAME: return "rename";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_MKDIR: return "mkdir";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_RMDIR: return "rmdir";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_SYMLINK: return "symlink";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_CREATE: return "create";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_OPEN: return "open";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_LOOKUPSNAP: return "lookupsnap";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_LSSNAP: return "lssnap";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_MKSNAP: return "mksnap";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_RMSNAP: return "rmsnap";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_SETFILELOCK: return "setfilelock";
> + =A0 =A0 =A0 =A0case CEPH_MDS_OP_GETFILELOCK: return "getfilelock";
> + =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0return plop;
> +}
> +
> +
> +
> =A0void proto_reg_handoff_ceph(void)
> =A0{
> =A0 =A0 =A0 =A0static gboolean initialized=3DFALSE;
> @@ -207,8 +290,23 @@ void proto_register_ceph (void)
> =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0static hf_register_info hf[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ &hf_ceph,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "Data", "ceph.data", =
=46T_NONE, BASE_NONE, NULL,
> 0x0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "Data", "ceph.data", =
=46T_NONE , BASE_NONE, NULL,
> 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"CEPH PDU", HFILL }},
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &hf_ceph_pgpools,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "pgpools", "ceph.pgpo=
ols", FT_NONE , BASE_NONE,
> NULL, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CEPH PG Pools", HFILL =
}},
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &hf_ceph_monmap,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "MON map", "ceph.monm=
ap", FT_NONE , BASE_NONE,
> NULL, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CEPH MON map", HFILL }=
},
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &hf_ceph_mdsmap,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "MDS map", "ceph.mdsm=
ap", FT_NONE , BASE_NONE,
> NULL, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CEPH MDS map", HFILL }=
},
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &hf_ceph_mdsnode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "MDS node", "ceph.mds=
node", FT_NONE , BASE_NONE,
> NULL, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CEPH MDS node", HFILL =
}},
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &hf_ceph_auth_reply,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "Authentication reply=
", "ceph.auth.reply",
> FT_NONE , BASE_NONE, NULL, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CEPH Authentication re=
ply", HFILL }},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ &hf_ceph_header,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ "Header", "ceph.head=
er", FT_NONE, BASE_NONE,
> NULL, 0x0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"CEPH Header", HFILL }=
},
> @@ -219,7 +317,7 @@ void proto_register_ceph (void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ "Ceph Entity Type", =
"ceph.entity.type",
> FT_UINT32, BASE_DEC, NULL, 0x0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Ceph Entity Type", HF=
ILL }},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ &hf_ceph_entity_num,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "Ceph Entity Num", "c=
eph.entity.num", FT_UINT32,
> BASE_DEC, NULL, 0x0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "Ceph Entity Num", "c=
eph.entity.num", FT_UINT64,
> BASE_DEC, NULL, 0x0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Ceph Entity Num", HFI=
LL }},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ &hf_ceph_entity_addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ "Ceph Entity Addr", =
"ceph.entity.addr", FT_NONE,
> BASE_NONE, NULL, 0x0,
> @@ -339,10 +437,10 @@ void proto_register_ceph (void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ "Front", "ceph.front=
", FT_NONE, BASE_NONE, NULL,
> 0x0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Ceph Front", HFILL }}=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ &hf_ceph_data,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "Data", "ceph.data", =
=46T_NONE, BASE_HEX, NULL,
> 0x0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "Data", "ceph.data", =
=46T_NONE, BASE_NONE, NULL,
> 0x0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Ceph Data", HFILL }},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ &hf_ceph_footer,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "Footer", "ceph.foote=
r", FT_NONE, BASE_HEX,
> NULL, 0x0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "Footer", "ceph.foote=
r", FT_NONE, BASE_NONE,
> NULL, 0x0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Ceph Footer", HFILL }=
},
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ &hf_ceph_footer_flags,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ "flags", "ceph.foote=
r.flags", FT_UINT32,
> BASE_HEX, NULL, 0x0,
> @@ -367,7 +465,7 @@ void proto_register_ceph (void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&ett_ceph_text,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&ett_ceph_data,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&ett_ceph_front,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 &ett_ceph_footer
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 &ett_ceph_footer,
> =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0//if (proto_ceph =3D=3D -1) { /* execute protocol init=
ialization only
> once */
> =A0 =A0 =A0 =A0proto_ceph =3D proto_register_protocol ("CEPH Protocol=
", "CEPH",
> "ceph");
> @@ -430,40 +528,30 @@ static guint32 dissect_ceph_entity_addr(tvbuff_=
t
> *tvb, proto_tree *tree, guint32
>
> =A0static guint32 dissect_ceph_fsid(tvbuff_t *tvb, proto_tree *tree, =
guint32
> offset)
> =A0{
> - =A0 =A0 =A0 proto_tree *ceph_entity_tree =3D NULL;
> - =A0 =A0 =A0 proto_item *ceph_sub_item =3D NULL;
> - =A0 =A0 =A0 struct ceph_fsid *fsid;
> -
> - =A0 =A0 =A0 fsid =3D (struct ceph_fsid *)tvb_get_ptr(tvb, offset, s=
izeof(struct
> ceph_fsid));
> -
> - =A0 =A0 =A0 ceph_sub_item =3D proto_tree_add_item( tree, hf_ceph_fs=
id, tvb,
> offset, sizeof(struct ceph_entity_addr), TRUE );
> - =A0 =A0 =A0 ceph_entity_tree =3D proto_item_add_subtree(ceph_sub_it=
em,
> ett_ceph);
> -
> - =A0 =A0 =A0 proto_tree_add_item(ceph_entity_tree, hf_ceph_connect_e=
rank, tvb,
> offset, 4, TRUE);
> - =A0 =A0 =A0 proto_tree_add_item(ceph_entity_tree, hf_ceph_connect_n=
once, tvb,
> offset+4, 4, TRUE);
> -
> - =A0 =A0 =A0 proto_tree_add_text(tree, tvb, 0,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(=
struct ceph_fsid), "fsid: " FMT_INO
> "." FMT_INO, ((unsigned long long *)fsid->fsid)[0], ((unsigned long l=
ong
> *)fsid->fsid)[1]);
> -
> + =A0 =A0 =A0 struct ceph_fsid fsid;
> + =A0 =A0 =A0 guint32 * fsid_dec =3D NULL;
> + =A0 =A0 =A0 fsid_dec =3D malloc(4*sizeof(guint32));
> + =A0 =A0 =A0 fsid =3D *(struct ceph_fsid *)tvb_get_ptr(tvb, offset, =
sizeof(struct
> ceph_fsid));
> + =A0 =A0 =A0 memcpy(fsid_dec,fsid.fsid,4*sizeof(guint32));
> + =A0 =A0 =A0 proto_tree_add_text(tree, tvb, offset,sizeof(struct cep=
h_fsid),
> "fsid: %x-%x-%x-%x",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ntohl(fsid_dec[0]),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ntohl(fsid_dec[1]),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ntohl(fsid_dec[2]),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ntohl(fsid_dec[3])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 );
> =A0 =A0 =A0 =A0offset +=3D sizeof(struct ceph_fsid);
> -
> =A0 =A0 =A0 =A0return offset;
> =A0}
>
> -static guint32 dissect_ceph_entity_inst(tvbuff_t *tvb, proto_tree *t=
ree,
> guint32 offset)
> +guint32 dissect_ceph_entity_name(tvbuff_t *tvb, proto_tree *tree, gu=
int32
> offset)
> =A0{
> - =A0 =A0 =A0 proto_tree *ceph_entity_tree =3D NULL;
> - =A0 =A0 =A0 proto_item *ceph_sub_item =3D NULL;
> -
> - =A0 =A0 =A0 ceph_sub_item =3D proto_tree_add_item( tree, hf_ceph_en=
tity_addr,
> tvb, offset, sizeof(struct ceph_entity_addr), TRUE );
> - =A0 =A0 =A0 ceph_entity_tree =3D proto_item_add_subtree(ceph_sub_it=
em,
> ett_ceph);
> - =A0 =A0 =A0 proto_tree_add_item(ceph_entity_tree, hf_ceph_entity_ty=
pe, tvb,
> offset, 4, TRUE);
> - =A0 =A0 =A0 proto_tree_add_item(ceph_entity_tree, hf_ceph_entity_nu=
m, tvb,
> offset+4, 4, TRUE);
> - =A0 =A0 =A0 offset +=3D 8;
> - =A0 =A0 =A0 offset =3D dissect_ceph_entity_addr(tvb, ceph_entity_tr=
ee, offset);
> + =A0 =A0 =A0 proto_tree_add_item(tree, hf_ceph_entity_type, tvb, off=
set, 1,
> TRUE);
> + =A0 =A0 =A0 proto_tree_add_item(tree, hf_ceph_entity_num, tvb, offs=
et+1, 8,
> TRUE);
> + =A0 =A0 =A0 offset +=3D sizeof(struct ceph_entity_name);
> =A0 =A0 =A0 =A0return offset;
> =A0}
>
> +
> =A0static guint32 dissect_ceph_footer(tvbuff_t *tvb, proto_tree *tree=
,
> guint32 offset, guint32 data_crc)
> =A0{
> =A0 =A0 =A0 =A0proto_tree *ceph_footer_tree =3D NULL;
> @@ -472,13 +560,13 @@ static guint32 dissect_ceph_footer(tvbuff_t *tv=
b,
> proto_tree *tree, guint32 offs
>
> =A0 =A0 =A0 =A0ceph_sub_item =3D proto_tree_add_item( tree, hf_ceph_f=
ooter, tvb,
> offset, sizeof(struct ceph_msg_footer), TRUE );
> =A0 =A0 =A0 =A0ceph_footer_tree =3D proto_item_add_subtree(ceph_sub_i=
tem, ett_ceph);
> - =A0 =A0 =A0 proto_tree_add_item(ceph_footer_tree, hf_ceph_footer_fl=
ags, tvb,
> offset, 4, TRUE);
> - =A0 =A0 =A0 proto_tree_add_item(ceph_footer_tree, hf_ceph_footer_fr=
ont_crc,
> tvb, offset+4, 4, TRUE);
> - =A0 =A0 =A0 proto_tree_add_item(ceph_footer_tree, hf_ceph_footer_mi=
ddle_crc,
> tvb, offset+8, 4, TRUE);
> - =A0 =A0 =A0 data_crc_item =3D proto_tree_add_item(ceph_footer_tree,
> hf_ceph_footer_data_crc, tvb, offset+12, 4, TRUE);
> + =A0 =A0 =A0 proto_tree_add_item(ceph_footer_tree, hf_ceph_footer_fr=
ont_crc,
> tvb, offset, 4, TRUE);
> + =A0 =A0 =A0 proto_tree_add_item(ceph_footer_tree, hf_ceph_footer_mi=
ddle_crc,
> tvb, offset+4, 4, TRUE);
> + =A0 =A0 =A0 data_crc_item =3D proto_tree_add_item(ceph_footer_tree,
> hf_ceph_footer_data_crc, tvb, offset+8, 4, TRUE);
> =A0 =A0 =A0 =A0proto_item_append_text(data_crc_item, " (calculated %x=
)",
> data_crc);
> + =A0 =A0 =A0 proto_tree_add_item(ceph_footer_tree, hf_ceph_footer_fl=
ags, tvb,
> offset+12, 1, TRUE);
>
> - =A0 =A0 =A0 offset +=3D 12;
> + =A0 =A0 =A0 offset +=3D 13;
> =A0 =A0 =A0 =A0return offset;
> =A0}
>
> @@ -488,6 +576,7 @@ static guint32 dissect_ceph_client_connect(tvbuff=
_t
> *tvb, proto_tree *tree, guin
> =A0 =A0 =A0 =A0proto_item *ceph_sub_item =3D NULL;
> =A0 =A0 =A0 =A0proto_item *ceph_item =3D proto_tree_get_parent(tree);
> =A0 =A0 =A0 =A0struct ceph_msg_connect *msg;
> + =A0 =A0 =A0 guint32 auth_len =3D 0;
>
> =A0 =A0 =A0 =A0offset =3D dissect_ceph_banner(tvb, tree, offset);
>
> @@ -507,12 +596,19 @@ static guint32 dissect_ceph_client_connect(tvbu=
ff_t
> *tvb, proto_tree *tree, guin
> =A0#endif
>
> =A0 =A0 =A0 =A0msg =3D (struct ceph_msg_connect *)tvb_get_ptr(tvb, of=
fset,
> sizeof(struct ceph_msg_connect));
> + =A0 =A0 =A0 PROTO_ADD_TEXT(struct ceph_msg_connect, msg, features, =
"%lld");
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_msg_connect, msg, host_type=
, "%d");
> - =A0 =A0 =A0 PROTO_ADD_TEXT(struct ceph_msg_connect, msg, global_seq=
, "%d");
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_msg_connect, msg, connect_s=
eq, "%d");
> + =A0 =A0 =A0 PROTO_ADD_TEXT(struct ceph_msg_connect, msg, global_seq=
, "%d");
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_msg_connect, msg, protocol_=
version,
> "%d");
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_msg_connect, msg, flags, "%=
x");
> -
> + =A0 =A0 =A0 PROTO_ADD_TEXT(struct ceph_msg_connect, msg, authorizer=
_protocol,
> "%d");
> + =A0 =A0 =A0 PROTO_ADD_TEXT(struct ceph_msg_connect, msg, authorizer=
_len,
> "%d");
> + =A0 =A0 =A0 offset +=3D sizeof(struct ceph_msg_connect);
> + =A0 =A0 =A0 auth_len =3D msg->authorizer_len;
> + =A0 =A0 =A0 auth_len =3D 174;
> + =A0 =A0 =A0 proto_tree_add_text(tree,tvb, offset, auth_len, "Authen=
tication
> key");
> + =A0 =A0 =A0 offset +=3D auth_len;
> =A0 =A0 =A0 =A0return offset;
> =A0}
>
> @@ -534,9 +630,11 @@ static guint32 dissect_ceph_server_connect(tvbuf=
f_t
> *tvb, proto_tree *tree, guin
> =A0 =A0 =A0 =A0offset =3D dissect_ceph_entity_addr(tvb, ceph_header_t=
ree, offset);
> =A0 =A0 =A0 =A0msg =3D (struct ceph_msg_connect_reply *)tvb_get_ptr(t=
vb, offset,
> sizeof(struct ceph_msg_connect_reply));
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_msg_connect_reply, msg, tag=
, "%d");
> + =A0 =A0 =A0 PROTO_ADD_TEXT(struct ceph_msg_connect_reply, msg, feat=
ures,
> "%lld");
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_msg_connect_reply, msg, glo=
bal_seq,
> "%d");
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_msg_connect_reply, msg, con=
nect_seq,
> "%d");
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_msg_connect_reply, msg,
> protocol_version, "%d");
> + =A0 =A0 =A0 PROTO_ADD_TEXT(struct ceph_msg_connect_reply, msg, auth=
orizer_len,
> "%d");
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_msg_connect_reply, msg, fla=
gs, "%x");
>
> =A0 =A0 =A0 =A0return offset;
> @@ -594,7 +692,7 @@ static guint32 dissect_ceph_mon_statfs(tvbuff_t *=
tvb,
> proto_tree *tree, guint32
> =A0 =A0 =A0 =A0req =3D (struct ceph_mon_statfs *)tvb_get_ptr(tvb, off=
set,
> sizeof(struct ceph_mon_statfs));
>
> =A0 =A0 =A0 =A0dissect_ceph_fsid(tvb, tree, offset + offsetof(struct
> ceph_mon_statfs, fsid));
> - =A0 =A0 =A0 PROTO_ADD_TEXT(struct ceph_mon_statfs, req, tid, "%lld"=
);
> + =A0 =A0 =A0 PROTO_ADD_TEXT(struct ceph_mon_statfs, req,
> monhdr.session_mon_tid, "%lld");
>
> =A0 =A0 =A0 =A0return offset + sizeof(struct ceph_mon_statfs);
> =A0}
> @@ -606,7 +704,8 @@ static guint32 dissect_ceph_mon_statfs_reply(tvbu=
ff_t
> *tvb, proto_tree *tree, gu
> =A0 =A0 =A0 =A0req =3D (struct ceph_mon_statfs_reply *)tvb_get_ptr(tv=
b, offset,
> sizeof(struct ceph_mon_statfs_reply));
>
> =A0 =A0 =A0 =A0dissect_ceph_fsid(tvb, tree, offset + offsetof(struct
> ceph_mon_statfs_reply, fsid));
> - =A0 =A0 =A0 PROTO_ADD_TEXT(struct ceph_mon_statfs_reply, req, tid, =
"%lld");
> + =A0 =A0 =A0 PROTO_ADD_TEXT(struct ceph_mon_statfs_reply, req, versi=
on,
> "%lld");
> +
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_mon_statfs_reply, req, st.k=
b, "%lld");
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_mon_statfs_reply, req, st.k=
b_used,
> "%lld");
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_mon_statfs_reply, req, st.k=
b_avail,
> "%lld");
> @@ -646,7 +745,7 @@ static guint32
> dissect_ceph_client_mds_request(tvbuff_t *tvb, packet_info *pinfo
>
> =A0 =A0 =A0 =A0head =3D (struct ceph_mds_request_head *)tvb_get_ptr(t=
vb, offset,
> sizeof(struct ceph_mds_request_head));
>
> - =A0 =A0 =A0 PROTO_ADD_TEXT(struct ceph_mds_request_head, head, tid,=
 "%lld");
> + =A0 =A0 =A0 //PROTO_ADD_TEXT(struct ceph_mds_request_head, head, ti=
d, "%lld");
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_mds_request_head, head,
> oldest_client_tid, "%lld");
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_mds_request_head, head, mds=
map_epoch,
> "%d");
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_mds_request_head, head, num=
_retry,
> "%d");
> @@ -695,6 +794,7 @@ static guint32
> dissect_ceph_client_mds_request(tvbuff_t *tvb, packet_info *pinfo
> =A0 =A0 =A0 =A0case CEPH_MDS_OP_LSSNAP:
> =A0 =A0 =A0 =A0case CEPH_MDS_OP_MKSNAP:
> =A0 =A0 =A0 =A0case CEPH_MDS_OP_RMSNAP:
> + =A0 =A0 =A0 case CEPH_MDS_OP_CREATE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> @@ -730,7 +830,7 @@ static guint32 dissect_ceph_client_mds_reply(tvbu=
ff_t
> *tvb, packet_info *pinfo,
>
> =A0 =A0 =A0 =A0head =3D (struct ceph_mds_reply_head *)tvb_get_ptr(tvb=
, offset,
> sizeof(struct ceph_mds_reply_head));
>
> - =A0 =A0 =A0 PROTO_ADD_TEXT(struct ceph_mds_reply_head, head, tid, "=
%lld");
> + =A0 =A0 =A0 //PROTO_ADD_TEXT(struct ceph_mds_reply_head, head, tid,=
 "%lld");
>
> =A0 =A0 =A0 =A0proto_tree_add_text(tree, tvb, offsetof(struct ceph_md=
s_reply_head,
> op),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof=
(head->op), "op: %d (%s)", head->op,
> ceph_mds_op_name(head->op));
> @@ -789,7 +889,7 @@ static guint32
> dissect_ceph_client_mds_caps_request(tvbuff_t *tvb, packet_info *
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_mds_caps, head, snap_follow=
s, "%llu");
> =A0 =A0 =A0 =A0PROTO_ADD_TEXT(struct ceph_mds_caps, head, snap_trace_=
len, "%d");
>
> -#define CAPS_REQ_ADD_TIME(field) PROTO_ADD_TIME(tvb, tree, struct
> ceph_mds_caps, offset, head, field, field)
> +#define CAPS_REQ_ADD_TIME(field) PROTO_ADD_TIME(tvb, tree, struct
> ceph_mds_caps, offset, head, field, field)
> =A0 =A0 =A0 =A0CAPS_REQ_ADD_TIME(mtime);
> =A0 =A0 =A0 =A0CAPS_REQ_ADD_TIME(atime);
> =A0 =A0 =A0 =A0CAPS_REQ_ADD_TIME(ctime);
> @@ -801,9 +901,163 @@ static guint32
> dissect_ceph_client_mds_caps_request(tvbuff_t *tvb, packet_info *
> =A0 =A0 =A0 =A0return orig_ofs + sizeof(struct ceph_mds_caps);
> =A0}
>
> -static guint32 dissect_ceph_client_front(tvbuff_t *tvb, packet_info
> *pinfo, proto_tree *tree, guint32 offset, guint16 type)
> +static guint32 dissect_ceph_auth_reply(tvbuff_t *tvb, proto_tree *tr=
ee,
> guint32 offset){
> + =A0 =A0 =A0 guint32 protocol, result, payload_len,str_len;
> + =A0 =A0 =A0 guint64 global_id;
> + =A0 =A0 =A0 proto_item *ceph_sub_item =3D NULL;
> + =A0 =A0 =A0 proto_item *ceph_item =3D proto_tree_get_parent(tree);
> + =A0 =A0proto_tree *ceph_auth_reply_tree;
> +
> + =A0 =A0ceph_auth_reply_tree =3D proto_item_add_subtree(ceph_item, e=
tt_ceph);
> + =A0 =A0 =A0 ceph_sub_item =3D proto_tree_add_item( tree, hf_ceph_au=
th_reply,
> tvb, offset, 16, TRUE );
> + =A0 =A0ceph_auth_reply_tree =3D proto_item_add_subtree(ceph_sub_ite=
m,
> ett_ceph);
> +
> + =A0 =A0PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"p=
rotocol:
> %d",protocol);
> + =A0 =A0PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"r=
esult:
> %d",result);
> +
> =A0PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letoh64,"global=
_id:
> %lu", global_id);
> +
> =A0PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"payload=
_len:
> %d",payload_len);
> +
> + =A0 =A0str_len =3D tvb_get_letohl(tvb,offset+payload_len);
> + =A0 =A0proto_tree_add_text(ceph_auth_reply_tree, tvb, offset+payloa=
d_len,
> str_len,"%s",tvb_get_const_stringz(tvb,offset,&str_len));
> + =A0 =A0 =A0 return offset;
> +}
> +
> +static guint32 dissect_ceph_pgpools(tvbuff_t *tvb, proto_tree *tree,
> guint32 offset){
> + =A0 =A0 =A0 guint32 n, i, pool;
> + =A0 =A0 =A0 proto_item *ceph_item =3D proto_tree_get_parent(tree);
> + =A0 =A0 =A0 proto_tree *ceph_pgpools_tree;
> + =A0 =A0 =A0 proto_item *ceph_sub_item =3D NULL;
> + =A0 =A0 =A0 ceph_pgpools_tree =3D proto_item_add_subtree(ceph_item,=
 ett_ceph);
> + =A0 =A0 =A0 ceph_sub_item =3D proto_tree_add_item(tree, hf_ceph_pgp=
ools, tvb,
> offset, -1, TRUE );
> + =A0 =A0 =A0 ceph_pgpools_tree =3D proto_item_add_subtree(ceph_sub_i=
tem,
> ett_ceph);
> + =A0 =A0PROTO_ADD_SIMPLE_TEXT(ceph_pgpools_tree,tvb_get_letohl," %d
> pool(s)",n);
> + =A0 =A0for ( i =3D 0; i<n; i++){
> +
> =A0PROTO_ADD_SIMPLE_TEXT(ceph_pgpools_tree,tvb_get_letohl,"data_pg_po=
ol:
> %d",pool);
> +
> =A0PROTO_ADD_SIMPLE_TEXT(ceph_pgpools_tree,tvb_get_letohl,"cas_pg_poo=
l:
> %d",pool);
> + =A0 =A0}
> + =A0 =A0 =A0 return offset;
> +}
> +static guint32 dissect_ceph_mdsmap_node(tvbuff_t *tvb, proto_tree *t=
ree,
> guint32 offset){
> + =A0 =A0 =A0 guint8 infoversion;
> + =A0 =A0 =A0 guint32 field, num_export_targets, i;
> + =A0 =A0 =A0 guint64 global_id, field64;
> + =A0 =A0 =A0 proto_item *ceph_item =3D proto_tree_get_parent(tree);
> + =A0 =A0 =A0 proto_tree *ceph_mdsnode_tree;
> + =A0 =A0 =A0 proto_item *ceph_sub_item =3D NULL;
> + =A0 =A0 =A0 struct ceph_timespec *cephtime =3D NULL;
> + =A0 =A0 =A0 time_t time;
> + =A0 =A0 =A0 ceph_mdsnode_tree =3D proto_item_add_subtree(ceph_item,=
 ett_ceph);
> + =A0 =A0 =A0 ceph_sub_item =3D proto_tree_add_item(tree, hf_ceph_mds=
node, tvb,
> offset, -1, TRUE );
> + =A0 =A0 =A0 ceph_mdsnode_tree =3D proto_item_add_subtree(ceph_sub_i=
tem,
> ett_ceph);
> +
> + =A0 =A0 =A0 PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letoh64=
,"Global
> ID: %ld",global_id);
> + =A0 =A0 =A0 infoversion =3D *tvb_get_ptr(tvb,offset,sizeof(infovers=
ion));
> + =A0 =A0 =A0 offset++;
> + =A0 =A0 =A0 offset+=3Dsizeof(guint64);
> + =A0 =A0proto_tree_add_text(ceph_mdsnode_tree, tvb, offset,
> sizeof(infoversion), "version: %d", infoversion);
> + =A0 =A0 =A0 PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letoh64=
,"Name
> length: %d",field);
> + =A0 =A0proto_tree_add_text(ceph_mdsnode_tree, tvb, offset, field,"M=
DS name:
> %s",tvb_get_const_stringz(tvb,offset,&field));
> + =A0 =A0offset+=3Dfield-1;
> + =A0 =A0PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"mds:
> %d",field);
> + =A0 =A0PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"inc:
> %d",field);
> + =A0 =A0PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"stat=
e:
> %d",field);
> + =A0 =A0PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letoh64,"sta=
te seq:
> %ld",field64);
> + =A0 =A0 =A0 offset =3D dissect_ceph_entity_addr(tvb, ceph_mdsnode_t=
ree, offset);
> + =A0 =A0 =A0 cephtime =3D (struct ceph_timespec *) tvb_get_ptr(tvb, =
offset,
> sizeof(struct ceph_timespec));
> + =A0 =A0 =A0 time =3D cephtime->tv_sec;
> + =A0 =A0 =A0 proto_tree_add_text(ceph_mdsnode_tree, tvb, offset, siz=
eof(time),
> "Time: %s (%d ns)", ctime(&time), cephtime->tv_nsec);
> + =A0 =A0 =A0 offset +=3D sizeof(struct ceph_timespec);
> + =A0 =A0 =A0 offset +=3D sizeof(guint32);
> + =A0 =A0 =A0 offset +=3D tvb_get_letohl(tvb,offset);
> + =A0 =A0 =A0 offset +=3D sizeof(guint32);
> + =A0 =A0 =A0 //offset ++;
> + =A0 =A0 =A0 if (infoversion >=3D 2 ){
> +
> PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"num_export_ta=
rgets:
> %d",num_export_targets);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 else{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_export_targets =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 for ( i =3D 0; i < num_export_targets ; i++){
> +
> PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"export_target=
:
> %d",field);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return offset;
> +}
> +
> +static guint32 dissect_ceph_mon_map(tvbuff_t *tvb, proto_tree *tree,
> guint32 offset)
> +{
> + =A0 =A0 =A0 guint32 epoch, num_mon, len, i;
> + =A0 =A0 =A0 guint16 version;
> + =A0 =A0 =A0 proto_item *ceph_item =3D proto_tree_get_parent(tree);
> + =A0 =A0 =A0 proto_tree *ceph_monmap_tree;
> + =A0 =A0 =A0 proto_item *ceph_sub_item =3D NULL;
> + =A0 =A0 =A0 ceph_monmap_tree =3D proto_item_add_subtree(ceph_item, =
ett_ceph);
> + =A0 =A0 =A0 len =3D tvb_get_letohl(tvb,offset);
> + =A0 =A0 =A0 ceph_sub_item =3D proto_tree_add_item(tree, hf_ceph_mon=
map, tvb,
> offset, len, TRUE );
> + =A0 =A0 =A0 ceph_monmap_tree =3D proto_item_add_subtree(ceph_sub_it=
em,
> ett_ceph);
> +
> + =A0 =A0 =A0 PROTO_ADD_SIMPLE_TEXT(ceph_monmap_tree,tvb_get_letohl,"=
length:
> %i",len);
> + =A0 =A0 =A0 PROTO_ADD_SIMPLE_TEXT(ceph_monmap_tree,tvb_get_letohs,"=
version:
> %i",version);
> + =A0 =A0 =A0 offset =3D dissect_ceph_fsid(tvb, ceph_monmap_tree, off=
set);
> + =A0 =A0 =A0 PROTO_ADD_SIMPLE_TEXT(ceph_monmap_tree,tvb_get_letohl,"=
epoch:
> %i",epoch);
> + =A0 =A0 =A0 PROTO_ADD_SIMPLE_TEXT(ceph_monmap_tree,tvb_get_letohl,"=
%i
> monitor",num_mon);
> + =A0 =A0 =A0 for (i =3D 0; i < num_mon; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D dissect_ceph_entity_name(tvb=
, ceph_monmap_tree,
> offset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D dissect_ceph_entity_addr(tvb=
, ceph_monmap_tree,
> offset);
> +
> + =A0 =A0 =A0 return offset;
> +}
> +
> +static guint32 dissect_ceph_mds_map(tvbuff_t *tvb, proto_tree *tree,
> guint32 offset)
> +{
> + =A0 =A0 =A0 guint16 version;
> + =A0 =A0 =A0 guint32 epoch, map_len, len, plop, i;
> + =A0 =A0 =A0 guint64 max_filesize;
> + =A0 =A0 =A0 proto_item *ceph_item =3D proto_tree_get_parent(tree);
> + =A0 =A0 =A0 proto_tree *ceph_mdsmap_tree;
> + =A0 =A0 =A0 proto_item *ceph_sub_item =3D NULL;
> + =A0 =A0 =A0 ceph_mdsmap_tree =3D proto_item_add_subtree(ceph_item, =
ett_ceph);
> + =A0 =A0 =A0 len =3D tvb_get_letohl(tvb,offset);
> + =A0 =A0 =A0 ceph_sub_item =3D proto_tree_add_item(tree, hf_ceph_mds=
map, tvb,
> offset, len, TRUE );
> + =A0 =A0 =A0 ceph_mdsmap_tree =3D proto_item_add_subtree(ceph_sub_it=
em,
> ett_ceph);
> + =A0 =A0 =A0 offset =3D dissect_ceph_fsid(tvb, ceph_mdsmap_tree, off=
set);
> + =A0 =A0 =A0 PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"=
epoch:
> %i",epoch);
> + =A0 =A0 =A0 PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"=
map length:
> %i",map_len);
> +
> + =A0 =A0 =A0 PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"=
version:
> %i",version);
> + =A0 =A0 =A0 PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"=
m_epoch:
> %i",plop);
> +
> PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_client_epoch=
:
> %i",plop);
> +
> PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_last_failure=
:
> %i",plop);
> + =A0 =A0 =A0 PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"=
m_root:
> %i",plop);
> +
> PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_session_time=
out:
> %i",plop);
> +
> PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_session_auto=
close:
> %i",plop);
> +
> PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letoh64,"m_maxfile_siz=
e:
> %ld",max_filesize);
> + =A0 =A0 =A0 PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"=
m_max_mds:
> %i",plop);
> + =A0 =A0 =A0 PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"=
n:
> %i",len);
> +
> +
> + =A0 =A0 =A0 for (i =3D 0; i < len; i++){
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0offset =3D dissect_ceph_mdsmap_node(=
tvb, ceph_mdsmap_tree,
> offset);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 offset =3D dissect_ceph_pgpools(tvb, ceph_mdsmap_tree, =
offset);
> + =A0 =A0 =A0 return offset;
> +}
> +
> +static guint32 dissect_ceph_front(tvbuff_t *tvb, packet_info *pinfo,
> proto_tree *tree, guint32 offset, guint16 type)
> =A0{
> =A0 =A0 =A0 =A0switch (type) {
> +/* =A0 =A0 case CEPH_MSG_AUTH:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D dissect_ceph_auth();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;*/
> + =A0 =A0 =A0 case CEPH_MSG_AUTH_REPLY:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D dissect_ceph_auth_reply(tvb,=
 tree, offset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case CEPH_MSG_MON_MAP:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D dissect_ceph_mon_map(tvb, tr=
ee, offset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case CEPH_MSG_MDS_MAP:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D dissect_ceph_mds_map(tvb, tr=
ee, offset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0case CEPH_MSG_STATFS:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0offset =3D dissect_ceph_mon_statfs(tvb=
, tree, offset);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> @@ -835,18 +1089,23 @@ static guint32 dissect_ceph_generic(tvbuff_t *=
tvb,
> packet_info *pinfo, proto_tre
> =A0 =A0 =A0 =A0proto_item *ceph_item =3D proto_tree_get_parent(tree);
> =A0 =A0 =A0 =A0guint32 front_len, middle_len, data_len;
> =A0 =A0 =A0 =A0guint8 tag;
> + =A0 =A0 =A0 guint32 hlen;
> =A0 =A0 =A0 =A0guint32 orig_ofs =3D offset;
> =A0 =A0 =A0 =A0guint16 type;
> =A0 =A0 =A0 =A0guint64 seq;
> =A0 =A0 =A0 =A0struct ceph_msg_header *header;
> =A0 =A0 unsigned int data_crc =3D 0;
>
> + =A0 =A0tag =3D tvb_get_guint8(tvb, offset);
> + =A0 =A0hlen =3D ( tag =3D=3D CEPH_MSGR_TAG_ACK ) ? ACK_MSG_SIZE:0;
> + =A0 =A0hlen +=3D sizeof(struct ceph_msg_header);
> + =A0 =A0hlen++;
> +
> =A0 =A0 =A0 =A0ceph_header_tree =3D proto_item_add_subtree(ceph_item,=
 ett_ceph);
>
> - =A0 =A0 =A0 ceph_sub_item =3D proto_tree_add_item( tree, hf_ceph_he=
ader, tvb,
> offset, -1, TRUE );
> + =A0 =A0 =A0 ceph_sub_item =3D proto_tree_add_item( tree, hf_ceph_he=
ader, tvb,
> offset, hlen, TRUE );
> =A0 =A0 =A0 =A0ceph_header_tree =3D proto_item_add_subtree(ceph_sub_i=
tem, ett_ceph);
>
> - =A0 =A0 =A0 tag =3D tvb_get_guint8(tvb, offset);
>
> =A0 =A0 =A0 =A0if (tag =3D=3D CEPH_MSGR_TAG_ACK) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0proto_tree_add_item(ceph_header_tree, =
hf_ceph_hdr_tag, tvb,
> offset, 1, TRUE);
> @@ -867,23 +1126,22 @@ static guint32 dissect_ceph_generic(tvbuff_t *=
tvb,
> packet_info *pinfo, proto_tre
> =A0 =A0 =A0 =A0PROTO_ADD_ITEM(ceph_header_tree, struct ceph_msg_heade=
r,
> hf_ceph_hdr_middle_len, header, middle_len);
> =A0 =A0 =A0 =A0PROTO_ADD_ITEM(ceph_header_tree, struct ceph_msg_heade=
r,
> hf_ceph_hdr_data_off, header, data_off);
> =A0 =A0 =A0 =A0PROTO_ADD_ITEM(ceph_header_tree, struct ceph_msg_heade=
r,
> hf_ceph_hdr_data_len, header, data_len);
> - =A0 =A0 =A0 dissect_ceph_entity_inst(tvb, ceph_header_tree, offset =
+
> offsetof(struct ceph_msg_header, src));
> - =A0 =A0 =A0 dissect_ceph_entity_inst(tvb, ceph_header_tree, offset =
+
> offsetof(struct ceph_msg_header, orig_src));
> =A0 =A0 =A0 =A0PROTO_ADD_ITEM(ceph_header_tree, struct ceph_msg_heade=
r,
> hf_ceph_hdr_crc, header, crc);
> -
> - =A0 =A0 =A0 offset +=3D sizeof(struct ceph_msg_header);
> -
> +
> + =A0 =A0 =A0 // Bad location
> + =A0 =A0 =A0 dissect_ceph_entity_name(tvb, ceph_header_tree, offset =
+
> offsetof(struct ceph_msg_header, src));
> + =A0 =A0 =A0 //dissect_ceph_entity_inst(tvb, ceph_header_tree, offse=
t +
> offsetof(struct ceph_msg_header, orig_src));
> +
> =A0 =A0 =A0 =A0type =3D TVB_MSG_FIELD(tvb_get_letohl, tvb, orig_ofs, =
type);
> =A0 =A0 =A0 =A0seq =3D TVB_MSG_FIELD(tvb_get_letoh64, tvb, orig_ofs, =
seq);
> =A0 =A0 =A0 =A0front_len =3D TVB_MSG_FIELD(tvb_get_letohs, tvb, orig_=
ofs,
> front_len);
> =A0 =A0 =A0 =A0middle_len =3D TVB_MSG_FIELD(tvb_get_letohs, tvb, orig=
_ofs,
> middle_len);
> =A0 =A0 =A0 =A0data_len =3D TVB_MSG_FIELD(tvb_get_letohl, tvb, orig_o=
fs, data_len);
>
> - =A0 =A0 =A0 if (front_len) {
> - =A0 =A0 =A0 /* =A0 =A0 =A0ceph_sub_item =3D proto_tree_add_item( tr=
ee, hf_ceph_front,
> tvb, offset, front_len, TRUE );
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset +=3D front_len; */
> + =A0 =A0 =A0 offset +=3D sizeof(struct ceph_msg_header);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dissect_ceph_client_front(tvb, pinfo, t=
ree, offset, type);
> + =A0 =A0 =A0 if (front_len) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dissect_ceph_front(tvb, pinfo, tree, of=
fset, type);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0offset +=3D front_len;
> =A0 =A0 =A0 =A0}
>
> @@ -895,17 +1153,32 @@ static guint32 dissect_ceph_generic(tvbuff_t *=
tvb,
> packet_info *pinfo, proto_tre
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *data;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ceph_sub_item =3D proto_tree_add_item(=
 tree, hf_ceph_data,
> tvb, offset, data_len, TRUE );
> =A0 =A0 =A0 =A0 =A0 =A0data =3D (char *)tvb_get_ptr(tvb, offset, data=
_len);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_crc =3D crc32c_le(0, data, data_le=
n);
> -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_crc =3D ceph_crc32c_le(0, data, da=
ta_len);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0offset +=3D data_len;
> =A0 =A0 =A0 =A0}
> -
> =A0 =A0 =A0 =A0offset =3D dissect_ceph_footer(tvb, tree, offset, data=
_crc);
> -
> =A0 =A0 =A0 =A0return offset;
> =A0}
>
> +
> +static const char *ceph_protocol_to_text(guint32 proto){
> + =A0 =A0 =A0 if ( proto =3D=3D CEPH_OSD_PROTOCOL )
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return "osd";
> + =A0 =A0 =A0 if ( proto =3D=3D CEPH_MDS_PROTOCOL )
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return "mds";
> + =A0 =A0 =A0 if ( proto =3D=3D CEPH_MON_PROTOCOL )
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return "mon";
> + =A0 =A0 =A0 if ( proto =3D=3D CEPH_OSDC_PROTOCOL )
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return "osd";
> + =A0 =A0 =A0 if ( proto =3D=3D CEPH_MDSC_PROTOCOL )
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return "mds";
> + =A0 =A0 =A0 if ( proto =3D=3D CEPH_MONC_PROTOCOL )
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return "mon";
> + =A0 =A0 =A0 else{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return "???";
> + =A0 =A0 =A0 }
> +}
> +
> =A0static const char *entity_name_by_type(int type)
> =A0{
> =A0 =A0 =A0 =A0if (type < 4)
> @@ -936,6 +1209,7 @@ dissect_ceph_client(tvbuff_t *tvb, packet_info
> *pinfo, proto_tree *tree)
> =A0 =A0 =A0 =A0proto_item *ceph_item =3D NULL;
> =A0 =A0 =A0 =A0proto_tree *ceph_tree =3D NULL;
> =A0 =A0 =A0 =A0guint16 type =3D 0;
> + =A0 =A0 =A0 guint32 proto =3D 0;
> =A0 =A0 =A0 =A0const guchar *ptr;
> =A0 =A0 =A0 =A0guint32 pos =3D 0;
> =A0 =A0 =A0 =A0int have_banner =3D 0;
> @@ -955,7 +1229,8 @@ dissect_ceph_client(tvbuff_t *tvb, packet_info
> *pinfo, proto_tree *tree)
>
> =A0 =A0 =A0 =A0// This is not a good way of dissecting packets. =A0Th=
e tvb length
> should
> =A0 =A0 =A0 =A0// be sanity checked so we aren't going past the actua=
l size of the
> buffer.
> - =A0 =A0 =A0 type =3D tvb_get_guint8( tvb, 4 ); // Get the type byte
> + =A0 =A0 =A0 type =3D tvb_get_guint8(tvb,4); // Get the type byte
> +
>
> =A0 =A0 =A0 =A0if (check_col(pinfo->cinfo, COL_INFO)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *entity_str =3D NULL;
> @@ -963,9 +1238,11 @@ dissect_ceph_client(tvbuff_t *tvb, packet_info
> *pinfo, proto_tree *tree)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (have_banner) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (IS_MON(pinfo))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0entity=
_str =3D MON_STR;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 entity_=
str =3D "???";
> -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 // Gues=
s communication type from "struct
> ceph_msg_connect"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 proto =3D=
 tvb_get_letohl(tvb,9 +
> sizeof(struct ceph_entity_addr) + 20);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 entity_=
str =3D ceph_protocol_to_text(proto);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0col_add_fstr(pinfo->ci=
nfo, COL_INFO, "[%s] Connect
> Request", entity_str);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type =3D TVB_MSG_FIELD=
(tvb_get_letohl, tvb, 0, type);
> @@ -1021,8 +1298,9 @@ dissect_ceph_server(tvbuff_t *tvb, packet_info
> *pinfo, proto_tree *tree)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *entity_str;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (IS_MON(pinfo))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0entity=
_str =3D MON_STR;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0entity=
_str =3D "???";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (have_banner) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0col_add_fstr(pinfo->ci=
nfo, COL_INFO, "[%s] Connect
> Response", entity_str);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> @@ -1084,19 +1362,19 @@ static guint get_ceph_message_len(packet_info
> *pinfo, tvbuff_t *tvb, int offset)
> =A0 =A0 =A0 =A0const char *ptr;
> =A0 =A0 =A0 =A0guint32 len;
> =A0 =A0 =A0 =A0guint32 pos =3D 0;
> -
> - =A0 =A0 =A0 ptr =3D tvb_get_ptr(tvb, offset, /* sizeof(CEPH_BANNER)
> */tvb->length-offset);
> + =A0 =A0 =A0 guint32 tlen =3D (int) tvb->length;
> + =A0 =A0 =A0 ptr =3D tvb_get_ptr(tvb, offset, tlen - offset);
> + =A0 =A0 =A0 //ptr =3D tvb_get_ptr(tvb, offset, /* sizeof(CEPH_BANNE=
R) */
> (tvb->length)-offset);
> =A0 =A0 =A0 =A0if (ptr && memcmp(ptr, "ceph", 4) =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (DEST_PORT_CEPH) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len =3D sizeof(CEPH_BA=
NNER) - 1 +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof=
(struct ceph_entity_addr) +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(=
struct ceph_msg_connect);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(=
struct ceph_msg_connect) +
> AUTH_LEN;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len =3D sizeof(CEPH_BA=
NNER) - 1 +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof=
(struct ceph_entity_addr) +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof=
(struct ceph_entity_addr) +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof=
(struct ceph_msg_connect_reply);
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return len;
> =A0 =A0 =A0 =A0}
>
> @@ -1114,18 +1392,39 @@ static guint get_ceph_message_len(packet_info
> *pinfo, tvbuff_t *tvb, int offset)
> =A0}
>
>
> -static void dissect_ceph(tvbuff_t *tvb, packet_info *pinfo, proto_tr=
ee
> *tree)
> -{
> +static void dissect_ceph(tvbuff_t *tvb, packet_info *pinfo, proto_tr=
ee
> *tree){
> =A0 =A0 =A0 =A0const char *ptr;
> -
> =A0 =A0 =A0 =A0ptr =3D tvb_get_ptr(tvb, 0, 6);
> -
> - =A0 =A0 =A0 if ((*ptr =3D=3D CEPH_MSGR_TAG_MSG) ||
> - =A0 =A0 =A0 =A0 =A0 =A0(memcmp(ptr, CEPH_BANNER, 4) =3D=3D 0) ||
> - =A0 =A0 =A0 =A0 =A0((ptr[0] =3D=3D CEPH_MSGR_TAG_ACK) && (ptr[5] =3D=
=3D
> CEPH_MSGR_TAG_MSG))
> - =A0 =A0 =A0 ) =A0{
> + =A0 =A0 =A0 if(*ptr =3D=3D CEPH_MSGR_TAG_RESETSESSION){
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 col_set_str(pinfo->cinfo, COL_PROTOCOL,=
 PROTO_TAG_CEPH);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 col_add_fstr(pinfo->cinfo, COL_INFO, "C=
eph reset
> session");
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 else if(*ptr =3D=3D CEPH_MSGR_TAG_WAIT){
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 col_set_str(pinfo->cinfo, COL_PROTOCOL,=
 PROTO_TAG_CEPH);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 col_add_fstr(pinfo->cinfo, COL_INFO, "C=
eph I am waiting");
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 else if(*ptr =3D=3D CEPH_MSGR_TAG_RETRY_SESSION){
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 col_set_str(pinfo->cinfo, COL_PROTOCOL,=
 PROTO_TAG_CEPH);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 col_add_fstr(pinfo->cinfo, COL_INFO, "C=
eph retry
> session");
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 else if(*ptr =3D=3D CEPH_MSGR_TAG_RETRY_GLOBAL){
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 col_set_str(pinfo->cinfo, COL_PROTOCOL,=
 PROTO_TAG_CEPH);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 col_add_fstr(pinfo->cinfo, COL_INFO, "C=
eph retry global");
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 else if(*ptr =3D=3D CEPH_MSGR_TAG_CLOSE){
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 col_set_str(pinfo->cinfo, COL_PROTOCOL,=
 PROTO_TAG_CEPH);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 col_add_fstr(pinfo->cinfo, COL_INFO, "C=
eph close");
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 else if(*ptr =3D=3D CEPH_MSGR_TAG_KEEPALIVE){
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 col_set_str(pinfo->cinfo, COL_PROTOCOL,=
 PROTO_TAG_CEPH);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 col_add_fstr(pinfo->cinfo, COL_INFO, "C=
eph keep alive");
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 else if ((*ptr =3D=3D CEPH_MSGR_TAG_MSG) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (memcmp(ptr, CEPH_BANNE=
R, 4) =3D=3D 0) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((ptr[0] =3D=3D CEPH_MS=
GR_TAG_ACK) && (ptr[9] =3D=3D
> CEPH_MSGR_TAG_MSG))
> + =A0 =A0 =A0 ){
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tcp_dissect_pdus(tvb, pinfo, tree, TRU=
E,
> TVB_MSG_HEADER_POS(src),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_ceph_message_len, d=
issect_ceph_message);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_cep=
h_message_len,
> dissect_ceph_message);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dissect_ceph_acks(tvb, pinfo, tree);
> =A0 =A0 =A0 =A0}
> diff --git a/wireshark/ceph/rados.h b/wireshark/ceph/rados.h
> index 2b7833c..0a99099 100644
> --- a/wireshark/ceph/rados.h
> +++ b/wireshark/ceph/rados.h
> @@ -9,6 +9,14 @@
> =A0#include "msgr.h"
>
> =A0/*
> + * osdmap encoding versions
> + */
> +#define CEPH_OSDMAP_INC_VERSION =A0 =A0 5
> +#define CEPH_OSDMAP_INC_VERSION_EXT 6
> +#define CEPH_OSDMAP_VERSION =A0 =A0 =A0 =A0 5
> +#define CEPH_OSDMAP_VERSION_EXT =A0 =A0 6
> +
> +/*
> =A0* fs id
> =A0*/
> =A0struct ceph_fsid {
> @@ -50,18 +58,16 @@ struct ceph_timespec {
> =A0#define CEPH_PG_LAYOUT_LINEAR 2
> =A0#define CEPH_PG_LAYOUT_HYBRID 3
>
> +#define CEPH_PG_MAX_SIZE =A0 =A0 =A016 =A0/* max # osds in a single =
pg */
>
> =A0/*
> =A0* placement group.
> =A0* we encode this into one __le64.
> =A0*/
> -union ceph_pg {
> - =A0 =A0 =A0 __u64 pg64;
> - =A0 =A0 =A0 struct {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __s16 preferred; /* preferred primary o=
sd */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __u16 ps; =A0 =A0 =A0 =A0/* placement s=
eed */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __u32 pool; =A0 =A0 =A0/* object pool *=
/
> - =A0 =A0 =A0 } __attribute__ ((packed)) pg;
> +struct ceph_pg {
> + =A0 =A0 =A0 __le16 preferred; /* preferred primary osd */
> + =A0 =A0 =A0 __le16 ps; =A0 =A0 =A0 =A0/* placement seed */
> + =A0 =A0 =A0 __le32 pool; =A0 =A0 =A0/* object pool */
> =A0} __attribute__ ((packed));
>
> =A0/*
> @@ -83,17 +89,20 @@ union ceph_pg {
> =A0*/
> =A0#define CEPH_PG_TYPE_REP =A0 =A0 1
> =A0#define CEPH_PG_TYPE_RAID4 =A0 2
> +#define CEPH_PG_POOL_VERSION 2
> =A0struct ceph_pg_pool {
> =A0 =A0 =A0 =A0__u8 type; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* CEPH_PG_T=
YPE_* */
> =A0 =A0 =A0 =A0__u8 size; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* number of=
 osds in each pg */
> =A0 =A0 =A0 =A0__u8 crush_ruleset; =A0 =A0 =A0 /* crush placement rul=
e */
> + =A0 =A0 =A0 __u8 object_hash; =A0 =A0 =A0 =A0 /* hash mapping objec=
t name to ps */
> =A0 =A0 =A0 =A0__le32 pg_num, pgp_num; =A0 /* number of pg's */
> =A0 =A0 =A0 =A0__le32 lpg_num, lpgp_num; /* number of localized pg's =
*/
> =A0 =A0 =A0 =A0__le32 last_change; =A0 =A0 =A0 /* most recent epoch c=
hanged */
> =A0 =A0 =A0 =A0__le64 snap_seq; =A0 =A0 =A0 =A0 =A0/* seq for per-poo=
l snapshot */
> =A0 =A0 =A0 =A0__le32 snap_epoch; =A0 =A0 =A0 =A0/* epoch of last sna=
p */
> =A0 =A0 =A0 =A0__le32 num_snaps;
> - =A0 =A0 =A0 __le32 num_removed_snap_intervals;
> + =A0 =A0 =A0 __le32 num_removed_snap_intervals; /* if non-empty, NO =
per-pool
> snaps */
> + =A0 =A0 =A0 __le64 auid; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* who owns th=
e pg */
> =A0} __attribute__ ((packed));
>
> =A0/*
> @@ -117,7 +126,7 @@ static inline int ceph_stable_mod(int x, int b, i=
nt
> bmask)
> =A0* object layout - how a given object should be stored.
> =A0*/
> =A0struct ceph_object_layout {
> - =A0 =A0 =A0 __le64 ol_pgid; =A0 =A0 =A0 =A0 =A0 /* raw pg, with _fu=
ll_ ps precision. */
> + =A0 =A0 =A0 struct ceph_pg ol_pgid; =A0 /* raw pg, with _full_ ps p=
recision. */
> =A0 =A0 =A0 =A0__le32 ol_stripe_unit; =A0 =A0/* for per-object parity=
, if any */
> =A0} __attribute__ ((packed));
>
> @@ -159,7 +168,6 @@ struct ceph_eversion {
> =A0#define CEPH_OSD_OP_MODE_WR =A0 =A00x2000
> =A0#define CEPH_OSD_OP_MODE_RMW =A0 0x3000
> =A0#define CEPH_OSD_OP_MODE_SUB =A0 0x4000
> -#define CEPH_OSD_OP_MODE_EXEC =A00x8000
>
> =A0#define CEPH_OSD_OP_TYPE =A0 =A0 =A0 0x0f00
> =A0#define CEPH_OSD_OP_TYPE_LOCK =A00x0100
> @@ -173,9 +181,17 @@ enum {
> =A0 =A0 =A0 =A0/* read */
> =A0 =A0 =A0 =A0CEPH_OSD_OP_READ =A0 =A0 =A0=3D CEPH_OSD_OP_MODE_RD | =
CEPH_OSD_OP_TYPE_DATA
> | 1,
> =A0 =A0 =A0 =A0CEPH_OSD_OP_STAT =A0 =A0 =A0=3D CEPH_OSD_OP_MODE_RD | =
CEPH_OSD_OP_TYPE_DATA
> | 2,
> + =A0 =A0 =A0 CEPH_OSD_OP_MAPEXT =A0 =A0=3D CEPH_OSD_OP_MODE_RD |
> CEPH_OSD_OP_TYPE_DATA | 3,
>
> =A0 =A0 =A0 =A0/* fancy read */
> - =A0 =A0 =A0 CEPH_OSD_OP_MASKTRUNC =3D CEPH_OSD_OP_MODE_RD |
> CEPH_OSD_OP_TYPE_DATA | 4,
> + =A0 =A0 =A0 CEPH_OSD_OP_MASKTRUNC =A0 =3D CEPH_OSD_OP_MODE_RD |
> CEPH_OSD_OP_TYPE_DATA | 4,
> + =A0 =A0 =A0 CEPH_OSD_OP_SPARSE_READ =3D CEPH_OSD_OP_MODE_RD |
> CEPH_OSD_OP_TYPE_DATA | 5,
> +
> + =A0 =A0 =A0 CEPH_OSD_OP_NOTIFY =A0 =A0=3D CEPH_OSD_OP_MODE_RD |
> CEPH_OSD_OP_TYPE_DATA | 6,
> + =A0 =A0 =A0 CEPH_OSD_OP_NOTIFY_ACK =3D CEPH_OSD_OP_MODE_RD |
> CEPH_OSD_OP_TYPE_DATA | 7,
> +
> + =A0 =A0 =A0 /* versioning */
> + =A0 =A0 =A0 CEPH_OSD_OP_ASSERT_VER =3D CEPH_OSD_OP_MODE_RD |
> CEPH_OSD_OP_TYPE_DATA | 8,
>
> =A0 =A0 =A0 =A0/* write */
> =A0 =A0 =A0 =A0CEPH_OSD_OP_WRITE =A0 =A0 =3D CEPH_OSD_OP_MODE_WR | CE=
PH_OSD_OP_TYPE_DATA
> | 1,
> @@ -195,11 +211,15 @@ enum {
> =A0 =A0 =A0 =A0CEPH_OSD_OP_TMAPGET =3D CEPH_OSD_OP_MODE_RD | CEPH_OSD=
_OP_TYPE_DATA |
> 12,
>
> =A0 =A0 =A0 =A0CEPH_OSD_OP_CREATE =A0=3D CEPH_OSD_OP_MODE_WR | CEPH_O=
SD_OP_TYPE_DATA |
> 13,
> + =A0 =A0 =A0 CEPH_OSD_OP_ROLLBACK=3D CEPH_OSD_OP_MODE_WR | CEPH_OSD_=
OP_TYPE_DATA
> | 14,
> +
> + =A0 =A0 =A0 CEPH_OSD_OP_WATCH =A0 =3D CEPH_OSD_OP_MODE_WR | CEPH_OS=
D_OP_TYPE_DATA
> | 15,
>
> =A0 =A0 =A0 =A0/** attrs **/
> =A0 =A0 =A0 =A0/* read */
> =A0 =A0 =A0 =A0CEPH_OSD_OP_GETXATTR =A0=3D CEPH_OSD_OP_MODE_RD | CEPH=
_OSD_OP_TYPE_ATTR
> | 1,
> =A0 =A0 =A0 =A0CEPH_OSD_OP_GETXATTRS =3D CEPH_OSD_OP_MODE_RD | CEPH_O=
SD_OP_TYPE_ATTR
> | 2,
> + =A0 =A0 =A0 CEPH_OSD_OP_CMPXATTR =A0=3D CEPH_OSD_OP_MODE_RD |
> CEPH_OSD_OP_TYPE_ATTR | 3,
>
> =A0 =A0 =A0 =A0/* write */
> =A0 =A0 =A0 =A0CEPH_OSD_OP_SETXATTR =A0=3D CEPH_OSD_OP_MODE_WR | CEPH=
_OSD_OP_TYPE_ATTR
> | 1,
> @@ -208,11 +228,14 @@ enum {
> =A0 =A0 =A0 =A0CEPH_OSD_OP_RMXATTR =A0 =3D CEPH_OSD_OP_MODE_WR | CEPH=
_OSD_OP_TYPE_ATTR
> | 4,
>
> =A0 =A0 =A0 =A0/** subop **/
> - =A0 =A0 =A0 CEPH_OSD_OP_PULL =A0 =A0 =A0 =A0 =A0 =3D CEPH_OSD_OP_MO=
DE_SUB | 1,
> - =A0 =A0 =A0 CEPH_OSD_OP_PUSH =A0 =A0 =A0 =A0 =A0 =3D CEPH_OSD_OP_MO=
DE_SUB | 2,
> - =A0 =A0 =A0 CEPH_OSD_OP_BALANCEREADS =A0 =3D CEPH_OSD_OP_MODE_SUB |=
 3,
> - =A0 =A0 =A0 CEPH_OSD_OP_UNBALANCEREADS =3D CEPH_OSD_OP_MODE_SUB | 4=
,
> - =A0 =A0 =A0 CEPH_OSD_OP_SCRUB =A0 =A0 =A0 =A0 =A0=3D CEPH_OSD_OP_MO=
DE_SUB | 5,
> + =A0 =A0 =A0 CEPH_OSD_OP_PULL =A0 =A0 =A0 =A0 =A0 =A0=3D CEPH_OSD_OP=
_MODE_SUB | 1,
> + =A0 =A0 =A0 CEPH_OSD_OP_PUSH =A0 =A0 =A0 =A0 =A0 =A0=3D CEPH_OSD_OP=
_MODE_SUB | 2,
> + =A0 =A0 =A0 CEPH_OSD_OP_BALANCEREADS =A0 =A0=3D CEPH_OSD_OP_MODE_SU=
B | 3,
> + =A0 =A0 =A0 CEPH_OSD_OP_UNBALANCEREADS =A0=3D CEPH_OSD_OP_MODE_SUB =
| 4,
> + =A0 =A0 =A0 CEPH_OSD_OP_SCRUB =A0 =A0 =A0 =A0 =A0 =3D CEPH_OSD_OP_M=
ODE_SUB | 5,
> + =A0 =A0 =A0 CEPH_OSD_OP_SCRUB_RESERVE =A0 =3D CEPH_OSD_OP_MODE_SUB =
| 6,
> + =A0 =A0 =A0 CEPH_OSD_OP_SCRUB_UNRESERVE =3D CEPH_OSD_OP_MODE_SUB | =
7,
> + =A0 =A0 =A0 CEPH_OSD_OP_SCRUB_STOP =A0 =A0 =A0=3D CEPH_OSD_OP_MODE_=
SUB | 8,
>
> =A0 =A0 =A0 =A0/** lock **/
> =A0 =A0 =A0 =A0CEPH_OSD_OP_WRLOCK =A0 =A0=3D CEPH_OSD_OP_MODE_WR | CE=
PH_OSD_OP_TYPE_LOCK
> | 1,
> @@ -263,6 +286,10 @@ static inline int ceph_osd_op_mode_modify(int op=
)
> =A0 =A0 =A0 =A0return (op & CEPH_OSD_OP_MODE) =3D=3D CEPH_OSD_OP_MODE=
_WR;
> =A0}
>
> +/*
> + * note that the following tmap stuff is also defined in the ceph
> librados.h
> + * any modification here needs to be updated there
> + */
> =A0#define CEPH_OSD_TMAP_HDR 'h'
> =A0#define CEPH_OSD_TMAP_SET 's'
> =A0#define CEPH_OSD_TMAP_RM =A0'r'
> @@ -287,6 +314,8 @@ enum {
> =A0 =A0 =A0 =A0CEPH_OSD_FLAG_BALANCE_READS =3D 256,
> =A0 =A0 =A0 =A0CEPH_OSD_FLAG_PARALLELEXEC =3D 512, /* execute op in p=
arallel */
> =A0 =A0 =A0 =A0CEPH_OSD_FLAG_PGOP =3D 1024, =A0 =A0 =A0/* pg op, no o=
bject */
> + =A0 =A0 =A0 CEPH_OSD_FLAG_EXEC =3D 2048, =A0 =A0 =A0/* op may exec =
*/
> + =A0 =A0 =A0 CEPH_OSD_FLAG_EXEC_PUBLIC =3D 4096, /* op may exec (pub=
lic) */
> =A0};
>
> =A0enum {
> @@ -296,6 +325,24 @@ enum {
> =A0#define EOLDSNAPC =A0 =A0ERESTART =A0/* ORDERSNAP flag set; writer=
 has old
> snapc*/
> =A0#define EBLACKLISTED ESHUTDOWN /* blacklisted */
>
> +/* xattr comparison */
> +enum {
> + =A0 =A0 =A0 CEPH_OSD_CMPXATTR_OP_NOP =3D 0,
> + =A0 =A0 =A0 CEPH_OSD_CMPXATTR_OP_EQ =A0=3D 1,
> + =A0 =A0 =A0 CEPH_OSD_CMPXATTR_OP_NE =A0=3D 2,
> + =A0 =A0 =A0 CEPH_OSD_CMPXATTR_OP_GT =A0=3D 3,
> + =A0 =A0 =A0 CEPH_OSD_CMPXATTR_OP_GTE =3D 4,
> + =A0 =A0 =A0 CEPH_OSD_CMPXATTR_OP_LT =A0=3D 5,
> + =A0 =A0 =A0 CEPH_OSD_CMPXATTR_OP_LTE =3D 6
> +};
> +
> +enum {
> + =A0 =A0 =A0 CEPH_OSD_CMPXATTR_MODE_STRING =3D 1,
> + =A0 =A0 =A0 CEPH_OSD_CMPXATTR_MODE_U64 =A0 =A0=3D 2
> +};
> +
> +#define RADOS_NOTIFY_VER =A0 =A0 =A0 1
> +
> =A0/*
> =A0* an individual object operation. =A0each may be accompanied by so=
me data
> =A0* payload
> @@ -306,16 +353,16 @@ struct ceph_osd_op {
> =A0 =A0 =A0 =A0union {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__le64 offset, length;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __le64 truncate_size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __le32 truncate_seq;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} __attribute__ ((packed)) extent;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__le32 name_len;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__le32 value_len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __u8 cmp_op; =A0 =A0 =A0=
 /* CEPH_OSD_CMPXATTR_OP_* */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __u8 cmp_mode; =A0 =A0 =
/* CEPH_OSD_CMPXATTR_MODE_* */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} __attribute__ ((packed)) xattr;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __le64 truncate_size;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __le32 truncate_seq;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } __attribute__ ((packed)) trunc;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__u8 class_len;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__u8 method_len;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__u8 argc;
> @@ -324,7 +371,15 @@ struct ceph_osd_op {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__le64 cookie, count;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} __attribute__ ((packed)) pgls;
> - =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __le64 snapid;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } __attribute__ ((packed)) snap;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __le64 cookie;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __le64 ver;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __u8 flag; =A0 =A0 =A0/=
* 0 =3D unwatch, 1 =3D watch */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } __attribute__ ((packed)) watch;
> +};
> =A0 =A0 =A0 =A0__le32 payload_len;
> =A0} __attribute__ ((packed));
>
> @@ -333,7 +388,6 @@ struct ceph_osd_op {
> =A0* ceph_osd_op object operations.
> =A0*/
> =A0struct ceph_osd_request_head {
> - =A0 =A0 =A0 __le64 tid; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* transaction id */
> =A0 =A0 =A0 =A0__le32 client_inc; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* =
client incarnation */
> =A0 =A0 =A0 =A0struct ceph_object_layout layout; =A0/* pgid */
> =A0 =A0 =A0 =A0__le32 osdmap_epoch; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* cl=
ient's osdmap epoch */
> @@ -354,7 +408,6 @@ struct ceph_osd_request_head {
> =A0} __attribute__ ((packed));
>
> =A0struct ceph_osd_reply_head {
> - =A0 =A0 =A0 __le64 tid; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 /* transaction id */
> =A0 =A0 =A0 =A0__le32 client_inc; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* c=
lient incarnation */
> =A0 =A0 =A0 =A0__le32 flags;
> =A0 =A0 =A0 =A0struct ceph_object_layout layout;
> @@ -369,4 +422,5 @@ struct ceph_osd_reply_head {
> =A0} __attribute__ ((packed));
>
>
> +
> =A0#endif
> diff --git a/wireshark/ceph/sctp_crc32.c b/wireshark/ceph/sctp_crc32.=
c
> index 43c06b4..1385834 100644
> --- a/wireshark/ceph/sctp_crc32.c
> +++ b/wireshark/ceph/sctp_crc32.c
> @@ -31,15 +31,22 @@
> =A0/* $KAME: sctp_crc32.c,v 1.12 2005/03/06 16:04:17 itojun Exp $ =A0=
*/
>
>
> -//#include <sys/cdefs.h>
> +#include <sys/cdefs.h>
> +#if 0
> +__FBSDID("$FreeBSD: src/sys/netinet/sctp_crc32.c,v 1.8 2007/05/08
> 17:01:10 rrs Exp $");
>
> -#include <glib.h>
>
> -typedef guint8 =A0uint8_t;
> -typedef guint32 uint32_t;
> -typedef unsigned long uintptr_t;
> +#include <netinet/sctp_os.h>
> +#include <netinet/sctp_crc32.h>
> +#endif
>
> +#include <stdint.h>
>
> +#if defined(__FreeBSD__)
> +#include <sys/endian.h>
> +#else
> +#include <endian.h>
> +#endif
>
> =A0#ifndef SCTP_USE_ADLER32
>
> @@ -588,7 +595,7 @@ sctp_crc32c_sb8_64_bit(uint32_t crc,
> =A0*
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 none
> =A0*/
> -uint32_t
> +static uint32_t
> =A0update_crc32(uint32_t crc32c,
> =A0 =A0 unsigned char const *buffer,
> =A0 =A0 unsigned int length)
> @@ -672,7 +679,8 @@ uint32_t sctp_crc_c[256] =3D {
>
> =A0#define SCTP_CRC32C(c,d) (c=3D(c>>8)^sctp_crc_c[(c^(d))&0xFF])
>
> -uint32_t
> +#if 0
> +static uint32_t
> =A0old_update_crc32(uint32_t crc32c,
> =A0 =A0 unsigned char const *buffer,
> =A0 =A0 unsigned int length)
> @@ -686,7 +694,7 @@ old_update_crc32(uint32_t crc32c,
> =A0}
>
>
> -uint32_t
> +static uint32_t
> =A0sctp_csum_finalize(uint32_t crc32c)
> =A0{
> =A0 =A0 =A0 =A0uint32_t result;
> @@ -718,8 +726,9 @@ sctp_csum_finalize(uint32_t crc32c)
> =A0#endif
> =A0 =A0 =A0 =A0return (crc32c);
> =A0}
> +#endif
>
> -uint32_t crc32c_le(uint32_t crc, unsigned char const *data, unsigned
> length)
> +uint32_t ceph_crc32c_le(uint32_t crc, unsigned char const *data, uns=
igned
> length)
> =A0{
> =A0 =A0 =A0 =A0return update_crc32(crc, data, length);
> =A0}
> diff --git a/wireshark/wireshark.patch b/wireshark/wireshark.patch
> index eb765c9..2e3b873 100644
> --- a/wireshark/wireshark.patch
> +++ b/wireshark/wireshark.patch
> @@ -26,24 +26,14 @@ Index: plugins/Makefile.nmake
> =A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =A0--- plugins/Makefile.nmake =A0 =A0 (revision 29691)
> =A0+++ plugins/Makefile.nmake =A0 =A0 (working copy)
> -@@ -33,6 +33,9 @@
> - =A0 =A0 =A0 cd asn1
> - =A0 =A0 =A0 $(MAKE) /$(MAKEFLAGS) -f Makefile.nmake $(PLUGIN_TARGET=
)
> - =A0 =A0 =A0 cd ..
> -+ =A0 =A0 =A0cd ceph
> -+ =A0 =A0 =A0$(MAKE) /$(MAKEFLAGS) -f Makefile.nmake $(PLUGIN_TARGET=
)
> -+ =A0 =A0 =A0cd ..
> - =A0 =A0 =A0 cd docsis
> - =A0 =A0 =A0 $(MAKE) /$(MAKEFLAGS) -f Makefile.nmake $(PLUGIN_TARGET=
)
> - =A0 =A0 =A0 cd ..
> -@@ -86,6 +89,7 @@
> - !IFDEF ENABLE_LIBWIRESHARK
> - =A0 =A0 =A0 cd..
> - =A0 =A0 =A0 xcopy plugins\asn1\*.dll $(INSTALL_DIR)\plugins\$(VERSI=
ON) /d
> -+ =A0 =A0 =A0xcopy plugins\ceph\*.dll $(INSTALL_DIR)\plugins\$(VERSI=
ON) /d
> - =A0 =A0 =A0 xcopy plugins\docsis\*.dll $(INSTALL_DIR)\plugins\$(VER=
SION) /d
> - =A0 =A0 =A0 xcopy plugins\ethercat\*.dll $(INSTALL_DIR)\plugins\$(V=
ERSION) /d
> - =A0 =A0 =A0 xcopy plugins\giop\*.dll $(INSTALL_DIR)\plugins\$(VERSI=
ON) /d
> +@@ -8,6 +8,7 @@
> +
> + PLUGIN_LIST =3D \
> + =A0 =A0 =A0 asn1 =A0 =A0 =A0 =A0\
> ++ =A0 =A0 =A0ceph =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 docsis =A0 =A0 =A0\
> + =A0 =A0 =A0 ethercat =A0 =A0\
> + =A0 =A0 =A0 giop =A0 =A0 =A0 =A0\
> =A0Index: plugins/Makefile.am
> =A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =A0--- plugins/Makefile.am =A0 =A0 =A0 =A0(revision 29691)
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
