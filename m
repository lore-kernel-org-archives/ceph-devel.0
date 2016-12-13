From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: use ceph-ci.git to get repositories out of dev branches
Date: Tue, 13 Dec 2016 15:20:52 +0100
Message-ID: <ca932c0f-3108-f786-6c72-a546359efbaf@suse.cz>
References: <CAC-Np1y=2DY7Rve+ao73i7EtKrFY1K_jnDR86Yhhgt9XF7gsQw@mail.gmail.com>
 <CAC-Np1wgRYptDTeF7=MSmWMW1B1tP_=RNp8EtTGkSy+ZqrP-rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53069 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932515AbcLMOU4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Dec 2016 09:20:56 -0500
In-Reply-To: <CAC-Np1wgRYptDTeF7=MSmWMW1B1tP_=RNp8EtTGkSy+ZqrP-rA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>
Cc: Andrew Schoen <aschoen@redhat.com>

Hi Alfredo:

I'm trying to build a "wip-hammer-backports" integration branch to test 
the 0.94.10 release, but shaman doesn't like it for some reason:

https://jenkins.ceph.com/job/ceph-dev-setup/4002//consoleFull

The same branch passes gitbuilder. Could you take a look?

Thanks,
Nathan

On 12/12/2016 01:48 PM, Alfredo Deza wrote:
> **REMINDER**
>
> Please, push development branches to ceph-ci.git to get
> repositories/binaries built.
>
> We are scheduled to restrict permissions to ceph.git in a few days.
>
> Thanks!
>
> On Wed, Dec 7, 2016 at 7:34 AM, Alfredo Deza <adeza@redhat.com> wrote:
>> As announced on November 23rd, please start pushing development
>> branches to ceph-ci.git (https://github.com/ceph/ceph-ci) to get
>> repositories.
>>
>> This doesn't change reporting in https://shaman.ceph.com and it
>> shouldn't affect testing via teuthology.
>>
>> The ceph.git repository will continue to build binaries and
>> repositories for another week to help transitioning.
>>
>> If you have any issues, please mention them in the #sepia or
>> #ceph-devel channels to me (alfredodeza) or Andrew Schoen
>> (andrewschoen).
>>
>> Thanks!
>>
>>
>> -Alfredo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
