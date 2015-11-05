From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: Re: dm-clock queue
Date: Thu, 5 Nov 2015 17:19:21 -0500
Message-ID: <563BD5E9.5060905@redhat.com>
References: <alpine.DEB.2.00.1511021051450.24297@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48901 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757062AbbKEWTY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 5 Nov 2015 17:19:24 -0500
In-Reply-To: <alpine.DEB.2.00.1511021051450.24297@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, g.marripudi@ssi.samsung.com
Cc: mbenjami@redhat.com, sjust@redhat.com, ceph-devel@vger.kernel.org

Thank you, Sage. I will contact you in a separate message, Gunna, to 
better understand your efforts and interests.

Eric


On 11/04/2015 05:35 PM, Sage Weil wrote:
> Hi Gunna, Eric-
>
> I wanted to make sure you were connected as we've talked to both of you
> independently about the new request queue in the OSD to support dm-clock
> and I want to make sure our efforts are coordinated.  I thnk the first
> goal is probably to implement something that works and performs well for
> just a few request classes (clients, recovery, scrub, snaptrim).
> Eventually we'll also need to determine if/how to do so for a large client
> count so that we can do client qos.  Just solving the first problem alone
> may be a big win, though: we hear lots of complaints about the effect of
> recovery on client io.
>
> Anyway, just wanted to make sure you two were connected and kick off the
> conversation.
>
> sage
>
