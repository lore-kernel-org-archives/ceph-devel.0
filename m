From: "Jonathan D. Proulx" <jon@csail.mit.edu>
Subject: Re: Puppet modules for Ceph
Date: Tue, 7 Aug 2012 09:51:44 -0400
Message-ID: <20120807135144.GA10072@csail.mit.edu>
References: <20120718135854.GI15546@potjevlesh.enovance.com>
 <CADvuQRG5jot8yhmWWk8cNFUF7BkoHKbyL6fCVVF6GMu_DpPy7g@mail.gmail.com>
 <CAKsDvb0Eq0amkEq=+9RrKcBv4RJ0PFwUGpzDpV8CzBHLQpMHtg@mail.gmail.com>
 <CADvuQRHt9ViPdD7B0==X-3kh-PT_NkX7+GNa9WZUb9zDSYTs0A@mail.gmail.com>
 <CAKsDvb2d63hDTq0LvmGL0z+yr09cNSr3ythWiqg6WVmzjxy8BA@mail.gmail.com>
 <CADvuQRFcBKwjmai+W1VArbv29GHm0CBgh2PKiy5tSN6X=GDjMQ@mail.gmail.com>
 <5391f2cc-e01f-4cf4-b6cb-b4479bd15df0@puppetlabs.com>
 <CADvuQRFZB6hR_KNg1rp8rCXX4BUoQmjN58rBS7sCheLmO=7hWg@mail.gmail.com>
 <alpine.DEB.2.00.1207311150140.3171@cobra.newdream.net>
 <CADvuQREVc0gqheYSo89m7cpsdCg02EFkxFJ5LvcMrVLwBMsO7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from outgoing.csail.mit.edu ([128.30.2.149]:48471 "EHLO
	outgoing.csail.mit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996Ab2HGOAW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 10:00:22 -0400
Content-Disposition: inline
In-Reply-To: <CADvuQREVc0gqheYSo89m7cpsdCg02EFkxFJ5LvcMrVLwBMsO7Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Sage Weil <sage@inktank.com>, loic.dachary@enovance.com, puppet-openstack@puppetlabs.com, Teyo Tyree <teyo@puppetlabs.com>, =?iso-8859-1?Q?Fran=E7ois?= Charlier <francois.charlier@enovance.com>, puppet-users@googlgroups.com, ceph-devel@vger.kernel.org

On Tue, Jul 31, 2012 at 12:09:13PM -0700, Tommi Virtanen wrote:

:Juju seems to provide a real-time notification mechanism between
:peers, using it's <name>-relation-changed hook. Other CM frameworks
:may need to step up their game, or be subject to the "keep re-running
:chef-client until it works" limitation.

Have you lloked at "puppet kick"

puppet-kick(8) -- Remotely control puppet agent
========

SYNOPSIS
--------
Trigger a puppet agent run on a set of hosts.

I'm not using it in my environment and it does require some specific
puppet config on the agent side to make it work so less than ideal,
but might atleast provide a path.

-Jon


