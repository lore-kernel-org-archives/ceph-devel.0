From: Sage Weil <sage@newdream.net>
Subject: Re: AW: ./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(osd))
Date: Wed, 3 Nov 2010 23:33:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1011032332300.32503@cobra.newdream.net>
References: <AANLkTikqk0KDAKRt=ED4-HCzKiUw9jhew+tyaZe1TGOM@mail.gmail.com>
 <vmime.4cc726f3.18e0.7333b92e48c27b02@lvps80-237-162-219.dedicated.hosteurope.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1714670503-1288852385=:32503"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42075 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104Ab0KDG3g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Nov 2010 02:29:36 -0400
In-Reply-To: <vmime.4cc726f3.18e0.7333b92e48c27b02@lvps80-237-162-219.dedicated.hosteurope.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?windows-1252?Q?Christian_Brunner?= <christian@brunner-muc.de>
Cc: =?windows-1252?Q?Christian_Brunner?= <chb@muc.de>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1714670503-1288852385=:32503
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Christian,

On Tue, 26 Oct 2010, Christian Brunner wrote:
> I can't promise this for tomorrow, but I think I can do this on Thursday.

Have you had a chance to look into this one at all?

Thanks-
sage


>=20
> Christian
>=20
> -----Urspr=FCngliche Nachricht-----
> Von: Sage Weil [mailto:sage@newdream.net]=20
> Gesendet: Dienstag, 26. Oktober 2010 21:09
> An: Christian Brunner
> Cc: ceph-devel@vger.kernel.org
> Betreff: Re: ./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(osd))
>=20
> On Tue, 26 Oct 2010, Christian Brunner wrote:
> > When accessing multiple RBD-Volumes from one VM in parallel, we are=20
> > receiving an assertion:
> >=20
> > ./osd/OSDMap.h: In function 'entity_inst_t OSDMap::get_inst(int)':
> > ./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(osd))
>=20
> Can you change that into two asserts so we can see which it is?
>=20
> And/or can you gdb this and see what the value of osd is here?
>=20
> Thanks!
> sage
>=20
>=20
> > ceph version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee7014279)
> > 1: (Objecter::op_submit(Objecter::Op*)+0x6c2) [0x38658854c2]
> > 2: /usr/lib64/librados.so.1() [0x3865855dc9]
> > 3: (RadosClient::aio_write(RadosClient::PoolCtx&, object_t, long,=20
> > ceph::buffer::list const&, unsigned long,
> > RadosClient::AioCompletion*)+0x24b) [0x386585724b]
> > 4: (rados_aio_write()+0x9a) [0x386585741a]
> > 5: /usr/bin/qemu-kvm() [0x45a305]
> > 6: /usr/bin/qemu-kvm() [0x45a430]
> > 7: /usr/bin/qemu-kvm() [0x43bb73]
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is=20
> > needed to interpret this.
> > ./osd/OSDMap.h: In function 'entity_inst_t OSDMap::get_inst(int)':
> > ./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(osd)) ceph=20
> > version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee7014279)
> > 1: (Objecter::op_submit(Objecter::Op*)+0x6c2) [0x38658854c2]
> > 2: /usr/lib64/librados.so.1() [0x3865855dc9]
> > 3: (RadosClient::aio_write(RadosClient::PoolCtx&, object_t, long,=20
> > ceph::buffer::list const&, unsigned long,
> > RadosClient::AioCompletion*)+0x24b) [0x386585724b]
> > 4: (rados_aio_write()+0x9a) [0x386585741a]
> > 5: /usr/bin/qemu-kvm() [0x45a305]
> > 6: /usr/bin/qemu-kvm() [0x45a430]
> > 7: /usr/bin/qemu-kvm() [0x43bb73]
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is=20
> > needed to interpret this.
> > terminate called after throwing an instance of 'ceph::FailedAssertion'
> > *** Caught signal (ABRT) ***
> > ceph version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee7014279)
> > 1: (sigabrt_handler(int)+0x91) [0x3865922b91]
> > 2: /lib64/libc.so.6() [0x3c0c032a30]
> > 3: (gsignal()+0x35) [0x3c0c0329b5]
> > 4: (abort()+0x175) [0x3c0c034195]
> > 5: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x3c110beaad]
> >=20
> > This is reproducible by doing the following inside a VM:
> >=20
> > # mkfs.btrfs /dev/vdb /dev/vdc /dev/vdd /dev/vde # mount /dev/vdb /mnt=
=20
> > # cd /mnt # bonnie++ -u root -d /mnt -f
> >=20
> > Any hints are welcome...
> >=20
> > Thanks,
> >=20
> > Christian
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> > in the body of a message to majordomo@vger.kernel.org More majordomo=20
> > info at  http://vger.kernel.org/majordomo-info.html
> >=20
> >=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1714670503-1288852385=:32503--
