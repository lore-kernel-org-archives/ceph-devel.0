From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v2] ceph: allocate the accurate extra bytes for the
 session features
Date: Wed, 8 Jan 2020 18:19:37 +0800
Message-ID: <f7a476b2-2b94-5b64-d3e0-d45f59dbf7e3@redhat.com>
References: <20200108101731.26652-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59647 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726368AbgAHKTt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jan 2020 05:19:49 -0500
In-Reply-To: <20200108101731.26652-1-xiubli@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

The testing output:

# ./bin/cephfs-journal-tool --rank=3D1:0 event get --type=3DSESSION json
Wrote output to JSON file 'dump'
# cat dump
[
 =C2=A0=C2=A0=C2=A0 {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "client instance": "client.42=
75 v1:192.168.195.165:0/461391971",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "open": "true",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "client map version": 1,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "inos": "[]",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "inotable version": 0,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "client_metadata": {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clie=
nt_features": {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "feature_bits": "0000000000001bff"
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "enti=
ty_id": "",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "host=
name": "fedora1",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "kern=
el_version": "5.5.0-rc2+",
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "root=
": "/"
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0 },
[...]

On 2020/1/8 18:17, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>
> The totally bytes maybe potentially larger than 8.
>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>   fs/ceph/mds_client.c | 20 ++++++++++++++------
>   fs/ceph/mds_client.h | 23 ++++++++++++++++-------
>   2 files changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 94cce2ab92c4..d379f489ab63 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -9,6 +9,7 @@
>   #include <linux/debugfs.h>
>   #include <linux/seq_file.h>
>   #include <linux/ratelimit.h>
> +#include <linux/bits.h>
>  =20
>   #include "super.h"
>   #include "mds_client.h"
> @@ -1053,20 +1054,21 @@ static struct ceph_msg *create_session_msg(u32 =
op, u64 seq)
>   	return msg;
>   }
>  =20
> +static const unsigned char feature_bits[] =3D CEPHFS_FEATURES_CLIENT_S=
UPPORTED;
> +#define FEATURE_BYTES(c) (DIV_ROUND_UP((size_t)feature_bits[c - 1] + 1=
, 64) * 8)
>   static void encode_supported_features(void **p, void *end)
>   {
> -	static const unsigned char bits[] =3D CEPHFS_FEATURES_CLIENT_SUPPORTE=
D;
> -	static const size_t count =3D ARRAY_SIZE(bits);
> +	static const size_t count =3D ARRAY_SIZE(feature_bits);
>  =20
>   	if (count > 0) {
>   		size_t i;
> -		size_t size =3D ((size_t)bits[count - 1] + 64) / 64 * 8;
> +		size_t size =3D FEATURE_BYTES(count);
>  =20
>   		BUG_ON(*p + 4 + size > end);
>   		ceph_encode_32(p, size);
>   		memset(*p, 0, size);
>   		for (i =3D 0; i < count; i++)
> -			((unsigned char*)(*p))[i / 8] |=3D 1 << (bits[i] % 8);
> +			((unsigned char*)(*p))[i / 8] |=3D BIT(feature_bits[i] % 8);
>   		*p +=3D size;
>   	} else {
>   		BUG_ON(*p + 4 > end);
> @@ -1087,6 +1089,7 @@ static struct ceph_msg *create_session_open_msg(s=
truct ceph_mds_client *mdsc, u6
>   	int metadata_key_count =3D 0;
>   	struct ceph_options *opt =3D mdsc->fsc->client->options;
>   	struct ceph_mount_options *fsopt =3D mdsc->fsc->mount_options;
> +	size_t size, count;
>   	void *p, *end;
>  =20
>   	const char* metadata[][2] =3D {
> @@ -1104,8 +1107,13 @@ static struct ceph_msg *create_session_open_msg(=
struct ceph_mds_client *mdsc, u6
>   			strlen(metadata[i][1]);
>   		metadata_key_count++;
>   	}
> +
>   	/* supported feature */
> -	extra_bytes +=3D 4 + 8;
> +	size =3D 0;
> +	count =3D ARRAY_SIZE(feature_bits);
> +	if (count > 0)
> +		size =3D FEATURE_BYTES(count);
> +	extra_bytes +=3D 4 + size;
>  =20
>   	/* Allocate the message */
>   	msg =3D ceph_msg_new(CEPH_MSG_CLIENT_SESSION, sizeof(*h) + extra_byt=
es,
> @@ -1125,7 +1133,7 @@ static struct ceph_msg *create_session_open_msg(s=
truct ceph_mds_client *mdsc, u6
>   	 * Serialize client metadata into waiting buffer space, using
>   	 * the format that userspace expects for map<string, string>
>   	 *
> -	 * ClientSession messages with metadata are v2
> +	 * ClientSession messages with metadata are v3
>   	 */
>   	msg->hdr.version =3D cpu_to_le16(3);
>   	msg->hdr.compat_version =3D cpu_to_le16(1);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index c021df5f50ce..c950f8f88f58 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -17,22 +17,31 @@
>   #include <linux/ceph/auth.h>
>  =20
>   /* The first 8 bits are reserved for old ceph releases */
> -#define CEPHFS_FEATURE_MIMIC		8
> -#define CEPHFS_FEATURE_REPLY_ENCODING	9
> -#define CEPHFS_FEATURE_RECLAIM_CLIENT	10
> -#define CEPHFS_FEATURE_LAZY_CAP_WANTED	11
> -#define CEPHFS_FEATURE_MULTI_RECONNECT  12
> +enum ceph_feature_type {
> +	CEPHFS_FEATURE_MIMIC =3D 8,
> +	CEPHFS_FEATURE_REPLY_ENCODING,
> +	CEPHFS_FEATURE_RECLAIM_CLIENT,
> +	CEPHFS_FEATURE_LAZY_CAP_WANTED,
> +	CEPHFS_FEATURE_MULTI_RECONNECT,
> +
> +	CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_MULTI_RECONNECT,
> +};
>  =20
> -#define CEPHFS_FEATURES_CLIENT_SUPPORTED { 	\
> +/*
> + * This will always have the highest feature bit value
> + * as the last element of the array.
> + */
> +#define CEPHFS_FEATURES_CLIENT_SUPPORTED {	\
>   	0, 1, 2, 3, 4, 5, 6, 7,			\
>   	CEPHFS_FEATURE_MIMIC,			\
>   	CEPHFS_FEATURE_REPLY_ENCODING,		\
>   	CEPHFS_FEATURE_LAZY_CAP_WANTED,		\
>   	CEPHFS_FEATURE_MULTI_RECONNECT,		\
> +						\
> +	CEPHFS_FEATURE_MAX,			\
>   }
>   #define CEPHFS_FEATURES_CLIENT_REQUIRED {}
>  =20
> -
>   /*
>    * Some lock dependencies:
>    *
