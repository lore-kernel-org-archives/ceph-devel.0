From: Florian Haas <florian@hastexo.com>
Subject: Re: Ceph Puppet modules (again)
Date: Mon, 10 Mar 2014 19:43:42 +0100
Message-ID: <CAPUexz-rw5poO5ad==6haruAnBaHORhBxwumNfeARccVy4qsWg@mail.gmail.com>
References: <CAPUexz9vuQ7Z91i8wwR1d9heuvkmTp9=q4GSRkNZaMV2M4Tz1Q@mail.gmail.com>
 <531E0411.9080002@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:48611 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbaCJSvt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Mar 2014 14:51:49 -0400
Received: by mail-qc0-f176.google.com with SMTP id m20so8100675qcx.21
        for <ceph-devel@vger.kernel.org>; Mon, 10 Mar 2014 11:51:48 -0700 (PDT)
In-Reply-To: <531E0411.9080002@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Mar 10, 2014 at 7:27 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Florian,
>
> New efforts should be directed to
>
> https://github.com/stackforge/puppet-ceph (mirrored at https://github.com/ceph/puppet-ceph) and evolving at https://review.openstack.org/#/q/status:open+project:stackforge/puppet-ceph,n,z
>
> I'm happily developing it with Andrew Woodward and David Simard and quite happy about how its future looks like. It will eventually unite all other modules and benefit from a proper integration test environment. I've been distressed far too often by the lack of integration tests when writing puppet modules. It makes all the difference in the world to me, although it's not currently popular among puppet module developers, to the point that the official tool (beaker) can't allocate a disk when creating an instance (!). I wrote a tiny tool https://pypi.python.org/pypi/gerritexec to listen to gerrit events, a simple one liner that actually runs the puppet modules for osd/mon on cuttlefish/dumpling/emperor in various situations.
>
> When working on puppet-ceph, my efforts are often directed to patching Ceph itself to make it more amicable to configuration management systems. "ceph-disk: prepare should be idempotent" is one example at http://tracker.ceph.com/issues/7475. But you will find a number of patches in Firefly oriented toward this goal. I believe this will also help reduce the complexity of the Chef, Ansible, Salt, ... playcookbooks (;-), in the same way hiding osd ids from them resolved a number of unnecessary problems for all of them (although some of them did not evolve to take advantage of it and are still overcomplex).
>
> From the point of view of someone in a hurry and no time to develop, what I'm doing it not useable at the moment. I'm under no pressure to rush anything and won't commit to any deadline ;-) However, if a developer is willing to help out, I'd be happy to spare the time to get her/him on board and speed up the process.

I'm not sure if I'm getting this correctly, but it sounds a bit like
"please send patches my way, but don't expect to get anything useable
anytime soon". That doesn't seem like a very powerful argument for
contribution, I'm sad to say.

But maybe I'm getting something wrong?

Cheers,
Florian
