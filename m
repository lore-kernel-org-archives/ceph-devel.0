From: Milan Broz <mbroz@redhat.com>
Subject: Re: LUKS encryption in OSDs (ceph-volume)
Date: Thu, 14 Dec 2017 14:49:58 +0100
Message-ID: <9236362e-435d-2ee0-3a4e-ffd8083ee008@redhat.com>
References: <CAC-Np1z_Kv1sSBzPXvsiQ7GubioSwQZnMMtuJL4Z3SUXR2L1fg@mail.gmail.com>
 <CAGbvivL=5WdKJbKtt=KO98v86EQZb3Nz+p=zLKusxbMv+_u0ig@mail.gmail.com>
 <CAC-Np1xymbq6taouoMZB7F_LKv5ZUq04zpeKgda3DtoZ+RVJ1A@mail.gmail.com>
 <alpine.DEB.2.11.1712122045010.25542@piezo.novalocal>
 <d89ffab5-73bd-063f-238f-d664a4ad6206@redhat.com>
 <alpine.DEB.2.11.1712131732290.2838@piezo.novalocal>
 <CAC-Np1ysivJO9K5+VxgAeLCGrYw83akMHtU0xruD12_36zmLkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbdLNNuA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 14 Dec 2017 08:50:00 -0500
In-Reply-To: <CAC-Np1ysivJO9K5+VxgAeLCGrYw83akMHtU0xruD12_36zmLkA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 12/14/2017 02:17 PM, Alfredo Deza wrote:
>>> Standard Fedora (and most other distors as well) install stacks LVM over LUKS
>>> (so you activate only one encrypted device and then the partitioning is up to LVM.
>>> Also LVM metadata are then encrypted.)
> 
> That is a very important distinction (encrypted LVM metadata) and why
> we don't want to go that route: we rely heavily on LVM metadata where
> we store the
> information about the OSD to be later queried. That metadata must be
> available without decryption.

LUKS2 allows you to store store your JSON data to LUKS header.
For the identification of OSD or whatever you need it is even simpler.

>> The problem I see is that we frequently carve up a single phsycial device
>> across lots of OSDs (usually for the journal or wal/db), and the key
>> management is currently structured around OSDs, not devices.  We can
>> either (1) switch it all around so the key management is based on physical
>> devices instead of OSDs, or (2) carve the physical device into raw LVs,
>> dm-crypt those, and then consume the result.
> 
> #2 here is my preference. Lets not switch key management around. I
> don't know how things like dmcache
> (which is made up of several physical devices) would work for option #1.

I currently lost overview what is Ceph doing, but for unlocking
of crypt device - LUKS2 allows you to store passphrase to kernel keyring
(in advance) and then device is unlocked automatically.
(It needs to configure a "token" for metadata - in the case of keyring
it is just name in keyring.)

Maybe it can simplify your key management in future with LUKS.

(LUKS2 is already in Fedora rawhide and in some experimental repos of other distros.
It need some time to be widely used and I know it will need some fixes - but in principle
things mentioned above already work.)

Milan
