From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: O_DIRECT change
Date: Sat, 4 Jun 2011 10:29:05 +0800
Message-ID: <BANLkTimgt0aW800==OCj72ocrAizJSfFjw@mail.gmail.com>
References: <Pine.LNX.4.64.1106030939020.27322@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61037 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab1FDC3G convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jun 2011 22:29:06 -0400
Received: by vxi39 with SMTP id 39so1775125vxi.19
        for <ceph-devel@vger.kernel.org>; Fri, 03 Jun 2011 19:29:05 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1106030939020.27322@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

We are on Dragon Boat Festival holidays. :) I will take a close look
and test it next week.
--
Henry

2011/6/4 Sage Weil <sage@newdream.net>:
> Hi Henry,
>
> I made a small change to the O_DIRECT path to zero holes properly in
> commit 85defe7 (below). =C2=A0Do you mind reviewing the change, and/o=
r testing,
> since you are the main O_DIRECT user? =C2=A0The test case that was fa=
iling is
> here:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://tracker.newdream.net/issues/1096#no=
te-19
>
> The problem was that the read coming down from the VFS isn't trimmed =
to
> i_size, so the old zero tail check wasn't true, and we would set
> *checkeof. =C2=A0Then ceph_aio_read would getattr and loop, since we
> didn't actually read eof (due to a hole).
>
> Actually, I suspect the *checkeof part is still incorrect... does the
> zeroing part at least look right to you?
>
> Thanks!
> sage
>
>
> From 85defe76f7e2a0b3d285a3be72fcffce96629b5c Mon Sep 17 00:00:00 200=
1
> From: Sage Weil <sage@newdream.net>
> Date: Wed, 1 Jun 2011 16:08:44 -0700
> Subject: [PATCH] ceph: fix short sync reads from the OSD
>
> If we get a short read from the OSD because the object is small, we n=
eed to
> zero the remainder of the buffer. =C2=A0For O_DIRECT reads, the attem=
pted range
> is not trimmed to i_size by the VFS, so we were actually looping
> indefinitely.
>
> Fix by trimming by i_size, and the unconditionally zeroing the traili=
ng
> range.
>
> Reported-by: Jeff Wu <cpwu@tnsoft.com.cn>
> Signed-off-by: Sage Weil <sage@newdream.net>
> ---
> =C2=A0fs/ceph/file.c | =C2=A0 28 +++++++++++++++-------------
> =C2=A01 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 8c5ac4e..b654f40 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -283,7 +283,7 @@ int ceph_release(struct inode *inode, struct file=
 *file)
> =C2=A0static int striped_read(struct inode *inode,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0u64 off, u64 len,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct page **pages, int num_pages,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int *checkeof, bool align_to_pages,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int *checkeof, bool o_direct,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0unsigned long buf_align)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ceph_fs_client *fsc =3D ceph_inode_=
to_client(inode);
> @@ -308,7 +308,7 @@ static int striped_read(struct inode *inode,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0io_align =3D off & ~PAGE_MASK;
>
> =C2=A0more:
> - =C2=A0 =C2=A0 =C2=A0 if (align_to_pages)
> + =C2=A0 =C2=A0 =C2=A0 if (o_direct)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0page_align =3D=
 (pos - io_align + buf_align) & ~PAGE_MASK;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0page_align =3D=
 pos & ~PAGE_MASK;
> @@ -346,20 +346,22 @@ more:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (was_short) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* was original ex=
tent fully inside i_size? */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pos + left <=3D=
 inode->i_size) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dout("zero tail\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ceph_zero_page_vector_range(page_off + read, len - read,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* did we bounce o=
ff eof? */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pos + left > i=
node->i_size)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 *checkeof =3D 1;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* zero trailing b=
ytes (inside i_size) */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (left > 0 && po=
s < inode->i_size) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (pos + left > inode->i_size)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 left =3D inode->i_size - pos;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dout("zero tail %d\n", left);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ceph_zero_page_vector_range(page_off + read, left,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pages);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 read =3D len;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto out;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 read +=3D left;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* check i_size */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *checkeof =3D 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> -out:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret >=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D read;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dout("striped_read returns %d\n", ret);
> @@ -659,7 +661,7 @@ out:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* hit EOF or =
hole? */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (statret =3D=
=3D 0 && *ppos < inode->i_size) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dout("aio_read sync_read hit hole, reading more\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dout("aio_read sync_read hit hole, ppos %lld < size %lld, readi=
ng more\n", *ppos, inode->i_size);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0read +=3D ret;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0base +=3D ret;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0len -=3D ret;
> --
> 1.7.0
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
