From: "Gurjar, Unmesh" <unmesh.gurjar@hp.com>
Subject: OSD sometimes stuck in init phase
Date: Thu, 6 Aug 2015 11:52:08 +0000
Message-ID: <BA2282FCE1654C43BF189535A964CC9F273279B3@G4W3218.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:55772 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbbHFLxQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 07:53:16 -0400
Received: from G4W6310.americas.hpqcorp.net (g4w6310.houston.hp.com [16.210.26.217])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g4t3427.houston.hp.com (Postfix) with ESMTPS id 861E5374
	for <ceph-devel@vger.kernel.org>; Thu,  6 Aug 2015 11:53:15 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On a Ceph Firefly cluster (version [1]), OSDs are configured to use sep=
arate data and journal disks (using the ceph-disk utility). It is obser=
ved, that few OSDs start-up fine (are 'up' and 'in' state); however, ot=
hers are stuck in the 'init creating/touching snapmapper object' phase.=
 Below is a OSD start-up log snippet:

2015-08-06 08:58:02.491537 7fd312df97c0=A0 1 journal _open /var/lib/cep=
h/osd/ceph-0/journal fd 21: 1073741824 bytes, block size 4096 bytes, di=
rectio =3D 1, aio =3D 1
2015-08-06 08:58:02.498447 7fd312df97c0=A0 1 journal _open /var/lib/cep=
h/osd/ceph-0/journal fd 21: 1073741824 bytes, block size 4096 bytes, di=
rectio =3D 1, aio =3D 1
2015-08-06 08:58:02.498720 7fd312df97c0=A0 2 osd.0 0 boot
2015-08-06 08:58:02.498865 7fd312df97c0 10 osd.0 0 read_superblock sb(2=
645bbf6-16d0-4c42-8835-8ba9f5c95a1d osd.0 a821146f-0742-4724-b4ca-39ea4=
ccc298d e0 [0,0] lci=3D[0,0])
2015-08-06 08:58:02.498937 7fd312df97c0 10 osd.0 0 init creating/touchi=
ng snapmapper object

The log statement is inaccurate though, since it is actually doing init=
 operation for the 'infos' object (as can be observed from source [2]).

Upon debugging further, the thread seems to be waiting to acquire the '=
ObjectStore::apply_transaction::my_lock' mutex. Below is the debug trac=
e:

(gdb) where
#0=A0 0x00007fd3122b708f in pthread_cond_wait@@GLIBC_2.3.2 () from /lib=
/x86_64-linux-gnu/libpthread.so.0
#1=A0 0x00007fd313132bf4 in ObjectStore::apply_transactions(ObjectStore=
::Sequencer*, std::list<ObjectStore::Transaction*, std::allocator<Objec=
tStore::Transaction*> >&, Context*) ()
#2=A0 0x00007fd313097d08 in ObjectStore::apply_transaction(ObjectStore:=
:Transaction&, Context*) ()
#3=A0 0x00007fd313076790 in OSD::init() ()
#4=A0 0x00007fd3130233a7 in main ()

In a few cases, upon restarting the stuck OSD (service), it successfull=
y completes the 'init' phase and reaches the 'up' and 'in' state!=20

Any help is greatly appreciated. Please let me know if any more details=
 are required for root causing.

[1] - 0.80.7 (6c0127fcb58008793d3c8b62d925bc91963672a3)
[2] - =A0https://github.com/ceph/ceph/blob/firefly/src/osd/OSD.cc#L1211

Regards,
Unmesh G.
IRC: unmeshg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
