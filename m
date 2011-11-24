From: Christian Brunner <chb@muc.de>
Subject: Re: pginfo updates
Date: Thu, 24 Nov 2011 21:45:36 +0100
Message-ID: <CAO47_-87sgYFew1ST3+xkRSbzHGYP2Qemq6Cy+FtiOhvkFD4uw@mail.gmail.com>
References: <CAO47_-_WLRby4m9rAvdUyCJu+_+33uHp90XPOnRJ0M=0JohouQ@mail.gmail.com>
	<CAF3hT9BJ0xQROqAMbJhWb=KcGwAgQNtNRUwOia7kZzpkiu4sGg@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38538 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060Ab1KXUph convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Nov 2011 15:45:37 -0500
Received: by vbbfc26 with SMTP id fc26so1751269vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 Nov 2011 12:45:37 -0800 (PST)
In-Reply-To: <CAF3hT9BJ0xQROqAMbJhWb=KcGwAgQNtNRUwOia7kZzpkiu4sGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Hmmm, OK. - This really seems to belong to one virtual machine, that
is writing to a single object over and over again.

Thanks for your hint. I guess I will have to look into the VM.

Christian



2011/11/24 Gregory Farnum <gregory.farnum@dreamhost.com>:
> PGInfos are updated on disk with every write to the PG. I'm surprised
> that one PG has so much more activity than the others, but that's why
> that inode has so much activity.
>
> What are you doing with this installation, and roughly how many PGs
> are on the node?
>
> On Thu, Nov 24, 2011 at 3:33 AM, Christian Brunner <chb@muc.de> wrote=
:
>> I'm running a btrfs-debug patch on one of our nodes. This patch prin=
ts
>> calls to btrfs_orphan_add. I'm still waiting for the problem the pat=
ch
>> was intended to trace, but in the logs I found something ceph relate=
d
>> I don't understand:
>>
>> When I look at the btrfs_orphan_add messages there is one inode that
>> is updated over and over again. When I count the inodes in my log, I
>> can see the following distribution (only inodes with more than 500
>> btrfs_orphan_add calls listed):
>>
>> =A0 #cnt =A0 =A0 Inode
>> =A0 1117 =A07403
>> =A017218 =A07457
>> =A0 =A0848 =A07484
>> =A0 =A0539 =A07984
>> =A0 1446 =A09098
>> =A0 =A0635 =A09346
>>
>> When I look at the filesysteme, I can see that inode 7457 belongs to=
:
>>
>> current/meta/DIR_8/DIR_A/pginfo\u2.8d__0_28D2BFA8
>>
>> I don't know how the pginfo stuff works, but I really wonder why the
>> distribution is so uneven.
>>
>> "strace -f | grep 28D2BFA8" is giving me the this output:
>>
>> [...]
>> [pid =A03840] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__=
0_28D16932",
>> {st_mode=3DS_IFREG|0644, st_size=3D8, ...}) =3D 0
>> [pid =A03840] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__=
0_28D16932",
>> {st_mode=3DS_IFREG|0644, st_size=3D8, ...}) =3D 0
>> [pid =A03840] truncate("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.=
d6__0_28D16932",
>> 0) =3D 0
>> [pid =A03840] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__=
0_28D16932",
>> {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
>> [pid =A03840] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__=
0_28D16932",
>> {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
>> [pid =A03840] open("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__=
0_28D16932",
>> O_WRONLY|O_CREAT, 0644) =3D 64
>> [pid =A03841] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__=
0_28D16932",
>> {st_mode=3DS_IFREG|0644, st_size=3D8, ...}) =3D 0
>> [pid =A03841] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__=
0_28D16932",
>> {st_mode=3DS_IFREG|0644, st_size=3D8, ...}) =3D 0
>> [pid =A03841] truncate("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.=
d6__0_28D16932",
>> 0) =3D 0
>> [pid =A03841] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__=
0_28D16932",
>> {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
>> [pid =A03841] stat("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__=
0_28D16932",
>> {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
>> [pid =A03841] open("/ceph/osd.015/current/meta/DIR_2/pginfo\\u2.d6__=
0_28D16932",
>> O_WRONLY|O_CREAT, 0644) =3D 64
>> [...]
>>
>> Regards,
>> Christian
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
