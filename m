From: Dan van der Ster <daniel.vanderster@cern.ch>
Subject: Re: XAttrs limited to 100 bytes
Date: Fri, 14 Nov 2014 16:48:43 +0100
Message-ID: <CABZ+qq=8PyiBBwwJsysoRt78br=T-2-huERV+Ju6fyZr-OBjqw@mail.gmail.com>
References: <54661092.7010804@cern.ch> <CAC6JEv84zupBwdLRQ-=ViCagTnb1szTZg7u73Ftr5sLMARTqGA@mail.gmail.com>
 <CABZ+qqnDdA_VGnKp-_O-cwPO6b7O_RsJDFBCzwnRfoMbzb0UTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:59553 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161026AbaKNPt0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 14 Nov 2014 10:49:26 -0500
Received: by mail-la0-f45.google.com with SMTP id pn19so15343109lab.18
        for <ceph-devel@vger.kernel.org>; Fri, 14 Nov 2014 07:49:23 -0800
 (PST)
In-Reply-To: <CABZ+qqnDdA_VGnKp-_O-cwPO6b7O_RsJDFBCzwnRfoMbzb0UTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>, Joaquim Rocha <joaquim.rocha@cern.ch>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Nov 14, 2014 at 4:35 PM, Dan van der Ster
<daniel.vanderster@cern.ch> wrote:
> Hi Greg,
>
> On Fri Nov 14 2014 at 4:07:41 PM Gregory Farnum <greg@gregs42.com> wrote:
>>
>> On Fri, Nov 14, 2014 at 6:24 AM, Joaquim Rocha <joaquim.rocha@cern.ch>
>> wrote:
>> > Hi folks,
>> >
>> > I found out recently that xattributes are limited to 100 chars in length
>> > so
>> > I saw the commits that introduced this change [1] but I don't understand
>> > why
>> > this is needed if we take into account that by default xattributes are
>> > going
>> > into the omap.
>> >
>> > In those changes it also prevents that limit to go over 100 even
>> > configured
>> > that way so I would like to know the reason for this limit and if there
>> > is
>> > any other way we can override it I might be missing.
>> >
>> > For my use case I will need a much larger length so I think that there
>> > should be a way to easily increase the limit (or even have a much larger
>> > value as the default).
>> >
>> > [1] https://github.com/ceph/ceph/pull/2111
>>
>> These are just setting limits on the length of the xattr *names*, not
>> the xattr contents. This is because filesystems impose limits on name
>> size and we do store xattrs in the filesystem in the default
>> configuration with most releases of Ceph (they overflow into leveldb
>> if there are too many).
>> If that's really going to be a problem for you...I don't know what to
>> say, sorry. These are close to limits you should have been following
>> already fi you want your stuff to work on e.g. ext4. :)
>
>
>
> Do you know where the limits are? This limitation was a surprise to us
> because with latest dumpling on RHEL6.6 XFS we can set and get very long
> xattr names. IOW, we cannot reproduce the truncation issue reported by
> yuyuyu in #2111. With a new object asdf we set the first xattr and it
> already overflowed into the omap.
>

Nevermind, I realized this is because we had
filestore_max_inline_xattrs = 2. With filestore_max_inline_xattrs = 5
for example, I can reproduce the truncation issue.

Cheers, Dan
