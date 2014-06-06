From: Sage Weil <sage@inktank.com>
Subject: Re: rados_stat() block all the time. help
Date: Fri, 6 Jun 2014 08:44:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406060843490.31587@cobra.newdream.net>
References: <CABhd1=bb5vVNspouie9fLxbN5A=tytgYknUKx=pGis+KD4dBAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-735086853-1402069455=:31587"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43747 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbaFFPoP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jun 2014 11:44:15 -0400
In-Reply-To: <CABhd1=bb5vVNspouie9fLxbN5A=tytgYknUKx=pGis+KD4dBAw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leo Chen <misty.wish@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-735086853-1402069455=:31587
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[Moving to ceph-devel]

Try putting debug ms =3D 1 and debug objecter =3D 20 in your ceph.conf un=
der=20
[clients] and see if the request is getting sent, and whether the reply i=
s=20
coming back.

sage


On Fri, 6 Jun 2014, Leo Chen wrote:

> hi sage,I use rados_stat() in fuse module , It's block all all all the =
time.
> Thank you for help me.
>=20
> #define FUSE_USE_VERSION 26
>=20
> #include <fuse.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <assert.h>
> #include <errno.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <unistd.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <rados/librados.h>
> #include <openssl/sha.h>
> #include <json/json.h>
> #include <time.h>
> #include <syslog.h>
>=20
> char *poold =3D "data";
> char *poolm =3D "metad";
> rados_t cluster =3D NULL;
> rados_ioctx_t dio =3D NULL;
> rados_ioctx_t mio =3D NULL;
>=20
> static int read_ceph_getattr(const char *path, struct stat *stbuf)
> {
> =C2=A0 int err =3D 0;
> =C2=A0 uint64_t size =3D 0;
> =C2=A0 time_t mtime =3D 0;
> =C2=A0 int res =3D 0;
> =C2=A0 unsigned char *buf =3D NULL;
> =C2=A0 const char *str_size =3D NULL;
> =C2=A0 unsigned char fileid[50] =3D {'\0'};
>=20
> =C2=A0 struct json_object *new_obj =3D NULL;
>=20
> =C2=A0 memset(stbuf, 0, sizeof(struct stat));
>=20
> =C2=A0 if (strcmp(path, "/") =3D=3D 0) {
> =C2=A0 =C2=A0 stbuf->st_mode =3D S_IFDIR | 0755;
> =C2=A0 =C2=A0 stbuf->st_nlink =3D 2;
> =C2=A0 =C2=A0 stbuf->st_mtime =3D time(NULL);
> =C2=A0 =C2=A0 stbuf->st_size =3D 4096;
> =C2=A0 =C2=A0 res =3D 0;
> =C2=A0 =C2=A0 goto Endhandle;
> =C2=A0 }
> =C2=A0 memcpy(fileid, path + 1, strlen(path) - 1);
>=20
> =C2=A0 syslog(LOG_INFO, "metadata fileid : %s\n", fileid);
>=20
> =C2=A0 if (strlen(fileid) < 40) {
> =C2=A0 =C2=A0 res =3D -ENOENT;
> =C2=A0 =C2=A0 goto Endhandle;
> =C2=A0 }
>=20
> =C2=A0 err =3D rados_stat(mio, fileid, &size, &mtime); //This block ...=
......
> =C2=A0 if (err < 0) {
> =C2=A0 =C2=A0 syslog(LOG_INFO, "mio rados_stat: %s\n", strerror(-err));
> =C2=A0 =C2=A0 res =3D -ENOENT;
> =C2=A0 =C2=A0 goto Endhandle;
> =C2=A0 }
>=20
> =C2=A0 buf =3D (unsigned char *)malloc(size + 1);
> =C2=A0 if (NULL =3D=3D buf) {
> =C2=A0 =C2=A0 res =3D -ENOENT;
> =C2=A0 =C2=A0 goto Endhandle;
> =C2=A0 }
> =C2=A0 memset(buf, 0, size + 1);
> =C2=A0=C2=A0
> =C2=A0 err =3D rados_read(mio, fileid, buf, size, 0);
> =C2=A0 if (err < 0) {
> =C2=A0 =C2=A0 syslog(LOG_INFO, "mio rados_read: %s\n", strerror(-err));
> =C2=A0 =C2=A0 res =3D -ENOENT;
> =C2=A0 =C2=A0 goto Endhandle;
> =C2=A0 }
> =C2=A0=C2=A0
> =C2=A0 syslog(LOG_INFO, "json : %s\n", buf);
>=20
> =C2=A0 new_obj =3D json_tokener_parse(buf);
> =C2=A0 str_size =3D json_object_get_string(json_object_object_get(new_o=
bj,
> "filesize"));
>=20
> =C2=A0 stbuf->st_nlink =3D 1;
> =C2=A0 stbuf->st_mode =3D S_IFREG | 0666;
> =C2=A0 stbuf->st_size =3D hextoll(str_size, strlen(str_size));
>=20
> =C2=A0 size =3D 0;
> =C2=A0 mtime =3D 0;
> =C2=A0 memset(fileid, 0, 50);
> =C2=A0 snprintf(fileid, 50, "%s.00000000", path + 1);
>=20
> =C2=A0 syslog(LOG_INFO, "data fileid : %s\n", fileid);
>=20
> =C2=A0 err =3D rados_stat(dio, fileid, &size, &mtime);
> =C2=A0 if (err < 0) {
> =C2=A0 =C2=A0 syslog(LOG_INFO, "dio rados_stat: %s\n", strerror(-err));
> =C2=A0 =C2=A0 res =3D -ENOENT;
> =C2=A0 =C2=A0 goto Endhandle;
> =C2=A0 }
> =C2=A0 stbuf->st_mtime =3D mtime;
>=20
> =C2=A0Endhandle:
> =C2=A0 if (NULL !=3D buf) {
> =C2=A0 =C2=A0 free(buf);
> =C2=A0 =C2=A0 buf =3D NULL;
> =C2=A0 }
> =C2=A0 if (NULL !=3D new_obj) {
> =C2=A0 =C2=A0 json_object_put(new_obj);
> =C2=A0 =C2=A0 new_obj =3D NULL;
> =C2=A0 }
> =C2=A0 return res;
> }
>=20
> static struct fuse_operations read_ceph_oper =3D {
> =C2=A0 .getattr =3D read_ceph_getattr
> };
>=20
> int main(int argc, char *argv[])
> {
> =C2=A0 int err =3D 0;
> =C2=A0 int iRet =3D 0;
>=20
> =C2=A0 err =3D rados_create(&cluster, NULL);
> =C2=A0 if (err < 0) {
> =C2=A0 =C2=A0 fprintf(stderr, "%s: cannot create a cluster handle: %s\n=
", argv[0],
> strerror(-err));
> =C2=A0 =C2=A0 iRet =3D -1;
> =C2=A0 =C2=A0 goto Endhandle;
> =C2=A0 }
>=20
> =C2=A0 err =3D rados_conf_read_file(cluster, "/etc/ceph/ceph.conf");
> =C2=A0 if (err < 0) {
> =C2=A0 =C2=A0 fprintf(stderr, "%s: cannot read config file: %s\n", argv=
[0],
> strerror(-err));
> =C2=A0 =C2=A0 iRet =3D -1;
> =C2=A0 =C2=A0 goto Endhandle;
> =C2=A0 }
>=20
> =C2=A0 err =3D rados_connect(cluster);
> =C2=A0 if (err < 0) {
> =C2=A0 =C2=A0 fprintf(stderr, "%s: cannot connect to cluster: %s\n", ar=
gv[0],
> strerror(-err));
> =C2=A0 =C2=A0 iRet =3D -1;
> =C2=A0 =C2=A0 goto Endhandle;
>=20
> =C2=A0 }
>=20
> =C2=A0 err =3D rados_ioctx_create(cluster, poold, &dio);
> =C2=A0 if (err < 0) {
> =C2=A0 =C2=A0 fprintf(stderr, "%s: cannot open rados pool %s: %s\n", ar=
gv[0], poold,
> strerror(-err));
> =C2=A0 =C2=A0 iRet =3D -1;
> =C2=A0 =C2=A0 goto Endhandle;
> =C2=A0 }
>=20
> =C2=A0 err =3D rados_ioctx_create(cluster, poolm, &mio);
> =C2=A0 if (err < 0) {
> =C2=A0 =C2=A0 fprintf(stderr, "%s: cannot open rados pool %s: %s\n", ar=
gv[0], poolm,
> strerror(-err));
> =C2=A0 =C2=A0 iRet =3D -1;
> =C2=A0 =C2=A0 goto Endhandle;
> =C2=A0 }
>=20
> =C2=A0 fuse_main(argc, argv, &read_ceph_oper, NULL);
>=20
> =C2=A0Endhandle:
>=20
> =C2=A0 if (NULL !=3D dio) {
> =C2=A0 =C2=A0 rados_ioctx_destroy(dio);
> =C2=A0 =C2=A0 dio =3D NULL;
> =C2=A0 }
> =C2=A0 if (NULL !=3D mio) {
> =C2=A0 =C2=A0 rados_ioctx_destroy(mio);
> =C2=A0 =C2=A0 mio =3D NULL;
> =C2=A0 }
> =C2=A0 if (NULL !=3D cluster) {
> =C2=A0 =C2=A0 rados_shutdown(cluster);
> =C2=A0 =C2=A0 cluster =3D NULL;
> =C2=A0 }
>=20
> =C2=A0 return iRet;
> }
>=20
>=20
>=20
--557981400-735086853-1402069455=:31587--
