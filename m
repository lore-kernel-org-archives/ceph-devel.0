From: Tommi Virtanen <tv@inktank.com>
Subject: Re: host settings in ceph.conf when ipaddress != hostname
Date: Thu, 16 Aug 2012 13:22:38 -0700
Message-ID: <CADvuQRE0wK+avi0wZ_Jko+idLiShz7n8KKPn0nzTc12vMzGuUw@mail.gmail.com>
References: <CACkq2moqr-VpwLpG2xcTvUfJ4Xm0EKazis4pW_M4FLuATqOHVg@mail.gmail.com>
 <CADvuQRFZRwL4oBvJW2H25VFME3pTk4rDZxr4WzwMT=sp-K8h6g@mail.gmail.com>
 <502D51D4.5010606@smart-weblications.de> <CACkq2mqjp-bgQ1XpdB1b7ApRRV_GtKivf_D9Tj9CXO==rFg4nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:47291 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030338Ab2HPUXA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 16:23:00 -0400
Received: by lbbgj3 with SMTP id gj3so1724176lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 13:22:58 -0700 (PDT)
In-Reply-To: <CACkq2mqjp-bgQ1XpdB1b7ApRRV_GtKivf_D9Tj9CXO==rFg4nA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>, John Wilkins <john.wilkins@inktank.com>
Cc: Smart Weblications GmbH <info@smart-weblications.de>, ceph-devel@vger.kernel.org

On Thu, Aug 16, 2012 at 1:13 PM, Travis Rhoden <trhoden@gmail.com> wrote:
> Is there a link to the docs where the config file options for
> public_network, cluster_network, mon host, cluster addr are listed and
> explained?  I looked for them, but couldn't find anything. I just come
> across different mailing list entries and blog entries that keep using
> options I've never seen before.  I expected to find these options
> here: http://ceph.com/docs/master/config-cluster/ceph-conf/  but no
> luck.

Yeah those don't seem to be well documented.

The only doc mentions of the config options are in:
http://ceph.com/docs/master/ops/manage/grow/mon/
http://ceph.com/docs/master/man/8/ceph-mon/
http://ceph.com/docs/master/dev/mon-bootstrap/

> Looking at a blog post like this:
> http://www.sebastien-han.fr/blog/2012/07/29/tip-ceph-public-slash-private-network-configuration/,
> I become more confused.  Obviously I don't understand the relationship
> between OSD and MONs correctly.  If I place all my OSDs on a private
> network and the MONs on a public one, how do clients reach the OSDs?
> I didn't think that data was funneled through the MONs.  Is that
> incorrect?  I thought my OSDs had to be reachable by anyone trying to
> mount/map an RBD, for example.

That setup is used with multihomed hosts. Two network interfaces, with
often the "cluster" one being significantly faster (replication causes
write amplification). Clients talk to mons and osds via the public
network, osd<->osd traffic is on the cluster network.
