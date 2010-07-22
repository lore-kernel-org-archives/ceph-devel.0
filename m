From: Hugo Slabbert <hugo.slabbert@slabnet.com>
Subject: Re: ceph, shadow_copy, cifs, and "Previous Versions"
Date: Thu, 22 Jul 2010 10:39:01 -0700
Message-ID: <AANLkTin8GQG3jlmM4jIMWHx86ni6TY4h6JvU5z69TnbP@mail.gmail.com>
References: <AANLkTilFlPF4vBYErEWtFaoR7IfXOh6ts6bY-VKvZmRD@mail.gmail.com>
	<AANLkTinENbMvvBImMJjEhZNOWSUn0ClutWZfZTxhknLY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39136 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab0GVRjR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Jul 2010 13:39:17 -0400
Received: by vws3 with SMTP id 3so400641vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Jul 2010 10:39:16 -0700 (PDT)
In-Reply-To: <AANLkTinENbMvvBImMJjEhZNOWSUn0ClutWZfZTxhknLY@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 22, 2010 at 10:34 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:=EF=9C=AB
> On Wed, Jul 21, 2010 at 11:19 PM, Hugo Slabbert
> <hugo.slabbert@slabnet.com> wrote:
>> Hi all,
>>
>> Might it be possible to expose snapshots from a ceph data store to t=
he
>> Previous Versions client on Windows machines using the shadow_copy o=
r
>> shadow_copy2 vfs modules in a Samba setup? Some people appear to be
>> running something like that on (Open)Solaris/BSD & ZFS or Linux & LV=
M.
>> I've been playing with ceph on a 3-box Debian setup in a lab
>> environment using those examples as a reference point, but I've not
>> had any luck so far.
>>
>> I saw a brief note on this at
>> http://marc.info/?l=3Dceph-devel&m=3D127710582006588&w=3D2, but noth=
ing much
>> to speak of. My thoughts were that a ceph system has the potential t=
o
>> make for a very robust backend to a NAS setup.
>>
>> Has anyone gone down that road before or have any ideas to investiga=
te on this?
>>
>
> Just a few points. As was mentioned before, ceph snapshots are being
> done per subtree and not per volume. At this point you can't create
> snapshots on the root directory, although this is now fixable.
> Another issue is that if you create a snapshot on a parent directory,
> you'd see the name of that snapshot in its subdirectories mangled (as
> it is possible to create a snapshot with the same name on different
> directories within the file hierarchy). E.g.,
>
> =C2=A0# mkdir a; mkdir a/b
> =C2=A0# mkdir a/.snap
> =C2=A0# ls -l a/b/.snap
> =C2=A0drwxr-xr-x 1 root root 0 Jul 22 17:50 1
> =C2=A0drwxr-xr-x 1 root root 0 Jul 22 17:50 _1_1099511627776
>
>
> We'd love to see cifs integration, and it'd be great getting this
> specific feature working with ceph. Please let us know if there are
> other issues that you hit.
>
> Yehuda
>

Thanks Yehuda,

I have a few more things to try out on this. I may have to shelf it
for a bit, but I'll post back if I strike any success or weird
challenges.

Cheers,

Hugo Slabbert
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
