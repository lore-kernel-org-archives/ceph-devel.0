From: Justin Erenkrantz <justin@erenkrantz.com>
Subject: Re: Ceph & Cinder & HA
Date: Sun, 9 Nov 2014 16:54:30 -0500
Message-ID: <CAOGLoJMMHZ3q9VxAG0B0ge6kaVdKZ1xVZLrjAFWZUGHf6kAeew@mail.gmail.com>
References: <545B9A53.4040502@dachary.org>
	<DAB091EE-E314-40D3-99F3-710E91ECC4D2@iweb.com>
	<545C927E.9010807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:52886 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbaKIVyb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Nov 2014 16:54:31 -0500
Received: by mail-pa0-f44.google.com with SMTP id bj1so6915036pad.31
        for <ceph-devel@vger.kernel.org>; Sun, 09 Nov 2014 13:54:31 -0800 (PST)
In-Reply-To: <545C927E.9010807@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Giulio Fidente <gfidente@redhat.com>
Cc: David Moreau Simard <dmsimard@iweb.com>, Loic Dachary <loic@dachary.org>, Florian Haas <florian.haas@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Nov 7, 2014 at 4:35 AM, Giulio Fidente <gfidente@redhat.com> wrote:
> The architecture we're considering is as follows:
>
>   keepalived
>     haproxy
>       ceph-mon
>
> where haproxy and ceph-mon are always up on all openstack 'controller' nodes
> (also running cinder) and keepalived is taking care of managing a virtual ip
> hosted on one of those

For Ceph, you almost certainly don't need to use keepalived or haproxy
as all Ceph clients will fail over to the full set of monitor IPs (you
need a way of distributing those IPs to the cluster -
chef/puppet/ansible/etc/etc can handle that).  Having
keepalived/haproxy in the loop for ceph-mon is one more thing that
could break.

We do run cinder services behind the controller/headnodes nodes via
keepalived/haproxy - the "trick" such as it is for Ceph is to set all
the hostnames in cinder to being the same and it works okay.  See:

https://github.com/bloomberg/chef-bcpc/blob/master/cookbooks/bcpc/templates/default/cinder.conf.erb

We haven't seen any issues in an active/active configuration; though
there are some MySQL schema deadlocks that aren't necessarily related
to Ceph sitting in Cinder.

Cheers.  -- justin
