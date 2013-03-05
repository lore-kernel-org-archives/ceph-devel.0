From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 6/7] ceph: don't early drop Fw cap
Date: Tue, 05 Mar 2013 09:57:18 +0800
Message-ID: <513550FE.1020401@intel.com>
References: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com> <1362120384-5188-7-git-send-email-zheng.z.yan@intel.com> <CAPYLRziF-BTvksCM3LDfdwvjrLWXQhSdoF+PB3XJAd7KJp4cmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:27325 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932721Ab3CEB5U (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Mar 2013 20:57:20 -0500
In-Reply-To: <CAPYLRziF-BTvksCM3LDfdwvjrLWXQhSdoF+PB3XJAd7KJp4cmw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On 03/05/2013 02:26 AM, Gregory Farnum wrote:
> On Thu, Feb 28, 2013 at 10:46 PM, Yan, Zheng <zheng.z.yan@intel.com> =
wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> ceph_aio_write() has an optimization that marks CEPH_CAP_FILE_WR
>> cap dirty before data is copied to page cache and inode size is
>> updated. The optimization avoids slow cap revocation caused by
>> balance_dirty_pages(), but introduces inode size update race. If
>> ceph_check_caps() flushes the dirty cap before the inode size is
>> updated, MDS can miss the new inode size. So just remove the
>> optimization.
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  fs/ceph/file.c | 42 +++++++++++++++++-------------------------
>>  1 file changed, 17 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>> index a949805..28ef273 100644
>> --- a/fs/ceph/file.c
>> +++ b/fs/ceph/file.c
>> @@ -724,9 +724,12 @@ static ssize_t ceph_aio_write(struct kiocb *ioc=
b, const struct iovec *iov,
>>         if (ceph_snap(inode) !=3D CEPH_NOSNAP)
>>                 return -EROFS;
>>
>> +       sb_start_write(inode->i_sb);
>>  retry_snap:
>> -       if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL))
>> -               return -ENOSPC;
>> +       if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL)) {
>> +               ret =3D -ENOSPC;
>> +               goto out;
>> +       }
>>         __ceph_do_pending_vmtruncate(inode);
>>         dout("aio_write %p %llx.%llx %llu~%u getting caps. i_size %l=
lu\n",
>>              inode, ceph_vinop(inode), pos, (unsigned)iov->iov_len,
>> @@ -750,29 +753,10 @@ retry_snap:
>>                 ret =3D ceph_sync_write(file, iov->iov_base, iov->io=
v_len,
>>                         &iocb->ki_pos);
>>         } else {
>> -               /*
>> -                * buffered write; drop Fw early to avoid slow
>> -                * revocation if we get stuck on balance_dirty_pages
>> -                */
>> -               int dirty;
>> -
>> -               spin_lock(&ci->i_ceph_lock);
>> -               dirty =3D __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_W=
R);
>> -               spin_unlock(&ci->i_ceph_lock);
>> -               ceph_put_cap_refs(ci, got);
>> -
>> -               ret =3D generic_file_aio_write(iocb, iov, nr_segs, p=
os);
>> -               if ((ret >=3D 0 || ret =3D=3D -EIOCBQUEUED) &&
>> -                   ((file->f_flags & O_SYNC) || IS_SYNC(file->f_map=
ping->host)
>> -                    || ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_N=
EARFULL))) {
>> -                       err =3D vfs_fsync_range(file, pos, pos + ret=
 - 1, 1);
>> -                       if (err < 0)
>> -                               ret =3D err;
>> -               }
>> -
>> -               if (dirty)
>> -                       __mark_inode_dirty(inode, dirty);
>> -               goto out;
>> +               mutex_lock(&inode->i_mutex);
>> +               ret =3D __generic_file_aio_write(iocb, iov, nr_segs,
>> +                                              &iocb->ki_pos);
>> +               mutex_unlock(&inode->i_mutex);
>=20
> Hmm, you're here passing in a different value than the removed
> generic_file_aio_write() call did =97 &iocb->ki_pos instead of pos.
> Everything else is using the pos parameter so I rather expect that
> should still be used here?

They always have the same value, see the BUG_ON in generic_file_aio_wri=
te()

> Also a quick skim of the interfaces makes me think that the two
> versions aren't interchangeable =97 __generic_file_aio_write() also
> handles O_SYNC in addition to grabbing i_mutex. Why'd you switch them=
?

ceph has its own code that handles O_SYNC case. I want to make sb_start=
_write()
covers ceph_sync_write(), that's the reason I use __generic_file_aio_wr=
ite() here.

Regards
Yan, Zheng

> (I haven't checked deep enough to see if the unlocked version is
> correct or not, but it does say that's what most filesystems should
> use.)
> -Greg
>=20
>=20
>>         }
>>
>>         if (ret >=3D 0) {
>> @@ -790,12 +774,20 @@ out_put:
>>              ceph_cap_string(got));
>>         ceph_put_cap_refs(ci, got);
>>
>> +       if (ret >=3D 0 &&
>> +           ((file->f_flags & O_SYNC) || IS_SYNC(file->f_mapping->ho=
st) ||
>> +            ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_NEARFULL))) =
{
>> +               err =3D vfs_fsync_range(file, pos, pos + ret - 1, 1)=
;
>> +               if (err < 0)
>> +                       ret =3D err;
>> +       }
>>  out:
>>         if (ret =3D=3D -EOLDSNAPC) {
>>                 dout("aio_write %p %llx.%llx %llu~%u got EOLDSNAPC, =
retrying\n",
>>                      inode, ceph_vinop(inode), pos, (unsigned)iov->i=
ov_len);
>>                 goto retry_snap;
>>         }
>> +       sb_end_write(inode->i_sb);
>>
>>         return ret;
>>  }
>> --
>> 1.7.11.7
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
