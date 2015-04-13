From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: loadable objectstore
Date: Mon, 13 Apr 2015 12:09:51 -0400 (EDT)
Message-ID: <1445111370.34.1428941391820.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <alpine.DEB.2.00.1504110746540.4469@cobra.newdream.net>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2163 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbbDMQJ7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Apr 2015 12:09:59 -0400
In-Reply-To: <alpine.DEB.2.00.1504110746540.4469@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Varada Kari <Varada.Kari@sandisk.com>

Seems good to me.

----- "Sage Weil" <sage@newdream.net> wrote:

> On Sat, 11 Apr 2015, Varada Kari wrote:
> > Hi Matt/ Sage,
> > 
> > Thanks for sharing the pull request. Will work on the items what
> sage 
> > was mentioning in the comments along with the items in the tracker.
> 
> I pushed a wip-plugin branch with the pattern I had in mind... does
> this 
> make sense?  It's only compile tested, and still needs preload()
> methods 
> implemented so that long-running daemons (or perhaps others?) can
> preload 
> it all at once.
> 

Matt

-- 
Matt Benjamin
CohortFS, LLC.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
