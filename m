From: Tone Zhang <tone.zhang@linaro.org>
Subject: Re: Ceph installation packages on Ubuntu
Date: Wed, 4 Jan 2017 17:14:22 +0800
Message-ID: <CAOCf4AmhchBK56+stO3tarSHG_JuByaTtXU1fqNaHGUBSuxE2g@mail.gmail.com>
References: <CAOCf4An8SHRYgeKQ-t9h1TjGU9k8GCc0GGmZRCt0dikUG3Azeg@mail.gmail.com>
 <CAC-Np1wLzXAPq6gdCGu_wY+safqGW0c6wGHCgm+-2Wxd-os5Sg@mail.gmail.com>
 <CAOCf4Akuk27q3Ki=LbAmjY-geUOjSgqCiRiSD5FhxV6Fw8uSAg@mail.gmail.com> <CAJE9aOMUDu-tLV+NeGNPEiLOJP7gCEXWCCyX3-pjdFYAQnJxSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:35385 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbdADJP4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jan 2017 04:15:56 -0500
Received: by mail-ua0-f181.google.com with SMTP id y9so14280768uae.2
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jan 2017 01:14:23 -0800 (PST)
In-Reply-To: <CAJE9aOMUDu-tLV+NeGNPEiLOJP7gCEXWCCyX3-pjdFYAQnJxSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Kefu,

Thanks!

Will try the correct command.

Br,
Tone

On 4 January 2017 at 17:11, kefu chai <tchaikov@gmail.com> wrote:
> On Wed, Jan 4, 2017 at 4:19 PM, Tone Zhang <tone.zhang@linaro.org> wrote:
>> Hi Kefu and Alfredo,
>>
>> Sorry for the late, and thanks a lot for your kindly help.
>>
>> @Kefu,
>> I tried to generate Ceph 10.2.3 deb packages with command
>> "dpkg-buildpackage", but failed. The error is different from you
>> shared.
> <quote>
> ubuntu@u202157:~/tone/ceph$ dpkg-buildpackage -v -uc -us -j16
> ...
>  dpkg-genchanges -v >../ceph_10.2.4-1_arm64.changes
> dpkg-genchanges: warning: 'since' option specifies non-existing version
> dpkg-genchanges: warning: use newest entry that is earlier than the
> one specified
> dpkg-genchanges: error:  is not a valid version
> dpkg-buildpackage: error: dpkg-genchanges gave error exit status 255
> </quote>
>
> you might want to pass a version in the -v option. or you can just use
>
>   dpkg-buildpackage -uc -us -j16
>
>
>> Then I generated deb packages for Ceph 10.2.4, it failed at almost the
>> last steps. I can find all the generated deb packages in the build
>> machine.
>>
>> The issue in 10.2.3 is different from 10.2.4.
>
> <quote>
> dpkg-shlibdeps: error: no dependency information found for
> /usr/lib/libleveldb.so.1 (used by debian/ceph-mon/usr/bin/ceph-mon)
> Hint: check if the library actually comes from a package.
> dh_shlibdeps: dpkg-shlibdeps -Tdebian/ceph-mon.substvars
> debian/ceph-mon/usr/bin/ceph-mon returned exit code 2
> debian/rules:112: recipe for target 'binary-arch' failed
> </quote>
>
> seems the libleveldb is not well packaged. a quick google returns:
> http://stackoverflow.com/questions/11238134/dpkg-shlibdeps-error-no-dependency-information-found-for
>
>>
>> @Alfredo,
>> Thanks for your help. I have installed Ceph 10.2.2 via "dpkg" command.
>>
>> I threw the question is that I thought Ceph community will stop
>> releasing Ceph version for arm platform. Obviously I am wrong. :)
>>
>>
>> I attached the log.
>>
>> Thanks.
>>
>> Br,
>> Tone
>>
>> On 4 January 2017 at 04:16, Alfredo Deza <adeza@redhat.com> wrote:
>>> On Wed, Dec 21, 2016 at 3:21 AM, Tone Zhang <tone.zhang@linaro.org> wrote:
>>>> Hi Cephers,
>>>>
>>>> In recent, I tried to deploy Ceph cluster on Ubuntu 16.04 on ARM
>>>> platform via "ceph-deploy".
>>>>
>>>> When I ran "ceph-deploy install" command, I got "cannot find ceph-osd"
>>>> and "ceph-mon". I checked the ceph download center for Ubuntu on ARM
>>>> (https://download.ceph.com/debian-jewel/pool/main/c/ceph/), it seems
>>>> since Ceph 10.2.4, there is no deb packages for ARM any more. What's
>>>> happened? Does it mean ceph jewel delivery on ARM platform will be
>>>> stopped?
>>>
>>> I don't recall why we didn't ship for 10.2.4. For regular releases we
>>> put the priority on the non-arm
>>> versions, so it is possible we had some temporary issue at the time of 10.2.4
>>>
>>> I will get a build going for that version and arm64, and will update
>>> this thread when that is complete (or if we find anything preventing a
>>> build)
>>>>
>>>> If I want to deploy Ceph jewel 10.2.2 via ceph-deploy, how shall I do?
>>>> Except download all the deb packaged for 10.2.2 and install ceph
>>>> manually, is there an easier way?
>>>
>>> There isn't a way to do this with a released Ceph version, because the
>>> DEB repos will not allow to provide metadata information for multiple
>>> versions of the same package (the deb tooling we use just ignores the
>>> older versions).
>>>
>>> If you can't wait, there is an unsigned repo for 10.2.2 available at:
>>>
>>> https://chacra.ceph.com/r/ceph/jewel/ubuntu/xenial/
>>>
>>> It contains the other DEB distros there as well (it isn't just xenial)
>>>
>>>>
>>>> Thanks a lot!
>>>>
>>>> Br,
>>>> Tone
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Regards
> Kefu Chai
