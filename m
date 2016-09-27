From: Alfredo Deza <adeza@redhat.com>
Subject: Re: libcephfs-java bindings built but not showing up in debian repository
Date: Tue, 27 Sep 2016 11:51:47 -0400
Message-ID: <CAC-Np1zgET95m7NMJSOcOtxNU73c3xrfW5FHHjZU3nJffUAsog@mail.gmail.com>
References: <28c544ef-6521-4ba7-8678-2c0ae8be65f6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38532 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933939AbcI0Pvt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Sep 2016 11:51:49 -0400
Received: by mail-wm0-f52.google.com with SMTP id l132so20220697wmf.1
        for <ceph-devel@vger.kernel.org>; Tue, 27 Sep 2016 08:51:48 -0700 (PDT)
In-Reply-To: <28c544ef-6521-4ba7-8678-2c0ae8be65f6@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Noah Watkins <noahwatkins@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Dan Mick <dmick@redhat.com>, Beocat KSU <mozes@ksu.edu>, Andrew Schoen <aschoen@redhat.com>

On Tue, Sep 27, 2016 at 11:47 AM, Dan Mick <dan.mick@redhat.com> wrote:
> Current thing to check: is javahelper installed in the pbuilder environment?
> If it's missing that'll do this.  That's where Andrew and I were yesterday.

It is installing it.

Confirmed :)
>
> It is a Build-Depends, so should be, but...
>
> Sent from Nine
> ________________________________
> From: Alfredo Deza
> Sent: Sep 27, 2016 7:25 AM
> To: Gregory Farnum
> Cc: Noah Watkins; ceph-devel; Dan Mick; Beocat KSU; Andrew Schoen
> Subject: Re: libcephfs-java bindings built but not showing up in debian
> repository
>
> On Fri, Jun 10, 2016 at 8:15 AM, Alfredo Deza <adeza@redhat.com> wrote:
>> On Thu, Jun 9, 2016 at 8:50 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>> On Thu, Jun 9, 2016 at 4:29 PM, Noah Watkins <noahwatkins@gmail.com>
>>> wrote:
>>>> I'm trying to track down why the Java Debian packages are not showing
>>>> up in the Jewel repository:
>>>>
>>>> Looking in the repository for jewel I see the JNI bindings deb:
>>>>
>>>>    http://download.ceph.com/debian-jewel/pool/main/c/ceph/
>>>>    libcephfs-jni_10.2.1-1trusty_amd64.deb 13-May-2016 23:53 20368086
>>>>
>>>> but not the deb file containing the Java bits (libcephfs-java).
>>>
>>> Hmm, that's the official release packages, which I think aren't
>>> produced using all the same stuff as the gitbuilders. Does
>>> libcephfs-java get built the same way as the JNI bindings? I know we
>>> have a separate gitbuilder for Hadoop JARs...
>>
>> The release packages are not produced using the same process as
>> gitbuilders.
>>
>> This is an example output of Trusty building Jewel:
>>
>>
>> https://jenkins.ceph.com/job/ceph-build/ARCH=x86_64,DIST=trusty,MACHINE_SIZE=huge/133/consoleFull
>>
>> At the end of the build, the process looks for files in:
>> `release/$VERSION` which in the previous case would be
>> `release/10.2.2`
>>
>> All binaries are placed there and that is what ends up being consumed.
>>
>> This is the actual file that builds debs for upstream releases:
>>
>>
>> https://github.com/ceph/ceph-build/blob/master/ceph-build/build/build_deb
>>
>> The part that actually calls pbuilder to produce the binaries and then
>> copy them to our centralized binary store is:
>>
>>
>> https://github.com/ceph/ceph-build/blob/master/ceph-build/build/build_deb#L165-L194
>>
>>
>
> As part of the migration out of gitbuilders and into the new CI
> system, we are now having issues where libcephfs-java is not getting
> built.
>
> We tried debugging and are a bit lost on what is required to get this
> built. The make flags seem correct (to me), and include
> WITH_CEPHFS_JAVA=ON
>
> Recent gitbuilder output shows this line that is missing when we build
> in Jenkins (and official releases as well):
>
>
>     install -d debian/libcephfs-java
>
> If anyone can point us in the right direction, that would be great.
> The teuthology integration is blocked on this currently and we are
> running out of ideas.
>
>
> Recent sample output from Jenkins that doesn't have libcephfs-java:
>
> https://jenkins.ceph.com/job/ceph-dev-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=xenial,DIST=xenial,MACHINE_SIZE=huge/826/consoleFull
>
>
>>>
>>> -Greg
>>>
>>>> However, it looks like the gitbuilder is producing them:
>>>>
>>>>
>>>> http://gitbuilder.ceph.com/ceph-deb-trusty-x86_64-basic/ref/jewel/pool/main/c/ceph/
>>>>    ===> libcephfs-java_10.2.1-135-g50143ed-1trusty_all.deb2016-06-09
>>>> 15:191.0M
>>>>    libcephfs-jni_10.2.1-135-g50143ed-1trusty_amd64.deb2016-06-09
>>>> 15:1919M
>>>>
>>>> I grepped around the autobuilders and don't see any special cases for
>>>> Java. Any clues?
>>>>
>>>> Thanks,
>>>> Noah
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
