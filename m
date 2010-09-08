From: Nat N <phenisha@gmail.com>
Subject: Re: MDS crashing
Date: Thu, 9 Sep 2010 08:30:23 +1000
Message-ID: <AANLkTi=1C07ETO72hcW-9F0j5Enzgxdtfv4hVfr+PrNL@mail.gmail.com>
References: <AANLkTinOE+zRi_UHq33xPkADp-xavEbxgiW+ezUhVciT@mail.gmail.com>
	<Pine.LNX.4.64.1009081019460.28511@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55015 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab0IHWiR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Sep 2010 18:38:17 -0400
Received: by ewy23 with SMTP id 23so504079ewy.19
        for <ceph-devel@vger.kernel.org>; Wed, 08 Sep 2010 15:38:16 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009081019460.28511@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Thu, Sep 9, 2010 at 3:27 AM, Sage Weil <sage@newdream.net> wrote:
> Hi Nat,
>
> Can you add
>
> =A0 =A0 =A0 =A0debug mds =3D 20
> =A0 =A0 =A0 =A0debug ms =3D 1
>
> to the [mds] section of your ceph.conf, restart the mds, and post the
> resulting mds log (normally in /var/log/ceph)?
>
> It looks like interval_set is throwing the assertion because it's
> inserting a value into the set that is already there.. the question i=
s
> why. =A0Once we identify where the error came from, we can also make =
the
> journal replay tolerate the condition as best it can.
>
> Thanks!
> sage
>

Sage,

I have completed this please see below for the last little bit before t=
he crash

10.09.09_08:01:28.390543 44cef940 mds0.journal EMetaBlob.replay dir 100=
00385002
10.09.09_08:01:28.390550 44cef940 mds0.journal EMetaBlob.replay
updated dir [dir 10000385002 /data/md_public/tmp_krx/ [2,head] auth
v=3D9175 cv=3D0/0 state=3D1610612738|complete f(v0 m10.09.03_13:49:31.0=
00144
190=3D1+189) n(v123 rc10.09.03_14:51:22.000677 b9509807549 1032=3D655+3=
77)
hs=3D190+1,ss=3D0+0 dirty=3D191 | child dirty 0x7fe8ccaced38]
10.09.09_08:01:28.390574 44cef940 mds0.journal EMetaBlob.replay for
[2,head] had [dentry #1/data/md_public/tmp_krx/99 [2,head] auth
(dversion lock) v=3D9174 inode=3D0x7fe8d06e5228 | inodepin dirty
0x7fe8c22dae30]
10.09.09_08:01:28.390590 44cef940 mds0.journal EMetaBlob.replay for
[2,head] had [inode 100003850a8 [...2,head]
/data/md_public/tmp_krx/99/ auth v9174 f(v2 m10.09.03_13:23:04.000779
1=3D0+1) n(v10 rc10.09.03_13:47:44.000284 b36219707 7=3D5+2) (inest syn=
c
dirty) (ifile sync dirty) (iversion lock) | dirtyscattered dirfrag
dirty 0x7fe8d06e5228]
10.09.09_08:01:28.390609 44cef940 mds0.journal EMetaBlob.replay
request client6312:2695 707
10.09.09_08:01:28.390626 44cef940 mds0.log _replay 16078321005~1330 /
16113176521 : EUpdate scatter_writebehind [metablob 10000385002, 2
dirs]
10.09.09_08:01:28.390634 44cef940 mds0.journal EMetaBlob.replay 2 dirlu=
mps
10.09.09_08:01:28.390639 44cef940 mds0.journal EMetaBlob.replay dir 100=
00385002
10.09.09_08:01:28.390646 44cef940 mds0.cache.dir(10000385002)
mark_dirty (already dirty) [dir 10000385002 /data/md_public/tmp_krx/
[2,head] auth v=3D9177 cv=3D0/0 state=3D1610612738|complete f(v0
m10.09.03_13:49:31.000144 190=3D1+189) n(v123 rc10.09.03_14:51:22.00067=
7
b9509807549 1032=3D655+377) hs=3D190+1,ss=3D0+0 dirty=3D191 | child dir=
ty
0x7fe8ccaced38] version 9177
10.09.09_08:01:28.390668 44cef940 mds0.journal EMetaBlob.replay
clean nestinfo on [dir 10000385002 /data/md_public/tmp_krx/ [2,head]
auth v=3D9177 cv=3D0/0 state=3D1610612738|complete f(v0
m10.09.03_13:49:31.000144 190=3D1+189) n(v123 rc10.09.03_14:51:22.00067=
7
b9509807549 1032=3D655+377) hs=3D190+1,ss=3D0+0 dirty=3D191 | child dir=
ty
0x7fe8ccaced38]
10.09.09_08:01:28.390687 44cef940 mds0.journal EMetaBlob.replay
updated dir [dir 10000385002 /data/md_public/tmp_krx/ [2,head] auth
v=3D9177 cv=3D0/0 state=3D1610612738|complete f(v0 m10.09.03_13:49:31.0=
00144
190=3D1+189) n(v123 rc10.09.03_14:51:22.000677 b9509807549 1032=3D655+3=
77)
hs=3D190+1,ss=3D0+0 dirty=3D191 | child dirty 0x7fe8ccaced38]
10.09.09_08:01:28.390709 44cef940 mds0.journal EMetaBlob.replay for
[2,head] had [dentry #1/data/md_public/tmp_krx/99 [2,head] auth
(dversion lock) v=3D9176 inode=3D0x7fe8d06e5228 | inodepin dirty
0x7fe8c22dae30]
10.09.09_08:01:28.390721 44cef940 mds0.journal EMetaBlob.replay for
[2,head] had [inode 100003850a8 [...2,head]
/data/md_public/tmp_krx/99/ auth v9176 f(v2 m10.09.03_13:23:04.000779
1=3D0+1) n(v10 rc10.09.03_13:47:44.000284 b36219707 7=3D5+2) (inest syn=
c
dirty) (ifile sync dirty) (iversion lock) | dirtyscattered dirfrag
dirty 0x7fe8d06e5228]
10.09.09_08:01:28.390741 44cef940 mds0.journal EMetaBlob.replay dir 100=
003850a8
10.09.09_08:01:28.390747 44cef940 mds0.journal EMetaBlob.replay
updated dir [dir 100003850a8 /data/md_public/tmp_krx/99/ [2,head] auth
v=3D207 cv=3D0/0 state=3D1610612738|complete f(v2 m10.09.03_13:23:04.00=
0779
1=3D0+1) n(v10 rc10.09.03_13:47:44.000284 b36219707 6=3D5+1) hs=3D1+0,s=
s=3D0+0
dirty=3D1 | child dirty 0x7fe8ccb0b428]
10.09.09_08:01:28.390771 44cef940 mds0.journal EMetaBlob.replay for
[2,head] had [dentry #1/data/md_public/tmp_krx/99/output [2,head] auth
(dversion lock) v=3D206 inode=3D0x7fe8d06e5a70 | inodepin dirty
0x7fe8c22db000]
10.09.09_08:01:28.390787 44cef940 mds0.journal EMetaBlob.replay for
[2,head] had [inode 100003850a9 [...2,head]
/data/md_public/tmp_krx/99/output/ auth v206 f(v2
m10.09.03_13:47:44.000284 5=3D5+0) n(v0 rc10.09.03_13:47:44.000284
b36219707 6=3D5+1) (inest sync dirty) (ifile sync dirty) (iversion lock=
)
| dirtyscattered dirfrag dirty 0x7fe8d06e5a70]
10.09.09_08:01:28.390826 44cef940 mds0.log _replay 16078322339~1343 /
16113176521 : EUpdate setattr [metablob 10000385002, 2 dirs]
10.09.09_08:01:28.390835 44cef940 mds0.journal EMetaBlob.replay 2 dirlu=
mps
10.09.09_08:01:28.390841 44cef940 mds0.journal EMetaBlob.replay dir 100=
00385002
10.09.09_08:01:28.390847 44cef940 mds0.cache.dir(10000385002)
mark_dirty (already dirty) [dir 10000385002 /data/md_public/tmp_krx/
[2,head] auth v=3D9179 cv=3D0/0 state=3D1610612738|complete f(v0
m10.09.03_13:49:31.000144 190=3D1+189) n(v123 rc10.09.03_14:51:22.00067=
7
b9509807549 1032=3D655+377) hs=3D190+1,ss=3D0+0 dirty=3D191 | child dir=
ty
0x7fe8ccaced38] version 9179
10.09.09_08:01:28.390868 44cef940 mds0.journal EMetaBlob.replay
clean nestinfo on [dir 10000385002 /data/md_public/tmp_krx/ [2,head]
auth v=3D9179 cv=3D0/0 state=3D1610612738|complete f(v0
m10.09.03_13:49:31.000144 190=3D1+189) n(v123 rc10.09.03_14:51:22.00067=
7
b9509807549 1032=3D655+377) hs=3D190+1,ss=3D0+0 dirty=3D191 | child dir=
ty
0x7fe8ccaced38]
10.09.09_08:01:28.390887 44cef940 mds0.journal EMetaBlob.replay
updated dir [dir 10000385002 /data/md_public/tmp_krx/ [2,head] auth
v=3D9179 cv=3D0/0 state=3D1610612738|complete f(v0 m10.09.03_13:49:31.0=
00144
190=3D1+189) n(v123 rc10.09.03_14:51:22.000677 b9509807549 1032=3D655+3=
77)
hs=3D190+1,ss=3D0+0 dirty=3D191 | child dirty 0x7fe8ccaced38]
10.09.09_08:01:28.390911 44cef940 mds0.journal EMetaBlob.replay for
[2,head] had [dentry #1/data/md_public/tmp_krx/99 [2,head] auth
(dversion lock) v=3D9178 inode=3D0x7fe8d06e5228 | inodepin dirty
0x7fe8c22dae30]
10.09.09_08:01:28.390924 44cef940 mds0.journal EMetaBlob.replay for
[2,head] had [inode 100003850a8 [...2,head]
/data/md_public/tmp_krx/99/ auth v9178 f(v2 m10.09.03_13:23:04.000779
1=3D0+1) n(v10 rc10.09.03_13:47:44.000284 b36219707 7=3D5+2) (inest syn=
c
dirty) (ifile sync dirty) (iversion lock) | dirtyscattered dirfrag
dirty 0x7fe8d06e5228]
10.09.09_08:01:28.390943 44cef940 mds0.journal EMetaBlob.replay dir 100=
003850a8
10.09.09_08:01:28.390950 44cef940 mds0.journal EMetaBlob.replay
updated dir [dir 100003850a8 /data/md_public/tmp_krx/99/ [2,head] auth
v=3D209 cv=3D0/0 state=3D1610612738|complete f(v2 m10.09.03_13:23:04.00=
0779
1=3D0+1) n(v10 rc10.09.03_13:47:44.000284 b36219707 6=3D5+1) hs=3D1+0,s=
s=3D0+0
dirty=3D1 | child dirty 0x7fe8ccb0b428]
10.09.09_08:01:28.390974 44cef940 mds0.journal EMetaBlob.replay for
[2,head] had [dentry #1/data/md_public/tmp_krx/99/output [2,head] auth
(dversion lock) v=3D208 inode=3D0x7fe8d06e5a70 | inodepin dirty
0x7fe8c22db000]
10.09.09_08:01:28.390988 44cef940 mds0.journal EMetaBlob.replay for
[2,head] had [inode 100003850a9 [...2,head]
/data/md_public/tmp_krx/99/output/ auth v208 f(v2
m10.09.03_13:47:44.000284 5=3D5+0) n(v0 rc10.09.03_13:47:44.000284
b36219707 6=3D5+1) (inest sync dirty) (ifile sync dirty) (iversion lock=
)
| dirtyscattered dirfrag dirty 0x7fe8d06e5a70]
10.09.09_08:01:28.391008 44cef940 mds0.journal EMetaBlob.replay
request client6312:2697 707
10.09.09_08:01:28.391025 44cef940 mds0.log _replay 16078323686~1406 /
16113176521 : EUpdate openc [metablob 100003850a8, 2 dirs
alloc_ino=3D10000385e80 prealloc_ino=3D[10000385e81~3e8] v3685237]
10.09.09_08:01:28.391034 44cef940 mds0.journal EMetaBlob.replay 2 dirlu=
mps
10.09.09_08:01:28.391040 44cef940 mds0.journal EMetaBlob.replay dir 100=
003850a8
10.09.09_08:01:28.391046 44cef940 mds0.cache.dir(100003850a8)
mark_dirty (already dirty) [dir 100003850a8
/data/md_public/tmp_krx/99/ [2,head] auth v=3D211 cv=3D0/0
state=3D1610612738|complete f(v2 m10.09.03_13:23:04.000779 1=3D0+1) n(v=
10
rc10.09.03_14:56:31.000710 b36219707 7=3D6+1)/n(v10
rc10.09.03_13:47:44.000284 b36219707 6=3D5+1) hs=3D1+0,ss=3D0+0 dirty=3D=
1 |
child dirty 0x7fe8ccb0b428] version 211
10.09.09_08:01:28.391068 44cef940 mds0.journal EMetaBlob.replay
dirty nestinfo on [dir 100003850a8 /data/md_public/tmp_krx/99/
[2,head] auth v=3D211 cv=3D0/0 state=3D1610612738|complete f(v2
m10.09.03_13:23:04.000779 1=3D0+1) n(v10 rc10.09.03_14:56:31.000710
b36219707 7=3D6+1)/n(v10 rc10.09.03_13:47:44.000284 b36219707 6=3D5+1)
hs=3D1+0,ss=3D0+0 dirty=3D1 | child dirty 0x7fe8ccb0b428]
10.09.09_08:01:28.391099 44cef940 mds0.locker mark_updated_scatterlock
(inest sync dirty) - already on list since 10.09.09_08:01:25.431917
10.09.09_08:01:28.391111 44cef940 mds0.journal EMetaBlob.replay
updated dir [dir 100003850a8 /data/md_public/tmp_krx/99/ [2,head] auth
v=3D211 cv=3D0/0 state=3D1610612738|complete f(v2 m10.09.03_13:23:04.00=
0779
1=3D0+1) n(v10 rc10.09.03_14:56:31.000710 b36219707 7=3D6+1)/n(v10
rc10.09.03_13:47:44.000284 b36219707 6=3D5+1) hs=3D1+0,ss=3D0+0 dirty=3D=
1 |
child dirty 0x7fe8ccb0b428]
10.09.09_08:01:28.391136 44cef940 mds0.journal EMetaBlob.replay for
[2,head] had [dentry #1/data/md_public/tmp_krx/99/output [2,head] auth
(dversion lock) v=3D210 inode=3D0x7fe8d06e5a70 | inodepin dirty
0x7fe8c22db000]
10.09.09_08:01:28.391150 44cef940 mds0.journal EMetaBlob.replay for
[2,head] had [inode 100003850a9 [...2,head]
/data/md_public/tmp_krx/99/output/ auth v210 f(v2
m10.09.03_14:56:31.000710 6=3D6+0) n(v0 rc10.09.03_14:56:31.000710
b36219707 7=3D6+1) (inest sync dirty) (ifile sync dirty) (iversion lock=
)
| dirtyscattered dirfrag dirty 0x7fe8d06e5a70]
10.09.09_08:01:28.391174 44cef940 mds0.journal EMetaBlob.replay dir 100=
003850a9
10.09.09_08:01:28.391180 44cef940 mds0.journal EMetaBlob.replay
updated dir [dir 100003850a9 /data/md_public/tmp_krx/99/output/
[2,head] auth v=3D185 cv=3D0/0 state=3D1610612738|complete f(v2
m10.09.03_14:56:31.000710 6=3D6+0) n(v0 rc10.09.03_14:56:31.000710
b36219707 6=3D6+0) hs=3D5+15,ss=3D0+0 dirty=3D20 | child dirty 0x7fe8cc=
b0ba20]
10.09.09_08:01:28.391212 44cef940 mds0.cache.dir(100003850a9)
add_null_dentry [dentry
#1/data/md_public/tmp_krx/99/output/.Kexpiring_2D_futures.zblock.bGxmqP
[2,head] auth NULL (dversion lock) pv=3D0 v=3D185 inode=3D0 0x7fe8c245d=
f80]
10.09.09_08:01:28.391228 44cef940 mds0.journal EMetaBlob.replay added
[dentry #1/data/md_public/tmp_krx/99/output/.Kexpiring_2D_futures.zbloc=
k.bGxmqP
[2,head] auth NULL (dversion lock) v=3D184 inode=3D0 | dirty
0x7fe8c245df80]
10.09.09_08:01:28.391250 44cef940 mds0.cache.dir(100003850a9)
link_primary_inode [dentry
#1/data/md_public/tmp_krx/99/output/.Kexpiring_2D_futures.zblock.bGxmqP
[2,head] auth NULL (dversion lock) v=3D184 inode=3D0 | dirty
0x7fe8c245df80] [inode 10000385e80 [2,head] #10000385e80 auth v184 s=3D=
0
nl=3D1 n(v0 1=3D1+0) (iversion lock) cr=3D{6312=3D0-4194304@0} 0x7fe8d0=
9ecfc0]
10.09.09_08:01:28.391278 44cef940 mds0.journal EMetaBlob.replay added
[inode 10000385e80 [2,head]
/data/md_public/tmp_krx/99/output/.Kexpiring_2D_futures.zblock.bGxmqP
auth v184 s=3D0 nl=3D1 n(v0 1=3D1+0) (iversion lock) cr=3D{6312=3D0-419=
4304@0} |
dirty 0x7fe8d09ecfc0]
10.09.09_08:01:28.391292 44cef940 mds0.journal EMetaBlob.replay noting
opened inode [inode 10000385e80 [2,head]
/data/md_public/tmp_krx/99/output/.Kexpiring_2D_futures.zblock.bGxmqP
auth v184 s=3D0 nl=3D1 n(v0 1=3D1+0) (iversion lock) cr=3D{6312=3D0-419=
4304@0} |
dirty 0x7fe8d09ecfc0]
10.09.09_08:01:28.391308 44cef940 mds0.journal EMetaBlob.replay
inotable v 3685237 - 1 =3D=3D table 3685235 allocated+used 10000385e80
prealloc [10000385e81~3e8]
10.09.09_08:01:28.391317 44cef940 mds0.inotable: replay_alloc_id 100003=
85e80
10.09.09_08:01:28.391329 44cef940 mds0.inotable: replay_alloc_ids
[10000385e81~3e8]
10.09.09_08:01:28.391338 44cef940 mds0.journal EMetaBlob.replay
sessionmap v7370409 -(1|2) =3D=3D table 7370408 prealloc [10000385e81~3=
e8]
used 0
10.09.09_08:01:28.391345 44cef940 mds0.journal  (session prealloc
[10000385e80~3e8])
=2E/include/interval_set.h: In function 'void interval_set<T>::insert(T=
,
T) [with T =3D inodeno_t]':
=2E/include/interval_set.h:202: FAILED assert(0)
 1: (EMetaBlob::replay(MDS*, LogSegment*)+0x3f75) [0x691625]
 2: (EUpdate::replay(MDS*)+0x38) [0x694d28]
 3: (MDLog::_replay_thread()+0x68e) [0x68801e]
 4: (MDLog::ReplayThread::entry()+0xd) [0x4bb3cd]
 5: (Thread::_entry_func(void*)+0xa) [0x49c71a]
 6: /lib64/libpthread.so.0 [0x3909c0673d]
 7: (clone()+0x6d) [0x39094d3d1d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
