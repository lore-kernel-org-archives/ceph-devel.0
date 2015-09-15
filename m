From: Dan van der Ster <dan@vanderster.com>
Subject: Re: gitbuilder mirrors
Date: Tue, 15 Sep 2015 17:36:36 +0200
Message-ID: <CABZ+qqk1XJJCJ00tEVSwRyu9Dm-ShNBPGJUWUMYtkX8NEPq5sQ@mail.gmail.com>
References: <CABZ+qqm0JSGgYhAN6cgvb7q7O=57oG1XZhCkeDvFjHr0zpOjKg@mail.gmail.com>
 <CAJ4mKGbKbOGVrTb8Lnk6ozNp4EVb2UD+8AdVOasVKTKQAW_u+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:35821 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbbIOPhT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Sep 2015 11:37:19 -0400
Received: by lagj9 with SMTP id j9so111920713lag.2
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2015 08:37:17 -0700 (PDT)
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com. [209.85.215.41])
        by smtp.gmail.com with ESMTPSA id u3sm1604077lau.10.2015.09.15.08.37.16
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2015 08:37:16 -0700 (PDT)
Received: by lanb10 with SMTP id b10so109700263lan.3
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2015 08:37:16 -0700 (PDT)
In-Reply-To: <CAJ4mKGbKbOGVrTb8Lnk6ozNp4EVb2UD+8AdVOasVKTKQAW_u+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Sep 15, 2015 at 5:33 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Tue, Sep 15, 2015 at 1:13 AM, Dan van der Ster <dan@vanderster.com> wrote:
>> Hi,
>> Downloading from gitbuilder.ceph.com is super slow from where I'm
>> sitting (<100KB/s). Does anyone have a publicly accessible mirror?
>> Cheers, Dan
>
> I'm not aware of any...it would be pretty bandwidth intensive and
> generally users shouldn't be running off of those. Probably best to
> set up a mirror of the one branch/build you're interested in locally
> if that's necessary.

Yeah I was looking for a mirror to mirror. It took 4 hours to mirror
centos7/wip-bigbang this morning.

Cheers, Dan
