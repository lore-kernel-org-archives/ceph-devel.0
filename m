From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Puppet modules for Ceph
Date: Tue, 31 Jul 2012 12:09:13 -0700
Message-ID: <CADvuQREVc0gqheYSo89m7cpsdCg02EFkxFJ5LvcMrVLwBMsO7Q@mail.gmail.com>
References: <20120718135854.GI15546@potjevlesh.enovance.com>
 <CADvuQRG5jot8yhmWWk8cNFUF7BkoHKbyL6fCVVF6GMu_DpPy7g@mail.gmail.com>
 <CAKsDvb0Eq0amkEq=+9RrKcBv4RJ0PFwUGpzDpV8CzBHLQpMHtg@mail.gmail.com>
 <CADvuQRHt9ViPdD7B0==X-3kh-PT_NkX7+GNa9WZUb9zDSYTs0A@mail.gmail.com>
 <CAKsDvb2d63hDTq0LvmGL0z+yr09cNSr3ythWiqg6WVmzjxy8BA@mail.gmail.com>
 <CADvuQRFcBKwjmai+W1VArbv29GHm0CBgh2PKiy5tSN6X=GDjMQ@mail.gmail.com>
 <5391f2cc-e01f-4cf4-b6cb-b4479bd15df0@puppetlabs.com> <CADvuQRFZB6hR_KNg1rp8rCXX4BUoQmjN58rBS7sCheLmO=7hWg@mail.gmail.com>
 <alpine.DEB.2.00.1207311150140.3171@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:41969 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab2GaTJe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 15:09:34 -0400
Received: by vbbff1 with SMTP id ff1so6131316vbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jul 2012 12:09:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207311150140.3171@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: loic.dachary@enovance.com, puppet-openstack@puppetlabs.com, Teyo Tyree <teyo@puppetlabs.com>, =?UTF-8?Q?Fran=C3=A7ois_Charlier?= <francois.charlier@enovance.com>, puppet-users@googlgroups.com, ceph-devel@vger.kernel.org

On Tue, Jul 31, 2012 at 11:51 AM, Sage Weil <sage@inktank.com> wrote:
> It is also possible to feed initial keys to the monitors during the 'mkfs'
> stage.  If the keys can be agreed on somehow beforehand, then they will
> already be in place when the initial quorum is reached.  Not sure if that
> helps in this situation or not...

Yeah, we're going that way for the "mon." key in the chef cookbooks
(to get the mons talking to each other at all, that *has* to be done
that way), but putting more and more stuff there is not very nice.

Your typical CM framework does not let the recipe run arbitrary code
at that sort of an instantiation time, and pushing this work on the
admin makes it laborous and brittle; what happens when we need a new
type of a bootstrap-foo key? Get all admins to cram an extra entry
into their environment json?
http://ceph.com/docs/master/config-cluster/chef/#configure-your-ceph-environment

That just does not seem like a good way.

Juju seems to provide a real-time notification mechanism between
peers, using it's <name>-relation-changed hook. Other CM frameworks
may need to step up their game, or be subject to the "keep re-running
chef-client until it works" limitation.

If the CM makes it safe to trigger a run manually (e.g. "sudo
chef-client" whenever you feel like it), we can trigger that locally
when we finally create the keys. This still doesn't help the receiving
side to notice any faster.

If the CM makes it safe for us to change node attributes outside of
the full CM run, we can do trigger that when we finally create the
keys. Chef seems to have a "full overwrites only" semantic, so this is
probably not safe with it. And as above, this does not help the
receiving side to notice that it has information to fetch.

What I want to do longer term, is make the Chef cookbook for Ceph very
thin, push everything except the cross-node communication into Ceph
proper, and then write a "mkcephfs v2.0" that uses SSH connections as
appropriate, from a central "workstation" host that can SSH anywhere,
to trigger these actions ASAP. Then that becomes the goal for CM
frameworks: "provide me a communication mechanism between these nodes
that can do *this*".
