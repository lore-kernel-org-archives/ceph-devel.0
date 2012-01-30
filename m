From: Sage Weil <sage@newdream.net>
Subject: Re: Installing_on_RedHat_or_CentOS
Date: Mon, 30 Jan 2012 09:35:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201300933400.23054@cobra.newdream.net>
References: <4F26BB5A.5060103@cirrhus9.com>
 <CAF3hT9DvvJ8PNQ3bXyZTt-FhHfA1GZ8bncm-HmZs9OX5=97aBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44785 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab2A3RfP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jan 2012 12:35:15 -0500
In-Reply-To: <CAF3hT9DvvJ8PNQ3bXyZTt-FhHfA1GZ8bncm-HmZs9OX5=97aBA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: JJ <jjones@cirrhus9.com>, ceph-devel@vger.kernel.org

On Mon, 30 Jan 2012, Gregory Farnum wrote:
> On Mon, Jan 30, 2012 at 7:46 AM, JJ <jjones@cirrhus9.com> wrote:
> > Is 64bit architecture a requirement?
> Nope!
> > Is fuse* a requirement? (modprobe fuse doesn't issue any warnings)
> Nope! Although you will have an easier time with the FUSE client than
> the kernel client on a CentOS machine.

Side note: Unfortunately, 64-bit is currently a requirement for ceph-fuse.  
The fuse api is ino based, and client/fuse_ll.cc doesn't do anything to 
cram the 64-bit ceph inos into 32 bits.

sage
