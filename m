From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: [ceph-users] ceph-disk is now deprecated
Date: Tue, 28 Nov 2017 09:39:13 +0100
Message-ID: <4c4b5589-b1ae-3f8b-e900-af0f2895fbc9@corp.ovh.com>
References: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw@mail.gmail.com>
 <1821337488.5487.1511856776936@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 11.mo301.mail-out.ovh.net ([37.187.190.77]:36244 "EHLO
        11.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbdK1IjP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 03:39:15 -0500
In-Reply-To: <1821337488.5487.1511856776936@ox.pcextreme.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@lists.ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

On 17-11-28 09:12 AM, Wido den Hollander wrote:
> 
>> Op 27 november 2017 om 14:36 schreef Alfredo Deza <adeza@redhat.com>:
>>
>>
>> For the upcoming Luminous release (12.2.2), ceph-disk will be
>> officially in 'deprecated' mode (bug fixes only). A large banner with
>> deprecation information has been added, which will try to raise
>> awareness.
>>
> 
> As much as I like ceph-volume and the work being done, is it really a good idea to use a minor release to deprecate a tool?
> 
> Can't we just introduce ceph-volume and deprecate ceph-disk at the release of M? Because when you upgrade to 12.2.2 suddenly existing integrations will have deprecation warnings being thrown at them while they haven't upgraded to a new major version.
> 
> As ceph-deploy doesn't support ceph-disk either I don't think it's a good idea to deprecate it right now.
> 
> How do others feel about this?

Same, although we don't have a *big* problem with this (we haven't upgraded 
to Luminous yet, so we can skip to next point release and move to 
ceph-volume together with Luminous). It's still a problem, though - now we 
have more of our infrastructure to migrate and test, meaning even more 
delays in production upgrades.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
