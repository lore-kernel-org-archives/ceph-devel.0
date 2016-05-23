From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: not able to run src/ceph any longer
Date: Mon, 23 May 2016 11:31:59 +0200
Message-ID: <932659d0-15b9-25c5-19ca-a847d967e9dd@digiware.nl>
References: <c6296508-10eb-f78a-f0e1-6bac2d1be6ea@digiware.nl>
 <CALe9h7d1Yt0qKZa4KtQg6c5A+wTpQf5o2YmKcG=TZ1OeDk1n0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:26227 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310AbcEWJcu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 May 2016 05:32:50 -0400
In-Reply-To: <CALe9h7d1Yt0qKZa4KtQg6c5A+wTpQf5o2YmKcG=TZ1OeDk1n0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 23-5-2016 11:15, John Spray wrote:
> On Mon, May 23, 2016 at 12:10 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> When the testscripts try to run src/ceph I get:
>>
>> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>> Traceback (most recent call last):
>>   File "src/ceph", line 118, in <module>
>>     import rados
>> ImportError: /usr/srcs/Ceph/work/ceph/src/.libs/librados.so.2: Undefined
>> symbol "g_ceph_context"
>>
>> which is in libglobal, but if I try to link that to librados I'm just
>> getting nothing but dubble definitions and errors.
>>
>> Where have things gone wrong for me?
>> How should "import rados" get the g_ceph_context?
> 
> Usually that's a symptom of a bug where something is touching global
> state somewhere it shouldn't (such as using dout instead of ldout in
> client code), and pulling in the g_ceph_context symbol where it
> shouldn't.  The symptom is that daemons build correctly but client
> libraries become un-importable.
> 
> Do you have local changes?  If not, try updating to latest master, it
> seems to be OK right now.

ehhhggg, right about the local changes. 8-D
or would that be :(

This is with my wip-freebsd tree. That has about 90 commits, and they
are just all over the place.
It started with all the rados dependent tools requiring $(CEPH_GLOBAL)
with linkage because they otherwise fail during linking.
So the Makefile*.am are in dire state anyways.

So I've probably added an include file for some reason or another to one
of the rados files. (although I ran into it after rebasing against
master) And your hint about dout versus ldout is a useful, since I did
not realize this "feature". And I've been very generous with dout calls
for debugging. Perhaps nm(1) can help me narrow down the file(s) that
get me into trouble.

The wip/pull that prepares for FreeBSD compiling
(wip-wjw-freebsd-compiling-2) does not have that problem, so it is very
likely that I've made my own mess.
Looks like it is time to start squashing/reorganizing my worktree. And
then start bisecting it. Was trying to avoid that, but keeping a clean
house is probably worth it in this case.

Thanx for the hints,
--WjW

> John
> 
>> Thanx
>> --WjW
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

