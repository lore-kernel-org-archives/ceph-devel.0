From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Ceph code coverage integration proposal
Date: Thu, 02 Jun 2011 14:32:40 -0700
Message-ID: <4DE80178.5050305@dreamhost.com>
References: <20110602180508.GC11721@dreamer> <4DE7FC06.9020704@dreamhost.com> <20110602211801.GD11721@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51540 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396Ab1FBVcl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 17:32:41 -0400
In-Reply-To: <20110602211801.GD11721@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 06/02/2011 02:18 PM, Tommi Virtanen wrote:
> On Thu, Jun 02, 2011 at 02:09:26PM -0700, Josh Durgin wrote:
>> On 06/02/2011 11:05 AM, Tommi Virtanen wrote:
>> <snip>
>>> Proposal:
>>>
>>> - add autoconf flag --enable-coverage, or some such (afaik Josh has
>>>    this already), that compiles with coverage recording
>>
>> This is in the wip_gcov branch as --with-gcov.
>
> Sweet.
>
> BTW, I know this has been going on for a while, but autoconf wasn't
> meant to be used like that.. --with-foo is supposed to be about
> external libraries and such, --enable-foo is supposed to be about
> features. So --with-debug should have been --enable-debug. I didn't
> change that the last time I was working on autoconf, because I wanted
> to limit the size of the crater I was creating, but for new stuff we
> probably should do it the "right way".

Good to know - I'll rename it --enable-coverage.
