From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: [ceph-users] Data still in OSD directories after removing
Date: Fri, 29 Apr 2016 15:09:08 +0300
Message-ID: <CABYiri-BgLZSzUmXWHeprDG0S5iNpzSZof56bsFWDbXwRG7FSg@mail.gmail.com>
References: <1400578369.11397.9.camel@localhost> <1400667430.27385.4.camel@localhost>
 <alpine.DEB.2.00.1405210818560.1689@cobra.newdream.net> <1400709806.24328.0.camel@asblu>
 <537D50EA.9020901@inktank.com> <1400748999.10571.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33421 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbcD2MJa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Apr 2016 08:09:30 -0400
Received: by mail-lf0-f54.google.com with SMTP id y84so115965354lfc.0
        for <ceph-devel@vger.kernel.org>; Fri, 29 Apr 2016 05:09:29 -0700 (PDT)
In-Reply-To: <1400748999.10571.3.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, Josh Durgin <jdurgin@redhat.com>

On Thu, May 22, 2014 at 12:56 PM, Olivier Bonvalet <ceph.list@daevel.fr=
> wrote:
>
> Le mercredi 21 mai 2014 =C3=A0 18:20 -0700, Josh Durgin a =C3=A9crit =
:
>> On 05/21/2014 03:03 PM, Olivier Bonvalet wrote:
>> > Le mercredi 21 mai 2014 =C3=A0 08:20 -0700, Sage Weil a =C3=A9crit=
 :
>> >> You're certain that that is the correct prefix for the rbd image =
you
>> >> removed?  Do you see the objects lists when you do 'rados -p rbd =
ls - |
>> >> grep <prefix>'?
>> >
>> > I'm pretty sure yes : since I didn't see a lot of space freed by t=
he
>> > "rbd snap purge" command, I looked at the RBD prefix before to do =
the
>> > "rbd rm" (it's not the first time I see that problem, but previous=
 time
>> > without the RBD prefix I was not able to check).
>> >
>> > So :
>> > - "rados -p sas3copies ls - | grep rb.0.14bfb5a.238e1f29" return n=
othing
>> > at all
>> > - # rados stat -p sas3copies rb.0.14bfb5a.238e1f29.00000002f026
>> >   error stat-ing sas3copies/rb.0.14bfb5a.238e1f29.00000002f026: No=
 such
>> > file or directory
>> > - # rados stat -p sas3copies rb.0.14bfb5a.238e1f29.000000000000
>> >   error stat-ing sas3copies/rb.0.14bfb5a.238e1f29.000000000000: No=
 such
>> > file or directory
>> > - # ls -al /var/lib/ceph/osd/ceph-67/current/9.1fe_head/DIR_E/DIR_=
=46/DIR_1/DIR_7/rb.0.14bfb5a.238e1f29.00000002f026__a252_E68871FE__9
>> > -rw-r--r-- 1 root root 4194304 oct.   8  2013 /var/lib/ceph/osd/ce=
ph-67/current/9.1fe_head/DIR_E/DIR_F/DIR_1/DIR_7/rb.0.14bfb5a.238e1f29.=
00000002f026__a252_E68871FE__9
>> >
>> >
>> >> If the objects really are orphaned, teh way to clean them up is v=
ia 'rados
>> >> -p rbd rm <objectname>'.  I'd like to get to the bottom of how th=
ey ended
>> >> up that way first, though!
>> >
>> > I suppose the problem came from me, by doing CTRL+C while "rbd sna=
p
>> > purge $IMG".
>> > "rados rm -p sas3copies rb.0.14bfb5a.238e1f29.00000002f026" don't =
remove
>> > thoses files, and just answer with a "No such file or directory".
>>
>> Those files are all for snapshots, which are removed by the osds
>> asynchronously in a process called 'snap trimming'. There's no
>> way to directly remove them via rados.
>>
>> Since you stopped 'rbd snap purge' partway through, it may
>> have removed the reference to the snapshot before removing
>> the snapshot itself.
>>
>> You can get a list of snapshot ids for the remaining objects
>> via the 'rados listsnaps' command, and use
>> rados_ioctx_selfmanaged_snap_remove() (no convenient wrapper
>> unfortunately) on each of those snapshot ids to be sure they are all
>> scheduled for asynchronous deletion.
>>
>> Josh
>>
>
> Great : "rados listsnaps" see it :
>         # rados listsnaps -p sas3copies rb.0.14bfb5a.238e1f29.0000000=
2f026
>         rb.0.14bfb5a.238e1f29.00000002f026:
>         cloneid snaps   size    overlap
>         41554   35746   4194304 []
>
> So, I have to write&compile a wrapper to
> rados_ioctx_selfmanaged_snap_remove(), and find a way to obtain a lis=
t
> of all "orphan" objects ?
>
> I also try to recreate the object (rados put) then remove it (rados r=
m),
> but snapshots still here.
>
> Olivier


Hi,

there is a certainly an issue with (at least) old FileStore and
snapshot chunks as they are getting completely unreferenced even for
listsnaps example from above but are presented in omap and on
filesystem after complete image and snapshot removal. Given the fact
that the control flow has not been interrupted ever, e.g. snap
deletion command was always been successful on exit either was image
removal itself, what could be done for those poor data chunks? In fact
this leakage on a long-scale runs like eight months in a given case
could be quite problematic to handle, as orphans do consume almost as
much data as the 'active' rest of the storage on selected OSDs. Since
the chunks are still referenced in omap by some reason, they must not
be deleted directly, so my question could be narrowed down to a
possible existing workaround for this.

Thanks!

3.1b0_head$ find . -type f -name '*64ba14d3dd381*' -mtime +90
=2E/DIR_0/DIR_B/DIR_1/DIR_1/rbd\udata.64ba14d3dd381.0000000000020dd7__2=
3116_25FB11B0__3
=2E/DIR_0/DIR_B/DIR_1/DIR_1/rbd\udata.64ba14d3dd381.0000000000020dd7__2=
41e9_25FB11B0__3
=2E/DIR_0/DIR_B/DIR_1/DIR_1/rbd\udata.64ba14d3dd381.0000000000020dd7__2=
507f_25FB11B0__3
=2E/DIR_0/DIR_B/DIR_1/DIR_1/rbd\udata.64ba14d3dd381.0000000000020dd7__2=
5dfd_25FB11B0__3



find . -type f -name '*64ba14d3dd381*snap*'
=2E/DIR_0/DIR_B/DIR_1/DIR_1/rbd\udata.64ba14d3dd381.0000000000020dd7__s=
napdir_25FB11B0__3
=2E/DIR_0/DIR_B/DIR_1/DIR_2/DIR_3/rbd\udata.64ba14d3dd381.0000000000010=
eb3__snapdir_2B8321B0__3
=2E/DIR_0/DIR_B/DIR_1/DIR_4/DIR_6/rbd\udata.64ba14d3dd381.000000000001c=
715__snapdir_F5D641B0__3
=2E/DIR_0/DIR_B/DIR_1/DIR_4/DIR_9/rbd\udata.64ba14d3dd381.000000000002b=
694__snapdir_CC4941B0__3
=2E/DIR_0/DIR_B/DIR_1/DIR_5/DIR_9/rbd\udata.64ba14d3dd381.000000000001b=
6f7__snapdir_08B951B0__3
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
