From: Greg Farnum <greg@inktank.com>
Subject: Re: [PATCH 6/7] ceph: don't early drop Fw cap
Date: Tue, 5 Mar 2013 12:42:02 -0800
Message-ID: <8FEB836B9E414807AA50520E14C5DFD7@inktank.com>
References: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com>
 <1362120384-5188-7-git-send-email-zheng.z.yan@intel.com>
 <CAPYLRziF-BTvksCM3LDfdwvjrLWXQhSdoF+PB3XJAd7KJp4cmw@mail.gmail.com>
 <513550FE.1020401@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:46384 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757742Ab3CEUmI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 15:42:08 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so4929785pbc.7
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 12:42:07 -0800 (PST)
In-Reply-To: <513550FE.1020401@intel.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Yan=2C_Zheng?= <zheng.z.yan@intel.com>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Monday, March 4, 2013 at 5:57 PM, Yan, Zheng wrote:
> On 03/05/2013 02:26 AM, Gregory Farnum wrote:
> > On Thu, Feb 28, 2013 at 10:46 PM, Yan, Zheng <zheng.z.yan@intel.com=
 (mailto:zheng.z.yan@intel.com)> wrote:
> > > From: "Yan, Zheng" <zheng.z.yan@intel.com (mailto:zheng.z.yan@int=
el.com)>
> > > =20
> > > ceph_aio_write() has an optimization that marks CEPH_CAP_FILE_WR
> > > cap dirty before data is copied to page cache and inode size is
> > > updated. The optimization avoids slow cap revocation caused by
> > > balance_dirty_pages(), but introduces inode size update race. If
> > > ceph_check_caps() flushes the dirty cap before the inode size is
> > > updated, MDS can miss the new inode size. So just remove the
> > > optimization.
> > > =20
> > > Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com (mailto:zheng.z.=
yan@intel.com)>
> > > ---
> > > fs/ceph/file.c | 42 +++++++++++++++++-------------------------
> > > 1 file changed, 17 insertions(+), 25 deletions(-)
> > > =20
> > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > index a949805..28ef273 100644
> > > --- a/fs/ceph/file.c
> > > +++ b/fs/ceph/file.c
> > > @@ -724,9 +724,12 @@ static ssize_t ceph_aio_write(struct kiocb *=
iocb, const struct iovec *iov,
> > > if (ceph_snap(inode) !=3D CEPH_NOSNAP)
> > > return -EROFS;
> > > =20
> > > + sb_start_write(inode->i_sb);
> > > retry_snap:
> > > - if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL))
> > > - return -ENOSPC;
> > > + if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL)) {
> > > + ret =3D -ENOSPC;
> > > + goto out;
> > > + }
> > > __ceph_do_pending_vmtruncate(inode);
> > > dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %llu\n"=
,
> > > inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
> > > @@ -750,29 +753,10 @@ retry_snap:
> > > ret =3D ceph_sync_write(file, iov->iov_base, iov->iov_len,
> > > &iocb->ki_pos);
> > > } else {
> > > - /*
> > > - * buffered write; drop Fw early to avoid slow
> > > - * revocation if we get stuck on balance_dirty_pages
> > > - */
> > > - int dirty;
> > > -
> > > - spin_lock(&ci->i_ceph_lock);
> > > - dirty =3D __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR);
> > > - spin_unlock(&ci->i_ceph_lock);
> > > - ceph_put_cap_refs(ci, got);
> > > -
> > > - ret =3D generic_file_aio_write(iocb, iov, nr_segs, pos);
> > > - if ((ret >=3D 0 || ret =3D=3D -EIOCBQUEUED) &&
> > > - ((file->f_flags & O_SYNC) || IS_SYNC(file->f_mapping->host)
> > > - || ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_NEARFULL))) {
> > > - err =3D vfs_fsync_range(file, pos, pos + ret - 1, 1);
> > > - if (err < 0)
> > > - ret =3D err;
> > > - }
> > > -
> > > - if (dirty)
> > > - __mark_inode_dirty(inode, dirty);
> > > - goto out;
> > > + mutex_lock(&inode->i_mutex);
> > > + ret =3D __generic_file_aio_write(iocb, iov, nr_segs,
> > > + &iocb->ki_pos);
> > > + mutex_unlock(&inode->i_mutex);
> > =20
> > =20
> > =20
> > Hmm, you're here passing in a different value than the removed
> > generic_file_aio_write() call did =E2=80=94 &iocb->ki_pos instead o=
f pos.
> > Everything else is using the pos parameter so I rather expect that
> > should still be used here?
> =20
> =20
> =20
> They always have the same value, see the BUG_ON in generic_file_aio_w=
rite()
> =20
> > Also a quick skim of the interfaces makes me think that the two
> > versions aren't interchangeable =E2=80=94 __generic_file_aio_write(=
) also
> > handles O_SYNC in addition to grabbing i_mutex. Why'd you switch th=
em?
> =20
> =20
> =20
> ceph has its own code that handles O_SYNC case. I want to make sb_sta=
rt_write()
> covers ceph_sync_write(), that's the reason I use __generic_file_aio_=
write() here.
> =20
> Regards
> Yan, Zheng
> =20
Ah, yep =E2=80=94 sounds good!
-Greg =20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
