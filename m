From: John Spray <jspray@redhat.com>
Subject: Re: nfsv41 over AF_VSOCK (nfs-ganesha)
Date: Fri, 23 Oct 2015 14:27:22 +0100
Message-ID: <CALe9h7fTUKJkxTxX4wKYwvJMOUXRneR+jB49p9M1Ji3-DVGuhw@mail.gmail.com>
References: <1602558852.33130185.1445028743632.JavaMail.zimbra@redhat.com>
 <1249838657.33136909.1445029697101.JavaMail.zimbra@redhat.com> <CALe9h7cGzjgBO=K-p7PF=MQViawh8ZKd6u_u4E5A_JSf5zhMVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35980 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbbJWN1n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Oct 2015 09:27:43 -0400
Received: by lffz202 with SMTP id z202so83639709lff.3
        for <ceph-devel@vger.kernel.org>; Fri, 23 Oct 2015 06:27:42 -0700 (PDT)
In-Reply-To: <CALe9h7cGzjgBO=K-p7PF=MQViawh8ZKd6u_u4E5A_JSf5zhMVg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Stefan Hajnoczi <shajnocz@redhat.com>

On Mon, Oct 19, 2015 at 5:13 PM, John Spray <jspray@redhat.com> wrote:
>> If you try this, send feedback.
>>

OK, got this up and running.

I've shared the kernel/qemu/nfsutils packages I built here:
https://copr.fedoraproject.org/coprs/jspray/vsock-nfs/builds/

(at time of writing the kernel one is still building, and I'm running
with ganesha out of a source tree)

Observations:
 * Running VM as qemu user gives EPERM opening vsock device, even
after changing permissions on the device node (for which I guess we'll
want udev rules at some stage) -- is there a particular capability
that we need to grant the qemu user?  Was looking into this to make it
convenient to run inside libvirt.
 * NFS writes from the guest are lagging for like a minute before
completing, my hunch is that this is something in the NFS client
recovery stuff (in ganesha) that's not coping with vsock, the
operations seem to complete at the point where the server declares
itself "NOT IN GRACE".
 * For those (like myself) unaccustomed to running ganesha, do not run
it straight out of a source tree and expect everything to work, by
default even VFS exports won't work that way (mounts work but clients
see an empty tree) because it can't find the built FSAL .so.  You can
write a config file that works, but it's easier just to make install
it.
 * (Anecdotal, seen while messing with other stuff) client mount seems
to hang if I kill ganesha and then start it again, not sure if this is
a ganesha issue or a general vsock issue.

Cheers,
John
