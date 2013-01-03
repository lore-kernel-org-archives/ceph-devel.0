From: Alex Elder <elder@inktank.com>
Subject: Re: kernel rbd format=2
Date: Thu, 03 Jan 2013 12:06:49 -0600
Message-ID: <50E5C8B9.8000201@inktank.com>
References: <20121218001054.GA17186@onthe.net.au> <CAPYLRzjAzyfbZyQdtmevdq1V0hW=ARV0ZH9JXy09z58bAU3Tiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50430 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604Ab3ACSGx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 13:06:53 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so18394198ieb.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 10:06:52 -0800 (PST)
In-Reply-To: <CAPYLRzjAzyfbZyQdtmevdq1V0hW=ARV0ZH9JXy09z58bAU3Tiw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Chris Dunlop <chris@onthe.net.au>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/03/2013 11:12 AM, Gregory Farnum wrote:
> Alex has been doing a lot of work to support this lately, but I don't
> think he's sketched out the actual implementation timeline yet.
> -Greg
> 
> On Mon, Dec 17, 2012 at 4:10 PM, Chris Dunlop <chris@onthe.net.au> wrote:
>> Hi,
>>
>> Format 2 images (and attendant layering support) are not yet
>> supported by the kernel rbd client, according to:
>>
>> http://ceph.com/docs/master/rbd/rbd-snapshot/#layering
>>
>> When might this support be available?

You should have received a response to this earlier; sorry about that.

The basic support for format 2 images is in place, but the layering
functionality still needs some work.  We are targeting the next kernel
merge cycle, meaning it will be supported in Linux 3.9 if all goes
according to plan.

					-Alex

>> Cheers,
>>
>> Chris
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

