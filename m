From: Milan Broz <mbroz@redhat.com>
Subject: Re: LUKS encryption in OSDs (ceph-volume)
Date: Fri, 15 Dec 2017 15:31:37 +0100
Message-ID: <b24fc539-96af-c466-178c-9e349276886f@redhat.com>
References: <CAC-Np1z_Kv1sSBzPXvsiQ7GubioSwQZnMMtuJL4Z3SUXR2L1fg@mail.gmail.com>
 <CAGbvivL=5WdKJbKtt=KO98v86EQZb3Nz+p=zLKusxbMv+_u0ig@mail.gmail.com>
 <CAC-Np1xymbq6taouoMZB7F_LKv5ZUq04zpeKgda3DtoZ+RVJ1A@mail.gmail.com>
 <alpine.DEB.2.11.1712122045010.25542@piezo.novalocal>
 <d89ffab5-73bd-063f-238f-d664a4ad6206@redhat.com>
 <alpine.DEB.2.11.1712131732290.2838@piezo.novalocal>
 <CAC-Np1ysivJO9K5+VxgAeLCGrYw83akMHtU0xruD12_36zmLkA@mail.gmail.com>
 <9236362e-435d-2ee0-3a4e-ffd8083ee008@redhat.com>
 <CAC-Np1zD9wYKyz50CQm=ouphSW_+=EJtDktQ3mTqJSpGfTz=cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755800AbdLOObk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 15 Dec 2017 09:31:40 -0500
In-Reply-To: <CAC-Np1zD9wYKyz50CQm=ouphSW_+=EJtDktQ3mTqJSpGfTz=cw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, ceph-devel <ceph-devel@vger.kernel.org>, Ondrej Kozina <okozina@redhat.com>

On 12/14/2017 03:00 PM, Alfredo Deza wrote:
> On Thu, Dec 14, 2017 at 8:49 AM, Milan Broz <mbroz@redhat.com> wrote:
>> On 12/14/2017 02:17 PM, Alfredo Deza wrote:

>> I currently lost overview what is Ceph doing, but for unlocking
>> of crypt device - LUKS2 allows you to store passphrase to kernel keyring
>> (in advance) and then device is unlocked automatically.
>> (It needs to configure a "token" for metadata - in the case of keyring
>> it is just name in keyring.)
> 
> Do you have docs that explain this bit in detail? We were just going
> to do what was done already by ceph-disk, that differs a lot from the
> kernel keyring
> workflow.

We have some example and I plan to write some short blog regarding keyring use.
But the best would be to talk directly to Ondra Kozina (cc) who wrote this keyring
part of the code and can help you to understand what is possible.

>> Maybe it can simplify your key management in future with LUKS.
>>
>> (LUKS2 is already in Fedora rawhide and in some experimental repos of other distros.
>> It need some time to be widely used and I know it will need some fixes - but in principle
>> things mentioned above already work.)
> 
> That is a big gotcha though, we would need 100% availability in the
> distros/versions we support at release time (around April-May 2018)

Yes, I think we should stick with LUKS1 for now.
But we can plan something more simple with LUKS2 in the future.
 
> Are you leaning towards encrypting the physical devices over
> encrypting LVs ? I'm not seeing any risks so far in just going the lv
> encryption route (yet)

See other mail - both works, if it makes more sense to use LUKS on top, that's ok.

Milan

