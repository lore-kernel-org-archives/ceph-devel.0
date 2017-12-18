From: Ondrej Kozina <okozina@redhat.com>
Subject: Re: LUKS encryption in OSDs (ceph-volume)
Date: Mon, 18 Dec 2017 16:57:18 +0100
Message-ID: <7b341eae-f63c-0b74-f017-6c945c5d7f2b@redhat.com>
References: <CAC-Np1z_Kv1sSBzPXvsiQ7GubioSwQZnMMtuJL4Z3SUXR2L1fg@mail.gmail.com>
 <CAGbvivL=5WdKJbKtt=KO98v86EQZb3Nz+p=zLKusxbMv+_u0ig@mail.gmail.com>
 <CAC-Np1xymbq6taouoMZB7F_LKv5ZUq04zpeKgda3DtoZ+RVJ1A@mail.gmail.com>
 <alpine.DEB.2.11.1712122045010.25542@piezo.novalocal>
 <d89ffab5-73bd-063f-238f-d664a4ad6206@redhat.com>
 <alpine.DEB.2.11.1712131732290.2838@piezo.novalocal>
 <CAC-Np1ysivJO9K5+VxgAeLCGrYw83akMHtU0xruD12_36zmLkA@mail.gmail.com>
 <9236362e-435d-2ee0-3a4e-ffd8083ee008@redhat.com>
 <CAC-Np1zD9wYKyz50CQm=ouphSW_+=EJtDktQ3mTqJSpGfTz=cw@mail.gmail.com>
 <b24fc539-96af-c466-178c-9e349276886f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934498AbdLRP5U (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 18 Dec 2017 10:57:20 -0500
In-Reply-To: <b24fc539-96af-c466-178c-9e349276886f@redhat.com>
Content-Language: en-MW
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milan Broz <mbroz@redhat.com>, Alfredo Deza <adeza@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 12/15/2017 03:31 PM, Milan Broz wrote:
> On 12/14/2017 03:00 PM, Alfredo Deza wrote:
>> On Thu, Dec 14, 2017 at 8:49 AM, Milan Broz <mbroz@redhat.com> wrote:
>>> On 12/14/2017 02:17 PM, Alfredo Deza wrote:
> 
>>> I currently lost overview what is Ceph doing, but for unlocking
>>> of crypt device - LUKS2 allows you to store passphrase to kernel keyring
>>> (in advance) and then device is unlocked automatically.
>>> (It needs to configure a "token" for metadata - in the case of keyring
>>> it is just name in keyring.)
>>
>> Do you have docs that explain this bit in detail? We were just going
>> to do what was done already by ceph-disk, that differs a lot from the
>> kernel keyring
>> workflow.

I'll describe briefly the process for cryptsetup cli only, but you may 
achieve same using cryptsetup library as well. For reference here's the 
api docs: https://gitlab.com/cryptsetup/cryptsetup/wikis/API/index.html

In general kernel keyring activation's an extension for easier LUKS2 
device unlocking.

Let's say you have LUKS2 device with keyslot 1 on /dev/sdx.

Add keyring token to LUKS2 header:
cryptsetup token add /dev/sdx --key-description my_key_name -S 1

(The token itself will contain only the key description and reference to 
keyslot(s) it may be used with. It's stored in jsom metadata area of 
LUKS2 header in plain text)

When you activate LUKS2 with such token it does following:

1) It'll try to activate the device using passphrase retrieved from 
kernel key described by "my_key_name" (kernel key type "user")

2) Only if step 1) fails (i.e. no such key in keyring or passphrase is 
wrong), the command will ask for passphrase the usual way.

So as long as "my_key_name" is reachable from calling process, user 
doesn't have to input passphrase every time he wants to unlock the device.

In fact kernel keyring in this particular case is just another source 
for passphrase just like key files stored in fs.

Regards
O.
