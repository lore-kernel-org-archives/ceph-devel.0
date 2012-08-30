From: Dieter Kasper <d.kasper@kabelmail.de>
Subject: Re: RBD performance - tuning hints / parameter doc
Date: Thu, 30 Aug 2012 17:08:38 +0200
Message-ID: <20120830150838.GB32184@oder.kd-bie.de>
References: <5867fa5f-5c24-4279-954a-5a1df06f3394@mailpro>
 <503E5360.50705@inktank.com>
 <20120829192908.GC17695@oder.kd-bie.de>
 <CA+4uBUZNBaQLfvTtVHC9b_Rz3rkQXPb0ggANHHX3iSpc8VJfTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:34806 "EHLO
	smtpa1.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab2H3PJn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 11:09:43 -0400
Content-Disposition: inline
In-Reply-To: <CA+4uBUZNBaQLfvTtVHC9b_Rz3rkQXPb0ggANHHX3iSpc8VJfTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Samuel,

thank you very much for this explicitely description!

As far as I understand the journal acts as a ringbuffer in front of the=
 OSD.
Using time as a parameter to trigger sync might not be the best for=20
a dynamic Storage subsystem. On a high workload e.g. 10/20 for min/max=20
might be optimal for for 4 nodes with 10 OSDs each,=20
but not after adding 4 additional nodes.

Are there parameters to trigger the syncs to OSD
in relation to the fill grade of the journal ?
e.g.
filestore [min|max] sync percent:

Do not sync before min-% full; sync after max-% full

What would happen if I set "filestore [min|max] sync interval" to 99999=
9 ?
Will the journal sync start at 100% full or at X% ?
What is 'X' by defaut ?
How can I set 'X' ?

Best Regards,
-Dieter


On Thu, Aug 30, 2012 at 12:34:43AM +0200, Samuel Just wrote:
> filestore [min|max] sync interval:
>=20
> Periodically, the filestore needs to quiesce writes and do a syncfs i=
n
> order to create
> a consistent commit point up to which it can free journal entries.  S=
yncing more
> frequently tends to reduce the time required to do the sync, and
> reduces the amount
> of data that needs to remain in the journal.  Less frequent syncs
> would allow the
> backing filesystem to better coalesce small writes and metadata
> updates hopefully
> resulting in more efficient syncs.  'filestore max sync interval'
> defines the maximum
> time period between syncs, 'filestore min sync interval' defines the
> minimum time
> period between syncs.
>=20
> filestore flusher:
>=20
> The filestore flusher forces data from large writes to be written out
> using sync_file_range
> before the sync in order to (hopefully) reduce the cost of the
> eventual sync.  In practice,
> disabling 'filestore flusher' seems to improve performance in some ca=
ses.
>=20
> filestore queue max ops:
>=20
> 'filestore queue max ops' defines the number of in progress ops the
> filestore will accept
> before blocking on queueing new ones.  This mostly shouldn't have muc=
h
> of an effect
> on performance and should probably be ignored.
>=20
> filestore op threads:
>=20
> 'filestore op threads' defines the number of threads used to submit
> filesystem operations
> in parallel.
>=20
> journal dio:
>=20
> 'journal dio' enables using O_DIRECT for writing to the journal.  Thi=
s
> should usually
> be enabled.  If possible, 'journal aio' should also be enabled to
> allow use of libaio
> to do asynchronous writes.
>=20
> osd op threads:
>=20
> 'osd op threads' defines the size of the thread pool used to service
> OSD operations
> such as client requests.  Increasing this may increase the rate of
> request processing.
>=20
> osd disk threads:
>=20
> 'osd disk threads' defines the number of threads used to perform back=
ground disk
> intensive osd operations such as scrubbing and snap trimming.
>=20
> On Wed, Aug 29, 2012 at 12:29 PM, Dieter Kasper <d.kasper@kabelmail.d=
e> wrote:
> > Hi Josh,
> >
> > thanks for the hint.
> > Can you please spend a view words about the meaing of these paramet=
ers ?
> > - filestore min/max sync interval =3D     int/float ?     seconds ?=
 of what ?
> > - filestore flusher =3D false
> > - filestore queue max ops =3D 10000
> >         what is 'one op' ?      queue in front of what ?
> > - filestore op threads =3D
> >         what are useful values here ?
> >
> > - journal dio =3D true/false
> > - osd op threads =3D
> > - osd disk threads =3D
> >
> >
> > Kind Regards,
> > -Dieter
> >
> >
> > On Wed, Aug 29, 2012 at 07:37:36PM +0200, Josh Durgin wrote:
> >> On 08/29/2012 01:50 AM, Alexandre DERUMIER wrote:
> >> > Nice results !
> >> > (can you make same benchmark from a qemu-kvm guest with virtio-d=
river ?
> >> > I have made some bench some month ago with stephan priebe, and w=
e never be able to have more than 20000iops, with a full ssd 3nodes clu=
ster)
> >> >
> >> >>> How can I set the variables when the Journal data have go to t=
he OSD ? (after X seconds and/or when Y %-full)
> >> > I think you can try to tune these values
> >> >
> >> > filestore max sync interval =3D 30
> >> > filestore min sync interval =3D 29
> >> > filestore flusher =3D false
> >> > filestore queue max ops =3D 10000
> >>
> >> Increasing filestore_op_threads might help as well.
> >>
> >> > ----- Mail original -----
> >> >
> >> > De: "Dieter Kasper" <d.kasper@kabelmail.de>
> >> > =C0: ceph-devel@vger.kernel.org
> >> > Cc: "Dieter Kasper (KD)" <d.kasper@kabelmail.de>
> >> > Envoy=E9: Mardi 28 Ao=FBt 2012 19:48:42
> >> > Objet: RBD performance - tuning hints
> >> >
> >> > Hi,
> >> >
> >> > on my 4-node system (SSD + 10GbE, see bench-config.txt for detai=
ls)
> >> > I can observe a pretty nice rados bench performance
> >> > (see bench-rados.txt for details):
> >> >
> >> > Bandwidth (MB/sec): 961.710
> >> > Max bandwidth (MB/sec): 1040
> >> > Min bandwidth (MB/sec): 772
> >> >
> >> >
> >> > Also the bandwidth performance generated with
> >> > fio --filename=3D/dev/rbd1 --direct=3D1 --rw=3D$io --bs=3D$bs --=
size=3D2G --iodepth=3D$threads --ioengine=3Dlibaio --runtime=3D60 --gro=
up_reporting --name=3Dfile1 --output=3Dfio_${io}_${bs}_${threads}
> >> >
> >> > .... is acceptable, e.g.
> >> > fio_write_4m_16 795 MB/s
> >> > fio_randwrite_8m_128 717 MB/s
> >> > fio_randwrite_8m_16 714 MB/s
> >> > fio_randwrite_2m_32 692 MB/s
> >> >
> >> >
> >> > But, the write IOPS seems to be limited around 19k ...
> >> > RBD 4M 64k (=3D optimal_io_size)
> >> > fio_randread_512_128 53286 55925
> >> > fio_randread_4k_128 51110 44382
> >> > fio_randread_8k_128 30854 29938
> >> > fio_randwrite_512_128 18888 2386
> >> > fio_randwrite_512_64 18844 2582
> >> > fio_randwrite_8k_64 17350 2445
> >> > (...)
> >> > fio_read_4k_128 10073 53151
> >> > fio_read_4k_64 9500 39757
> >> > fio_read_4k_32 9220 23650
> >> > (...)
> >> > fio_read_4k_16 9122 14322
> >> > fio_write_4k_128 2190 14306
> >> > fio_read_8k_32 706 13894
> >> > fio_write_4k_64 2197 12297
> >> > fio_write_8k_64 3563 11705
> >> > fio_write_8k_128 3444 11219
> >> >
> >> >
> >> > Any hints for tuning the IOPS (read and/or write) would be appre=
ciated.
> >> >
> >> > How can I set the variables when the Journal data have go to the=
 OSD ? (after X seconds and/or when Y %-full)
> >> >
> >> >
> >> > Kind Regards,
> >> > -Dieter
> >> >
> >> >
> >> >
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
