From: Wido den Hollander <wido@widodh.nl>
Subject: Re: cluster status information
Date: Thu, 26 May 2011 16:54:18 +0200
Message-ID: <1306421658.2760.23.camel@wido-desktop>
References: <4DDE4531.6060703@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:55996 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab1EZOyT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2011 10:54:19 -0400
In-Reply-To: <4DDE4531.6060703@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Hi,

On Thu, 2011-05-26 at 15:18 +0300, Fyodor Ustinov wrote:
> Hi!
> 
> How to get information about status of each server in cluster?
> 
> #ceph osd stat
> 2011-05-26 15:07:05.103621 mon <- [osd,stat]
> 2011-05-26 15:07:05.104201 mon0 -> 'e413: 6 osds: 5 up, 5 in' (0)
> 
> I see - in cluster 6 osd servers and now up only 5.  How do I know which 
> server is down?

Like mentioned, this can be done with: ceph osd dump -o -

Or you can write it to a file: ceph osd dump -o osdstatus.txt

> 
> More global question - how to monitor the state of servers in a cluster?

Currently 'ceph -s' or 'ceph health' will give you the best available
information, but this is a aspect that is being worked on.

Getting more and better monitoring is on the wishlist (so I heard).

There is a issue about this in the tracker:
http://tracker.newdream.net/issues/685

Once this information is exposed via libceph, writing an application
which shows it in a nice format is trivial.

Wido

> 
> WBR,
>      Fyodor.
> 
> P.S. JFYI: key "-s" do not described in manual page about ceph command.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


