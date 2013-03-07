From: Alex Elder <elder@inktank.com>
Subject: Re: Is linux 3.8.2 up to date with all ceph patches?
Date: Thu, 07 Mar 2013 16:58:59 -0600
Message-ID: <51391BB3.3050804@inktank.com>
References: <CAPud5_53zNYsGnEs89ynWiKWjz7i9bipkwdpEoh9fMJ+uV6GbA@mail.gmail.com> <alpine.DEB.2.00.1303071323100.17054@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:54615 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab3CGW7E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Mar 2013 17:59:04 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so1305009ieb.15
        for <ceph-devel@vger.kernel.org>; Thu, 07 Mar 2013 14:59:03 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1303071323100.17054@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Nick Bartos <nick@pistoncloud.com>, ceph-devel@vger.kernel.org

On 03/07/2013 03:23 PM, Sage Weil wrote:
> On Thu, 7 Mar 2013, Nick Bartos wrote:
>> I'm looking at upgrading to 3.8.2 from 3.5.7 with patches, and I just
>> wanted to make sure that there weren't any additional ceph fixes that
>> should be applied to 3.8.2.
> 
> Nothing that I'm aware of.  Alex?

I will look, but unfortunately I'm headed out for
a concert right now so you'll have to wait until
tomorrow for an answer.

I am not aware of anything major, but there might
be one or two things we should back port.

					-Alex

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

