From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: ceph, shadow_copy, cifs, and "Previous Versions"
Date: Thu, 22 Jul 2010 10:37:42 -0700
Message-ID: <AANLkTingctUjysTZZ6b0ItbqlELT6PxAaxqttq5iRkxG@mail.gmail.com>
References: <AANLkTilFlPF4vBYErEWtFaoR7IfXOh6ts6bY-VKvZmRD@mail.gmail.com>
	<AANLkTinENbMvvBImMJjEhZNOWSUn0ClutWZfZTxhknLY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40324 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768Ab0GVRhn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Jul 2010 13:37:43 -0400
Received: by gxk23 with SMTP id 23so4749805gxk.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Jul 2010 10:37:42 -0700 (PDT)
In-Reply-To: <AANLkTinENbMvvBImMJjEhZNOWSUn0ClutWZfZTxhknLY@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hugo Slabbert <hugo.slabbert@slabnet.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 22, 2010 at 10:34 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
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
> =A0# mkdir a; mkdir a/b
> =A0# mkdir a/.snap
> =A0# ls -l a/b/.snap
> =A0drwxr-xr-x 1 root root 0 Jul 22 17:50 1
> =A0drwxr-xr-x 1 root root 0 Jul 22 17:50 _1_1099511627776

This example is erroneous, should be:
 # mkdir a; mkdir a/b
 # mkdir a/.snap/1
 # mkdir a/b/.snap/1
 # ls -l a/b/.snap
 drwxr-xr-x 1 root root 0 Jul 22 17:50 1
 drwxr-xr-x 1 root root 0 Jul 22 17:50 _1_1099511627776
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
