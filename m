From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: How to create new empty journal?
Date: Thu, 09 Jun 2011 23:07:45 +0300
Message-ID: <4DF12811.6000100@ufm.su>
References: <4DEFF804.9010606@ufm.su>	<1307614145.2906.2.camel@wido-desktop>	<4DF09E18.5090006@ufm.su> <BANLkTime2c04mvMy0uB7EV3=bFwGLJ=3hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:60301 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755289Ab1FIUHt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Jun 2011 16:07:49 -0400
In-Reply-To: <BANLkTime2c04mvMy0uB7EV3=bFwGLJ=3hA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On 06/09/2011 08:13 PM, Gregory Farnum wrote:
> For all of these use cases you're going to want to flush the journal
> to permanent store to make sure you don't lose any data.
> 1) Shut down the cosd.
> 2) Start it up again with the --flush-journal argument.
> It will run in the foreground and flush out any data in the journal.
> You're all set and can do whatever you want!
> -Greg
Thanx!

WBR,
     Fyodor.
