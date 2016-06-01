From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Message sequence overflow
Date: Wed, 1 Jun 2016 10:22:43 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606011019090.6221@cpach.fuggernut.com>
References: <CAAM7YA=3T_Gh6ZQQN3EgaxOw+JzQoP+9WuPWBWBhTSDBS4AZew@mail.gmail.com>
	<alpine.DEB.2.11.1606010847240.6221@cpach.fuggernut.com>
	<CAAM7YA=xU+Ovxf-QU6ruRKGhWS88-d0UaX1AbcR9oCLbEi9_jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1860278122-1464790966=:6221"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAM7YA=xU+Ovxf-QU6ruRKGhWS88-d0UaX1AbcR9oCLbEi9_jg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "Yan, Zheng" <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, James Webb <jamesw-pKHY6dePtwZBDgjK7y7TUQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1860278122-1464790966=:6221
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Jun 2016, Yan, Zheng wrote:
> On Wed, Jun 1, 2016 at 8:49 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > On Wed, 1 Jun 2016, Yan, Zheng wrote:
> >> On Wed, Jun 1, 2016 at 6:15 AM, James Webb <jamesw-pKHY6dePtwZBDgjK7y7TUQ@public.gmane.org> wrot=
e:
> >> > Dear ceph-users...
> >> >
> >> > My team runs an internal buildfarm using ceph as a backend storage=
 platform. We=E2=80=99ve recently upgraded to Jewel and are having reliab=
ility issues that we need some help with.
> >> >
> >> > Our infrastructure is the following:
> >> > - We use CEPH/CEPHFS (10.2.1)
> >> > - We have 3 mons and 6 storage servers with a total of 36 OSDs (~4=
160 PGs).
> >> > - We use enterprise SSDs for everything including journals
> >> > - We have one main mds and one standby mds.
> >> > - We are using ceph kernel client to mount cephfs.
> >> > - We have upgrade to Ubuntu 16.04 (4.4.0-22-generic kernel)
> >> > - We are using a kernel NFS to serve NFS clients from a ceph mount=
 (~ 32 nfs threads. 0 swappiness)
> >> > - These are physical machines with 8 cores & 32GB memory
> >> >
> >> > On a regular basis, we lose all IO via ceph FS. We=E2=80=99re stil=
l trying to isolate the issue but it surfaces as an issue between MDS and=
 ceph client.
> >> > We can=E2=80=99t tell if our our NFS server is overwhelming the MD=
S or if this is some unrelated issue. Tuning NFS server has not solved ou=
r issues.
> >> > So far our only recovery has been to fail the MDS and then restart=
 our NFS. Any help or advice will be appreciated on the CEPH side of thin=
gs.
> >> > I=E2=80=99m pretty sure we=E2=80=99re running with default tuning =
of CEPH MDS configuration parameters.
> >> >
> >> >
> >> > Here are the relevant log entries.
> >> >
> >> > From my primary MDS server, I start seeing these entries start to =
pile up:
> >> >
> >> > 2016-05-31 14:34:07.091117 7f9f2eb87700  0 log_channel(cluster) lo=
g [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 100=
00004491 pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877480 s=
econds ago\
> >> > 2016-05-31 14:34:07.091129 7f9f2eb87700  0 log_channel(cluster) lo=
g [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 100=
00005ddf pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877382 s=
econds ago\
> >> > 2016-05-31 14:34:07.091133 7f9f2eb87700  0 log_channel(cluster) lo=
g [WRN] : client.4283066 isn't responding to mclientcaps(revoke), ino 100=
00000a2a pending pAsLsXsFsxcrwb issued pAsxLsXsxFsxcrwb, sent 63.877356 s=
econds ago
> >> >
> >> > From my NFS server, I see these entries from dmesg also start pili=
ng up:
> >> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 s=
eq 0 expected 4294967296
> >> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 s=
eq 1 expected 4294967296
> >> > [Tue May 31 14:33:09 2016] libceph: skipping mds0 X.X.X.195:6800 s=
eq 2 expected 4294967296
> >> >
> >>
> >> 4294967296 is 0x100000000, this looks like sequence  overflow.
> >>
> >> In src/msg/Message.h:
> >>
> >> class Message {
> >> ...
> >>   unsigned get_seq() const { return header.seq; }
> >>   void set_seq(unsigned s) { header.seq =3D s; }
> >> ...
> >> }
> >>
> >> in src/msg/simple/Pipe.cc
> >>
> >> class Pipe {
> >> ...
> >>   __u32 get_out_seq() { return out_seq; }
> >> ...
> >> }
> >>
> >> Is this bug or intentional ?
> >
> > That's a bug.  The seq values are intended to be 32 bits.
> >
> > (We should also be using the ceph_cmp_seq (IIRC) helper for any inequ=
ality
> > checks, which does a sloppy comparison so that a 31-bit signed differ=
ence
> > is used to determine > or <.  It sounds like in this case we're just
> > failing an equality check, though.)
> >
>=20
> struct ceph_msg_header {
>         __le64 seq;       /* message seq# for this session */
>         ...
> }
>=20
> you means we should leave the upper 32-bits unused?

Oh, hmm. I'm confusing this with the cap seq (which is 32 bits). =20

I think we can safely go either way.. the question is which path is=20
easier.  If we move to 32 bits used on the kernel side, will userspace=20
also need to be patched to make reconnect work?  That unsigned get_seq()=20
is only 32-bits wide.

If we go with 64 bits, userspace still needs to be fixed to change that=20
unsigned to uint64_t.

What do you think?
sage


>=20
>=20
> > sage
> >
> >
> >> Regards
> >> Yan, Zheng
> >>
> >>
> >> > Next, we find something like this on one of the OSDs.:
> >> > 2016-05-31 14:34:44.130279 mon.0 XX.XX.XX.188:6789/0 1272184 : clu=
ster [INF] HEALTH_WARN; mds0: Client storage-nfs-01 failing to respond to=
 capability release
> >> >
> >> > Finally, I am seeing consistent HEALTH_WARN in my status regarding=
 trimming which I am not sure if it is related:
> >> >
> >> > cluster XXXXXXXX-bd8f-4091-bed3-8586fd0d6b46
> >> >      health HEALTH_WARN
> >> >             mds0: Behind on trimming (67/30)
> >> >      monmap e3: 3 mons at {storage02=3DX.X.X.190:6789/0,storage03=3D=
X.X.X.189:6789/0,storage04=3DX.X.X.188:6789/0}
> >> >             election epoch 206, quorum 0,1,2 storage04,storage03,s=
torage02
> >> >       fsmap e74879: 1/1/1 up {0=3Dcephfs-03=3Dup:active}, 1 up:sta=
ndby
> >> >      osdmap e65516: 36 osds: 36 up, 36 in
> >> >       pgmap v15435732: 4160 pgs, 3 pools, 37539 GB data, 9611 kobj=
ects
> >> >             75117 GB used, 53591 GB / 125 TB avail
> >> >                 4160 active+clean
> >> >   client io 334 MB/s rd, 319 MB/s wr, 5839 op/s rd, 4848 op/s wr
> >> >
> >> >
> >> > Regards,
> >> > James Webb
> >> > DevOps Engineer, Engineering Tools
> >> > Unity Technologies
> >> > _______________________________________________
> >> > ceph-users mailing list
> >> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
> >> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--8323329-1860278122-1464790966=:6221
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-1860278122-1464790966=:6221--
