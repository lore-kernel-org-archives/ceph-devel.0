From: Sage Weil <sweil@redhat.com>
Subject: Re: Ask help for boost::statechart in PG
Date: Sat, 30 Aug 2014 09:14:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408300913230.966@cobra.newdream.net>
References: <CAOdVJi2e2cBOwRk8TS4Te2eZ1NO2hw26zL6M3Mq94pv60Z9vWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44201 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbaH3QOw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Aug 2014 12:14:52 -0400
In-Reply-To: <CAOdVJi2e2cBOwRk8TS4Te2eZ1NO2hw26zL6M3Mq94pv60Z9vWQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: star fan <jfanix@gmail.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

On Sat, 30 Aug 2014, star fan wrote:
> I ask the question because I am not good at  boost::statechart and I
> can't get answer from other way.
> 
> To help me to good understand the PG statechart, I hope someone answer
> below questions:
> In Initial state,
> 1.  why there is not react function for custom_reaction< NullEvt >
> 2. why there is not custom_reaction definition about
> boost::statechart::result react(const MNotifyRec&);

One thing to keep in mind is that the states form a hierarchy.  If a state 
doesn't explicitly handle/react to an event, the parent will.  You'll 
notice that Reset and Started both react to NullEvt, and the other states 
are substates/children of those.

sage
