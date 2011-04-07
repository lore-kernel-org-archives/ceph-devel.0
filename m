From: Yoshiaki Tamura <tamura.yoshiaki@gmail.com>
Subject: Re: [PATCH v2 2/2] rbd: allow configuration of rados from the rbd filename
Date: Thu, 7 Apr 2011 10:14:03 +0900
Message-ID: <BANLkTinZa+_FfZcyO54QE9W37PB___+m1g@mail.gmail.com>
References: <6f9466b6098b5159aca9c789f9fce45f409e684f.1301354138.git.josh.durgin@dreamhost.com>
	<99252a76de350c8123eebfe4fc01fc6a1c9b2383.1301354138.git.josh.durgin@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61205 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757165Ab1DGBOG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Apr 2011 21:14:06 -0400
In-Reply-To: <99252a76de350c8123eebfe4fc01fc6a1c9b2383.1301354138.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

Hi,

2011/3/29 Josh Durgin <josh.durgin@dreamhost.com>:
> The new format is rbd:pool/image[@snapshot][:option1=3Dvalue1[:option=
2=3Dvalue2...]]
> Each option is used to configure rados, and may be any Ceph option, o=
r "conf".
> The "conf" option specifies a Ceph configuration file to read.
>
> This allows rbd volumes from more than one Ceph cluster to be used by
> specifying different monitor addresses, as well as having different
> logging levels or locations for different volumes.
>
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> ---
> =A0block/rbd.c | =A0119 +++++++++++++++++++++++++++++++++++++++++++++=
+++++--------
> =A01 files changed, 102 insertions(+), 17 deletions(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index cb76dd3..bc3323d 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -22,13 +22,17 @@
> =A0/*
> =A0* When specifying the image filename use:
> =A0*
> - * rbd:poolname/devicename
> + * rbd:poolname/devicename[@snapshotname][:option1=3Dvalue1[:option2=
=3Dvalue2...]]

I'm not sure IIUC, but currently this @snapshotname seems to be
meaningless; it doesn't allow you to boot from a snapshot because it's
read only.  Am I misunderstanding or tested incorrectly?

Yoshi

> =A0*
> =A0* poolname must be the name of an existing rados pool
> =A0*
> =A0* devicename is the basename for all objects used to
> =A0* emulate the raw device.
> =A0*
> + * Each option given is used to configure rados, and may be
> + * any Ceph option, or "conf". The "conf" option specifies
> + * a Ceph configuration file to read.
> + *
> =A0* Metadata information (image size, ...) is stored in an
> =A0* object with the name "devicename.rbd".
> =A0*
> @@ -121,7 +125,8 @@ static int qemu_rbd_next_tok(char *dst, int dst_l=
en,
> =A0static int qemu_rbd_parsename(const char *filename,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *poo=
l, int pool_len,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *sna=
p, int snap_len,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *na=
me, int name_len)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *na=
me, int name_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char *co=
nf, int conf_len)
> =A0{
> =A0 =A0 const char *start;
> =A0 =A0 char *p, *buf;
> @@ -133,28 +138,84 @@ static int qemu_rbd_parsename(const char *filen=
ame,
>
> =A0 =A0 buf =3D qemu_strdup(start);
> =A0 =A0 p =3D buf;
> + =A0 =A0*snap =3D '\0';
> + =A0 =A0*conf =3D '\0';
>
> =A0 =A0 ret =3D qemu_rbd_next_tok(pool, pool_len, p, '/', "pool name"=
, &p);
> =A0 =A0 if (ret < 0 || !p) {
> =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> =A0 =A0 =A0 =A0 goto done;
> =A0 =A0 }
> - =A0 =A0ret =3D qemu_rbd_next_tok(name, name_len, p, '@', "object na=
me", &p);
> - =A0 =A0if (ret < 0) {
> - =A0 =A0 =A0 =A0goto done;
> +
> + =A0 =A0if (strchr(p, '@')) {
> + =A0 =A0 =A0 =A0ret =3D qemu_rbd_next_tok(name, name_len, p, '@', "o=
bject name", &p);
> + =A0 =A0 =A0 =A0if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0goto done;
> + =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0ret =3D qemu_rbd_next_tok(snap, snap_len, p, ':', "s=
nap name", &p);
> + =A0 =A0} else {
> + =A0 =A0 =A0 =A0ret =3D qemu_rbd_next_tok(name, name_len, p, ':', "o=
bject name", &p);
> =A0 =A0 }
> - =A0 =A0if (!p) {
> - =A0 =A0 =A0 =A0*snap =3D '\0';
> + =A0 =A0if (ret < 0 || !p) {
> =A0 =A0 =A0 =A0 goto done;
> =A0 =A0 }
>
> - =A0 =A0ret =3D qemu_rbd_next_tok(snap, snap_len, p, '\0', "snap nam=
e", &p);
> + =A0 =A0ret =3D qemu_rbd_next_tok(conf, conf_len, p, '\0', "configur=
ation", &p);
>
> =A0done:
> =A0 =A0 qemu_free(buf);
> =A0 =A0 return ret;
> =A0}
>
> +static int qemu_rbd_set_conf(rados_t cluster, const char *conf)
> +{
> + =A0 =A0char *p, *buf;
> + =A0 =A0char name[RBD_MAX_CONF_NAME_SIZE];
> + =A0 =A0char value[RBD_MAX_CONF_VAL_SIZE];
> + =A0 =A0int ret =3D 0;
> +
> + =A0 =A0buf =3D qemu_strdup(conf);
> + =A0 =A0p =3D buf;
> +
> + =A0 =A0while (p) {
> + =A0 =A0 =A0 =A0ret =3D qemu_rbd_next_tok(name, sizeof(name), p,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0'=3D=
', "conf option name", &p);
> + =A0 =A0 =A0 =A0if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0if (!p) {
> + =A0 =A0 =A0 =A0 =A0 =A0error_report("conf option %s has no value", =
name);
> + =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0ret =3D qemu_rbd_next_tok(value, sizeof(value), p,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0':',=
 "conf option value", &p);
> + =A0 =A0 =A0 =A0if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0if (strncmp(name, "conf", strlen("conf"))) {
> + =A0 =A0 =A0 =A0 =A0 =A0ret =3D rados_conf_set(cluster, name, value)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report("invalid conf option %s=
", name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0} else {
> + =A0 =A0 =A0 =A0 =A0 =A0ret =3D rados_conf_read_file(cluster, value)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_report("error reading conf fil=
e %s", value);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0}
> + =A0 =A0}
> +
> + =A0 =A0qemu_free(buf);
> + =A0 =A0return ret;
> +}
> +
> =A0static int qemu_rbd_create(const char *filename, QEMUOptionParamet=
er *options)
> =A0{
> =A0 =A0 int64_t bytes =3D 0;
> @@ -163,6 +224,7 @@ static int qemu_rbd_create(const char *filename, =
QEMUOptionParameter *options)
> =A0 =A0 char pool[RBD_MAX_POOL_NAME_SIZE];
> =A0 =A0 char name[RBD_MAX_IMAGE_NAME_SIZE];
> =A0 =A0 char snap_buf[RBD_MAX_SNAP_NAME_SIZE];
> + =A0 =A0char conf[RBD_MAX_CONF_SIZE];
> =A0 =A0 char *snap =3D NULL;
> =A0 =A0 rados_t cluster;
> =A0 =A0 rados_ioctx_t io_ctx;
> @@ -170,7 +232,8 @@ static int qemu_rbd_create(const char *filename, =
QEMUOptionParameter *options)
>
> =A0 =A0 if (qemu_rbd_parsename(filename, pool, sizeof(pool),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snap_buf, size=
of(snap_buf),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name, sizeof(na=
me)) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name, sizeof(na=
me),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conf, sizeof(co=
nf)) < 0) {
> =A0 =A0 =A0 =A0 return -EINVAL;
> =A0 =A0 }
> =A0 =A0 if (snap_buf[0] !=3D '\0') {
> @@ -203,8 +266,17 @@ static int qemu_rbd_create(const char *filename,=
 QEMUOptionParameter *options)
> =A0 =A0 =A0 =A0 return -EIO;
> =A0 =A0 }
>
> - =A0 =A0if (rados_conf_read_file(cluster, NULL) < 0) {
> - =A0 =A0 =A0 =A0error_report("error reading config file");
> + =A0 =A0if (strstr(conf, "conf=3D") =3D=3D NULL) {
> + =A0 =A0 =A0 =A0if (rados_conf_read_file(cluster, NULL) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0error_report("error reading config file");
> + =A0 =A0 =A0 =A0 =A0 =A0rados_shutdown(cluster);
> + =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
> + =A0 =A0 =A0 =A0}
> + =A0 =A0}
> +
> + =A0 =A0if (conf[0] !=3D '\0' &&
> + =A0 =A0 =A0 =A0qemu_rbd_set_conf(cluster, conf) < 0) {
> + =A0 =A0 =A0 =A0error_report("error setting config options");
> =A0 =A0 =A0 =A0 rados_shutdown(cluster);
> =A0 =A0 =A0 =A0 return -EIO;
> =A0 =A0 }
> @@ -314,11 +386,13 @@ static int qemu_rbd_open(BlockDriverState *bs, =
const char *filename, int flags)
> =A0 =A0 BDRVRBDState *s =3D bs->opaque;
> =A0 =A0 char pool[RBD_MAX_POOL_NAME_SIZE];
> =A0 =A0 char snap_buf[RBD_MAX_SNAP_NAME_SIZE];
> + =A0 =A0char conf[RBD_MAX_CONF_SIZE];
> =A0 =A0 int r;
>
> =A0 =A0 if (qemu_rbd_parsename(filename, pool, sizeof(pool),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snap_buf, size=
of(snap_buf),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->name, sizeof=
(s->name)) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->name, sizeof=
(s->name),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conf, sizeof(co=
nf)) < 0) {
> =A0 =A0 =A0 =A0 return -EINVAL;
> =A0 =A0 }
> =A0 =A0 s->snap =3D NULL;
> @@ -332,11 +406,22 @@ static int qemu_rbd_open(BlockDriverState *bs, =
const char *filename, int flags)
> =A0 =A0 =A0 =A0 return r;
> =A0 =A0 }
>
> - =A0 =A0r =3D rados_conf_read_file(s->cluster, NULL);
> - =A0 =A0if (r < 0) {
> - =A0 =A0 =A0 =A0error_report("error reading config file");
> - =A0 =A0 =A0 =A0rados_shutdown(s->cluster);
> - =A0 =A0 =A0 =A0return r;
> + =A0 =A0if (strstr(conf, "conf=3D") =3D=3D NULL) {
> + =A0 =A0 =A0 =A0r =3D rados_conf_read_file(s->cluster, NULL);
> + =A0 =A0 =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0error_report("error reading config file");
> + =A0 =A0 =A0 =A0 =A0 =A0rados_shutdown(s->cluster);
> + =A0 =A0 =A0 =A0 =A0 =A0return r;
> + =A0 =A0 =A0 =A0}
> + =A0 =A0}
> +
> + =A0 =A0if (conf[0] !=3D '\0') {
> + =A0 =A0 =A0 =A0r =3D qemu_rbd_set_conf(s->cluster, conf);
> + =A0 =A0 =A0 =A0if (r < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0error_report("error setting config options")=
;
> + =A0 =A0 =A0 =A0 =A0 =A0rados_shutdown(s->cluster);
> + =A0 =A0 =A0 =A0 =A0 =A0return r;
> + =A0 =A0 =A0 =A0}
> =A0 =A0 }
>
> =A0 =A0 r =3D rados_connect(s->cluster);
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
