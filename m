From: Sage Weil <sage@newdream.net>
Subject: Re: output file not truncated
Date: Wed, 7 Sep 2011 21:41:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109072122580.5347@cobra.newdream.net>
References: <CANExM-M8+-i8f38vGkv2ivQkZGu5U7ba+6S5uxpRB8jOxWOkMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34950 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab1IHEgH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2011 00:36:07 -0400
In-Reply-To: <CANExM-M8+-i8f38vGkv2ivQkZGu5U7ba+6S5uxpRB8jOxWOkMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 8 Sep 2011, Henry C Chang wrote:
> Hi,
> 
> Finally got some time to play around ceph.
> I found that: when I dumped osd status by: ceph osd dump -o
> /tmp/dump.json --format=json, I got some garbage data in the end of
> file.
> Thus, I checked the code. I noticed that the output file was not
> truncated in ceph_tool_cli_input:
> 
>   // Write to a file. Don't truncate the file.
>   int fd = TEMP_FAILURE_RETRY(::open(outfile, O_WRONLY|O_CREAT|O_TRUNC, 0644));
> 
> Since it seems intended, I was wondering why. After all, in my case, I
> found it causing problems.

There was a recent change that lets you stack up commands, separated 
by ';':

 $ ceph pg stat \; osd stat

Basically we were lazy and reopened the output file inside the loop.

Just pushed a patch cleaning it up some!

sage

