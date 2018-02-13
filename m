From: Tiago Melo <tmelo@suse.com>
Subject: Re: Building dashboard_v2
Date: Tue, 13 Feb 2018 18:13:19 +0000
Message-ID: <80665ea8-df7d-3321-05a8-ac943371f878@suse.com>
References: <CALe9h7fAMGtsami7ov_=yMY4EUuh2QqRmqQidikEi6dWvgEm3g@mail.gmail.com>
 <875f7a8e-18e9-aae6-4dc3-3c590647f2e2@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:45978 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965158AbeBMSNf (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 13 Feb 2018 13:13:35 -0500
In-Reply-To: <875f7a8e-18e9-aae6-4dc3-3c590647f2e2@suse.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lenz Grimmer <lgrimmer@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>



On 02/13/2018 04:32 PM, Lenz Grimmer wrote:
> Hi John,
> 
> thanks for the feedback!
> 
> On 02/13/2018 04:29 PM, John Spray wrote:
> 
>> Having just built the awesome new dashboard code
>> (https://github.com/ceph/ceph/pull/20103) in my dev environment for
>> the first time, I'll share my notes...
>>
>> When building on Ubuntu 16.04, which does not have a recent enough
>> node.js for the build -- had to get one from an external source.  It
>> looks like Fedora and EPEL do have more recent ones.  Not sure if
>> there is a sufficiently trusted third party Ubuntu repo to add to
>> install_deps.sh.
> 
> There are some hints on how to get a recent version of Node.js installed
> on Ubuntu, using either an upstream PPA or nvm:
> 
> https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04
> 

It seems this can be overcomed by including node (v8.9.4) as a local
dependency.
By doing this the npm scripts defined on package.json will use the local
version instead of the global one.

I just tried to run 'npm run build' on a machine with node v4.8.7 and
npm v5.6.0, and it worked great.

PR: https://github.com/openattic/ceph/pull/93

> 
>> My fedora 26 machine had a sufficiently recent node/npm, so building
>> there was simpler.  Just had to install the python2-bcrypt package (in
>> addition to what is already covered in install_deps).
> 
> Good to know. Most of the developers currently working on the Dashboard
> v2 use a Docker build environment based on this:
> 
> https://github.com/ricardoasmarques/ceph-dev-docker/
> 
>> The frontend build only takes 25 seconds, which I think is pretty
>> good.  The resulting dist/ dir is 18M at the moment, which is very
>> similar to the existing dashboard static files size.  I would suggest
>> we can decrease that a bit by restricting the font formats included:
>> by default we're getting eog/svg/ttf output, but we probably only need
>> WOFF.
> 
> We'll take a look at that, to check what the "production" build will
> include.
> 
>> I didn't need a virtualenv or any pip-installed things to run the
>> dashboard in development (presumably would have needed that to run
>> unit tests on the backend python code).
>>
>> Detailed notes below.
>>
>>
>> On Ubuntu 16.04 (aka senta04)
>> =============
>>
>> Had to symlink /usr/bin/nodejs to /usr/bin/node (one of the
>> dependencies depends on it)
> 
> Yes, that's a common annoyance on Ubuntu - you can install the package
> "nodejs-legacy" to create that symlink automatically.
> 
>> The distro comes with node 4.2.6.  The dashboard_v2 code requires node
>>> = 6.9.0 (per tmelo) -- that isn't being explicitly checked, so if
>> your node is old then you just get a nasty syntax error during "npm
>> run build".
>>
>> Angular CLI depends on node >= 6.9.0 and npm >= 3 (according to its README).
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
> 
> Thanks for the notes! I'll see if I can incorporate some of that into
> the README/HACKING documents included in that directory.
> 
> Lenz
> 
