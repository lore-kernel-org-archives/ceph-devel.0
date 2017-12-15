From: Milan Broz <mbroz@redhat.com>
Subject: Re: LUKS encryption in OSDs (ceph-volume)
Date: Fri, 15 Dec 2017 15:25:40 +0100
Message-ID: <e9b4aa89-bb72-d44c-68c5-7232ae9cbc15@redhat.com>
References: <CAC-Np1z_Kv1sSBzPXvsiQ7GubioSwQZnMMtuJL4Z3SUXR2L1fg@mail.gmail.com>
 <CAGbvivL=5WdKJbKtt=KO98v86EQZb3Nz+p=zLKusxbMv+_u0ig@mail.gmail.com>
 <CAC-Np1xymbq6taouoMZB7F_LKv5ZUq04zpeKgda3DtoZ+RVJ1A@mail.gmail.com>
 <alpine.DEB.2.11.1712122045010.25542@piezo.novalocal>
 <d89ffab5-73bd-063f-238f-d664a4ad6206@redhat.com>
 <CAEPMp+5mx57spPOBPtx6VpOJca=zpQ2MCumvBJwY7a5bH9HH=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755503AbdLOOZn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 15 Dec 2017 09:25:43 -0500
In-Reply-To: <CAEPMp+5mx57spPOBPtx6VpOJca=zpQ2MCumvBJwY7a5bH9HH=w@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Schoen <aschoen@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Alfredo Deza <adeza@redhat.com>, Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 12/14/2017 03:58 PM, Andrew Schoen wrote:
>>> It's worth mentioning that the "new" way for new ceph-volume OSD
>>> deployments will also be using LVM, and (presumably?) allow layering
>>> dm-crypt on top of an LV--not just a PV or raw device.  So this is more a
>>> question of what, clean slate, we want to do to deploy dm-crypt when the
>>> end result that we're after is an LV to feed to bluestore or filestore.
>>> I'm not sure how/where LUKS fits in in the LVM world...
>>
>> I think LUKS fits in LVM world quite well.
>>
>> Standard Fedora (and most other distors as well) install stacks LVM over LUKS
>> (so you activate only one encrypted device and then the partitioning is up to LVM.
>> Also LVM metadata are then encrypted.)
>>
>> You can of course stack LUKS over LV as well, but for example LV resize
>> will be two-step operation (well, fsadm can automate it but it is still two-steps).
> 
> Would this be the only downside to LUKS on LVM? This approach is nice
> for ceph-volume
> because we need to be able to encrypt anything given to us, which is
> often times a LV.
> 
> The LVM on LUKS approach also makes it more difficult to expand the
> underlying vgs and span
> lvs across many disks. If I'm understanding correctly.

LUKS over LV should work perfectly fine, so if you have more arguments for this approach,
than use it.
(I think you can still have more LUKS devices that contains more PVs to one VG in LVM,
byt it could be more complicated to maintain.)

So I am probably just a little bit confused from the approach that there can be more OSDs
spanning one physical device. If it is common now, then I guess LV is just an equivalent
of OSD on a physical hotplugged device and you solution makes perfect sense.

Milan
