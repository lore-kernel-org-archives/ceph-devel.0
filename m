From: Sage Weil <sage@inktank.com>
Subject: Re: OSD daemon changes port no
Date: Tue, 20 Nov 2012 08:45:39 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211200844240.7369@cobra.newdream.net>
References: <CAGfy=6kVyt-a+j8mKYqXYVErRWEUK8ko1ydJuBxY5dr849OD0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45456 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab2KTQpl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 11:45:41 -0500
In-Reply-To: <CAGfy=6kVyt-a+j8mKYqXYVErRWEUK8ko1ydJuBxY5dr849OD0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 20 Nov 2012, hemant surale wrote:
> Hi Community,
>    I have question about port number used by ceph-osd daemon . I
> observed traffic (inter -osd communication while data ingest happened)
> on port 6802 and then after some time when I ingested second file
> after some delay port no 6804 was used . Is there any specific reason
> to change port no here?

The ports are dynamic.  Daemons bind to a random (6800-6900) port on 
startup and communicate on that.  They discover each other via the 
addresses published in the osdmap when the daemon starts.

>    and one more thing how can it be possible to read from one osd and
> then simultaneous write to direct on other osd with less/no traffic?

I'm not sure I understand the question...

sage
