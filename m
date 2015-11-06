From: "Gunna (Gunneswara) Marripudi-SSI" <g.marripudi@ssi.samsung.com>
Subject: RE: dm-clock queue
Date: Fri, 6 Nov 2015 05:45:19 +0000
Message-ID: <B635C18AD584704D94E8BCDF6FB98A9B1BAEB4C6@SSIEXCH-MB3.ssi.samsung.com>
References: <alpine.DEB.2.00.1511021051450.24297@cobra.newdream.net>
 <563BD5E9.5060905@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.ssi.samsung.com ([207.140.43.206]:60495 "EHLO
	mx2.ssi.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbKFFp6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Nov 2015 00:45:58 -0500
In-Reply-To: <563BD5E9.5060905@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "J. Eric Ivancich" <ivancich@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: "mbenjami@redhat.com" <mbenjami@redhat.com>, "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage,

Thanks for the introduction.

Eric,

Glad to meet you over email. I will respond to you on a separate thread.

Regards,

Gunna

-----Original Message-----
From: J. Eric Ivancich [mailto:ivancich@redhat.com] 
Sent: Thursday, November 05, 2015 2:19 PM
To: Sage Weil; Gunna (Gunneswara) Marripudi-SSI
Cc: mbenjami@redhat.com; sjust@redhat.com; ceph-devel@vger.kernel.org
Subject: Re: dm-clock queue

Thank you, Sage. I will contact you in a separate message, Gunna, to better understand your efforts and interests.

Eric


On 11/04/2015 05:35 PM, Sage Weil wrote:
> Hi Gunna, Eric-
>
> I wanted to make sure you were connected as we've talked to both of 
> you independently about the new request queue in the OSD to support 
> dm-clock and I want to make sure our efforts are coordinated.  I thnk 
> the first goal is probably to implement something that works and 
> performs well for just a few request classes (clients, recovery, scrub, snaptrim).
> Eventually we'll also need to determine if/how to do so for a large 
> client count so that we can do client qos.  Just solving the first 
> problem alone may be a big win, though: we hear lots of complaints 
> about the effect of recovery on client io.
>
> Anyway, just wanted to make sure you two were connected and kick off 
> the conversation.
>
> sage
>
