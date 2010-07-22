From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: ceph, shadow_copy, cifs, and "Previous Versions"
Date: Thu, 22 Jul 2010 10:34:25 -0700
Message-ID: <AANLkTinENbMvvBImMJjEhZNOWSUn0ClutWZfZTxhknLY@mail.gmail.com>
References: <AANLkTilFlPF4vBYErEWtFaoR7IfXOh6ts6bY-VKvZmRD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64686 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759323Ab0GVRe1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Jul 2010 13:34:27 -0400
Received: by vws3 with SMTP id 3so395721vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Jul 2010 10:34:27 -0700 (PDT)
In-Reply-To: <AANLkTilFlPF4vBYErEWtFaoR7IfXOh6ts6bY-VKvZmRD@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hugo Slabbert <hugo.slabbert@slabnet.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jul 21, 2010 at 11:19 PM, Hugo Slabbert
<hugo.slabbert@slabnet.com> wrote:
> Hi all,
>
> Might it be possible to expose snapshots from a ceph data store to the
> Previous Versions client on Windows machines using the shadow_copy or
> shadow_copy2 vfs modules in a Samba setup? Some people appear to be
> running something like that on (Open)Solaris/BSD & ZFS or Linux & LVM.
> I've been playing with ceph on a 3-box Debian setup in a lab
> environment using those examples as a reference point, but I've not
> had any luck so far.
>
> I saw a brief note on this at
> http://marc.info/?l=ceph-devel&m=127710582006588&w=2, but nothing much
> to speak of. My thoughts were that a ceph system has the potential to
> make for a very robust backend to a NAS setup.
>
> Has anyone gone down that road before or have any ideas to investigate on this?
>

Just a few points. As was mentioned before, ceph snapshots are being
done per subtree and not per volume. At this point you can't create
snapshots on the root directory, although this is now fixable.
Another issue is that if you create a snapshot on a parent directory,
you'd see the name of that snapshot in its subdirectories mangled (as
it is possible to create a snapshot with the same name on different
directories within the file hierarchy). E.g.,

 # mkdir a; mkdir a/b
 # mkdir a/.snap
 # ls -l a/b/.snap
 drwxr-xr-x 1 root root 0 Jul 22 17:50 1
 drwxr-xr-x 1 root root 0 Jul 22 17:50 _1_1099511627776


We'd love to see cifs integration, and it'd be great getting this
specific feature working with ceph. Please let us know if there are
other issues that you hit.

Yehuda
