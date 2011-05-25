From: Sage Weil <sage@newdream.net>
Subject: Re: ceph and network
Date: Wed, 25 May 2011 09:04:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105250903380.29945@cobra.newdream.net>
References: <4DDB82FF.4070100@ufm.su> <BANLkTimTdB9zMKuLSz_BiSrCbyvBB42Q6Q@mail.gmail.com>
 <4DDD002B.7060902@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36761 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475Ab1EYQDY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 12:03:24 -0400
In-Reply-To: <4DDD002B.7060902@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: Brian Chrisman <brchrisman@gmail.com>, ceph-devel@vger.kernel.org

On Wed, 25 May 2011, Fyodor Ustinov wrote:
> On 05/24/2011 05:55 PM, Brian Chrisman wrote:
> > On Tue, May 24, 2011 at 3:05 AM, Fyodor Ustinov<ufm@ufm.su>  wrote:
> > > Hi!
> > > 
> > > I need to implement this scheme of servers connections:
> > > 
> > > All servers of ceph cluster have 2 network addresses in different nets.
> > > One net - for ceph interconnect. I.e. for traffic between ceph servers
> > > (Suppose called "internal").
> > > One - for traffic between clients and cluster ("external").
> > > 
> > > As I understand it - the client receives the address of the ceph servers
> > > frommon. And mon server needs to know about that it is necessary give out
> > > "external" address, not "internal".
> > > 
> > > How can I do?
> > There's a 'cluster addr' option which is intended to split the traffic
> > between multiple networks afaik.
> As Iunderstandmdsandmonserversshould livein the"public"network?

They only use the public address, if thats what you mean.  THat doesn't 
mean it has to be a public network (and it probably shouldn't be!).  It 
just means that's the address that other daemons connect to.  In contrast, 
the osd cluster addr is used only for osd to osd communication.

sage
