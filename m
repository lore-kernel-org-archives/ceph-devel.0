From: huang jun <hjwsm1989@gmail.com>
Subject: How to improve erasure pool's delete performance
Date: Sun, 3 Apr 2016 14:40:09 +0800
Message-ID: <CABAwU-a1kxbc=i564da=GAj11_5M-tKE6R2kP5vaX7Ga2F3g=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34917 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbcDCGkL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Apr 2016 02:40:11 -0400
Received: by mail-lf0-f43.google.com with SMTP id c126so6852907lfb.2
        for <ceph-devel@vger.kernel.org>; Sat, 02 Apr 2016 23:40:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all
Recently, we test deletion performance of erasure pool, and we found
the delete op
is pretty slow.
We trace the code and found Delete op was converted to Rename in Filest=
ore,
It was implemented in function FileStore::_collection_move_rename(),
it calls FileStore::_set_replay_guard function and
=46ileStore::_close_replay_guard function,
in these 2 function, do 3 fsyncs and 1 objectmap sync, which we think
spend the most time.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Envirnoment:
ceph version: 0.94.5
linux kernel: 3.18
Test cluster: 1MON, 1MDS, 4OSD
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
We do some comparison tests:
1. sync omap + fd=EF=BC=88default)
avg rename op used 0.883818s
2. only sync omap: 0.428431s
3. only sync fd: 0.400266s
4. dont sync: 0.00319648
5. do posix_fadvise(FADVISE_DONTNEED) after write, and sync omap + fd: =
0.855178s
6. use fdatasync to replace fsync, and sync omap + fd : 0.432659s

As we can see, sync fd and sync objectmap use 50% of the total time eac=
h.
Compare 1 with 6, fdatasync uses 50% less time compared to fdatasync,
which means sync metadata spent more time than sync data.
In FileStore::_set_replay_guard function and
=46ileStore::_close_replay_guard function,
it only set object's user.cephos.seq xattr, then do sync to let it dura=
ble.

I have some questions:
1. Do we record the xattr(user.cephos.seq) to avoid replaying an older
transaction?
2. If dont do sync, we will get the best performance, is there any
side effects? like: get data corrupted.

Any comments are welcome.

--=20
thanks
huangjun
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
