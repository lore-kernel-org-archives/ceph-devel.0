From: kefu chai <tchaikov@gmail.com>
Subject: Re: increasingly large packages and longer build times
Date: Tue, 22 Aug 2017 15:01:55 +0800
Message-ID: <CAJE9aON9ELevTue_DXdcYnqBVO2LbTe8mthbytegbtyfLm+K7A@mail.gmail.com>
References: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
 <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com> <CAJ4mKGZ5eAvOTTDwAzoAjv2Ed0C3mb1E7PxQvphY85rXZy5Oow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36729 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754563AbdHVHB6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Aug 2017 03:01:58 -0400
Received: by mail-oi0-f44.google.com with SMTP id g131so177102101oic.3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Aug 2017 00:01:57 -0700 (PDT)
In-Reply-To: <CAJ4mKGZ5eAvOTTDwAzoAjv2Ed0C3mb1E7PxQvphY85rXZy5Oow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Alfredo Deza <adeza@redhat.com>, Ken Dreyer <kdreyer@redhat.com>

On Thu, Aug 17, 2017 at 5:44 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Mon, Aug 7, 2017 at 7:58 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
>> On Wed, Aug 2, 2017 at 7:39 AM, Alfredo Deza <adeza@redhat.com> wrote:
>>> The ceph-debuginfo package has continued to increase in size on almost
>>> every release, reaching 1.5GB for the latest luminous RC (12.1.2).
>>>
>>> To contrast that, the latest ceph-debuginfo in Hammer was about 0.73GB.
>>>
>>> Having packages that large is problematic on a few fronts:
>>
>> I agree Alfredo. Here's a similar issue I am experiencing with the sourc=
e sizes:
>>
>> Jewel sizes:
>>   14M ceph-10.2.7.tar.gz
>>   82M ceph-10.2.7 uncompressed
>>
>> Luminous sizes:
>>   142M ceph-12.1.2.tar.gz
>>   709M ceph-12.1.2  uncompressed
>>
>> This adds minutes onto the build times when we must shuffle these
>> large artifacts around:
>>
>> - Upstream we're transferring the artifacts between Jenkins slaves and c=
hacra
>>   and download.ceph.com.
>>
>> - Downstream in Fedora/RHEL land we're uploading these source tars to
>>   dist-git's lookaside cache, and it takes a while just to upload/downlo=
ad.
>>
>> - Downstream in Debian and Ubuntu (AFAICT) they upload the source tars t=
o Git
>>   with git-buildpackage, and this increases the time it takes to even "g=
it
>>   clone" these repos.
>>
>> The bundled Boost alone is is 474MB unpacked in 12.1.2. If we could
>> build Boost as a separate package (and not bundle it into ceph) it
>> would make it easier to manage builds upstream and downstream.
>>
>> We could build a boost package in the jenkins.ceph.com infrastructure,
>> or the CentOS Storage SIG (for RHEL-based distros), and then start
>> depending on that system instead of EPEL. For Debian/Ubuntu, we could
>> use jenkins.ceph.com/chacra or something else - any suggestions from
>> Debian/Ubuntu folks?

we will need to build the full set of boost packages, including static
boost libraries and devel packages for all supported distros, and link
against them in our own CI and release process. or build the dynamic
boost libraries and install them into $prefix/lib/ceph, and link all
executables against them at run-time.

my main concern would be the downstream. how shall we accommodate the
packaging of downstream? for example, what if the boost package
maintainers of SuSE/fedora/debian/ubuntu are not ready to package the
boost version we want to use in future?

but as long as we don't require newer boost to build, we are safe on
debian and ubuntu at this moment. as boost 1.61 is required for
building ceph, and both debian unstable and ubuntu artful package
boost v1.62.

>
> I spent some time talking to Ken and Alfredo today to try and work
> their concerns into something understandable by happily
> package-building-unaware developers like myself. I've tried to distill
> that conversation into the points below:
>
> 1) They would *love* it if we started relying more on "external"
> packages and less on in-tree source, even if our packaging team is
> responsible for maintaining them.
>
> 2) The actual size of a full source checkout is an actual problem when
> building 600 packages a day (our systems are). If we can cut it down,
> we can get dev packages built more quickly!
> The biggest contributors anybody isolated are boost and inclusions
> like the web dev stuff for ceph-mgr. (I'm making no promises for him,
> but it sounded like Ken was going to investigate/push against the
> boost wall a bit more.)
>
> 3) ceph-debuginfo (and the .deb equivalents) are ginormous enough (so
> much so that it requires special configuration of our package serving
> infrastructure)
>
> Don't have much to say about (1) in isolation.
>
> As far as (2) goes, it's really convenient from a dev perspective to
> have one git checkout and its submodules to deal with, instead of
> needing to install a bunch of packages. But we already have our
> install-deps and we don't seem to update many of the dependencies that
> often. How much would it hurt to split out stuff into separate
> ceph-dev-* repos and packages we rely on? (We could probably even do
> separate ones for each Ceph release stream?) We do sometimes update
> the submodule and add an interface jump concurrent with that, but I
> don't think it's really often. Is it feasible from both sides to
> instead change what package version we depend on, and to start
> building a new package?
>
> On (3), there are a few causes. One is that we just have a lot of
> code. But a far bigger impact seems to come from all the ceph_test_*
> binaries and other things which we have statically linked with
> ceph-common et al. There are two approaches we can take there: we can
> figure out how to dynamically link them (which I haven't been involved
> in but recall being difficult =E2=80=94 but also have caused other issues=
 to

actually almost all ceph_test_* are linking against libceph-common.
but they are linking against libglobal and libos statically.

> us over the years that it would be good to resolve); separately we can
> be more picky about what debug info we actually put into
> ceph-debuginfo. We have a giant ceph-tests package that mixes up both
> the test binaries and very disaster-recovery-helpful stuff like
> ceph-objectstore-tool. If we could better segregate those, we can at
> least avoid distributing them to users. (We would probably still want
> debuginfo for the ceph-tests packages because we run them in
> teuthology. But I assume just splitting it would still do some good.)
>
> Hopefully that helps other people understand some of what we're all
> dealing with. :)
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards
Kefu Chai
