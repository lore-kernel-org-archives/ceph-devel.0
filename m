From: =?UTF-8?B?SmVucyBLcmlzdGlhbiBTw7hnYWFyZA==?=
	<jens@mermaidconsulting.dk>
Subject: Re: Improving responsiveness of KVM guests on Ceph storage
Date: Mon, 31 Dec 2012 00:12:18 +0100
Message-ID: <50E0CA52.9020909@mermaidconsulting.dk>
References: <50E0745D.8050306@mermaidconsulting.dk> <CABYiri9A4LxEgjrGHRVfn_WSLR9_ztHKN_+GJBh7KButwa68JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx03.stofanet.dk ([212.10.10.13]:58162 "EHLO mx03.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755140Ab2L3XMV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 30 Dec 2012 18:12:21 -0500
In-Reply-To: <CABYiri9A4LxEgjrGHRVfn_WSLR9_ztHKN_+GJBh7KButwa68JA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Andrey,

Thanks for your reply!

> You may try do play with SCHED_RT, I have found it hard to use for
> myself, but you can achieve your goal by adding small RT slices via
> ``cpu'' cgroup to vcpu/emulator threads, it dramatically increases
> overall VM` responsibility.

I'm not quite sure I understand your suggestion.

Do you mean that you set the process priority to real-time on each=20
qemu-kvm process, and then use cgroups cpu.rt_runtime_us /=20
cpu.rt_period_us to restrict the amount of CPU time those processes can=
=20
receive?

I'm not sure how that would apply here, as I have only one qemu-kvm=20
process and it is not non-responsive because of the lack of allocated=20
CPU time slices - but rather because some I/Os take a long time to=20
complete, and other I/Os apparently have to wait for those to complete.

> threads. Of course, some Ceph tuning like writeback cache and large
> journal may help you too, I`m speaking primarily of VM` performance b=
y

I have been considering the journal as something where I could improve=20
performance by tweaking the setup. I have set aside 10 GB of space for=20
the journal, but I'm not sure if this is too little - or if the size=20
really doesn't matter that much when it is on the same mdraid as the=20
data itself.

Is there a tool that can tell me how much of my journal space that is=20
actually actively being used?

I.e. I'm looking for something that could tell me, if increasing the=20
size of the journal or placing it on a seperate (SSD) disk could solve=20
my problem.

How do I change the size of the writeback cache when using qemu-kvm lik=
e=20
I do?

Does setting rbd cache size in ceph.conf have any effect on qemu-kvm,=20
where the drive is defined as:

   format=3Drbd,file=3Drbd:data/image1:rbd_cache=3D1,if=3Dvirtio

--=20
Jens Kristian S=C3=B8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
