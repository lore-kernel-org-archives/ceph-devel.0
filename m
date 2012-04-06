From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: defaults paths #2
Date: Fri, 6 Apr 2012 10:57:46 -0700
Message-ID: <CAORUGqD_Oe2F-yTS87h5P8oB=OrUTcuZo7BsWo3bqy66VJ1YfA@mail.gmail.com>
References: <CAORUGqBs3=_sVnYB+vdamAW3S7ShqY5Gz1hGiY4ozUd7enTn3w@mail.gmail.com>
 <9B9005B1-9397-4171-8726-A52903B8B8F1@openminds.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:39578 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756703Ab2DFR6I convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Apr 2012 13:58:08 -0400
Received: by vbbff1 with SMTP id ff1so1324015vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Apr 2012 10:58:07 -0700 (PDT)
In-Reply-To: <9B9005B1-9397-4171-8726-A52903B8B8F1@openminds.be>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bernard Grymonpon <bernard@openminds.be>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Apr 6, 2012 at 00:37, Bernard Grymonpon <bernard@openminds.be> =
wrote:
> Storage lives by UUID's, I would suggest to move the programming in t=
he direction to get rid of all the own naming and labeling, and just st=
ick to uuids. I could not care less if the data on that disk is interna=
lly named "23" or "678", it is just a part of my cluster, and it is up =
to ceph to figure out which part of the puzzle it holds.

Ceph storage does not live by UUIDs. Each object is stored in specific
osds, which are identified by a sequential, dense, unique, integer.
These integers exist, are allocated and freed, and are the very
*definition* of an osd.

UUIDs are useful for ensuring 1. that osd.42 from cluster A is not
confused with a osd.42 from cluster B (cluster-wide fsid)  2. for
ensuring we use the right journal for an osd (per-osd uuid, stored in
both osd data and journal).

UUIDs are not human friendly, and are not a native identifier in Ceph.

Here's what running multiple osds looks like with the new upstart stuff=
:

ubuntu@inst01:~$ sudo initctl list|grep ceph
ceph-osd-all stop/waiting
ceph-mon-all stop/waiting
ceph-mon (ceph/single) start/running, process 2527
ceph-osd (ceph/0) start/running, process 2576
ceph-osd (ceph/1) start/running, process 2580
ceph-osd (ceph/2) start/running, process 2592
ceph-osd (ceph/3) start/running, process 3053

Doing the same with UUIDs would make that output have lines like

ceph-osd (ceph/1bbb1f49-c574-45b0-b4cc-43dbe7bacc0d) start/running, pro=
cess 2576

and I really, really don't want for no gain.

UUIDs make a lot of sense when you don't have central coordination of
identifiers. But Ceph *has* that. (It *needs* that, because we don't
do lookup tables.)

>> I think many people with that hardware setup will choose to just GPT
>> partition the SSD, and have a lot less code in the way of the IO.
> A single file, sitting on some partition somewhere, will be very hard=
 to auto-find, unless you'll keep some info in OSD that tracks the UUID=
 of the disk + the path inside the filesystem where it previously was.

=46or example: "All the journals that are just files are inside
/var/lib/ceph/journal, or are symlinked there." And that can even be a
configurable search path with multiple entries. Not that hard.

OSD data will not contain a path name to the journal, that is too trans=
ient.

>> I think we agree on intents, but I disagree strongly with the words
>> you chose. The sysadmin should not need to symlink anything. We will
>> bring up a whole cluster, and enable you to manage that easily.
>> Anything less is a failure. You may choose to opt out of some of tha=
t
>> higher smarts, if you want to do it differently, but we will need to
>> provide that. Managing a big cluster without automation is painful,
>> and people shouldn't need to reinvent the wheel.
>
> Actually, it will bring up one node of a cluster, regardless of the s=
tate of the other parts of the cluster. Question is how automated every=
thing should be detected and started.
>
> Hotplugging and auto-mounting is there already - it is up to the sysa=
dmin to use it if needed.

The automation I'm working is intended to bring up and manage a *whole
cluster*. Not a single machine.

Hotplugging is *not* there already. There is no turn-key
installs-in-under-60-minutes solution that gives you that.

> Same goes the other way - if someone like to start everything automag=
ically, there is nothing that stops others from using the normal hotplu=
g tools available, just write some rules to act on the presence of cert=
ain disklabels.

I am writing that logic, right now. For everyone to use. So that
everyone doesn't need to reinvent the wheel.

> Ceph can provide scripts to do this, but I would keep this logic out =
of the default behavior of ceph-osd. In my opinion, this is a storage d=
aemon - not a storage-node-management-daemon.
>
> If you want to keep this outside ceph-osd, and provide this as some h=
elper to the /etc/init.d scripts, then I'm all the way with you, as lon=
g as the magic .

It will all be optional, though you will be encouraged to use the autom=
ation.

> In my opinion the config file for ceph should contain only UUIDs for =
the devices which hold the data, like:
>
> ...
> [osd]
> =C2=A0uuid=3Dabc-123-123-123
> =C2=A0uuid=3Ddef-456-456-456
> =C2=A0uuid=3Dghi-789-789-789
> ...

We are talking about hundreds of machines and thousands of disks.
Nobody I've talked to wants to edit a config file to add/replace a
disk on a system that big, that's just not the way to go.

> If someone removes or pops in a disk, what should happen then is up t=
o me. If it starts everything automatically, or if a certain node isn't=
 set to auto-boot, is up to me (and should result in changes in the con=
fig in my chef-server, which controls all my nodes). If I want all thes=
e UUIDs to auto-start a OSD when inserted, then I would let chef write =
a rules file in udev to do exactly that.

It seems you have different enough opinions about how to manage your
systems that you might choose to not to use the automation I've been
working on. That's fine, just do it. The core ceph daemons will not
assume things either way.

I would recommend you come back in a few months and see what come out
of the work, you might find it more acceptable than you currently
think.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
