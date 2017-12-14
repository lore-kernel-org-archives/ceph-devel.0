From: Milan Broz <mbroz@redhat.com>
Subject: Re: LUKS encryption in OSDs (ceph-volume)
Date: Thu, 14 Dec 2017 14:33:38 +0100
Message-ID: <ba1dfbee-073b-06f4-71ab-9ef5ab394797@redhat.com>
References: <CAC-Np1z_Kv1sSBzPXvsiQ7GubioSwQZnMMtuJL4Z3SUXR2L1fg@mail.gmail.com>
 <CAGbvivL=5WdKJbKtt=KO98v86EQZb3Nz+p=zLKusxbMv+_u0ig@mail.gmail.com>
 <CAC-Np1xymbq6taouoMZB7F_LKv5ZUq04zpeKgda3DtoZ+RVJ1A@mail.gmail.com>
 <alpine.DEB.2.11.1712122045010.25542@piezo.novalocal>
 <d89ffab5-73bd-063f-238f-d664a4ad6206@redhat.com>
 <alpine.DEB.2.11.1712131732290.2838@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752016AbdLNNdk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 14 Dec 2017 08:33:40 -0500
In-Reply-To: <alpine.DEB.2.11.1712131732290.2838@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Alfredo Deza <adeza@redhat.com>, Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 12/13/2017 06:36 PM, Sage Weil wrote:
> We don't really have a need to resize devices, generally, so that's 
> probably not an issue... but I wonder if (1) is going to be an 
> easier/smaller change to make this work.  It maps more directly onto the 
> threat model (a lost *device*) and probably also avoids some DM layers, 
> and so ought to be slightly faster?

DM is based on stacking device model, linear mapping (normal LV in LVM)
cost you almost nothing - it is just offset overwrite inside kernel.
So if you think about layering linear devices, the speed difference should be negligible.

With dm-crypt it is something different - it need to clone bio requests and
then encrypt/decrypt them.

Milan

