From: Wido den Hollander <wido@42on.com>
Subject: Re: CodingStyle on existing code
Date: Tue, 1 Dec 2015 16:16:09 +0100
Message-ID: <565DB9B9.7030806@42on.com>
References: <565D9C37.3060903@42on.com> <565DA503.9000401@dachary.org>
 <CAJ4mKGbFz2OjLvN54sRD7Gw8VBiyvFti1ZpJZN3ZPCjU-p-uwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:53149 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbbLAPQM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Dec 2015 10:16:12 -0500
In-Reply-To: <CAJ4mKGbFz2OjLvN54sRD7Gw8VBiyvFti1ZpJZN3ZPCjU-p-uwA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 01-12-15 16:00, Gregory Farnum wrote:
> On Tue, Dec 1, 2015 at 5:47 AM, Loic Dachary <loic@dachary.org> wrote:
>>
>>
>> On 01/12/2015 14:10, Wido den Hollander wrote:
>>> Hi,
>>>
>>> While working on mon/PGMonitor.cc I see that there is a lot of
>>> inconsistency on the code.
>>>
>>> A lot of whitespaces, indentation which is not correct, well, a lot of
>>> things.
>>>
>>> Is this something we want to fix? With some scripts we can probably do
>>> this easily, but it might cause merge hell with people working on features.
>>
>> A sane (but long) way to do that is to cleanup when fixing a bug or adding a feature. With (a lot) of patience, it will eventually be better :-)
> 
> Yeah, we generally want you to follow the standards in any new code. A
> mass update of the code style on existing code makes navigating the
> history a little harder so a lot of people don't like it much, though.

Understood. But in this case I'm working in PGMonitor.cc. For just 20
lines of code I probably shouldn't refactor the whole file, should I?

> *shrug*
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
