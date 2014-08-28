From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] daemons: write pid file even when told not to daemonize
Date: Thu, 28 Aug 2014 04:35:10 -0300
Message-ID: <or7g1tawy9.fsf@free.home>
References: <or4mxyuvo4.fsf@free.home> <53D9C379.9070904@dachary.org>
	<alpine.DEB.2.00.1407302129530.18917@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:59932 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872AbaH1HiW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Aug 2014 03:38:22 -0400
In-Reply-To: <alpine.DEB.2.00.1407302129530.18917@cobra.newdream.net> (Sage
	Weil's message of "Wed, 30 Jul 2014 21:30:09 -0700 (PDT)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org

On Jul 31, 2014, Sage Weil <sweil@redhat.com> wrote:

> On Thu, 31 Jul 2014, Loic Dachary wrote:
>> Hi Alexandre,
>> 
>> With this patch ceph-osd -f will try to create the default pid file : 
>> this is a non backward compatible change. Maybe there is a way for 
>> systemd to capture the pid of the process and store it instead of 
>> requiring the deamon to create the pid file ?

> Do we need the pid file at all when we aren't using sysinit?

My own monitoring scripts use it, and ceph stop use it as well.  I was
surprised we were not creating them in spite of an explicit command line
option to do so.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
