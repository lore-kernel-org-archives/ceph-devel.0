From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Puppet modules for Ceph
Date: Tue, 31 Jul 2012 11:48:42 -0700
Message-ID: <CADvuQRFZB6hR_KNg1rp8rCXX4BUoQmjN58rBS7sCheLmO=7hWg@mail.gmail.com>
References: <20120718135854.GI15546@potjevlesh.enovance.com>
 <CADvuQRG5jot8yhmWWk8cNFUF7BkoHKbyL6fCVVF6GMu_DpPy7g@mail.gmail.com>
 <CAKsDvb0Eq0amkEq=+9RrKcBv4RJ0PFwUGpzDpV8CzBHLQpMHtg@mail.gmail.com>
 <CADvuQRHt9ViPdD7B0==X-3kh-PT_NkX7+GNa9WZUb9zDSYTs0A@mail.gmail.com>
 <CAKsDvb2d63hDTq0LvmGL0z+yr09cNSr3ythWiqg6WVmzjxy8BA@mail.gmail.com>
 <CADvuQRFcBKwjmai+W1VArbv29GHm0CBgh2PKiy5tSN6X=GDjMQ@mail.gmail.com> <5391f2cc-e01f-4cf4-b6cb-b4479bd15df0@puppetlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:47503 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179Ab2GaStD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 14:49:03 -0400
Received: by vcbfk26 with SMTP id fk26so6176675vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jul 2012 11:49:02 -0700 (PDT)
In-Reply-To: <5391f2cc-e01f-4cf4-b6cb-b4479bd15df0@puppetlabs.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: loic.dachary@enovance.com
Cc: puppet-openstack@puppetlabs.com, Teyo Tyree <teyo@puppetlabs.com>, =?UTF-8?Q?Fran=C3=A7ois_Charlier?= <francois.charlier@enovance.com>, puppet-users@googlgroups.com, ceph-devel@vger.kernel.org

On Tue, Jul 24, 2012 at 6:15 AM,  <loic.dachary@enovance.com> wrote:
> Note that if puppet client was run on nodeB before it was run on nodeA, all
> three steps would have been run in sequence instead of being spread over two
> puppet client invocations.

Unfortunately, even that is not enough.

The relevant keys (client.admin, client.bootstrap-osd, later
bootstrap-mds radosgw etc also) can only be created once the mons have
reached quorum. This is some time after they have started, even in the
best case. Making the puppet/chef run wait for that sounds like a bad
idea; especially since I use further chef-client runs to feed ceph-mon
information about its peers, which may be necessary for it to ever
reach quorum.

While I can find ways of making the key generation happen as soon as
quorum is reached, communicating the keys to other nodes only happens
at the mercy of the configuration management system; both puppet and
chef seem to be in the mindset of "run every N minutes" option. So
even if we generate the keys best case 2 seconds after ceph-mon
startup, it needs a full configuration manager run on the source node,
and then a run on the destination node, before OSD bring-up etc can
succeed.

I have found no satisfying solution to this, so far.
