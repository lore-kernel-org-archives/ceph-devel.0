From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Puppet modules for Ceph
Date: Thu, 9 Aug 2012 10:04:56 -0700
Message-ID: <CADvuQRGOkwH2enFdJa_haobpVursD3Li_ZfCVyJsvmjH8y48Gw@mail.gmail.com>
References: <20120718135854.GI15546@potjevlesh.enovance.com>
 <CADvuQRG5jot8yhmWWk8cNFUF7BkoHKbyL6fCVVF6GMu_DpPy7g@mail.gmail.com>
 <CAKsDvb0Eq0amkEq=+9RrKcBv4RJ0PFwUGpzDpV8CzBHLQpMHtg@mail.gmail.com>
 <CADvuQRHt9ViPdD7B0==X-3kh-PT_NkX7+GNa9WZUb9zDSYTs0A@mail.gmail.com>
 <CAKsDvb2d63hDTq0LvmGL0z+yr09cNSr3ythWiqg6WVmzjxy8BA@mail.gmail.com>
 <CADvuQRFcBKwjmai+W1VArbv29GHm0CBgh2PKiy5tSN6X=GDjMQ@mail.gmail.com>
 <5391f2cc-e01f-4cf4-b6cb-b4479bd15df0@puppetlabs.com> <CADvuQRFZB6hR_KNg1rp8rCXX4BUoQmjN58rBS7sCheLmO=7hWg@mail.gmail.com>
 <alpine.DEB.2.00.1207311150140.3171@cobra.newdream.net> <CADvuQREVc0gqheYSo89m7cpsdCg02EFkxFJ5LvcMrVLwBMsO7Q@mail.gmail.com>
 <20120807135144.GA10072@csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:47160 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab2HIRFT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 13:05:19 -0400
Received: by vbbff1 with SMTP id ff1so175713vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Aug 2012 10:05:17 -0700 (PDT)
In-Reply-To: <20120807135144.GA10072@csail.mit.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Jonathan D. Proulx" <jon@csail.mit.edu>
Cc: Sage Weil <sage@inktank.com>, loic.dachary@enovance.com, puppet-openstack@puppetlabs.com, Teyo Tyree <teyo@puppetlabs.com>, =?UTF-8?Q?Fran=C3=A7ois_Charlier?= <francois.charlier@enovance.com>, puppet-users@googlgroups.com, ceph-devel@vger.kernel.org

On Tue, Aug 7, 2012 at 6:51 AM, Jonathan D. Proulx <jon@csail.mit.edu> wrote:
> :Juju seems to provide a real-time notification mechanism between
> :peers, using it's <name>-relation-changed hook. Other CM frameworks
> :may need to step up their game, or be subject to the "keep re-running
> :chef-client until it works" limitation.
>
> Have you lloked at "puppet kick"
>
> puppet-kick(8) -- Remotely control puppet agent

I haven't really used puppet, but that doesn't look like it's peer to
peer, the manpage talks about reading the "master's" config file. I
may be wrong in that.

The other nice thing Juju is let you transfer data between the peers
in a relationship -- e.g. we could transport the crypto secret to a
new OSD that way.
