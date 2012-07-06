From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Fri, 6 Jul 2012 20:09:04 +0200
Message-ID: <D104B995-5AA4-46C2-B9D1-0A80878BEF4C@profihost.ag>
References: <CAPYLRzhU9pyp-ExVL0wfXL4=F=CHY4uWd7=3tPzgKA4-kPYTZg@mail.gmail.com> <9437d87e-97db-48fc-a133-f25042b21a38@mailpro> <CAPYLRziiFAAv8j=tJM1tmnmjoDQE8qbeLMQ==aE540xCCik7nA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:37404 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab2GFSJJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 14:09:09 -0400
In-Reply-To: <CAPYLRziiFAAv8j=tJM1tmnmjoDQE8qbeLMQ==aE540xCCik7nA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Am 06.07.2012 um 19:11 schrieb Gregory Farnum <greg@inktank.com>:

> On Thu, Jul 5, 2012 at 8:50 PM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
>> Hi,
>> Stefan is on vacation for the moment,I don't know if he can reply you.
>> 
>> But I can reoly for him for the kvm part (as we do same tests together in parallel).
>> 
>> - kvm is 1.1
>> - rbd 0.48
>> - drive option rbd:pool/volume:auth_supported=cephx;none;keyring=/etc/pve/priv/ceph/ceph.keyring:mon_host=X.X.X.X";
>> -using writeback
>> 
>> writeback tuning in ceph.conf on the kvm host
>> 
>> rbd_cache_size = 33554432
>> rbd_cache_max_age = 2.0
>> 
>> benchmark use in kvm guest:
>> fio --filename=$DISK --direct=1 --rw=randwrite --bs=4k --size=200G --numjobs=50 --runtime=90 --group_reporting --name=file1
>> 
>> results show max 14000io/s with 1 vm, 7000io/s by vm with 2vm,...
>> so it doesn't scale
>> 
>> (bench is with directio, so maybe writeback cache don't help)
>> 
>> hardware for ceph , is 3 nodes with 4 intel ssd each. (1 drive can handle 40000io/s randwrite locally)
> 
> I'm interested in figuring out why we aren't getting useful data out
> of the admin socket, and for that I need the actual configuration
> files. It wouldn't surprise me if there are several layers to this
> issue but I'd like to start at the client's endpoint. :)

While I'm on holiday I can't send you my ceph.conf but it doesn't contain anything else than the locations and journal dio false for tmpfs and /var/run/ceph_$name.sock

> 
> Regarding the random IO, you shouldn't overestimate your storage.
> Under plenty of scenarios your drives are lucky to do more than 2k
> IO/s, which is about what you're seeing....
> http://techreport.com/articles.x/22415/9
You're fine if the ceph workload is the same as the iometer file server workload. I don't know. I've measured the raw random 4k workload. Also I've tested adding another osd and speed still doesn't change but with a size of 200gb I should hit several osd servers.

Stefan


> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
