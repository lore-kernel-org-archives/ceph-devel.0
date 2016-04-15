From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Sessions and Persistence
Date: Fri, 15 Apr 2016 18:44:26 -0400 (EDT)
Message-ID: <1264222877.12340029.1460760266271.JavaMail.zimbra@redhat.com>
References: <20160415210536.GA16458@ultraspiritum.redhat.com> <CAJ4mKGbhPrFbMKJi_hKAP1rKzjnX8GqQGMP+m7C_io-m1VDquA@mail.gmail.com> <20160415222936.GA6461@ultraspiritum.redhat.com> <CAJ4mKGaM=3i_hDGcRZRNbme616O_ARQ0Z4HBZ8qBt-nxLTg-5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:43343 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbcDOWo2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2016 18:44:28 -0400
In-Reply-To: <CAJ4mKGaM=3i_hDGcRZRNbme616O_ARQ0Z4HBZ8qBt-nxLTg-5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi,

----- Original Message -----
> From: "Gregory Farnum" <gfarnum@redhat.com>
> To: "The Sacred Order of the Squid Cybernetic" <ceph-devel@vger.kernel.org>
> Sent: Friday, April 15, 2016 6:38:39 PM
> Subject: Re: Sessions and Persistence
> 
...

> This is something I've suggested in the past, but I think it's at the
> stage where somebody needs to write code demonstrating it is something
> approaching performant. If it is, I don't think anybody opposes the
> idea;

That's reasonable.

 if it's not, then throughput/IOP regressions are not a tradeoff
> Sam/Sage are willing to make for this IIRC (and, though I am more
> optimistic than I remember them being about our odds of success, I
> suppose I'm not either).

There seems to be violent agreement about this.

Matt

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
