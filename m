From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: CodingStyle on existing code
Date: Tue, 1 Dec 2015 07:00:39 -0800
Message-ID: <CAJ4mKGbFz2OjLvN54sRD7Gw8VBiyvFti1ZpJZN3ZPCjU-p-uwA@mail.gmail.com>
References: <565D9C37.3060903@42on.com>
	<565DA503.9000401@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37806 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626AbbLAPAl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Dec 2015 10:00:41 -0500
Received: by wmww144 with SMTP id w144so16981198wmw.0
        for <ceph-devel@vger.kernel.org>; Tue, 01 Dec 2015 07:00:40 -0800 (PST)
In-Reply-To: <565DA503.9000401@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Wido den Hollander <wido@42on.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Dec 1, 2015 at 5:47 AM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 01/12/2015 14:10, Wido den Hollander wrote:
>> Hi,
>>
>> While working on mon/PGMonitor.cc I see that there is a lot of
>> inconsistency on the code.
>>
>> A lot of whitespaces, indentation which is not correct, well, a lot of
>> things.
>>
>> Is this something we want to fix? With some scripts we can probably do
>> this easily, but it might cause merge hell with people working on features.
>
> A sane (but long) way to do that is to cleanup when fixing a bug or adding a feature. With (a lot) of patience, it will eventually be better :-)

Yeah, we generally want you to follow the standards in any new code. A
mass update of the code style on existing code makes navigating the
history a little harder so a lot of people don't like it much, though.
*shrug*
-Greg
