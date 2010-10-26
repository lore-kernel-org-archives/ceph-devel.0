From: =?windows-1252?Q?Christian_Brunner?= <christian@brunner-muc.de>
Subject: AW: ./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(osd))
Date: Tue, 26 Oct 2010 21:05:27 +0200
Message-ID: <vmime.4cc72677.12b6.316d0f4e6f07c9e2@lvps80-237-162-219.dedicated.hosteurope.de>
References: <AANLkTikqk0KDAKRt=ED4-HCzKiUw9jhew+tyaZe1TGOM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.brunner-muc.de ([80.237.162.219]:58726 "EHLO
	mail.brunner-muc.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab0JZTFe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Oct 2010 15:05:34 -0400
In-Reply-To: <AANLkTim6dKYgt+Yw_-hFLa8XFp6KaMnrCFYAd9VhYHqa@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?windows-1252?Q?Gregory_Farnum?= <gregf@hq.newdream.net>, =?windows-1252?Q?Christian_Brunner?= <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

Yes, one OSD crashed approximately an hour before this was happening.

Christian

-----Urspr=FCngliche Nachricht-----
Von: gregf@hq.newdream.net [mailto:ceph-devel-owner@vger.kernel.org] Im=
 Auftrag von Gregory Farnum
Gesendet: Dienstag, 26. Oktober 2010 20:00
An: Christian Brunner
Cc: ceph-devel@vger.kernel.org
Betreff: Re: ./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(osd=
))

Do you have any down OSDs? Looking through the code I am noticing an is=
sue with down OSDs where op_submit can get an error code that it isn't =
watching for, but there may be checks in other places to prevent that a=
ctually happening.
-Greg

On Tue, Oct 26, 2010 at 5:13 AM, Christian Brunner <chb@muc.de> wrote:
> When accessing multiple RBD-Volumes from one VM in parallel, we are=20
> receiving an assertion:
>
> ./osd/OSDMap.h: In function 'entity_inst_t OSDMap::get_inst(int)':
> ./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(osd)) ceph=20
> version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee7014279)
> 1: (Objecter::op_submit(Objecter::Op*)+0x6c2) [0x38658854c2]
> 2: /usr/lib64/librados.so.1() [0x3865855dc9]
> 3: (RadosClient::aio_write(RadosClient::PoolCtx&, object_t, long,=20
> ceph::buffer::list const&, unsigned long,
> RadosClient::AioCompletion*)+0x24b) [0x386585724b]
> 4: (rados_aio_write()+0x9a) [0x386585741a]
> 5: /usr/bin/qemu-kvm() [0x45a305]
> 6: /usr/bin/qemu-kvm() [0x45a430]
> 7: /usr/bin/qemu-kvm() [0x43bb73]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is=20
> needed to interpret this.
> ./osd/OSDMap.h: In function 'entity_inst_t OSDMap::get_inst(int)':
> ./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(osd)) ceph=20
> version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee7014279)
> 1: (Objecter::op_submit(Objecter::Op*)+0x6c2) [0x38658854c2]
> 2: /usr/lib64/librados.so.1() [0x3865855dc9]
> 3: (RadosClient::aio_write(RadosClient::PoolCtx&, object_t, long,=20
> ceph::buffer::list const&, unsigned long,
> RadosClient::AioCompletion*)+0x24b) [0x386585724b]
> 4: (rados_aio_write()+0x9a) [0x386585741a]
> 5: /usr/bin/qemu-kvm() [0x45a305]
> 6: /usr/bin/qemu-kvm() [0x45a430]
> 7: /usr/bin/qemu-kvm() [0x43bb73]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is=20
> needed to interpret this.
> terminate called after throwing an instance of 'ceph::FailedAssertion=
'
> *** Caught signal (ABRT) ***
> ceph version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee7014279)
> 1: (sigabrt_handler(int)+0x91) [0x3865922b91]
> 2: /lib64/libc.so.6() [0x3c0c032a30]
> 3: (gsignal()+0x35) [0x3c0c0329b5]
> 4: (abort()+0x175) [0x3c0c034195]
> 5: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x3c110beaad]
>
> This is reproducible by doing the following inside a VM:
>
> # mkfs.btrfs /dev/vdb /dev/vdc /dev/vdd /dev/vde # mount /dev/vdb /mn=
t=20
> # cd /mnt # bonnie++ -u root -d /mnt -f
>
> Any hints are welcome...
>
> Thanks,
>
> Christian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
