From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: problem with ceph init scripts
Date: Wed, 16 Feb 2011 14:00:26 -0800
Message-ID: <20110216220026.GA20757@dreamer>
References: <AANLkTi=kvS=Oxou=1ZKeN+NW-0jMcYOtTQS-rzTZf2-9@mail.gmail.com>
 <AANLkTikuEbwkmaPDKiMALRvzoxGzx9a86xejzx3TjHfi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56858 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab1BPWA0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Feb 2011 17:00:26 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikuEbwkmaPDKiMALRvzoxGzx9a86xejzx3TjHfi@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Upendra Moturi <upendra.m@hexagrid.com>, sage@newdream.net, ceph-devel@vger.kernel.org, Suresh Mandava <suresh@hexagrid.com>

On Wed, Feb 16, 2011 at 01:41:44PM -0800, Colin McCabe wrote:
> It might be nice to have some kind of interface like "run command X on
> osd1", but init-ceph is not that.

For general cluster administration tasks, let me recommend tools such
as:

dsh: like "ssh HOST COMMAND" but does multiple hosts at once
http://www.netfort.gr.jp/~dancer/software/dsh.html

Fabric: remote deployment and remote command running utility
(more oriented toward scripting a solution than ad hoc)
http://fabfile.org/

Puppet, Chef, Kokki: more full-blown cluster management solutions;
based on the idea of writing recipes and running them automatically
http://www.puppetlabs.com/
http://www.opscode.com/chef/
http://samuelks.com/kokki/

-- 
:(){ :|:&};:
