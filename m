From: Gregory Farnum <greg@inktank.com>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Fri, 6 Jul 2012 10:11:14 -0700
Message-ID: <CAPYLRziiFAAv8j=tJM1tmnmjoDQE8qbeLMQ==aE540xCCik7nA@mail.gmail.com>
References: <CAPYLRzhU9pyp-ExVL0wfXL4=F=CHY4uWd7=3tPzgKA4-kPYTZg@mail.gmail.com>
	<9437d87e-97db-48fc-a133-f25042b21a38@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61592 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757294Ab2GFRLQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 13:11:16 -0400
Received: by bkwj10 with SMTP id j10so4608659bkw.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jul 2012 10:11:15 -0700 (PDT)
In-Reply-To: <9437d87e-97db-48fc-a133-f25042b21a38@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Stefan Priebe <s.priebe@profihost.ag>

On Thu, Jul 5, 2012 at 8:50 PM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
> Hi,
> Stefan is on vacation for the moment,I don't know if he can reply you.
>
> But I can reoly for him for the kvm part (as we do same tests together in parallel).
>
> - kvm is 1.1
> - rbd 0.48
> - drive option rbd:pool/volume:auth_supported=cephx;none;keyring=/etc/pve/priv/ceph/ceph.keyring:mon_host=X.X.X.X";
> -using writeback
>
> writeback tuning in ceph.conf on the kvm host
>
> rbd_cache_size = 33554432
> rbd_cache_max_age = 2.0
>
> benchmark use in kvm guest:
> fio --filename=$DISK --direct=1 --rw=randwrite --bs=4k --size=200G --numjobs=50 --runtime=90 --group_reporting --name=file1
>
> results show max 14000io/s with 1 vm, 7000io/s by vm with 2vm,...
> so it doesn't scale
>
> (bench is with directio, so maybe writeback cache don't help)
>
> hardware for ceph , is 3 nodes with 4 intel ssd each. (1 drive can handle 40000io/s randwrite locally)

I'm interested in figuring out why we aren't getting useful data out
of the admin socket, and for that I need the actual configuration
files. It wouldn't surprise me if there are several layers to this
issue but I'd like to start at the client's endpoint. :)

Regarding the random IO, you shouldn't overestimate your storage.
Under plenty of scenarios your drives are lucky to do more than 2k
IO/s, which is about what you're seeing....
http://techreport.com/articles.x/22415/9
-Greg
