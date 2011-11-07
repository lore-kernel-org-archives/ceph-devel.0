From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ceph-mon blocked error
Date: Mon, 7 Nov 2011 11:48:59 -0800
Message-ID: <CAF3hT9DPq_X5F2ZK0JU5jh+ugMX_DzfB2hYTLRJ5G3aELRKKag@mail.gmail.com>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
	<CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
	<CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
	<orwrbfu4js.fsf@livre.localdomain>
	<CA+jddaMPvTae_W_zKyjTewiKEzpJ_FB_zQoS=4J5pjEcOj90sQ@mail.gmail.com>
	<orobwqt186.fsf@livre.localdomain>
	<CA+jddaMvo2XWAv2BvfEqBwMXYv8JV4MmFGXYF-0F2hQx92FGfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62781 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab1KGTtA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 14:49:00 -0500
Received: by iage36 with SMTP id e36so6209962iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2011 11:48:59 -0800 (PST)
In-Reply-To: <CA+jddaMvo2XWAv2BvfEqBwMXYv8JV4MmFGXYF-0F2hQx92FGfw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: Alexandre Oliva <oliva@lsd.ic.unicamp.br>, ceph-devel@vger.kernel.org

Assuming you mean a Ceph bug for filesystem deadlock (part of that
conversation went off-list, it looks like?), there isn't one. Ceph
already uses syncfs if it's available, and on btrfs it justs uses
ioctls. But if it can't do that it needs to call sync(), on both the
monitor and the OSD. This *will* break things if you have a client
mount:
1) the OSD calls sync()
2) the VM tells the client to sync
3) the client tries to flush its data out to the OSD and waits until it=
's safe
4) the OSD waits until it can sync the data to disk before replying
that it's safe -- which it can't do because it's still waiting on its
sync to finish

The monitor can trigger this loop by calling sync() itself, although
in the common case the client doesn't need to talk to the monitor to
do its own sync() so it will appear to work (you don't want to create
a product with this assumption though, because it will deadlock
eventually -- either make syncfs() work, back the monitor with btrfs,
or separate your daemons from your clients).
The only reason that cfuse isn't susceptible to this problem is
because FUSE doesn't let you wire up sync() (maybe to avoid exactly
this problem?).

In your specific case, with a btrfs-backed OSD, I *think* this
actually won't cause things to break because the OSD can set up
independent syncs. But the underlying problem of syncing can't be
"fixed" any more than it already is without breaking our consistency
guarantees, so no bug number.

In closing: you hit some kind of issue with xfs or your IO subsystem
and shouldn't be running into any trouble with sync deadlocks right
now =97 but eventually you will and we can't make it better.
-Greg
(Hopefully this email still makes sense; I rewrote it several times
trying to figure out what was going on with ceph-fuse!)

On Mon, Nov 7, 2011 at 11:07 AM, Mandell Degerness
<mandell@pistoncloud.com> wrote:
> Can someone give me the bug number for this?
>
> On Sat, Nov 5, 2011 at 7:48 PM, Alexandre Oliva <oliva@lsd.ic.unicamp=
=2Ebr> wrote:
>> On Nov =A05, 2011, Mandell Degerness <mandell@pistoncloud.com> wrote=
:
>>
>>> Yes, we are using kernel module for ceph and there was a posix file
>>> system and an RBD mounted on the node at the time. =A0The monitor i=
s not
>>> using either for it's data though.
>>
>> It doesn't matter. =A0The monitor calls sync() quite often, and that=
 waits
>> for *all* filesystems to flush, including the ceph.ko mount, thus th=
e
>> potential deadlock. =A0It can use syncfs() if that's available in ke=
rnel
>> and glibc, but I'm not sure that's enough to work around this partic=
ular
>> deadlock scenario. =A0As I found out the hard way, there are others =
in the
>> osd as well, so if you want to mount -o rw on a mon or osd, use the =
fuse
>> client, or virtualize the mount (never tested this to make sure it
>> actually addresses the problem).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
