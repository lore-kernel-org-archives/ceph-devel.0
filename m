From: Sage Weil <sage@inktank.com>
Subject: Re: Puppet modules for Ceph
Date: Tue, 31 Jul 2012 11:51:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207311150140.3171@cobra.newdream.net>
References: <20120718135854.GI15546@potjevlesh.enovance.com> <CADvuQRG5jot8yhmWWk8cNFUF7BkoHKbyL6fCVVF6GMu_DpPy7g@mail.gmail.com> <CAKsDvb0Eq0amkEq=+9RrKcBv4RJ0PFwUGpzDpV8CzBHLQpMHtg@mail.gmail.com> <CADvuQRHt9ViPdD7B0==X-3kh-PT_NkX7+GNa9WZUb9zDSYTs0A@mail.gmail.com>
 <CAKsDvb2d63hDTq0LvmGL0z+yr09cNSr3ythWiqg6WVmzjxy8BA@mail.gmail.com> <CADvuQRFcBKwjmai+W1VArbv29GHm0CBgh2PKiy5tSN6X=GDjMQ@mail.gmail.com> <5391f2cc-e01f-4cf4-b6cb-b4479bd15df0@puppetlabs.com>
 <CADvuQRFZB6hR_KNg1rp8rCXX4BUoQmjN58rBS7sCheLmO=7hWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54094 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756306Ab2GaSvb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 14:51:31 -0400
In-Reply-To: <CADvuQRFZB6hR_KNg1rp8rCXX4BUoQmjN58rBS7sCheLmO=7hWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: loic.dachary@enovance.com, puppet-openstack@puppetlabs.com, Teyo Tyree <teyo@puppetlabs.com>, =?ISO-8859-15?Q?Fran=E7ois_Charlier?= <francois.charlier@enovance.com>, puppet-users@googlgroups.com, ceph-devel@vger.kernel.org

On Tue, 31 Jul 2012, Tommi Virtanen wrote:
> On Tue, Jul 24, 2012 at 6:15 AM,  <loic.dachary@enovance.com> wrote:
> > Note that if puppet client was run on nodeB before it was run on nodeA, all
> > three steps would have been run in sequence instead of being spread over two
> > puppet client invocations.
> 
> Unfortunately, even that is not enough.
> 
> The relevant keys (client.admin, client.bootstrap-osd, later
> bootstrap-mds radosgw etc also) can only be created once the mons have
> reached quorum. This is some time after they have started, even in the
> best case. Making the puppet/chef run wait for that sounds like a bad
> idea; especially since I use further chef-client runs to feed ceph-mon
> information about its peers, which may be necessary for it to ever
> reach quorum.
> 
> While I can find ways of making the key generation happen as soon as
> quorum is reached, communicating the keys to other nodes only happens
> at the mercy of the configuration management system; both puppet and
> chef seem to be in the mindset of "run every N minutes" option. So
> even if we generate the keys best case 2 seconds after ceph-mon
> startup, it needs a full configuration manager run on the source node,
> and then a run on the destination node, before OSD bring-up etc can
> succeed.
> 
> I have found no satisfying solution to this, so far.

It is also possible to feed initial keys to the monitors during the 'mkfs' 
stage.  If the keys can be agreed on somehow beforehand, then they will 
already be in place when the initial quorum is reached.  Not sure if that 
helps in this situation or not...

sage
