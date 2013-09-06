From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: subdir-objects
Date: Fri, 6 Sep 2013 10:27:52 -0700
Message-ID: <CA+Hcz59qJgWY2gukY8h-=c_HXj5Dxj-UCEHrEnBXZKEckWEgJg@mail.gmail.com>
References: <CAN04cT5zbp2oe9QvcbnQ4W=7ByA1UybzPEGGWvngjLogsqFaWA@mail.gmail.com>
	<CA+Hcz5-uxiNMQiNXKfbETiQG0D6-nUrbV5oGpmMqn8oWi4DwGw@mail.gmail.com>
	<alpine.DEB.2.00.1308211340020.28981@cobra.newdream.net>
	<CAN04cT74h7QjWhOCQqc3e7HM__qaw+BrbaCy3NW_ZzC1xzX4Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:62068 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab3IFR1x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Sep 2013 13:27:53 -0400
Received: by mail-ve0-f174.google.com with SMTP id jy13so1819386veb.33
        for <ceph-devel@vger.kernel.org>; Fri, 06 Sep 2013 10:27:52 -0700 (PDT)
In-Reply-To: <CAN04cT74h7QjWhOCQqc3e7HM__qaw+BrbaCy3NW_ZzC1xzX4Kg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Roald,

Sage just pointed me at your wip-automake branch. I also just pushed
up a branch, make-refactor, that I was hacking on a bit. Not sure how
much overlap there is, or if my approach is bogus, but I thought I'd
point it out to see if there is anything that can be combined :)

-Noah

On Wed, Aug 21, 2013 at 2:01 PM, Roald van Loon <roaldvanloon@gmail.com> wrote:
> On Wed, Aug 21, 2013 at 10:41 PM, Sage Weil <sage@inktank.com> wrote:
>> Yes, the Makefile.am is in dire need of from TLC from someone who knows a
>> bit of autotools-fu.  It is only this way because in the beginning I
>> didn't know any better.
>
> Well, my average knowledge of autotools could at least fix this
> particular issue and clean up a bit more. It's a start I guess and
> helps me to continue my RGW things.
>
> I'll send out a pull request when I've found some time to implement
> and test this.
>
> Roald
