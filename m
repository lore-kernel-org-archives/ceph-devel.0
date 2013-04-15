From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: ceph and efficient access of distributed resources
Date: Mon, 15 Apr 2013 15:38:32 -0700
Message-ID: <516C8168.40402@inktank.com>
References: <loom.20130412T055215-88@post.gmane.org> <51683184.9010301@inktank.com> <CAJH6TXgurT4yUshaH4QOgUKOaB3DqQd1-=HPshp+eH5HB7p3Hg@mail.gmail.com> <516C7E55.1050801@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:60897 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932513Ab3DOWie (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 18:38:34 -0400
Received: by mail-pb0-f48.google.com with SMTP id xb4so2739013pbc.21
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 15:38:34 -0700 (PDT)
In-Reply-To: <516C7E55.1050801@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Matthias Urlichs <matthias@urlichs.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

If I correctly understand the discussion, you are correct
that I/O could be saved by doing this ... were it not for
the fact the I/O in question is already being saved much
more effectively by someone else.

The entire web is richly festooned with cache servers whose
sole raison d'etre is to solve precisely this problem.  They
are so good at it that back-bone providers often find it more
cash-efficient to buy more cache servers than to lay more
fiber.  Cache servers don't merely save disk I/O, they catch
these requests before they reach the server (or even the
backbone).

> On 04/15/2013 01:06 PM, Gandalf Corvotempesta wrote:
>>
>>> Currently reads always come from the primary OSD in the placement group
>>> rather than a secondary even if the secondary is closer to the client.
>>>
>>
>> In this way, only one OSD will be involved in reading an object, this
>> will
>> result in a bottleneck if multiple clients needs to access to the same
>> file.
>>
>> For example, a 3KB CSS file served by a webserver to 400 users, will be
>> read just from one OSD. 400 users directed to 1 OSD  while (in case of
>> replica 3) other 2 OSDs are available?
