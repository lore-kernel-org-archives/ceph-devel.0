From: John Spray <john.spray@redhat.com>
Subject: Re: Tool for ceph performance analysis
Date: Tue, 24 Feb 2015 11:57:08 +0000
Message-ID: <54EC6714.3090604@redhat.com>
References: <CAONhiy7Bu1aqML80D_7Xu42qS1ZTSMwa_W3mZ+t4ivXdwE1szQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43742 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbbBXL5L (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 24 Feb 2015 06:57:11 -0500
In-Reply-To: <CAONhiy7Bu1aqML80D_7Xu42qS1ZTSMwa_W3mZ+t4ivXdwE1szQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alyona Kiselyova <akiselyova@mirantis.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "ceph-calamari@lists.ceph.com" <ceph-calamari@lists.ceph.com>

On 24/02/2015 08:40, Alyona Kiselyova wrote:
> There are similar message from Sage Weil in ceph-devel maillist some
> weeks ago. It was about perf-watch.py script, which is available from
> ceph repository, but it provides only per-node work too (and works on
> vbstart cluster, so to use it on working system some changes must be
> done).
There is now a modernized version of perf-watch in a PR: 
https://github.com/ceph/ceph/pull/3615

I posted about it to the list a little while ago but there wasn't any 
interest, so it's still hanging around in a PR (subject was "Performance 
watching (dstat-like) CLI mode")
>
> We are working now on tool, which has similar possibilities, but it
> can collect counters either from one node, or from all ceph nodes.
> Also tool provide possibility to check system resources usage by ceph
> processes.Now it uses ssh, so it doesn't work good, if you have no
> password-less access to all nodes.
Cool!  You may also be interested in the calamari branch of diamond:
https://github.com/ceph/Diamond/tree/calamari

This will grab all the perf counters and send them back to a graphite 
server that you can run whatever queries you wish to on.
> The first version of this tool is available on github
> (https://github.com/Ved-vampir/ceph-perf-tool). May be, after
> improvements, this tool will be useful for other people and it can
> appear in ceph in some way. It would be cose, if such utility will be
> in ceph "out of the box". May be, we can merge it?
There has been discussion in the past about allowing users to run 
arbitrary admin socket operations via the mon, that would at least 
remove the need for a program like yours to do its own SSHing. However, 
regular polling of 1000s of OSDs perf stats via this mechanism could 
quickly have a measurable impact on things.

The other thing that would be very nice to add into the main ceph .py 
code is the general service discovery part where we enumerate which 
services are running on a node and get their admin socket paths: 
currently this is done in both the diamond collector module and in the 
calamari salt module.
>
> It would be great, if there will be internal possibility to collect
> info about whole cluster from one node. May be, something like
> extension for "tell" command, which can call any node directly and
> replace external network connections. Or improved version of "ceph osd
> perf" command, which would allow to get more info.
>
This pretty much already exists if someone chooses to deploy 
diamond+graphite.  Perhaps we need to talk about what's wrong with that 
solution as it stands?  I'm guessing the main problem is that it's less 
highly available than ceph mons, and comparatively heavyweight, 
especially if one is only interested in the latest values.

Cheers,
John


