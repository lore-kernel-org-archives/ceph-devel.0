From: Sage Weil <sage@newdream.net>
Subject: Re: c++11 merged in master
Date: Sun, 9 Aug 2015 10:38:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508091032040.22099@cobra.newdream.net>
References: <alpine.DEB.2.00.1508071041040.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56493 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933105AbbHIRix (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Aug 2015 13:38:53 -0400
In-Reply-To: <alpine.DEB.2.00.1508071041040.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: adeza@redhat.com

On Fri, 7 Aug 2015, Sage Weil wrote:
> Yay!  Thanks, Casey!
> 
> This initially breaks the precise and el6 builds on master.  I've fixed 
> the precise gitbuilders with
> 
> sudo apt-get install python-software-properties
> echo | sudo add-apt-repository ppa:ubuntu-toolchain-r/test
> sudo apt-get update
> sudo apt-get install -y g++-4.8
> /srv/autobuild-ceph/gitbuilder.git/build/install-deps.sh
> sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.6
> sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 40 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8
> echo 2 | sudo update-alternatives --config gcc
> sudo restart autobuild-ceph
> 
> We'll need to do something similar on centos6 to get g++ 4.7 or 4.8 in 
> place, and the jenkins slaves for release builds will also need to be 
> updated.
> 
> Assuming this doesn't cause problems (e.g., runtime issues on vanilla 
> precise) this will have no bearing on the previous discussion about 
> whether we continue supporting old distros for future releases.

Well, I spoke too soon.  The builds still aren't completing (the 
older boost's shared_ptr is buggy on c++11, and I'm not sure we can 
upgrade since some of it is dynamically linked).  Also, when you try to 
install packages built with gcc 4.8 (regardless of the branch), you get

2015-08-08T11:28:45.471 INFO:teuthology.orchestra.run.plana89.stdout: ceph 
: Depends: libstdc++6 (>= 4.8.1) but 4.6.3-1ubuntu5 is to be installed
2015-08-08T11:28:45.471 INFO:teuthology.orchestra.run.plana89.stdout: 
ceph-test : Depends: libstdc++6 (>= 4.8.1) but 4.6.3-1ubuntu5 is to be 
installed

...which blows.  I think we'd either need to include the 4.8 runtime 
in our repos or require users to add the appropriate APT source.  :(


At this point my vote is to drop precise and el6 entirely for infernalis 
and later.  Someone can always go build themselves and hunt down the 
proper backports but it's not worth our time.

The main downsides here are:

 - There may be precise or el6 users who want infernalis or later.  Given 
what we've seen so far I think there aren't many of these people and 
our time is better spent on other things.

 - We'll need to reimage the precise machines in the upstream QA 
lab.  This effectively means that while we will still build all the 
existing releases on precise and el6, the regression testing will be on 
trusty and centos7.  Given how few bugs we've seen over the last 
couple years that are distro-dependent, and the (un)likelihood of a new 
distro issue arising in a stable branch, I'm okay with this, but want to 
make sure others aren't concerned.  We will still use VMs running those 
distros doing the stable upgrade tests--they just won't get as much stress 
testing on bare metal.

Thoughts?
sage
