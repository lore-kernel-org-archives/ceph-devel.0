From: Hugh Saunders <hugh@wherenow.org>
Subject: Re: teuthology consumability
Date: Fri, 8 Nov 2013 15:19:10 +0800
Message-ID: <2A6E3DA2-2468-477C-B848-AAC90F99B19F@wherenow.org>
References: <alpine.DEB.2.00.1311070711080.17943@cobra.newdream.net> <527BB190.2010302@dachary.org> <alpine.DEB.2.00.1311071700410.17943@cobra.newdream.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34269 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab3KHHZF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Nov 2013 02:25:05 -0500
Received: by mail-pa0-f45.google.com with SMTP id kp14so1808872pab.4
        for <ceph-devel@vger.kernel.org>; Thu, 07 Nov 2013 23:25:04 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1311071700410.17943@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 8 Nov 2013, at 09:08, "Sage Weil" <sage@inktank.com> wrote:
> 
>> On Thu, 7 Nov 2013, Loic Dachary wrote:
>> 
>> Hi Sage,
>> 
>>> On 07/11/2013 23:21, Sage Weil wrote:
>>> Hey all,
>>> 
>>> I've had a couple different conversations with week with organizations 
>>> that want to ramp up their ceph development efforts, as a big piece of 
>>> that, spin up their own teuthology environments.  There has been a lot 
>>> going on here, and I haven't been on the weekly calls, but I suspect 
>>> things that will help them move forward include:
>>> 
>>> - documenting a teuthology install-from-scratch.  this would include 
>>> setting up the databases, lock server, workers, etc., and will initially 
>>> be long and ugly but will hopefully shrink over time.
>>> 
>>> - adding support for euca2ools or some other cloud client that does 
>>> openstack and ec2 for creating/destroying test machines.  hopefully most 
>>> of the integration points are mapped out from the downburst integration 
>>> work.
>> 
>> I'm including Hugh Saunders on this thread : we discussed this topic 
>> during the OpenStack summit this week in relation to the associated 
>> ticket:
>> 
>> http://tracker.ceph.com/issues/6502
> 
> Great.  I would love to see someone sign up for this for the firefly cycle 
> (and write up a quick blueprint).  :)

Hi, I should have some time to look into teuthology next week. Haven't used it before so will take a while before I can contribute. However notes from setup as a new user should be helpful for docs. 

After that can look at supporting openstack for test instances.

--
Hugh Saunders
