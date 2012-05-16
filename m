From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 1/2 v2] rbd: allow importing from stdin
Date: Wed, 16 May 2012 15:25:07 -0700
Message-ID: <CAC-hyiGsyMU5TogJ7SA8tQDVFY4Z5ht_hTwFB9dTsZgihBZJWw@mail.gmail.com>
References: <20120516203233.GA32219@sir.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53926 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757406Ab2EPWZI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 May 2012 18:25:08 -0400
Received: by bkcji2 with SMTP id ji2so1054886bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 May 2012 15:25:07 -0700 (PDT)
In-Reply-To: <20120516203233.GA32219@sir.fritz.box>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Wed, May 16, 2012 at 1:32 PM, Christian Brunner <chb@muc.de> wrote:
> This patch allows importing images from stdin with the following comm=
and:
>
> =A0 rbd import --size=3D<size in MB> - [dest-image]
>
> v1 -> v2: stat stdin as well
>
> Signed-off-by: Christian Brunner <chb@muc.de>
> ---
> =A0src/rbd.cc | =A0 26 +++++++++++++++++++-------
> =A01 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/src/rbd.cc b/src/rbd.cc
> index 655d9a2..1a0c510 100644
> --- a/src/rbd.cc
> +++ b/src/rbd.cc
> @@ -402,16 +402,21 @@ done_img:
> =A0}
>
> =A0static int do_import(librbd::RBD &rbd, librados::IoCtx& io_ctx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *imgname, int *or=
der, const char *path)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *imgname, int *or=
der, const char *path,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int64_t size)
> =A0{
> - =A0int fd =3D open(path, O_RDONLY);
> - =A0int r;
> - =A0int64_t size =3D 0;
> + =A0int fd, r;
> =A0 struct stat stat_buf;
> =A0 string md_oid;
> =A0 struct fiemap *fiemap;
> =A0 MyProgressContext pc("Importing image");
>
> + =A0if (! strcmp(path, "-")) {
> + =A0 =A0fd =3D 0;

fd =3D STDIN_FILENO;

> + =A0} else {
> + =A0 =A0fd =3D open(path, O_RDONLY);
> + =A0}
> +
> =A0 if (fd < 0) {
> =A0 =A0 r =3D -errno;
> =A0 =A0 cerr << "error opening " << path << std::endl;
> @@ -424,7 +429,9 @@ static int do_import(librbd::RBD &rbd, librados::=
IoCtx& io_ctx,
> =A0 =A0 cerr << "stat error " << path << std::endl;
> =A0 =A0 return r;
> =A0 }
> - =A0size =3D (uint64_t)stat_buf.st_size;
> + =A0if (stat_buf.st_size)
> + =A0 =A0size =3D (uint64_t)stat_buf.st_size;
> +
> =A0 if (!size) {
> =A0 =A0 r =3D get_block_device_size(fd, &size);

I assume you're going to fail here with stdin, and when size wasn't
passed? or when we're trying to import empty image?

> =A0 =A0 if (r < 0) {
> @@ -505,7 +512,12 @@ static int do_import(librbd::RBD &rbd, librados:=
:IoCtx& io_ctx,
> =A0 =A0 =A0 while (cur_seg) {
> =A0 =A0 =A0 =A0 bufferptr p(cur_seg);
> =A0 =A0 =A0 =A0 //cerr << "reading " << cur_seg << " bytes at offset =
" << file_pos << std::endl;
> - =A0 =A0 =A0 =A0ssize_t rval =3D TEMP_FAILURE_RETRY(::pread(fd, p.c_=
str(), cur_seg, file_pos));
> + =A0 =A0 =A0 ssize_t rval;
> + =A0 =A0 =A0 if(extent =3D=3D 0 && fiemap->fm_extents[extent].fe_log=
ical =3D=3D 0) {
> + =A0 =A0 =A0 =A0 rval =3D TEMP_FAILURE_RETRY(::read(fd, p.c_str(), c=
ur_seg));
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 rval =3D TEMP_FAILURE_RETRY(::pread(fd, p.c_str(), =
cur_seg, file_pos));
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 if (rval < 0) {
> =A0 =A0 =A0 =A0 =A0 r =3D -errno;
> =A0 =A0 =A0 =A0 =A0 cerr << "error reading file: " << cpp_strerror(r)=
 << std::endl;
> @@ -1303,7 +1315,7 @@ int main(int argc, const char **argv)
> =A0 =A0 =A0 cerr << "pathname should be specified" << std::endl;
> =A0 =A0 =A0 exit(1);
> =A0 =A0 }
> - =A0 =A0r =3D do_import(rbd, dest_io_ctx, destname, &order, path);
> + =A0 =A0r =3D do_import(rbd, dest_io_ctx, destname, &order, path, si=
ze);

I'd rather not pass size for stdin. We should instead make it so that
we don't read size at all and just importing while !eof (or do that
only when size is 0). We'd need to create the image with size=3D0 and
update the header in the end.


Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
