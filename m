From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] daemons: write pid file even when told not to daemonize
Date: Fri, 29 Aug 2014 03:41:18 -0300
Message-ID: <oriolbajch.fsf@free.home>
References: <or4mxyuvo4.fsf@free.home> <53D9C379.9070904@dachary.org>
	<alpine.DEB.2.00.1407302129530.18917@cobra.newdream.net>
	<or7g1tawy9.fsf@free.home> <53FEE3B8.4070902@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:35116 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaH2Gnm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Aug 2014 02:43:42 -0400
In-Reply-To: <53FEE3B8.4070902@dachary.org> (Loic Dachary's message of "Thu,
	28 Aug 2014 10:09:28 +0200")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

On Aug 28, 2014, Loic Dachary <loic@dachary.org> wrote:

> Changing this behavior is not backward compatible but it is indeed more intuitive. Has it been a significant inconvenience so far ?

Before I wrote the patch, it was very inconvenient: in order to stop
ceph services, I had to dig up the PIDs from ps output and then kill the
processes manually, and I had to run ceph without my monitor that
automatically restarted services that died (checking that the pid file
was absent, or that the PID it named was not a running process).

After I applied the patch in my local build, I could just forget about
the earlier problems, and none surfaced because of the creation of the
PID file.

Is this what you were asking?

> On 28/08/2014 09:35, Alexandre Oliva wrote:
>> On Jul 31, 2014, Sage Weil <sweil@redhat.com> wrote:
>> 
>>> On Thu, 31 Jul 2014, Loic Dachary wrote:
>>>> Hi Alexandre,
>>>> 
>>>> With this patch ceph-osd -f will try to create the default pid file : 
>>>> this is a non backward compatible change. Maybe there is a way for 
>>>> systemd to capture the pid of the process and store it instead of 
>>>> requiring the deamon to create the pid file ?
>> 
>>> Do we need the pid file at all when we aren't using sysinit?
>> 
>> My own monitoring scripts use it, and ceph stop use it as well.  I was
>> surprised we were not creating them in spite of an explicit command line
>> option to do so.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
