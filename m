From: =?windows-1252?Q?Christian_Brunner?= <christian@brunner-muc.de>
Subject: AW: osd/ReplicatedPG.cc:2403: FAILED
 assert(!missing.is_missing(soid))
Date: Tue, 26 Oct 2010 21:10:33 +0200
Message-ID: <vmime.4cc727a9.24c0.776fd10e4e05ee22@lvps80-237-162-219.dedicated.hosteurope.de>
References: <AANLkTim_-Je553u5FVv6bdhCirz1t90KQEUG=icmMr5-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.brunner-muc.de ([80.237.162.219]:58865 "EHLO
	mail.brunner-muc.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757700Ab0JZTKk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Oct 2010 15:10:40 -0400
In-Reply-To: <14C7F4F06DB5814AB0DE29716C4F6D670EBCCA7C@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?windows-1252?Q?Smets=2C_Jan_=28Jan=29?= <jan.smets@alcatel-lucent.com>
Cc: ceph-devel@vger.kernel.org

Does someone know which commit this is? I don't want to switch to the u=
nstable branch at the moment.

Christian


-----Urspr=FCngliche Nachricht-----
Von: Smets, Jan (Jan) [mailto:jan.smets@alcatel-lucent.com]=20
Gesendet: Dienstag, 26. Oktober 2010 14:37
An: Christian Brunner
Betreff: RE: osd/ReplicatedPG.cc:2403: FAILED assert(!missing.is_missin=
g(soid))

Hi

I think I've seen this one before, and I think it's fixed in the unstab=
le branch.

Can you try that one?

- Jan
=20

-----Original Message-----
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Christian Brunner
Sent: dinsdag 26 oktober 2010 14:15
To: ceph-devel@vger.kernel.org
Subject: osd/ReplicatedPG.cc:2403: FAILED assert(!missing.is_missing(so=
id))

Here is another problem (I think it's unrelated to the previous, but I'=
m not sure).

One of our osds crashed with the following message:

osd/ReplicatedPG.cc: In function 'void ReplicatedPG::sub_op_modify(MOSD=
SubOp*)':
osd/ReplicatedPG.cc:2403: FAILED assert(!missing.is_missing(soid)) ceph=
 version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee7014279)
1: (OSD::dequeue_op(PG*)+0x374) [0x4d27a4]
2: (ThreadPool::worker()+0x291) [0x5b69d1]
3: (ThreadPool::WorkThread::entry()+0xd) [0x4f36dd]
4: (Thread::_entry_func(void*)+0x7) [0x470927]
5: (()+0x77e1) [0x7fe83e60e7e1]
6: (clone()+0x6d) [0x7fe83d83251d]
NOTE: a copy of the executable, or `objdump -rdS <executable>` is neede=
d to interpret this.
*** Caught signal (ABRT) ***
ceph version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee7014279)
1: (sigabrt_handler(int)+0x7d) [0x5c767d]
2: (()+0x32a30) [0x7fe83d783a30]
3: (gsignal()+0x35) [0x7fe83d7839b5]
4: (abort()+0x175) [0x7fe83d785195]
5: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x7fe83e028aad]
6: (()+0xbcc36) [0x7fe83e026c36]
7: (()+0xbcc63) [0x7fe83e026c63]
8: (()+0xbcd5e) [0x7fe83e026d5e]
9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x448) [0x5b5338]
10: (ReplicatedPG::sub_op_modify(MOSDSubOp*)+0x719) [0x48d8b9]
11: (OSD::dequeue_op(PG*)+0x374) [0x4d27a4]
12: (ThreadPool::worker()+0x291) [0x5b69d1]
13: (ThreadPool::WorkThread::entry()+0xd) [0x4f36dd]
14: (Thread::_entry_func(void*)+0x7) [0x470927]
15: (()+0x77e1) [0x7fe83e60e7e1]
16: (clone()+0x6d) [0x7fe83d83251d]

When we are trying to restart the cosd, we can see the following log-ou=
tput:

2010-10-26 13:51:52.176904 7f005e83e720 journal read_entry
10102640640: seq 188804 728 bytes
2010-10-26 13:51:52.308172 7f0054f31710 osd5 39 map says i am down or h=
ave a different address.  switching to boot state.
2010-10-26 13:51:52.308222 7f0054f31710 log [WRN] : map e39 wrongly mar=
ked me down
2010-10-26 13:51:56.097515 7f0054f31710 journal throttle: waited for op=
s

After that we are unable to do any rados operations in our cluster.
The only way to solve this, was killing the cosd again.

Regards,
Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
