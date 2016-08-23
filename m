From: Alfredo Deza <adeza@redhat.com>
Subject: Re: should we remove autotools from master?
Date: Tue, 23 Aug 2016 14:08:33 -0400
Message-ID: <CAC-Np1x2wxuZ0X6V8PfZjbwpApeYnZXpY_Ad1JdMjt6zDQ2atg@mail.gmail.com>
References: <alpine.DEB.2.11.1608231356290.25681@piezo.us.to>
 <57BC5B7A.8050103@dachary.org> <DB5PR05MB16077097293BBD4CBF85D90EA9EB0@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <alpine.DEB.2.11.1608231517060.25681@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38158 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754114AbcHWSIf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2016 14:08:35 -0400
Received: by mail-wm0-f49.google.com with SMTP id o80so206759641wme.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 11:08:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608231517060.25681@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Avner Ben Hanoch <avnerb@mellanox.com>, Loic Dachary <loic@dachary.org>, Nathan Cutler <ncutler@suse.cz>, Brad Hubbard <bhubbard@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Adir Lev <adirl@mellanox.com>

On Tue, Aug 23, 2016 at 11:21 AM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 23 Aug 2016, Avner Ben Hanoch wrote:
>> For removing autotools support, I think that we should first announce
>> that autotools will not be supported starting <some-future-day> and till
>> then support both of them in parallel and response to questions about
>> it.
>
> I think we're basically proposing some-future-day as now.
>
>> Also, we first need to make sure that we have comprehensive instructions
>> for using cmake. Notice, that many developers are not familiar with
>> cmake; hence, there might be need for extra explanations.
>>
>> For example, I tried now the instructions in https://github.com/ceph/ceph/blob/master/README.md
>>       ./do_cmake.sh
>>       cd build
>>       make
>> and I got the error:
>>       make: *** No targets specified and no makefile found.  Stop.
>>
>> Probably, because of the explanation "This assumes you make your build
>> dir a subdirectory of the ceph.git checkout. If you put it elsewhere,
>> just replace .. above with a correct path to the checkout." However, if
>> you are not familiar with cmake, then this explanation does not tell you
>> how to recover from the error.
>
> The do_cmake.sh script is doing 'mkdir build', so assuming you actually
> ran it from the git checkout (i.e., ./do_cmake.sh) then this should be the
> case.  Is that actually what caused the error?
>
> I agree that step 0 is to make README.md complete for cmake.  Perhaps
> step 1 is to remove autotools instructions too.
>
>> Also, I am not sure it is clear to all developers how to combine above
>> instructions with options that you could provide to ./configure script.
>
> There is no more ./configure :).  There are a new set of options you can
> pass cmake that are referenced here in README.md:
>
>         https://github.com/ceph/ceph/blob/master/README.md#cmake-options
>
>> Hence, I think removing autotools support should not be immediate
>
> Please help us identify any (other) documentation gaps so we can get past
> this.  I thought README.md was in good shape...

Nothing in there helped when trying to build binaries in the CI
scripts. I had to look at
https://github.com/ceph/autobuild-ceph/blob/master/build-ceph-rpm.sh#L56-L58
to try to make it work.

Of course, this might not help anyone else, since it might not be
common to run `make-dist` ?

>
> sage
>
>
>> Avner
>>
>> > -----Original Message-----
>> > From: Loic Dachary
>> >
>> >
>> > On 23/08/2016 15:58, Sage Weil wrote:
>> > > Should we remove the autotools stuff from master?
>> > >
>> > > Yes:
>> > > - It won't be maintained
>> > > - It sucks
>> > > - It confuses people and they use it by mistake
>> > > - We'll find any build scripts etc that haven't been converted sooner
>> > > rather than later
>> > >
>> > > No:
>> > > - Other architectures might rely on it
>> > > - It's possible some build scripts haven't been convert yet
>> > >
>> > > I'm thinking yes?
>> >
>> > I vote yes. The build scripts I know about are either converted or broken
>> > because autotools no longer works :-)
>> >

Yes from me too. We do have the build scripts kind of messed up
already for master in Jenkins:

https://github.com/ceph/ceph-build/commit/40b94af494dbb07440bf90f5b6695ecf2839b392

We still need to support both because we still need to cut releases
for branches that do not support it though.

>> > Cheers
>> >
>> > > sage
>> > >
>> > >
>> > > On Tue, 23 Aug 2016, Nathan Cutler wrote:
>> > >
>> > >>> That's a different make-deb(s).sh
>> > >>
>> > >> Allow me to qualify that statement. This thread seems to be about
>> > >>
>> > >> https://github.com/ceph/ceph/blob/master/make-debs.sh
>> > >>
>> > >> while the "make-deb.sh" I am working on is
>> > >>
>> > >> https://github.com/ceph/ceph-qa-suite/blob/master/tasks/buildpackages
>> > >> /make-deb.sh
>> > >>
>> > >> which is used with the teuthology-openstack backend. However, I see
>> > >> the two scripts are similar.
>> > >>
>> > >> In general, although the autotools stuff is still there in master, it
>> > >> is not maintained and should not be expected to work (or continue to
>> > >> work). All build infrastructure targeting master should be converted to
>> > cmake.
>> > >>
>> > >> Nathan
>> > >> --
>> > >> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> > >> in the body of a message to majordomo@vger.kernel.org More majordomo
>> > >> info at  http://vger.kernel.org/majordomo-info.html
>> > >>
>> > >>
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> > > in the body of a message to majordomo@vger.kernel.org More majordomo
>> > > info at  http://vger.kernel.org/majordomo-info.html
>> > >
>> >
>> > --
>> > Loïc Dachary, Artisan Logiciel Libre
>>
>>
