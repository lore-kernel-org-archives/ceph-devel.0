From: Sage Weil <sage@newdream.net>
Subject: Re: Message sequence overflow
Date: Wed, 1 Jun 2016 08:49:16 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606010847240.6221@cpach.fuggernut.com>
References: <CAAM7YA=3T_Gh6ZQQN3EgaxOw+JzQoP+9WuPWBWBhTSDBS4AZew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1711946710-1464785359=:6221"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37744 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbcFAMsx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2016 08:48:53 -0400
In-Reply-To: <CAAM7YA=3T_Gh6ZQQN3EgaxOw+JzQoP+9WuPWBWBhTSDBS4AZew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, James Webb <jamesw@unity3d.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1711946710-1464785359=:6221
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 1 Jun 2016, Yan, Zheng wrote:
> On Wed, Jun 1, 2016 at 6:15 AM, James Webb <jamesw@unity3d.com> wrote:
> > Dear ceph-users...
> >
> > My team runs an internal buildfarm using ceph as a backend storage platform. We’ve recently upgraded to Jewel and are having reliability issues that we need some help with.
> >
> > Our infrastructure is the following:
> > - We use CEPH/CEPHFS (10.2.1)
> > - We have 3 mons and 6 storage servers with a total of 36 OSDs (~4160 PGs).
> > - We use enterprise SSDs for everything including journals
> > - We have one main mds and one standby mds.
> > - We are using ceph kernel client to mount cephfs.
> > - We have upgrade to Ubuntu 16.04 (4.4.0-22-generic kernel)
> > - We are using a kernel NFS to serve NFS clients from a ceph mount (~ 32 nfs threads. 0 swappiness)
> > - These are physical machines with 8 cores & 32GB memory
> >
> > On a regular basis, we lose all IO via ceph FS. We’re still trying to isolate the issue but it surfaces as an issue between MDS and ceph client.
> > We can’t tell if our our NFS server is overwhelming the MDS or if this is some unrelated issue. Tuning NFS server has not solved our issues.
> > So far our only recovery has been to fail the MDS and then restart our NFS. Any help or advice will be appreciated on the CEPH side of things.
> > I’m pretty sure we’re running with default tuning of CEPH MDS configuration parameters.
> >
> >
> > Here are the relevant log entries.
> >
> > From my primary MDS server, I start seeing these entries start to pile up:
> >
> > 2016-05-31 14:34:07.091117 7f9f2eb87700  0 log_channel(cluster) log [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 10000004491 pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877480 seconds ago\
> > 2016-05-31 14:34:07.091129 7f9f2eb87700  0 log_channel(cluster) log [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 10000005ddf pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877382 seconds ago\
> > 2016-05-31 14:34:07.091133 7f9f2eb87700  0 log_channel(cluster) log [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 10000000a2a pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877356 seconds ago
> >
> > From my NFS server, I see these entries from dmesg also start piling up:
> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 seq 0 expected 4294967296
> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 seq 1 expected 4294967296
> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 seq 2 expected 4294967296
> >
> 
> 4294967296 is 0x100000000, this looks like sequence  overflow.
> 
> In src/msg/Message.h:
> 
> class Message {
> ...
>   unsigned get_seq() const { return header.seq; }
>   void set_seq(unsigned s) { header.seq = s; }
> ...
> }
> 
> in src/msg/simple/Pipe.cc
> 
> class Pipe {
> ...
>   __u32 get_out_seq() { return out_seq; }
> ...
> }
> 
> Is this bug or intentional ?

That's a bug.  The seq values are intended to be 32 bits. 

(We should also be using the ceph_cmp_seq (IIRC) helper for any inequality 
checks, which does a sloppy comparison so that a 31-bit signed difference 
is used to determine > or <.  It sounds like in this case we're just 
failing an equality check, though.)

sage


> Regards
> Yan, Zheng
> 
> 
> > Next, we find something like this on one of the OSDs.:
> > 2016-05-31 14:34:44.130279 mon.0 XX.XX.XX.188:6789/0 1272184 : cluster [INF] HEALTH_WARN; mds0: Client storage-nfs-01 failing to respond to capability release
> >
> > Finally, I am seeing consistent HEALTH_WARN in my status regarding trimming which I am not sure if it is related:
> >
> > cluster XXXXXXXX-bd8f-4091-bed3-8586fd0d6b46
> >      health HEALTH_WARN
> >             mds0: Behind on trimming (67/30)
> >      monmap e3: 3 mons at {storage02=X.X.X.190:6789/0,storage03=X.X.X.189:6789/0,storage04=X.X.X.188:6789/0}
> >             election epoch 206, quorum 0,1,2 storage04,storage03,storage02
> >       fsmap e74879: 1/1/1 up {0=cephfs-03=up:active}, 1 up:standby
> >      osdmap e65516: 36 osds: 36 up, 36 in
> >       pgmap v15435732: 4160 pgs, 3 pools, 37539 GB data, 9611 kobjects
> >             75117 GB used, 53591 GB / 125 TB avail
> >                 4160 active+clean
> >   client io 334 MB/s rd, 319 MB/s wr, 5839 op/s rd, 4848 op/s wr
> >
> >
> > Regards,
> > James Webb
> > DevOps Engineer, Engineering Tools
> > Unity Technologies
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-1711946710-1464785359=:6221--
