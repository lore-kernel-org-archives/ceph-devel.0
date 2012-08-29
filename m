From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: RBD performance - tuning hints
Date: Wed, 29 Aug 2012 10:37:36 -0700
Message-ID: <503E5360.50705@inktank.com>
References: <5867fa5f-5c24-4279-954a-5a1df06f3394@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55346 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab2H2Rhk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 13:37:40 -0400
Received: by dady13 with SMTP id y13so572080dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 10:37:39 -0700 (PDT)
In-Reply-To: <5867fa5f-5c24-4279-954a-5a1df06f3394@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Dieter Kasper <d.kasper@kabelmail.de>, ceph-devel@vger.kernel.org

On 08/29/2012 01:50 AM, Alexandre DERUMIER wrote:
> Nice results !
> (can you make same benchmark from a qemu-kvm guest with virtio-driver=
 ?
> I have made some bench some month ago with stephan priebe, and we nev=
er be able to have more than 20000iops, with a full ssd 3nodes cluster)
>
>>> How can I set the variables when the Journal data have go to the OS=
D ? (after X seconds and/or when Y %-full)
> I think you can try to tune these values
>
> filestore max sync interval =3D 30
> filestore min sync interval =3D 29
> filestore flusher =3D false
> filestore queue max ops =3D 10000

Increasing filestore_op_threads might help as well.

> ----- Mail original -----
>
> De: "Dieter Kasper" <d.kasper@kabelmail.de>
> =C3=80: ceph-devel@vger.kernel.org
> Cc: "Dieter Kasper (KD)" <d.kasper@kabelmail.de>
> Envoy=C3=A9: Mardi 28 Ao=C3=BBt 2012 19:48:42
> Objet: RBD performance - tuning hints
>
> Hi,
>
> on my 4-node system (SSD + 10GbE, see bench-config.txt for details)
> I can observe a pretty nice rados bench performance
> (see bench-rados.txt for details):
>
> Bandwidth (MB/sec): 961.710
> Max bandwidth (MB/sec): 1040
> Min bandwidth (MB/sec): 772
>
>
> Also the bandwidth performance generated with
> fio --filename=3D/dev/rbd1 --direct=3D1 --rw=3D$io --bs=3D$bs --size=3D=
2G --iodepth=3D$threads --ioengine=3Dlibaio --runtime=3D60 --group_repo=
rting --name=3Dfile1 --output=3Dfio_${io}_${bs}_${threads}
>
> .... is acceptable, e.g.
> fio_write_4m_16 795 MB/s
> fio_randwrite_8m_128 717 MB/s
> fio_randwrite_8m_16 714 MB/s
> fio_randwrite_2m_32 692 MB/s
>
>
> But, the write IOPS seems to be limited around 19k ...
> RBD 4M 64k (=3D optimal_io_size)
> fio_randread_512_128 53286 55925
> fio_randread_4k_128 51110 44382
> fio_randread_8k_128 30854 29938
> fio_randwrite_512_128 18888 2386
> fio_randwrite_512_64 18844 2582
> fio_randwrite_8k_64 17350 2445
> (...)
> fio_read_4k_128 10073 53151
> fio_read_4k_64 9500 39757
> fio_read_4k_32 9220 23650
> (...)
> fio_read_4k_16 9122 14322
> fio_write_4k_128 2190 14306
> fio_read_8k_32 706 13894
> fio_write_4k_64 2197 12297
> fio_write_8k_64 3563 11705
> fio_write_8k_128 3444 11219
>
>
> Any hints for tuning the IOPS (read and/or write) would be appreciate=
d.
>
> How can I set the variables when the Journal data have go to the OSD =
? (after X seconds and/or when Y %-full)
>
>
> Kind Regards,
> -Dieter
>
>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
