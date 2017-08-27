From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: increasingly large packages and longer build times
Date: Mon, 28 Aug 2017 08:30:55 +1000
Message-ID: <CAF-wwdH7ummeA96zovQn3hu2pyaAG=gvgyqDVDSfz=e0Ua7OHA@mail.gmail.com>
References: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
 <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com>
 <CAJ4mKGZ5eAvOTTDwAzoAjv2Ed0C3mb1E7PxQvphY85rXZy5Oow@mail.gmail.com>
 <CAJE9aON9ELevTue_DXdcYnqBVO2LbTe8mthbytegbtyfLm+K7A@mail.gmail.com>
 <71c7b782-6d7e-1e06-e889-bbbf9004ebfe@suse.cz> <CAJE9aONTxPVcyOfoXDw7ZBQrgpWEXpE29b++cct1X816LVY3+w@mail.gmail.com>
 <CAC-Np1w22udazP7Pg0PFqgRj+tEOFiRwXncQNVNigPaZpBUejQ@mail.gmail.com>
 <CAJE9aOMXRGU0L3z_LaMYgX3voDNLuvy5++W3p3Pon+Rbq7Gyug@mail.gmail.com>
 <CAC-Np1zLsgWG=PznwRtFh8tSkh8Z-xc7T+NeBYQrLQBizjiLhA@mail.gmail.com> <alpine.DEB.2.11.1708241327080.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35318 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdH0Wa6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Aug 2017 18:30:58 -0400
Received: by mail-lf0-f48.google.com with SMTP id k186so15740457lfe.2
        for <ceph-devel@vger.kernel.org>; Sun, 27 Aug 2017 15:30:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708241327080.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Alfredo Deza <adeza@redhat.com>, kefu chai <tchaikov@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Ken Dreyer <kdreyer@redhat.com>

On Thu, Aug 24, 2017 at 11:36 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 24 Aug 2017, Alfredo Deza wrote:
>> On Thu, Aug 24, 2017 at 4:41 AM, kefu chai <tchaikov@gmail.com> wrote:
>> > On Wed, Aug 23, 2017 at 2:58 AM, Alfredo Deza <adeza@redhat.com> wrote:
>> >> On Tue, Aug 22, 2017 at 9:35 AM, kefu chai <tchaikov@gmail.com> wrote:
>> >>> On Tue, Aug 22, 2017 at 4:27 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>> >>>>> my main concern would be the downstream. how shall we accommodate the
>> >>>>> packaging of downstream? for example, what if the boost package
>> >>>>> maintainers of SuSE/fedora/debian/ubuntu are not ready to package the
>> >>>>> boost version we want to use in future?
>> >>>>>
>> >>>>> but as long as we don't require newer boost to build, we are safe on
>> >>>>> debian and ubuntu at this moment. as boost 1.61 is required for
>> >>>>> building ceph, and both debian unstable and ubuntu artful package
>> >>>>> boost v1.62.
>> >>>>
>> >>>>
>> >>>> The very latest cutting-edge versions of the distros may ship boost >= 1.61
>> >>>> but the stable versions most likely do not.
>> >>>
>> >>> yeah. but, IIRC, debian stable does not accepts new packages unless
>> >>> they contain critical bug fixes. the new packages will go to the
>> >>> unstable or experimental distribution first. so, presumably, debian
>> >>> will be fine. guess ubuntu is using similar strategy for including
>> >>> packages in its LTS distros.
>> >>
>> >> Why are you concerned with distros and the availability to have a
>> >> package at the version that we need?
>> >>
>> >> We publish our own repos, where we could have whatever boost version
>> >> we need. Distro package maintainers have to
>> >> decide what they can or can't do. For us it shouldn't matter.
>> >>
>> >
>> > i think it matters. and i believe it'd be desirable if Ceph can be
>> > easier for downstream to package. if the downstream finds that Ceph is
>> > too difficult to package, and give up, that's surely not the end of
>> > the world. but it could decrease the popularity level of ceph, and in
>> > long term, it might hurt Ceph.
>>
>> I fully agree here Kefu, but we don't make it easier by embedding
>> libraries! Those need to
>> get removed in distros. Most distros will *not* allow embedding
>> dependencies like we do. That means that someone (probably
>> a package maintainer) will have to remove these, figure out what
>> versions are needed, and attempt to make it
>> work with whatever that distro version will provide.
>
> There are several categories here:
>
> Yes:
> - A bunch of stuff we embed can definitely be separated out; we embedded
> only because distros didn't have packages yet (e.g., zstd).  As soon as
> they are packages the submodules can be removed.
>
> Maybe:
> - The big one, though, is boost, which is mostly headers... only a *tiny*
> bit of code can be dynamically loaded, so there is minimal benefit to
> using the distro package... except that 'git clone' and the build are
> slightly faster. We could use a more up to date distro package, but we
> won't be able to put it in el7.  I worry that cases like this will be
> problematic: even if we build the updated package, it may be undesireable
> to require users to install a newer version on their system.

Should we ship a ceph-boost, etc. package then that does not overwrite
distro packages (installs in a different location)?

>
> No:
> - Then there is stuff that's fast-moving and new and unlikely to be
> helpful if separated out (spdk, dpdk).  The distro packages will never be
> up to date.  I'm not sure they even have any dynamically-linkable code...
> would have to check.
>
> - And then rocksdb and civetweb are truly embedded. We sometimes have to
> carry modifications so it is a bad idea to use a distro package (our
> modifications may be incompatible with other users on the system).
>
> Note that although distros complain about static linking, they have never
> actually taken a stand on the issue with Ceph.  *shrug*
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
