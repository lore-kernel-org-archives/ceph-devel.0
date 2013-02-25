From: Sage Weil <sage@inktank.com>
Subject: Re: osdc/ObjectCacher.cc: 834: FAILED assert(ob->last_commit_tid <
 tid)
Date: Mon, 25 Feb 2013 13:46:02 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302251345080.5703@cobra.newdream.net>
References: <511CFDDF.6080406@tuxadero.com> <alpine.DEB.2.00.1302140916260.19760@cobra.newdream.net> <511D24CE.4030507@tuxadero.com> <CACkq2mpOSGnpWtjpx9JDgFnEPL3FuqLC-3Ux71y2TS8kPzLC7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42013 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab3BYVqD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 16:46:03 -0500
In-Reply-To: <CACkq2mpOSGnpWtjpx9JDgFnEPL3FuqLC-3Ux71y2TS8kPzLC7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel@vger.kernel.org

I've cherry-picked the fixes to bobtail.  There are more coming, though, 
in other code but triggered by the same torture tests.  If you like, you 
can run the current bobtail branch, or you can wait and get more stuff or 
(eventually) another point release.

sage


On Mon, 25 Feb 2013, Travis Rhoden wrote:

> Any word on what the status of this is?  I just ran into it myself,
> all on 0.56.3, latest KVM/qemu for Ubuntu 12.04.
> 
> Looking at the bug in tracker, it's resolved.  Is this going to be
> backported to bobtail?
> 
> I'm booting VMs directly off of RBD, and this bug takes a few of them
> down at startup.  I don't have a reproducilble method for it -- it's
> more that one out of every 10 or 15 VMs starts up and then crashes,
> and this error shows up in the qemu logs.
> 
> Thanks.
> 
> On Thu, Feb 14, 2013 at 12:54 PM, Martin Mailand <martin@tuxadero.com> wrote:
> > Hi Sage,
> >
> > everything is on 0.56.2 and the cluster is healthy.
> > I can reproduce it with an apt-get upgrade within the vm, the vm os is
> > 12.04. Most of the time the assertion happened when the firmware .deb is
> > updated. See the log in my first email.
> > But I use a custom build qemu version (1.4-rc1), which was build against
> > 0.56.2.
> >
> >
> > root@store1:~# ceph -s
> >    health HEALTH_OK
> >    monmap e1: 1 mons at {a=192.168.195.33:6789/0}, election epoch 1,
> > quorum 0 a
> >    osdmap e160: 20 osds: 20 up, 20 in
> >     pgmap v28314: 3264 pgs: 3264 active+clean; 437 GB data, 1027 GB
> > used, 144 TB / 145 TB avail
> >    mdsmap e1: 0/0/1 up
> >
> > root@store1:~# ceph --version
> > ceph version 0.56.2 (586538e22afba85c59beda49789ec42024e7a061)
> >
> >
> > root@compute4:~# dpkg -l|grep 'rbd\|rados\|qemu'
> > ii  librados2                        0.56.2-1precise
> > RADOS distributed object store client library
> > ii  librbd1                          0.56.2-1precise
> > RADOS block device client library
> > ii  qemu-common                      1.4.0-rc1-vdsp1.0
> > qemu common functionality (bios, documentation, etc)
> > ii  qemu-kvm                         1.4.0-rc1-vdsp1.0
> > Full virtualization on i386 and amd64 hardware
> > ii  qemu-utils                       1.4.0-rc1-vdsp1.0
> > qemu utilities
> >
> >
> > -martin
> >
> > On 14.02.2013 18:18, Sage Weil wrote:
> >> Hi Martin-
> >>
> >> On Thu, 14 Feb 2013, Martin Mailand wrote:
> >>> Hi List,
> >>>
> >>> I get reproducible this assertion, how can I help to debug it?
> >>
> >> Can you describe the workload?  Are the OSDs also running 0.56.2(+)?  Any
> >> other activity on the server side (data migration, OSD failure, etc.) that
> >> may have contributed?
> >>
> >> We just reopened http://tracker.ceph.com/issues/2947 to track this.  I'm
> >> working on reproducing it now as well.
> >>
> >> Thanks!
> >> sage
> >>
> >>
> >>
> >>>
> >>>
> >>> -martin
> >>>
> >>> (Lese Datenbank ... 52246 Dateien und Verzeichnisse sind derzeit
> >>> installiert.)
> >>> Vorbereitung zum Ersetzen von linux-firmware 1.79 (durch
> >>> .../linux-firmware_1.79.1_all.deb) ...
> >>> Ersatz f?r linux-firmware wird entpackt ...
> >>> osdc/ObjectCacher.cc: In function 'void
> >>> ObjectCacher::bh_write_commit(int64_t, sobject_t, loff_t, uint64_t,
> >>> tid_t, int)' thread 7f72b7fff700 time 2013-02-14 16:04:48.867285
> >>> osdc/ObjectCacher.cc: 834: FAILED assert(ob->last_commit_tid < tid)
> >>>  ceph version 0.56.2 (586538e22afba85c59beda49789ec42024e7a061)
> >>>  1: (ObjectCacher::bh_write_commit(long, sobject_t, long, unsigned long,
> >>> unsigned long, int)+0xd68) [0x7f72d4050848]
> >>>  2: (ObjectCacher::C_WriteCommit::finish(int)+0x6b) [0x7f72d405742b]
> >>>  3: (Context::complete(int)+0xa) [0x7f72d400f9ba]
> >>>  4: (librbd::C_Request::finish(int)+0x85) [0x7f72d403f145]
> >>>  5: (Context::complete(int)+0xa) [0x7f72d400f9ba]
> >>>  6: (librbd::rados_req_cb(void*, void*)+0x47) [0x7f72d40241b7]
> >>>  7: (librados::C_AioSafe::finish(int)+0x1d) [0x7f72d33db16d]
> >>>  8: (Finisher::finisher_thread_entry()+0x1c0) [0x7f72d3444e50]
> >>>  9: (()+0x7e9a) [0x7f72d03c7e9a]
> >>>  10: (clone()+0x6d) [0x7f72d00f4cbd]
> >>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> >>> needed to interpret this.
> >>> terminate called after throwing an instance of 'ceph::FailedAssertion'
> >>> Aborted
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
