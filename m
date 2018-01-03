From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: SMART disk monitoring
Date: Wed, 3 Jan 2018 23:44:45 +0100
Message-ID: <20180103224445.4gimkspvts73simj@suse.com>
References: <alpine.DEB.2.11.1711101751430.2819@piezo.novalocal>
 <207642670.33700582.1510357519950.JavaMail.zimbra@redhat.com>
 <CAP6jbrTOujE+DrsgAnne16zLaXubKUZzyn_rpF5FD1ubBTycPw@mail.gmail.com>
 <20171112171653.q7dn7bw52ijltb3q@suse.com>
 <alpine.DEB.2.11.1801031632370.8186@piezo.novalocal>
 <20180103203501.kvmekeaq2ya6w3u3@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbeACWoy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 3 Jan 2018 17:44:54 -0500
Content-Disposition: inline
In-Reply-To: <20180103203501.kvmekeaq2ya6w3u3@jf_suse_laptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, yaarit@gmail.com, ceph-devel@vger.kernel.org

On 2018-01-03T21:36:56, Jan Fajerski <jfajerski@suse.com> wrote:

> We do collect SMART data with the mechanism described above. We use salt to
> setup up a cronjob (though say a systemd timer would also work) that runs
> smartmon.sh > node_exporter/text_collector_dir/file.
> It does not work out of the box, but that is how the node_exporter is meant
> to be extended afaiu.

I could see this being more neatly handled by having a smarter exporter
that pulls data on-demand on scrape, and then manage the intervals
accordingly via that mechanism, but that'd be inefficient with multiple
Prometheus instances scraping (which is a common setup).

I'd prefer if we got JSON directly out of smartctl, of course. But even
ceph-osd would probably only do periodic scrapes for the above
reasons.

Unless you want ceph-osd to take direct action, I'm not sure there's a
need for it to handle this internally.

Also, how would it handle things like devices shared between OSDs, e.g.,
the WAL/journals? That's better handled via an outside scheduler.


Regards,
    Lars

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

