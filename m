From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Puppet modules for Ceph
Date: Wed, 18 Jul 2012 15:31:20 -0700
Message-ID: <CADvuQRFcBKwjmai+W1VArbv29GHm0CBgh2PKiy5tSN6X=GDjMQ@mail.gmail.com>
References: <20120718135854.GI15546@potjevlesh.enovance.com>
 <CADvuQRG5jot8yhmWWk8cNFUF7BkoHKbyL6fCVVF6GMu_DpPy7g@mail.gmail.com>
 <CAKsDvb0Eq0amkEq=+9RrKcBv4RJ0PFwUGpzDpV8CzBHLQpMHtg@mail.gmail.com>
 <CADvuQRHt9ViPdD7B0==X-3kh-PT_NkX7+GNa9WZUb9zDSYTs0A@mail.gmail.com> <CAKsDvb2d63hDTq0LvmGL0z+yr09cNSr3ythWiqg6WVmzjxy8BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:36311 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab2GRWbl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jul 2012 18:31:41 -0400
Received: by gglu4 with SMTP id u4so2163929ggl.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jul 2012 15:31:40 -0700 (PDT)
In-Reply-To: <CAKsDvb2d63hDTq0LvmGL0z+yr09cNSr3ythWiqg6WVmzjxy8BA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Teyo Tyree <teyo@puppetlabs.com>
Cc: =?UTF-8?Q?Fran=C3=A7ois_Charlier?= <francois.charlier@enovance.com>, puppet-users@googlgroups.com, ceph-devel@vger.kernel.org, puppet-openstack@puppetlabs.com

On Wed, Jul 18, 2012 at 3:26 PM, Teyo Tyree <teyo@puppetlabs.com> wrote:
> Ha, that would be an interesting experiment indeed. I think Francois would
> like to have the Puppet module done sooner rather than later. Are the
> current Chef cookbooks functional enough for us to get started with them as
> a reference?

I think so. They Work For Me(tm). The ugly stuff is mostly things like
needing to wait a few rounds due to Chef's asynchronous data store,
and it's missing just about all internal documentation; the
user-visible aspects have a decent write-up, but nothing explains e.g.
what exactly /var/lib/ceph/bootstrap-osd/ is about.

I'd love to help you work through that though, so please keep talking
to me and make me explain everything in enough detail. It's just that
I don't have anything except source to give you right now.

The end user Chef deployment docs are at
http://ceph.com/docs/master/install/chef/
http://ceph.com/docs/master/config-cluster/chef/

The cookbook is at https://github.com/ceph/ceph-cookbooks and
currently it assumes Ubuntu 12.04.
