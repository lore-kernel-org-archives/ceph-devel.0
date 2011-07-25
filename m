From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: My favorite question
Date: Mon, 25 Jul 2011 15:55:38 -0700
Message-ID: <CAF3hT9CZZAn7+bV02TNtSunj4zDTvfwpMkDc-NyRJMXAh85hJg@mail.gmail.com>
References: <4E25646C.4000909@ufm.su>
	<Pine.LNX.4.64.1107190728370.5656@cobra.newdream.net>
	<4E2996DD.8040809@ufm.su>
	<CAF3hT9CpsEE5bnyaPiS6hv-Y+4VbwP-1uQ2CWVePXFcSKphkYA@mail.gmail.com>
	<4E2DDD1D.2040003@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:34349 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468Ab1GYWzj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jul 2011 18:55:39 -0400
Received: by yia27 with SMTP id 27so2552558yia.19
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jul 2011 15:55:38 -0700 (PDT)
In-Reply-To: <4E2DDD1D.2040003@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 25, 2011 at 2:16 PM, Fyodor Ustinov <ufm@ufm.su> wrote:
> On 07/25/2011 11:54 PM, Gregory Farnum wrote:
>>
>> Hmmm, what are you doing with this PG? Have you been doing any snapshots?
>
> I'm not use snapshot in ceph. Only as simple file system. And I'm not doing
> anything "special" or "unnatural" :)
Drat. In that case this isn't the bug we hoped/thought it was.
How old is this filesystem, what version of the code are you running
now, and do you have OSD logging?
