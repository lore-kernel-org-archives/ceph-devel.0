From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Puppet modules for Ceph
Date: Wed, 18 Jul 2012 15:21:38 -0700
Message-ID: <CADvuQRHt9ViPdD7B0==X-3kh-PT_NkX7+GNa9WZUb9zDSYTs0A@mail.gmail.com>
References: <20120718135854.GI15546@potjevlesh.enovance.com>
 <CADvuQRG5jot8yhmWWk8cNFUF7BkoHKbyL6fCVVF6GMu_DpPy7g@mail.gmail.com> <CAKsDvb0Eq0amkEq=+9RrKcBv4RJ0PFwUGpzDpV8CzBHLQpMHtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62600 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab2GRWV7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jul 2012 18:21:59 -0400
Received: by pbbrp8 with SMTP id rp8so3256422pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jul 2012 15:21:58 -0700 (PDT)
In-Reply-To: <CAKsDvb0Eq0amkEq=+9RrKcBv4RJ0PFwUGpzDpV8CzBHLQpMHtg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Teyo Tyree <teyo@puppetlabs.com>
Cc: =?UTF-8?Q?Fran=C3=A7ois_Charlier?= <francois.charlier@enovance.com>, puppet-users@googlgroups.com, ceph-devel@vger.kernel.org, puppet-openstack@puppetlabs.com

On Wed, Jul 18, 2012 at 2:59 PM, Teyo Tyree <teyo@puppetlabs.com> wrote:
> As you probably know, Puppet Labs is based in Portland. Are you attending
> OScon? It might be a good opportunity for us to have some face to face
> hacking time on a Puppet module. Let me know if you would like for us to
> arrange sometime to get together if you are in town.

Sorry, I'm not at OScon, I'm intentionally limiting my travel right
now. A large chunk of Inktank is based in Los Angeles, so we're not
far away even outside of conferences.

Frankly, we still have a bit of cleanup work to do on the chef
cookbook side, and you'd probably be most productive writing puppet
modules once that stuff is all flushed out. Soon, we'll start to
de-emphasize mkcephfs in favor of other, more flexible, deployment
mechanisms; I think bringing together some Puppet, Juju and Chef
experts at that point would be most beneficial.
