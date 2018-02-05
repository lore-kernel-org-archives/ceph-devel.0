From: Andrew Schoen <aschoen@redhat.com>
Subject: Re: Better anticipation for minor releases
Date: Mon, 5 Feb 2018 09:28:02 -0600
Message-ID: <CAEPMp+4mVJd6155ZykTUmrgupLAvoLFEPUTBLVY26Hk+anXogA@mail.gmail.com>
References: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com>
 <4173fd50ca3d6d4e4f691f116b425397@suse.com> <CAC-Np1xbgABOgjDoYpPrDUvX7hOn3U-AD-YF-LpRsbjAfEPi6g@mail.gmail.com>
 <bfc90180-334b-519b-cf2c-db13b33abff2@suse.cz> <CALqRxCzxBuihz6FTtFq4oROmgstnh79uB8F-iosameNo4+7SOQ@mail.gmail.com>
 <robbat2-20180202T195241-795645967Z@orbis-terrarum.net> <b0e75bc4-e7da-db16-ddb3-bb70df281699@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:42129 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeBEP2o (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Feb 2018 10:28:44 -0500
Received: by mail-qk0-f175.google.com with SMTP id f68so12718966qke.9
        for <ceph-devel@vger.kernel.org>; Mon, 05 Feb 2018 07:28:43 -0800 (PST)
In-Reply-To: <b0e75bc4-e7da-db16-ddb3-bb70df281699@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, Ken Dreyer <kdreyer@redhat.com>, Alfredo Deza <adeza@redhat.com>, Abhishek <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>
>> Thought:
>> - Tag or branch a candidate commit for going INTO the QE phase, say
>>    v12.2.3-rcX.
>> - Run QE on that tag.
>> - If QE passes entirely, create final tag at same commit as rc tag.
>
>
> That assumes it's possible the release tooling supports releasing something
> other than the tip of a branch (i.e. a SHA1 or tag), though, right?

I'm pretty sure we have support to build from a tag. The build system
might need a few tweaks, but I think it'd be doable and worth the
effort.

Andrew
