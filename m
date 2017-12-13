From: Milan Broz <mbroz@redhat.com>
Subject: Re: LUKS encryption in OSDs (ceph-volume)
Date: Wed, 13 Dec 2017 18:00:46 +0100
Message-ID: <d89ffab5-73bd-063f-238f-d664a4ad6206@redhat.com>
References: <CAC-Np1z_Kv1sSBzPXvsiQ7GubioSwQZnMMtuJL4Z3SUXR2L1fg@mail.gmail.com>
 <CAGbvivL=5WdKJbKtt=KO98v86EQZb3Nz+p=zLKusxbMv+_u0ig@mail.gmail.com>
 <CAC-Np1xymbq6taouoMZB7F_LKv5ZUq04zpeKgda3DtoZ+RVJ1A@mail.gmail.com>
 <alpine.DEB.2.11.1712122045010.25542@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753323AbdLMRAs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 13 Dec 2017 12:00:48 -0500
In-Reply-To: <alpine.DEB.2.11.1712122045010.25542@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Alfredo Deza <adeza@redhat.com>
Cc: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 12/12/2017 09:47 PM, Sage Weil wrote:
> On Tue, 12 Dec 2017, Alfredo Deza wrote:
>> On Tue, Dec 12, 2017 at 2:38 PM, Wyllys Ingersoll
>> <wyllys.ingersoll@keepertech.com> wrote:
>>> Its useful for legacy systems that installed with "plain" back when
>>> that was the only option. Since there is no easy migration path for
>>> re-keying an encrypted OSD to use a new encryption scheme, keeping
>>> support for legacy "plain" is still very useful and desirable.
>>
>> Yes, for sure we are going to support that legacy option. But for
>> *newly* created OSDs, I was looking forward to follow
>> the preferred way with LUKS only.
> 
> It's worth mentioning that the "new" way for new ceph-volume OSD 
> deployments will also be using LVM, and (presumably?) allow layering 
> dm-crypt on top of an LV--not just a PV or raw device.  So this is more a 
> question of what, clean slate, we want to do to deploy dm-crypt when the 
> end result that we're after is an LV to feed to bluestore or filestore.  
> I'm not sure how/where LUKS fits in in the LVM world...

I think LUKS fits in LVM world quite well.

Standard Fedora (and most other distors as well) install stacks LVM over LUKS
(so you activate only one encrypted device and then the partitioning is up to LVM.
Also LVM metadata are then encrypted.)

You can of course stack LUKS over LV as well, but for example LV resize
will be two-step operation (well, fsadm can automate it but it is still two-steps).

Milan
