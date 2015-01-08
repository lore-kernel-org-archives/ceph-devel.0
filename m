From: Ken Dreyer <kdreyer@redhat.com>
Subject: new testing lab (was: Re: Testing the next giant release)
Date: Thu, 08 Jan 2015 08:50:22 -0700
Message-ID: <54AEA73E.2010504@redhat.com>
References: <54AD3C8B.4030705@dachary.org>	<CAFd2DpShjeBXQ5YPfWLVq2zsSTZDBzyZuvo40kOhzVy2fTdmCA@mail.gmail.com>	<54ADB2FA.9030204@dachary.org>	<CAJBxG-s5C6wzuJhVZhUAfNy9G1XuaDv+6D+R5c95WVWug7o4nA@mail.gmail.com>	<CAFd2DpSu5uvQKjfz=vtCMOuLYEDddfrgCNLja+LU5sC+XHWLoA@mail.gmail.com>	<54ADBB4F.40705@dachary.org> <CAJBxG-vBhwymM5e_hjF3uaen+rUP_5MRgZZ7Efa0d7E=DG2geg@mail.gmail.com> <54ADC3FB.1050201@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41455 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486AbbAHPva (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Jan 2015 10:51:30 -0500
In-Reply-To: <54ADC3FB.1050201@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/07/2015 04:40 PM, Loic Dachary wrote:
> Great, thanks, I did not know about this one :-)
> 
> On 08/01/2015 00:29, Yuri Weinstein wrote:
>> Look for them in new Octo lab - http://pulpito.ceph.redhat.com/

Not everyone in the community is going to know about the Octo lab, and
that URL is unavailable outside of Red Hat's network. I want to be
sure we're explaining this for everyone's benefit here.

In contrast to our "Sepia" lab in Irvine, the "Octo lab" is a new set
of hardware in Raleigh that we've been using in order to run some
other Teuthology tests. As part of the Inktank acquisition by Red Hat,
we've begun migrating some Teuthology tests onto this new hardware.
It's simply a matter of the current hardware's old age and the desire
to move to "something else" before we find ourselves at point where QA
is completely blocked on broken boxes or we're losing data.

A side-effect of this change is that some of our Teuthology test runs
are currently unavailable to the public. (If you've run across Ceph
Redmine tickets recently that mention hostnames like
"*.ceph.redhat.com" you'll know what I'm talking about.)

Obviously we want to make our tests as public as possible just as we
strove to do with the older public "sepia" lab in Irvine.

Sandon Van Ness has been working hard to bring up a second Raleigh lab
that will feature new Seamicro hardware and be as open to the
community as sepia is. Things are still in flux regarding the exact
hostnames, but the current plan is to refer to this lab as "typica" to
distinguish the Raleigh machines from the "sepia" machines in Irvine.

If you're interested in our test labs or other public Ceph
infrastructure, we have a public IRC channel, and it's #sepia on OFTC.
You're welcome to hang out and watch us discuss teuthology failures :)

- Ken
