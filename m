From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Nightly "Kernel branch not found" errors
Date: Mon, 1 Jun 2015 15:56:04 +0300
Message-ID: <CAOi1vP895PURL9ZugUfHaRqUiBXPooAVx-hJAGqBab+7q6c=JQ@mail.gmail.com>
References: <CAC6JEv_oJzokLL-QvJ6VTNC43kSp9s4Vf=cY47Ug+Gqy0BBApw@mail.gmail.com>
	<CAOi1vP-63Qya7JQcPhr62a5ffufaYSd9WwqLY-hMFYs7MmHS8g@mail.gmail.com>
	<CAC6JEv8CCThYLNa73ufOo7C8U42fVPTaW8r6CNOQxXHx_04=qg@mail.gmail.com>
	<alpine.DEB.2.00.1505311518340.6462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33962 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbbFAM4F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jun 2015 08:56:05 -0400
Received: by wibut5 with SMTP id ut5so37644961wib.1
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jun 2015 05:56:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1505311518340.6462@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <greg@gregs42.com>, Zack Cerza <zack@redhat.com>, Andrew Schoen <aschoen@redhat.com>, ceph-qa <ceph-qa@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jun 1, 2015 at 1:19 AM, Sage Weil <sage@newdream.net> wrote:
> On Sun, 31 May 2015, Gregory Farnum wrote:
>> On Sun, May 31, 2015 at 1:40 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>> > On Sun, May 31, 2015 at 10:54 PM, Gregory Farnum <greg@gregs42.com> wrote:
>> >> We are getting this error in what looks like everything that specifies
>> >> the testing kernel. (That turns out to be almost all of the FS tests
>> >> and a surprising number of the non-rados runs; e.g. rgw.) I've checked
>> >> that the testing branch of ceph-client.git still exists and when
>> >> looking at the teuthology git logs the recent ping-pong of commits on
>> >> kernel flavors et al stand out. Any ideas? :)
>> >
>> > Which lab is this in?  Latest rgw and fs in sepia look fine.
>> >
>> > Kernel task was broken the entire last week but in a different way -
>> > when scheduled with teuthology-suite it wouldn't install anything even
>> > if you told it to install e.g. testing.  I fixed that on Friday.
>> >
>> > Looks like this is coming from create_initial_config().  Could be an
>> > environment issue, like down gitbuilders or a problem with requests
>> > module?  Kernel branch is checked before the others so it may not have
>> > anything to do with it at all.
>>
>> It's happening across labs for tests that were supposed to be
>> scheduled starting on the 29 (at least, that I've noticed). I think
>> this issue is before they get into pulpito, which is why the latest fs
>> suite run there was scheduled on May 27. :(
>> Looking at the gitbuliders I do see that the CentOS6 testing branch is
>> red and rhel7 appears to be down...maybe we're checking on more of
>> them now and then failing when those don't appear? :/
>
> We're half-way through creating the centos7 kernel builder to replace the
> rhel ones so I expect things are broken on the rpm side.  Not sure if
> that is the root cause here, but we can probably wait for that to get
> fixed first before looking further

I think it's definitely related to this.  commit f2ce5e1ed3d4 ("Treat
RHEL as CentOS when scheduling") by Zack makes it so centos7
gitbuilders are poked in case distro wasn't specified explicitly, which
is how I assume all those runs are scheduled.  kernel centos6
gitbuilder is down and AFAICT the centos7 one doesn't exist.

Thanks,

                Ilya
