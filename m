From: Samuel Just <sjust@redhat.com>
Subject: Re: c++11 merged in master
Date: Fri, 7 Aug 2015 11:36:18 -0700
Message-ID: <CAN=+7FU_D=qcj-Ku_2JbFSZA1SM-4dBGJ6qcewmu3qnLQCGNJg@mail.gmail.com>
References: <alpine.DEB.2.00.1508071041040.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33509 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946063AbbHGSgT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Aug 2015 14:36:19 -0400
Received: by igbpg9 with SMTP id pg9so37155766igb.0
        for <ceph-devel@vger.kernel.org>; Fri, 07 Aug 2015 11:36:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1508071041040.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Deza, Alfredo" <adeza@redhat.com>

lambdas and autos for everyone!
-Sam

On Fri, Aug 7, 2015 at 10:52 AM, Sage Weil <sweil@redhat.com> wrote:
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
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
