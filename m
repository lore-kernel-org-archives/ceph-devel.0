From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Some findings on 0.48, qemu-1.0.1 eating up RDB-write-cache memory
Date: Mon, 09 Jul 2012 13:26:57 +0200
Message-ID: <4FFAC001.4020503@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-5.de-punkt.de ([93.190.64.35]:35666 "EHLO
	mail-5.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab2GIL1A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 07:27:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi *,

as I have read many postings from users using qemu, too, I would like=20
them to keep an eye on memory consumption.

I'm with qemu-1.0.1 and qemu-1.1.0-1 and linux-kernel 3.4.2/3.5.0-rc2.

If I restart a VM from cold, I do some readings, up to memory being=20
fully used ( cache/buffers), that is, VM started with:

     -m 1024

and I can see RSS of 1.1g in top.
After doing some normal IOps testing with:
     spew -v --raw -P -t -i 5 -b 4k -p random -B 4k 2G /tmp/doof.dat

so a 2G file, tested for IOps-performance with 4k blocks I get a pretty=
=20
good value for 5x write/read-after-write:

Total iterations:                                5
Total runtime:                            00:04:43
Total write transfer time (WTT):          00:02:15
Total write transfer rate (WTR):    77480.53 KiB/s
Total write IOPS:                   19370.13 IOPS
Total read transfer time (RTT):           00:01:40
Total read transfer rate (RTR):    103823.12 KiB/s
Total read IOPS:                    25955.78 IOPS

but at the cost of approx. 400MiB more memory used, showing now 1.5g.=20
Though it's not proportional, after next run I get 1.6g, then the=20
process slows down... two another runs and we break the 1.7g border...=20
But with the following settings in the global section of ceph.conf:

        rbd_cache =3D true
        rbd_cache_size=3D16777216
        rbd_cache_max_dirty=3D8388608
        rbd_cache_target_dirty=3D4194304

I cannot see, why we should waste 500+ MiB of memory ;) ( multiplied=20
with approx. 100 VM's running).

If same VM started with:
     :rbd_cache=3Dfalse
everything stays as it should.

Anybody with similar setup willing to do some testing?

Other than that: fast and stable release, it seems ;)

Thnx in @vance,

Oliver.

--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
