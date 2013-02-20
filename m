From: Gregory Farnum <greg@inktank.com>
Subject: Re: mds crashes upon access to some snapshotted files
Date: Wed, 20 Feb 2013 12:09:15 -0800
Message-ID: <CAPYLRzgraE=BadeC0Ab1J4YM3_01TchE8Ra344--AxCW3nV6fw@mail.gmail.com>
References: <ortxpcs9h5.fsf@livre.home>
	<orfw0wry6d.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:36612 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934590Ab3BTUJQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Feb 2013 15:09:16 -0500
Received: by mail-qa0-f48.google.com with SMTP id j8so2617434qah.14
        for <ceph-devel@vger.kernel.org>; Wed, 20 Feb 2013 12:09:15 -0800 (PST)
In-Reply-To: <orfw0wry6d.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Feb 16, 2013 at 4:56 AM, Alexandre Oliva <oliva@gnu.org> wrote:
> I suppose this might be the result of some filesystem corruption, but=
 I
> have some files in my ceph tree that, when accessed, crash the mds.
>
> The files are in subdirectories of dirs snapshotted numerous times, s=
ome
> very recently, some long ago.  All but the most recent snapshots have
> been removed, though.  Anyway, I'm not accessing them through the
> snapshot (i.e., not as subdir/.snap/_snapname_inode/filename, but as
> subdir/filename).
>
> I've had this problem for quite a long time, and I couldn't quite fig=
ure
> out what's special about the files, the directories holding them, or
> what.  I suspect some corruption from old releases of ceph, that migh=
t
> or might not still be possible to create with a newer release.
>
> Anyway, long ago I found out this patch would work around the problem=
,
> enabling me to access the files just fine, apparently without any oth=
er
> bad consequences.
>
> Does it make sense to put it in the upcoming stable release?
>
> Any ideas of what to do to find out why I need this patch, and/or wha=
t I
> could do to not need this patch any more?

It sounds like you've got snapshots that were incompletely deleted =97
the ancestor snapshots got removed, but not the snaps on the inodes
they're crashing on. And indeed that's the case, see below.
The other possibility is that this is bug
http://tracker.ceph.com/issues/4212, which Sage noticed when I brought
up my discussion of #4213. :)


On Sat, Feb 16, 2013 at 9:00 AM, Alexandre Oliva <oliva@gnu.org> wrote:
> On Feb 16, 2013, Alexandre Oliva <oliva@gnu.org> wrote:
>
>> I suppose this might be the result of some filesystem corruption, bu=
t I
>> have some files in my ceph tree that, when accessed, crash the mds.
>
> Here's another patch from my mds crash avoidance series.
>
> With it, instead of a crash, I get a message like this in the mds log=
:
>
>   2013-02-16 13:49:16.360480 7f0e7a0f1700  0 mds.0.cache  hmm, 82 is =
not the first in old_inodes; 2 is

This one's definitely a problem.

> @@ -1763,7 +1763,13 @@ void MDCache::project_rstat_frag_to_inode(nest=
_info_t& rstat, nest_info_t& accou
>         first =3D p->second.first;
>         if (first > last) {
>           dout(10) << " oldest old_inode is [" << first << "," << p->=
first << "], done." << dendl;
> -         assert(p =3D=3D pin->old_inodes.begin());
> +         if (p !=3D pin->old_inodes.begin())
> +           dout(0) << " hmm, " << p->first
> +                   << " is not the first in old_inodes; "
> +                   << (pin->old_inodes.begin() !=3D pin->old_inodes.=
end()
> +                       ? pin->old_inodes.begin()->first
> +                       : snapid_t (CEPH_NOSNAP))
> +                   << " is" << dendl;

old_inodes represent the inode as it was for some snapshots. Earlier
in this function, we got "p", and it was the map::lower_bound of last.
In this branch, we've discovered that the old inode's version is
greater than "last", and that shouldn't be the case unless there was
nobody older in old_inodes =97 ie, the old inode has to be the first in
the list. The fact that it's not indicates that the old_inodes map is
definitely corrupted somehow. And that looks to be an MDS bug because
it's not clearing out old_inodes when snapshots are deleted, see
http://tracker.ceph.com/issues/4213. :(


So your workaround patches should work for you without farther
breakage, but we want to fix the source rather than the symptom of the
problem right now (there aren't many people using CephFS, and
especially snapshots, after all!).
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
