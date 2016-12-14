From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: use ceph-ci.git to get repositories out of dev branches
Date: Wed, 14 Dec 2016 19:15:21 +0100
Message-ID: <f66b4496-0111-190b-8d82-46df928668aa@suse.cz>
References: <CAC-Np1y=2DY7Rve+ao73i7EtKrFY1K_jnDR86Yhhgt9XF7gsQw@mail.gmail.com>
 <CAC-Np1wgRYptDTeF7=MSmWMW1B1tP_=RNp8EtTGkSy+ZqrP-rA@mail.gmail.com>
 <ca932c0f-3108-f786-6c72-a546359efbaf@suse.cz>
 <alpine.DEB.2.11.1612140128290.32565@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752589AbcLNSPh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Dec 2016 13:15:37 -0500
In-Reply-To: <alpine.DEB.2.11.1612140128290.32565@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Andrew Schoen <aschoen@redhat.com>

Thanks, Sage. I am eager to use the new stuff, but ATM it appears that 
Shaman does not build hammer at all.

See https://jenkins.ceph.com/job/ceph-dev-setup/4055//consoleFull

Right after configure it appears to do "git diff" and not like what it 
sees. All hammer-based branches (including hammer itself) fail in the 
same way.

Needless to say, in gitbuilder they build fine.

This is blocking work on the 0.94.10 release.

Nathan

On 12/14/2016 02:31 AM, Sage Weil wrote:
> On Tue, 13 Dec 2016, Nathan Cutler wrote:
>> Hi Alfredo:
>>
>> I'm trying to build a "wip-hammer-backports" integration branch to test the
>> 0.94.10 release, but shaman doesn't like it for some reason:
>>
>> https://jenkins.ceph.com/job/ceph-dev-setup/4002//consoleFull
>>
>> The same branch passes gitbuilder. Could you take a look?
>
> There is a new teuthology-suite option, --ceph-repo, that you can pass the
> repo name to.  So, for example,
>
>  teuthology-suite -s rados -c wip-foo --ceph-repo https://github.com/ceph/ceph-ci.git
>
> Soon we'll switch the default around so that ceph-ci.git will be the
> default and you'll need to tell teuthology-suite if you're scheduling
> against a branch in ceph.git (this will mostly just be the cron jobs).
>
> Also, starting very soon (tomorrow), --suite-repo will also pick up this
> value, so that it is (by default) assumed that the *tests* will come out
> of this repo too.  That is, the default for --suite-repo will be whatever
> --ceph-repo is, and --suite-relpath will default to 'qa' (the suite yaml
> files will soon be merged into ceph.git qa/suite/*).  --suite-branch
> will continue to default to whatever the -c ceph branch is (like they do
> already), although it will seem a bit less magic than before since it's
> generally the same branch in the same repo.
>
> sage
>
>
>
>>
>> Thanks,
>> Nathan
>>
>> On 12/12/2016 01:48 PM, Alfredo Deza wrote:
>>> **REMINDER**
>>>
>>> Please, push development branches to ceph-ci.git to get
>>> repositories/binaries built.
>>>
>>> We are scheduled to restrict permissions to ceph.git in a few days.
>>>
>>> Thanks!
>>>
>>> On Wed, Dec 7, 2016 at 7:34 AM, Alfredo Deza <adeza@redhat.com> wrote:
>>>> As announced on November 23rd, please start pushing development
>>>> branches to ceph-ci.git (https://github.com/ceph/ceph-ci) to get
>>>> repositories.
>>>>
>>>> This doesn't change reporting in https://shaman.ceph.com and it
>>>> shouldn't affect testing via teuthology.
>>>>
>>>> The ceph.git repository will continue to build binaries and
>>>> repositories for another week to help transitioning.
>>>>
>>>> If you have any issues, please mention them in the #sepia or
>>>> #ceph-devel channels to me (alfredodeza) or Andrew Schoen
>>>> (andrewschoen).
>>>>
>>>> Thanks!
>>>>
>>>>
>>>> -Alfredo
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Nathan Cutler
>> Software Engineer Distributed Storage
>> SUSE LINUX, s.r.o.
>> Tel.: +420 284 084 037
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
