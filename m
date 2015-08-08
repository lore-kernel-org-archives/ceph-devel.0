From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: c++11 merged in master
Date: Sat, 8 Aug 2015 10:03:24 +1000
Message-ID: <55C5474C.6040008@redhat.com>
References: <alpine.DEB.2.00.1508071041040.22099@cobra.newdream.net>
 <CAN=+7FU_D=qcj-Ku_2JbFSZA1SM-4dBGJ6qcewmu3qnLQCGNJg@mail.gmail.com>
Reply-To: bhubbard@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55719 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946338AbbHHAD1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Aug 2015 20:03:27 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 5CE418A4BA
	for <ceph-devel@vger.kernel.org>; Sat,  8 Aug 2015 00:03:27 +0000 (UTC)
In-Reply-To: <CAN=+7FU_D=qcj-Ku_2JbFSZA1SM-4dBGJ6qcewmu3qnLQCGNJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Deza, Alfredo" <adeza@redhat.com>

On 08/08/2015 04:36 AM, Samuel Just wrote:
> lambdas and autos for everyone!

\o/

> -Sam
>
> On Fri, Aug 7, 2015 at 10:52 AM, Sage Weil <sweil@redhat.com> wrote:
>> Yay!  Thanks, Casey!
>>
>> This initially breaks the precise and el6 builds on master.  I've fixed
>> the precise gitbuilders with
>>
>> sudo apt-get install python-software-properties
>> echo | sudo add-apt-repository ppa:ubuntu-toolchain-r/test
>> sudo apt-get update
>> sudo apt-get install -y g++-4.8
>> /srv/autobuild-ceph/gitbuilder.git/build/install-deps.sh
>> sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.6
>> sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 40 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8
>> echo 2 | sudo update-alternatives --config gcc
>> sudo restart autobuild-ceph
>>
>> We'll need to do something similar on centos6 to get g++ 4.7 or 4.8 in
>> place, and the jenkins slaves for release builds will also need to be
>> updated.
>>
>> Assuming this doesn't cause problems (e.g., runtime issues on vanilla
>> precise) this will have no bearing on the previous discussion about
>> whether we continue supporting old distros for future releases.
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
