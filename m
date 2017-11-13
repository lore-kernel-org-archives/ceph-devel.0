From: Sage Weil <sage@newdream.net>
Subject: Re: SMART disk monitoring
Date: Mon, 13 Nov 2017 13:28:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711131324080.2819@piezo.novalocal>
References: <alpine.DEB.2.11.1711101751430.2819@piezo.novalocal> <207642670.33700582.1510357519950.JavaMail.zimbra@redhat.com> <CAP6jbrTOujE+DrsgAnne16zLaXubKUZzyn_rpF5FD1ubBTycPw@mail.gmail.com> <20171112171653.q7dn7bw52ijltb3q@suse.com>
 <alpine.DEB.2.11.1711122003420.23234@piezo.novalocal> <CALe9h7eU_UiU93AUgJ4819Q2So5V=Nabjmz7ViHcJioXngknQA@mail.gmail.com> <20171113110021.374fj4y6elmofrx2@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:53823 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754244AbdKMN2H (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Nov 2017 08:28:07 -0500
In-Reply-To: <20171113110021.374fj4y6elmofrx2@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 13 Nov 2017, Lars Marowsky-Bree wrote:
> On 2017-11-13T10:46:25, John Spray <jspray@redhat.com> wrote:
> 
> > At the risk of stretching the analogy to breaking point, when we build
> > something "batteries included", it doesn't mean someone can't also
> > plug it into a mains power supply :-)
> 
> Plugging something designed to take 2x AAA cells into a mains power
> supply is usually considered a bad idea, though ;-)
> 
> > My attitude to prometheus is that we should use it (a lot! I'm a total
> > fan boy) but that it isn't an exclusive relationship: plug prometheus
> > into Ceph and you get the histories of things, but without prometheus
> > you should still be able to see all the latest values.
> 
> That makes sense, of course. Prometheus scrapes values from various
> sources, and if it could scrape data directly off the ceph-osd
> processes, why not.
> 
> > In that context, I would wonder if it would be better to initially do
> > the SMART work with just latest values (for just latest vals we could
> > persist these in config keys), and any history-based failure
> > prediction would perhaps depend on the user having a prometheus server
> > to store the history?
> 
> That isn't a bad idea, but would you really want to persist this in a
> (potentially rather large) map? That'd involve relaying them to the MONs
> or mgr.
> 
> Wouldn't it make more sense for something that wants to look at this
> data to contact the relevant daemon? It exposing the data also in the
> Prometheus exporter format would be useful (so they can directly be
> ingested), of course.

The decision should about preemptive failure should be made by the mgr 
module regardless (so it can consider other factors, like cluster 
health and fullness), so if it's not getting the raw data to apply the 
model it needs to get a sufficiently meaningful metric (e.g., 
precision/recall curve or area under precisiosn-recall curve [1]).

> This would allow a platform like kubernetes and Prometheus combined to
> take care of the automatic service discovery eventually too, and would
> even work well for micro-server deployments.
> 
> If going down this route though, might want to directly link SMART
> libraries into ceph-osd so the daemon doesn't need to call out to
> smartctl.

There is a libatasmart.. it's simple and clean but it only works with ATA.  
smartmontools is much more robust and gathers health metrics for NVMe as 
well, which is I we were going down that path.

This is a pretty infrequent event, so I don't think it matters if we exec 
out to smartctl to get a JSON blob.

sage
