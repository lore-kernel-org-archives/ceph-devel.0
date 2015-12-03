From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: CodingStyle on existing code
Date: Thu, 3 Dec 2015 11:12:32 +0000
Message-ID: <566023A0.6070506@suse.de>
References: <565D9C37.3060903@42on.com> <565DA503.9000401@dachary.org>
 <CAJ4mKGbFz2OjLvN54sRD7Gw8VBiyvFti1ZpJZN3ZPCjU-p-uwA@mail.gmail.com>
 <565DB9B9.7030806@42on.com>
 <alpine.DEB.2.00.1512010717380.19170@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43401 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759769AbbLCLMf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 06:12:35 -0500
In-Reply-To: <alpine.DEB.2.00.1512010717380.19170@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Wido den Hollander <wido@42on.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/01/2015 03:18 PM, Sage Weil wrote:
> On Tue, 1 Dec 2015, Wido den Hollander wrote:
>>
>> On 01-12-15 16:00, Gregory Farnum wrote:
>>> On Tue, Dec 1, 2015 at 5:47 AM, Loic Dachary <loic@dachary.org> wrote:
>>>>
>>>>
>>>> On 01/12/2015 14:10, Wido den Hollander wrote:
>>>>> Hi,
>>>>>
>>>>> While working on mon/PGMonitor.cc I see that there is a lot of
>>>>> inconsistency on the code.
>>>>>
>>>>> A lot of whitespaces, indentation which is not correct, well, a lot of
>>>>> things.
>>>>>
>>>>> Is this something we want to fix? With some scripts we can probably do
>>>>> this easily, but it might cause merge hell with people working on features.
>>>>
>>>> A sane (but long) way to do that is to cleanup when fixing a bug or adding a feature. With (a lot) of patience, it will eventually be better :-)
>>>
>>> Yeah, we generally want you to follow the standards in any new code. A
>>> mass update of the code style on existing code makes navigating the
>>> history a little harder so a lot of people don't like it much, though.
>>
>> Understood. But in this case I'm working in PGMonitor.cc. For just 20
>> lines of code I probably shouldn't refactor the whole file, should I?

While it annoys me finding a given commit in history that just changes
every single line to fix styling, I also recognize that this is the sort
of janitorial task that may be warranted for certain files.

As sage mentions below, this is a low-traffic file. And whenever it's
changed, is often just tiny bits here and there. That tends to add to
the style divergence rather than to convergence.

I'd say go for it. If you are indeed changing those 20 or so lines
though, please add those lines on a separate patch from the style changes.

  -Joao

> 
> Easiest thing is to fix the code around your change.
> 
> I'm also open to a wholesale cleanup since it's a low-traffic file and 
> likely won't conflict with other stuff in flight.  But, up to you!
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

