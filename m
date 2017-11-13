From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: SMART disk monitoring
Date: Mon, 13 Nov 2017 12:00:21 +0100
Message-ID: <20171113110021.374fj4y6elmofrx2@suse.com>
References: <alpine.DEB.2.11.1711101751430.2819@piezo.novalocal>
 <207642670.33700582.1510357519950.JavaMail.zimbra@redhat.com>
 <CAP6jbrTOujE+DrsgAnne16zLaXubKUZzyn_rpF5FD1ubBTycPw@mail.gmail.com>
 <20171112171653.q7dn7bw52ijltb3q@suse.com>
 <alpine.DEB.2.11.1711122003420.23234@piezo.novalocal>
 <CALe9h7eU_UiU93AUgJ4819Q2So5V=Nabjmz7ViHcJioXngknQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40353 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751986AbdKMLAg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Nov 2017 06:00:36 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4242BABEB
        for <ceph-devel@vger.kernel.org>; Mon, 13 Nov 2017 11:00:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALe9h7eU_UiU93AUgJ4819Q2So5V=Nabjmz7ViHcJioXngknQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 2017-11-13T10:46:25, John Spray <jspray@redhat.com> wrote:

> At the risk of stretching the analogy to breaking point, when we build
> something "batteries included", it doesn't mean someone can't also
> plug it into a mains power supply :-)

Plugging something designed to take 2x AAA cells into a mains power
supply is usually considered a bad idea, though ;-)

> My attitude to prometheus is that we should use it (a lot! I'm a total
> fan boy) but that it isn't an exclusive relationship: plug prometheus
> into Ceph and you get the histories of things, but without prometheus
> you should still be able to see all the latest values.

That makes sense, of course. Prometheus scrapes values from various
sources, and if it could scrape data directly off the ceph-osd
processes, why not.

> In that context, I would wonder if it would be better to initially do
> the SMART work with just latest values (for just latest vals we could
> persist these in config keys), and any history-based failure
> prediction would perhaps depend on the user having a prometheus server
> to store the history?

That isn't a bad idea, but would you really want to persist this in a
(potentially rather large) map? That'd involve relaying them to the MONs
or mgr.

Wouldn't it make more sense for something that wants to look at this
data to contact the relevant daemon? It exposing the data also in the
Prometheus exporter format would be useful (so they can directly be
ingested), of course.

This would allow a platform like kubernetes and Prometheus combined to
take care of the automatic service discovery eventually too, and would
even work well for micro-server deployments.

If going down this route though, might want to directly link SMART
libraries into ceph-osd so the daemon doesn't need to call out to
smartctl.


Regards,
    Lars

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

