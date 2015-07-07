From: Ivo Jimenez <ivo@redhat.com>
Subject: Re: Docker task for teuthology
Date: Tue, 7 Jul 2015 15:35:49 -0400 (EDT)
Message-ID: <411240269.5493749.1436297748996.JavaMail.zimbra@redhat.com>
References: <971548538.4673346.1435793765362.JavaMail.zimbra@redhat.com> <1354525906.4673455.1435793988737.JavaMail.zimbra@redhat.com> <55953789.5090408@dachary.org>
Reply-To: Ivo Jimenez <ivo@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:53290 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933205AbbGGTgv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jul 2015 15:36:51 -0400
In-Reply-To: <55953789.5090408@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Sorry Loic, I thought I had replied to your message.
 
> I did not know about https://github.com/signalfuse/maestro-ng, sound really
> interesting ! How is it different from
> https://github.com/GoogleCloudPlatform/kubernetes or
> https://github.com/projectatomic or https://coreos.com/ ? I've no experience
> in any of them.

maestro is very lightweight compared to kubernetes. kubernetes has monitoring/dashboard features (among many others) and requires an agent to be installed alongside the docker hosts. maestro communicates directly with the docker daemon, so it doesn't require any external dependencies/configuration. Neither of the two have deployment features. maestro's codebase is much more smaller and it's written in python (vs. golang for kubernetes).

coreos and projectatomic are Linux distros that provide "just enough operating system" (JeOS) and assume that all applications run in containerized form. There are projects that combine coreos and kubernetes (plus more infra) to turn a cluster into a PaaS. Deis is an example (which uses Ceph as its storage backend).
 
> You're going in a direction I did not think about: adding a task instead of
> modifying teuthology itself. It's an interesting route and maybe better than
> the one I took which is to modify the lock/provision files, mostly, to
> create OpenStack machines instead of Downburst machines. I'm very interested
> to know if that works out. Modifying the internals of teuthology is more
> complicated and if your method works, it's likely to be simpler.

Yes, the plan is to combine ansible+maestro to make it easier to run integration tests. My goal is to make it possible to run teuthology on a laptop

> 
> I see you wrote tests which is much needed. I found that having integration
> tests is better than any kind of unit / functional testing because, in the
> end, most of teuthology work is to properly assemble and run bits and pieces
> that are external to it. In other words, without integration tests you cover
> only a fraction of the behavior even if you cover 100% of the LOC.
> 
> Cheers

thanks!
