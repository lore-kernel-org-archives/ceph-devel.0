From: Sage Weil <sage@newdream.net>
Subject: Re: SMART disk monitoring
Date: Sun, 12 Nov 2017 20:16:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711122003420.23234@piezo.novalocal>
References: <alpine.DEB.2.11.1711101751430.2819@piezo.novalocal> <207642670.33700582.1510357519950.JavaMail.zimbra@redhat.com> <CAP6jbrTOujE+DrsgAnne16zLaXubKUZzyn_rpF5FD1ubBTycPw@mail.gmail.com> <20171112171653.q7dn7bw52ijltb3q@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:43207 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdKLUQm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Nov 2017 15:16:42 -0500
In-Reply-To: <20171112171653.q7dn7bw52ijltb3q@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: ceph-devel@vger.kernel.org

On Sun, 12 Nov 2017, Lars Marowsky-Bree wrote:
> On 2017-11-10T22:36:46, Yaarit Hatuka <yaarit@gmail.com> wrote:
> 
> > Many thanks! I'm very excited to join Ceph's outstanding community!
> > I'm looking forward to working on this challenging project, and I'm
> > very grateful for the opportunity to be guided by Sage.
> 
> That's all excellent news!
> 
> Can we discuss though if/how this belongs into ceph-osd? Given that this
> can (and is) already collected via smartmon, either via prometheus or, I
> assume, collectd as well? Does this really need to be added to the OSD
> code?
> 
> Would the goal be for them to report this to ceph-mgr, or expose
> directly as something to be queried via, say, a prometheus exporter
> binding? Or are the OSDs supposed to directly act on this information?

The OSD is just a convenient channel, but needn't be the only 
one or only option.

Part 1 of the project is to get JSON output out of smartctl so we avoid 
one of the many crufty projects floating around to parse its weird output; 
that'll be helpful all consumers, presumably.

Part 2 is to map OSDs to host:device pairs; that merged already.

Part 3 is to gather the actual data.  The prototype has the OSD polling 
this because it (1) knows which devices it consumes and (2) is present on 
every node.  We're contemplating a per-host ceph-volume-agent for 
assisting with OSD (de)provisioning (i.e., running ceph-volume); that 
could be an option.  Of if some other tool is already scraping it and can 
be queried, that would work too.

I think the OSD will end up being a necessary path (perhaps among many), 
though, because when we are using SPDK I don't think we'll be able to get 
the SMART data via smartctl (or any other tool) at all because the OSD 
process will be running the NVMe driver.

Part 4 is to archive the results.  The original thought was to dump it 
into RADOS.  I hadn't considered prometheus, but that might be a better 
fit!  I'm generally pretty cautious about introducing dependencies like 
this but we're already expecting prometheus to be used for other metrics 
for the dashboard.  I'm not sure whether prometheus' query interface lends 
itself to the failure models, though...

Part 5 is to do some basic failure prediction!

sage
