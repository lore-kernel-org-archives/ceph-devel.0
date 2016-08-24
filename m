From: Casey Bodley <cbodley@redhat.com>
Subject: Re: rgw and the next jewel release v10.2.3
Date: Wed, 24 Aug 2016 13:32:06 -0400
Message-ID: <6315ff7a-e766-6d21-539f-cff31cf124bd@redhat.com>
References: <57BC10E5.10408@dachary.org>
 <CADRKj5Sb6+9gue7NZJ47+3AmK-PyQZA2BoKvqXD7EbYXSrqv3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33918 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752703AbcHXRcI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 13:32:08 -0400
Received: by mail-yw0-f175.google.com with SMTP id z8so14373811ywa.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 10:32:08 -0700 (PDT)
In-Reply-To: <CADRKj5Sb6+9gue7NZJ47+3AmK-PyQZA2BoKvqXD7EbYXSrqv3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>


On 08/24/2016 12:41 PM, Yehuda Sadeh-Weinraub wrote:
> Hey Casey,
>
> are all the multisite fixes we wanted in?

There are still a few pending backport, including 3 in particular that 
fix segfaults:

http://tracker.ceph.com/issues/16901
http://tracker.ceph.com/issues/16864
http://tracker.ceph.com/issues/16696

It looks like that last one is blocked by conflicts with the tenant 
support backport in http://tracker.ceph.com/issues/16702. I'll rebase 
that one and open a PR.

Casey

>
> On Tue, Aug 23, 2016 at 2:01 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Yehuda,
>>
>> The next jewel release as found at https://github.com/ceph/ceph/tree/jewel passed the rgw suite (http://tracker.ceph.com/issues/16344#note-27 except for two failures). Do you think the jewel branch is ready for QE to start their own round of testing ?
>>
>> Cheers
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre

