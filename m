From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: ceph + -lssl
Date: Fri, 26 Feb 2016 12:43:24 -0800
Message-ID: <CADRKj5Shu=S4aHX+bz-yw8zuXgGPWE2YE_au5x1HYExwer6HTw@mail.gmail.com>
References: <20160224050912.GA6585@degu.b.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35472 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818AbcBZUnZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Feb 2016 15:43:25 -0500
Received: by mail-vk0-f54.google.com with SMTP id e6so88002522vkh.2
        for <ceph-devel@vger.kernel.org>; Fri, 26 Feb 2016 12:43:24 -0800 (PST)
In-Reply-To: <20160224050912.GA6585@degu.b.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Watts <mwatts@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I rebased these 4 commits on top of a recent master, and here's the
new pull request:

https://github.com/ceph/ceph/pull/7825

On Tue, Feb 23, 2016 at 9:09 PM, Marcus Watts <mwatts@redhat.com> wrote:
> I've been working on better integrating ssl int ceph.
> Currently, I have a branch, "wip-openssl" which I've pushed to
> github, which builds using gitbuilder, also builds with cmake.
> I haven't done much testing with this, so there may be some other
> business (with certs and such) to make this actually useful.
>
> commits to make this build:
> 1/ ba8bfab15255d4b321f200a617bc2e0335676482
>         automake: -lssl
> 2/ 5188536a6e42d9207d45dadc86700546ac12b1a2
>         cmake: ssl + crypto
> 3/ 96fe7c5745584158aa69223e3b2482fc9dcfc8fe
>         automake: -lssl -lcrypto (not just -lssl)
> 4/ a23e063a7db4780f120a2199db55ce5ae816b829
>         git: used fixed version of civetweb.
>         fixes a warning.
>
> There are some additional commits in wip-openssl to support
> build "out of tree".  I'll post a separate message about that.
>
>                                         -Marcus Watts
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
