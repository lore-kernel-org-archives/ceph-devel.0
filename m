From: Sage Weil <sage@newdream.net>
Subject: Re: Some Question Regarding to RBD performance
Date: Tue, 27 Dec 2011 08:07:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112270805100.8031@cobra.newdream.net>
References: <CAA9wQNfSH=8ei6Kk8VQ6nWELhL5SV0eXFHv58WkPL4bFQsjtqg@mail.gmail.com>
 <Pine.LNX.4.64.1112260819590.3637@cobra.newdream.net>
 <CAA9wQNd6YhCVcgN__Mgotw15HH0kMXxaT=1MD1R+iDDNeS+GPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1758043816-1325002032=:8031"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33245 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab1L0QHN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Dec 2011 11:07:13 -0500
In-Reply-To: <CAA9wQNd6YhCVcgN__Mgotw15HH0kMXxaT=1MD1R+iDDNeS+GPA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1758043816-1325002032=:8031
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Dec 2011, Leander Yu wrote:
> Thanks for the feedback. We found the performance issue actually from
> the journal writing. even we separate journal into the other SATA HDD,
> it didn't shows any performance difference.
> At the end , we use SSD to store the journal file which give us the
> performance 52.3MB/s with oflag=3Ddirect. compare SATA 6MB/s
> I didn't have chance to trace the code for journal writing , however I
> am wondering that is there a way to improve the journal writing so we
> can get better performance in SATA HDD.

We can.  The FileJournal code is currently doing a single sync direct-io=20
write to the device, which means that you usually do a full disk rotation=
=20
between each write.  It needs to do aio so that we can keep multiple=20
writes in flight.

http://tracker.newdream.net/issues/1836

This would be a great thing for an external contributor to work on, as=20
it's not dependent on anything else!

Thanks-
sage


>=20
> Thanks.
>=20
> Regards,
> Leander Yu.
>=20
> On Tue, Dec 27, 2011 at 12:27 AM, Sage Weil <sage@newdream.net> wrote:
> > Hi Leander,
> >
> > On Mon, 26 Dec 2011, Leander Yu wrote:
> >> Hi all,
> >> I have a question regarding to RBD performance. Recently I test RBD in
> >> 2 cluster, using dd if=3D/dev/zero of=3D/dev/rbd5 bs=3D4M count=3D1024
> >> oflag=3Ddirect. I got 33.4MB/s in one cluster , however got only 6MB/s
> >> in the other cluster.
> >>
> >> I have confirmed that the network bandwidth is ok. and osd bench shows
> >> around 32 ~ 40 MB/s on all OSD. Is this performance normal? if not ,
> >> how can I troubleshoot it?
> >> I have move journal to ramdisk for testing and get performance boost
> >> to 7x MB/s. Does this means the HDD is the bottleneck ?
> >>
> >> The other cluster that got 33.4 MB/s , it's osd bench shows around
> >> 44MB/s. The major difference between those two cluster is the better
> >> performed one use SAS with RAID controller the other use SATA with no
> >> RAID control.
> >
> > If you are using the kernel client, each 4M write is fully synchronous,
> > which means (among other things) that the client is completely idle whi=
le
> > the write is being replicated by the OSDs. =A0This makes the performanc=
e
> > very sensitive to the write latency; it's not really testing write
> > throughput. =A0Your SAS RAID controller is probably doing writeback cac=
hing
> > of some kind that keeps the write latency low, while the SATA disks
> > clearly are not.
> >
> > 'dd oflag=3Ddirect' is probably not the benchmark you want; no applicat=
ion
> > should do a single synchronous IO at a time and expect good throughput.
> > The more interesting number would be steady-state buffered write
> > throughput when you have a file system on top, or something along those
> > lines.
> >
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1758043816-1325002032=:8031--
