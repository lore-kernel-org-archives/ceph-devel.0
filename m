From: Sage Weil <sage@inktank.com>
Subject: Re: Consistently reading/writing rados objects via command line
Date: Tue, 22 Jan 2013 09:27:02 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301220906540.4085@cobra.newdream.net>
References: <CAPud5_7tn1yEkCZSb+f7MC8_-jGFPzm+VZp6RAMBK8vaX3sArA@mail.gmail.com> <0CFBBA27610A4E35A8D340A46E009F40@inktank.com> <alpine.DEB.2.00.1301212113140.29915@cobra.newdream.net> <CAPud5_4fdrdSb9aNms1H=4HPm_YYovQQuVJgzF4APcRKWXOzqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34504 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165Ab3AVR1D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 12:27:03 -0500
In-Reply-To: <CAPud5_4fdrdSb9aNms1H=4HPm_YYovQQuVJgzF4APcRKWXOzqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Tue, 22 Jan 2013, Nick Bartos wrote:
> Assuming that the clone is atomic so that the client only ever grabbed
> a complete old or new version of the file, that method really seems
> ideal.  How much work/time would that be?
> 
> The objects will likely average around 10-20MB, but it's possible that
> in some cases they may grow to a few hundred MB.

You're in luck--my email load was mercifully light this morning.  

  713  ./rados -p data ls -
  714  ./rados put foo.tmp /etc/passwd  -p data --object-locator foo
  715  ./rados clone foo.tmp foo -p data --object-locator foo
  716  ./rados -p data ls -
  717  ./rados -p data rm foo.tmp --object-locator foo
  718  ./rados -p data ls -
  719  ./rados -p data get foo -

see wip-rados-clone.

sage


> 
> 
> On Mon, Jan 21, 2013 at 9:14 PM, Sage Weil <sage@inktank.com> wrote:
> > With a bit of additional support in the rados tool, we could write to
> > object $foo.tmp with key $foo, and then clone it into position and delete
> > the .tmp.
> >
> > If they're really big objects, though, you may also be better off with
> > radosgw, which provides striping and atomicity..
> >
> > sage
> 
> 
