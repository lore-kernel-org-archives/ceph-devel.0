From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: radosgw: bad content length
Date: Fri, 30 Jan 2015 10:41:08 -0800
Message-ID: <CABBk=J8srZWJf4m=p3UEvYVimGW6vBWvq=Y-jw9Cy4pckNxciA@mail.gmail.com>
References: <loom.20150130T152219-712@post.gmane.org>
	<CABBk=J9G-pQauPiaiixmbZ6U=aLgb16i99WS5Ck0QcZ7ZcGdig@mail.gmail.com>
	<02c301d03cae$090b3590$1b21a0b0$@dunkel.de>
	<CABBk=J8ufgB-e8vMua=nk1jYrywy7VB+zNgmCJRXGysB9rJOxg@mail.gmail.com>
	<loom.20150130T180747-561@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:63339 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649AbbA3SlJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 13:41:09 -0500
Received: by mail-pa0-f43.google.com with SMTP id eu11so55423818pac.2
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 10:41:09 -0800 (PST)
In-Reply-To: <loom.20150130T180747-561@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Axel Dunkel <ad@dunkel.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Right, the we should call strict_strtoll() instead. I opened issue
#10701, and sent a pull request for the fix.

Thanks,
Yehuda

On Fri, Jan 30, 2015 at 10:01 AM, Axel Dunkel <ad@dunkel.de> wrote:
>
>  >
>> > Telling from the source code the issue seems not to be that the
> content
>> > lengths do not match, rather that the http-header Content-Length is
> not
>> > parseable (allthough the header is displayed fine in the debug
> output). If
>> > strict_strtol returns an error, to be exact - ?
>> >
>>
>> In that case the time is meaningless. How big is Content-Length when
> it fails?
>
> CONTENT_LENGTH=2147483648
> just a bit too much for a long - ?
>
> Best regards
> Axel Dunkel
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
