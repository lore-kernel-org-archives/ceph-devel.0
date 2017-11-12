From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: SMART disk monitoring
Date: Sun, 12 Nov 2017 18:16:53 +0100
Message-ID: <20171112171653.q7dn7bw52ijltb3q@suse.com>
References: <alpine.DEB.2.11.1711101751430.2819@piezo.novalocal>
 <207642670.33700582.1510357519950.JavaMail.zimbra@redhat.com>
 <CAP6jbrTOujE+DrsgAnne16zLaXubKUZzyn_rpF5FD1ubBTycPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38267 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbdKLRQ5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 12 Nov 2017 12:16:57 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CBF1FAAAD
        for <ceph-devel@vger.kernel.org>; Sun, 12 Nov 2017 17:16:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAP6jbrTOujE+DrsgAnne16zLaXubKUZzyn_rpF5FD1ubBTycPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2017-11-10T22:36:46, Yaarit Hatuka <yaarit@gmail.com> wrote:

> Many thanks! I'm very excited to join Ceph's outstanding community!
> I'm looking forward to working on this challenging project, and I'm
> very grateful for the opportunity to be guided by Sage.

That's all excellent news!

Can we discuss though if/how this belongs into ceph-osd? Given that this
can (and is) already collected via smartmon, either via prometheus or, I
assume, collectd as well? Does this really need to be added to the OSD
code?

Would the goal be for them to report this to ceph-mgr, or expose
directly as something to be queried via, say, a prometheus exporter
binding? Or are the OSDs supposed to directly act on this information?


Regards,
    Lars

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

