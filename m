From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: gitbuilder mirrors
Date: Tue, 15 Sep 2015 08:33:04 -0700
Message-ID: <CAJ4mKGbKbOGVrTb8Lnk6ozNp4EVb2UD+8AdVOasVKTKQAW_u+g@mail.gmail.com>
References: <CABZ+qqm0JSGgYhAN6cgvb7q7O=57oG1XZhCkeDvFjHr0zpOjKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:32833 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbbIOPdG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Sep 2015 11:33:06 -0400
Received: by wiclk2 with SMTP id lk2so34477901wic.0
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2015 08:33:05 -0700 (PDT)
In-Reply-To: <CABZ+qqm0JSGgYhAN6cgvb7q7O=57oG1XZhCkeDvFjHr0zpOjKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Sep 15, 2015 at 1:13 AM, Dan van der Ster <dan@vanderster.com> wrote:
> Hi,
> Downloading from gitbuilder.ceph.com is super slow from where I'm
> sitting (<100KB/s). Does anyone have a publicly accessible mirror?
> Cheers, Dan

I'm not aware of any...it would be pretty bandwidth intensive and
generally users shouldn't be running off of those. Probably best to
set up a mirror of the one branch/build you're interested in locally
if that's necessary.
-Greg
