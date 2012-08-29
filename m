From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: RBD kernel: Weird messages about "connect authorization failure"
 or "socket closed"
Date: Wed, 29 Aug 2012 17:37:43 +0200
Message-ID: <CAF6-1L6q22CWN7DrmpE5KSTPxaag4crwaTM=mBdXeyzA7N9sSg@mail.gmail.com>
References: <CAF6-1L4q5PsDjE=393oOjRZ56n-=7XjdQQu0i+1KhOeWc7KsGA@mail.gmail.com>
	<CAF6-1L7nf1+jUjSMDbP-1yhELndm1mNQiAVcsAOvMetD=hnAoQ@mail.gmail.com>
	<CAC-hyiFgPdRVWTj7=M4QQyVKz2UHQvJrV+8bVew5zNGzjSC_SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58589 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918Ab2H2Pho (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 11:37:44 -0400
Received: by vcbfk26 with SMTP id fk26so761584vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 08:37:43 -0700 (PDT)
In-Reply-To: <CAC-hyiFgPdRVWTj7=M4QQyVKz2UHQvJrV+8bVew5zNGzjSC_SQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

> Did that happen just once, or is it a reoccurring incident? What it
> basically says that the client sent a request using an old ticket. Did
> the client just wake up?

It happens every 15 / 20 min ... it varies a bit.

But what's weird is that it happens only one one OSD. Even though
there is a second OSD daemon running on the same machine ...

I also made sure all the machine are running NTP and peered to the
same server, all having the same time.

Cluster is running 0.48.1argonaut-1precise btw. Client is 3.2 / 3.6-rc3.

Cheers,

    Sylvain
