From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Building dashboard_v2
Date: Wed, 14 Feb 2018 13:15:24 -0500
Message-ID: <CAC-Np1wnmFmhebXLU3M8KwikA39E7y2G7sGdMNhOqAOsNf2Ltw@mail.gmail.com>
References: <CALe9h7fAMGtsami7ov_=yMY4EUuh2QqRmqQidikEi6dWvgEm3g@mail.gmail.com>
 <1419a76e-dc93-ab50-6c74-27efd1bcf4fe@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:44995 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161731AbeBNSP0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Feb 2018 13:15:26 -0500
Received: by mail-qt0-f181.google.com with SMTP id f18so8805892qth.11
        for <ceph-devel@vger.kernel.org>; Wed, 14 Feb 2018 10:15:25 -0800 (PST)
In-Reply-To: <1419a76e-dc93-ab50-6c74-27efd1bcf4fe@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Dias <rdias@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>

On Wed, Feb 14, 2018 at 11:34 AM, Ricardo Dias <rdias@suse.com> wrote:
> Hi,
>
> The PR https://github.com/openattic/ceph/pull/91 updates
> install-deps.sh script to install the development dependencies
> required by dashboard_v2.
>
> Since I can only test this in openSUSE based distros in a reliable way
> I ask if there are some volunteers that can test this in other distros.

Please note that the install-deps.sh script is used for building Ceph
binaries, including those for
actual releases.

Unsure what distinctions (if any) are being made to separate
"development" of the dashboard vs. "running" the dashboard (as pointed
out earlier in the thread)
>
> Thanks,
> Ricardo Dias
>
> On 13-02-2018 15:29, John Spray wrote:
>>
>> Hi folks,
>>
>> Having just built the awesome new dashboard code
>> (https://github.com/ceph/ceph/pull/20103) in my dev environment for
>> the first time, I'll share my notes...
>>
>> When building on Ubuntu 16.04, which does not have a recent enough
>> node.js for the build -- had to get one from an external source.  It
>> looks like Fedora and EPEL do have more recent ones.  Not sure if
>> there is a sufficiently trusted third party Ubuntu repo to add to
>> install_deps.sh.
>>
>> My fedora 26 machine had a sufficiently recent node/npm, so building
>> there was simpler.  Just had to install the python2-bcrypt package (in
>> addition to what is already covered in install_deps).
>>
>> The frontend build only takes 25 seconds, which I think is pretty
>> good.  The resulting dist/ dir is 18M at the moment, which is very
>> similar to the existing dashboard static files size.  I would suggest
>> we can decrease that a bit by restricting the font formats included:
>> by default we're getting eog/svg/ttf output, but we probably only need
>> WOFF.
>>
>> I didn't need a virtualenv or any pip-installed things to run the
>> dashboard in development (presumably would have needed that to run
>> unit tests on the backend python code).
>>
>> Detailed notes below.
>>
>> Cheers,
>> John
>>
>>
>>
>>
>> On Ubuntu 16.04 (aka senta04)
>> =============
>>
>> Had to symlink /usr/bin/nodejs to /usr/bin/node (one of the
>> dependencies depends on it)
>>
>> The distro comes with node 4.2.6.  The dashboard_v2 code requires node
>>>
>>> = 6.9.0 (per tmelo) -- that isn't being explicitly checked, so if
>>
>> your node is old then you just get a nasty syntax error during "npm
>> run build".
>>
>> Angular CLI depends on node >= 6.9.0 and npm >= 3 (according to its
>> README).
>>
>> Repo with a more recent node is here:
>> curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
>> This is linked from the nodejs official page, but I have no idea of
>> provenance beyond that.
>>
>> If you had already tried "npm run build" with an older node before
>> installing the newer one, do a "npm rebuild node-sass" after
>> installing the new node before trying to build dashboard frontend
>> again.
>>
>> Had to install python-bcrypt.
>>
>> Fedora 26 (aka my laptop)
>> ========
>>
>> This distro appears to come with node 6.12.
>>
>> dnf install python2-bcrypt
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
