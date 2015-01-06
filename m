From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Ceph-client branch for Ubuntu 14.04.1 LTS (3.13.0-x kernels)
Date: Tue, 6 Jan 2015 17:19:05 +0300
Message-ID: <CALFYKtAs+685rxyJx0dasHprMatLUeLyv7oq397Ty2SiJ_uCCw@mail.gmail.com>
References: <9E914F5BD7F48A4782456CEB550A42280A758A6D@SACMBXIP01.sdcorp.global.sandisk.com>
	<CALFYKtAxr9AbPR_DJp9EBTZ+FX4+d9dwhk89M74VRDK2Gq3E1g@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F28271DE7@SACMBXIP02.sdcorp.global.sandisk.com>
	<CALFYKtCTg7qPF76qnGLEFYoKN73tGhVD+RNr7a2v486FURNC-Q@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F28271FF7@SACMBXIP02.sdcorp.global.sandisk.com>
	<CALFYKtC+7EDJg-J3PnvoedkrSoak1cnHN6+aejsZE91E0dcFCg@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2827201B@SACMBXIP02.sdcorp.global.sandisk.com>
	<9E914F5BD7F48A4782456CEB550A42280A75905D@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:33700 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbbAFOTH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jan 2015 09:19:07 -0500
Received: by mail-qc0-f171.google.com with SMTP id r5so17175293qcx.30
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jan 2015 06:19:05 -0800 (PST)
In-Reply-To: <9E914F5BD7F48A4782456CEB550A42280A75905D@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jan 6, 2015 at 3:31 PM, Chaitanya Huilgol
<Chaitanya.Huilgol@sandisk.com> wrote:
> Hi Ilya,
>
> The RBD crash on OSD nodes going away is routinely hit in our setups.
> We have not been able to get a good stack trace for this one due to o=
ur console capture issues and these don't end up in the syslogs either =
after the crash. Will get you the traces soon.
> Most of the times this happens when all the OSD nodes go away at once=
=2E  This could have probably been fixed by one of the following commit=
s?
>
> Ilya Dryomov
> libceph: change from BUG to WARN for __remove_osd() asserts =E2=80=A6
> idryomov authored on Nov 5
> cc9f1f5
> Ilya Dryomov
> libceph: clear r_req_lru_item in __unregister_linger_request() =E2=80=
=A6
> idryomov authored on Nov 5
> ba9d114
> Ilya Dryomov
> libceph: unlink from o_linger_requests when clearing r_osd =E2=80=A6
> idryomov authored on Nov 4
> a390de0

Yes, but probably others as well.

>
> Also, We have encountered a few other issues listed below
>
> (1) Soft Lockup issue
> Dec 10 11:22:28 rack3-client-1 kernel: [661597.506625] BUG: soft lock=
up - CPU#2 stuck for 22s! [java:29169] --- (vdbench process)
> .
> .
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.043935] Call Trace:
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.097630] [<ffffffffa062d9e=
8>] con_work+0x298/0x640 [libceph]
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.152461] [<ffffffff810838a=
2>] process_one_work+0x182/0x450
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.206653] [<ffffffff8108464=
1>] worker_thread+0x121/0x410
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.259860] [<ffffffff8108452=
0>] ? rescuer_thread+0x3e0/0x3e0
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.312023] [<ffffffff8108b31=
2>] kthread+0xd2/0xf0
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.362974] [<ffffffff8108b24=
0>] ? kthread_create_on_node+0x1d0/0x1d0
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.414058] [<ffffffff8172637=
c>] ret_from_fork+0x7c/0xb0
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.464358] [<ffffffff8108b24=
0>] ? kthread_create_on_node+0x1d0/0x1d0
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.514121] Code: ff ff 48 89=
 df e8 e3 f1 ff ff 48 8b 7d a8 e8 7a 8c 0e e1 48 8b 7d b0 e8 41 d8 a7 e=
0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b 48 8b 45 b8 49 8=
b 0e 4c 89 f2 48 c7 c6 d0 76 64 a0 48 c7
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.663443] RIP [<ffffffffa06=
3340e>] osd_reset+0x22e/0x2c0 [libceph]
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.712105] RSP <ffff880a22b8=
bd80>
>
> (2) Soft lockup when OSDs are flapping
>
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.089489] BUG: soft lock=
up - CPU#4 stuck for 23s! [kworker/4:0:45012]
> .
> .
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098648] Call Trace:
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098653] [<ffffffffa030=
d963>] kick_requests+0x1e3/0x440 [libceph]
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098657] [<ffffffffa030=
df98>] ceph_osdc_handle_map+0x2a8/0x620 [libceph]
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098662] [<ffffffffa030=
e55b>] dispatch+0x24b/0xb20 [libceph]
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098665] [<ffffffffa030=
1c08>] ? ceph_tcp_recvmsg+0x48/0x60 [libceph]
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098669] [<ffffffffa030=
552f>] con_work+0x164f/0x2b60 [libceph]
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098672] [<ffffffff8101=
b7d9>] ? sched_clock+0x9/0x10
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098674] [<ffffffff8101=
b763>] ? native_sched_clock+0x13/0x80
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098676] [<ffffffff8101=
b7d9>] ? sched_clock+0x9/0x10
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098679] [<ffffffff8109=
d2d5>] ? sched_clock_cpu+0xb5/0x100
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098681] [<ffffffff8109=
df6d>] ? vtime_common_task_switch+0x3d/0x40
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098684] [<ffffffff8108=
38a2>] process_one_work+0x182/0x450
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098686] [<ffffffff8108=
4641>] worker_thread+0x121/0x410
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098688] [<ffffffff8108=
4520>] ? rescuer_thread+0x3e0/0x3e0
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098690] [<ffffffff8108=
b312>] kthread+0xd2/0xf0
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098692] [<ffffffff8108=
b240>] ? kthread_create_on_node+0x1d0/0x1d0
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098695] [<ffffffff8172=
637c>] ret_from_fork+0x7c/0xb0
> Dec 18 18:25:10 rack3-client-2 kernel: [157126.098697] [<ffffffff8108=
b240>] ? kthread_create_on_node+0x1d0/0x1d0
>
> (3)  BUG_ON(!list_empty(&req->r_req_lru_item));
>
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320359.828209] kernel BUG at /bu=
ild/buildd/linux-3.13.0/net/ceph/osd_client.c:892!
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.043935] Call Trace:
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.097630] [<ffffffffa062d9e=
8>] con_work+0x298/0x640 [libceph]
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.152461] [<ffffffff810838a=
2>] process_one_work+0x182/0x450
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.206653] [<ffffffff8108464=
1>] worker_thread+0x121/0x410
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.259860] [<ffffffff8108452=
0>] ? rescuer_thread+0x3e0/0x3e0
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.312023] [<ffffffff8108b31=
2>] kthread+0xd2/0xf0
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.362974] [<ffffffff8108b24=
0>] ? kthread_create_on_node+0x1d0/0x1d0
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.414058] [<ffffffff8172637=
c>] ret_from_fork+0x7c/0xb0
> Dec 4 17:14:33 rack6-ramp-4 kernel: [320361.464358] [<ffffffff8108b24=
0>] ? kthread_create_on_node+0x1d0/0x1d0
>
> (4) img_request null
> Dec 12 08:07:48 rack1-ram-6 kernel: [251596.908865] Assertion failure=
 in rbd_img_obj_callback() at line 2127:
> Dec 12 08:07:48 rack1-ram-6 kernel: [251596.908865]
> Dec 12 08:07:48 rack1-ram-6 kernel: [251596.908865]     rbd_assert(im=
g_request !=3D NULL);
>
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.257322]  [<ffffffffa01a58=
97>] rbd_obj_request_complete+0x27/0x70 [rbd]
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.268450]  [<ffffffffa01a8d=
4f>] rbd_osd_req_callback+0xdf/0x4e0 [rbd]
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.279182]  [<ffffffffa039e2=
62>] dispatch+0x4a2/0x900 [libceph]
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.289159]  [<ffffffffa03949=
4b>] try_read+0x4ab/0x10d0 [libceph]
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.299236]  [<ffffffffa03963=
62>] ? try_write+0xa42/0xe30 [libceph]
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.309777]  [<ffffffff8101b7=
d9>] ? sched_clock+0x9/0x10
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.318627]  [<ffffffff8101b7=
63>] ? native_sched_clock+0x13/0x80
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.332347]  [<ffffffff8101b7=
d9>] ? sched_clock+0x9/0x10
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.341095]  [<ffffffff8109d2=
d5>] ? sched_clock_cpu+0xb5/0x100
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.351061]  [<ffffffffa03968=
09>] con_work+0xb9/0x640 [libceph]
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.361003]  [<ffffffff810838=
a2>] process_one_work+0x182/0x450
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.370752]  [<ffffffff810846=
41>] worker_thread+0x121/0x410
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.379816]  [<ffffffff810845=
20>] ? rescuer_thread+0x3e0/0x3e0
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.389173]  [<ffffffff8108b3=
12>] kthread+0xd2/0xf0
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.396898]  [<ffffffff8108b2=
40>] ? kthread_create_on_node+0x1d0/0x1d0
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.407506]  [<ffffffff817263=
7c>] ret_from_fork+0x7c/0xb0
> Dec 12 08:07:50 rack1-ram-6 kernel: [251597.416181]  [<ffffffff8108b2=
40>] ? kthread_create_on_node+0x1d0/0x1d0
> This is similar to: http://tracker.ceph.com/issues/8378
>
> Saw that the rhel7a branch has many of the latest fixes and is somewh=
at compatible with 3.13 kernels,
> For validation, we have taken the rhel7a ceph-client branch and with =
minor modification gotten it to compile with 3.13.0 headers. With this =
we did not hit any issues (expect issue-2).

What do you mean by "expect issue-2"?

(3) and (4) should be fixed in rhel7-a.  Can't say anything about (1)
and (2) - please report back if you see any soft lockup splats on
rhel7-a.

> We understand that is not the right approach for Ubuntu, It would be =
great if we could get the fixes into Ubuntu 14.04 kernels as well.

It may not be the right approach, but in many ways it's better than
a set of selected backports.  While working on another report I found
a couple easy-to-backport patches that are missing from Ubuntu 3.13
series and will forward them to stable guys, but, for those who can
build their own kernels at least, branches like rhel7-a are best.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
