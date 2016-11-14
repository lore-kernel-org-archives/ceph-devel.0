From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: A Transformation of our Global Context
Date: Mon, 14 Nov 2016 11:10:15 -0500
Message-ID: <20161114161015.GB13710@ultraspiritum.eng.arb.redhat.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1606101616210.6221@cpach.fuggernut.com>
 <20160610210433.GA16959@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1606101716180.6221@cpach.fuggernut.com>
 <CADRKj5S-wzkZztQvyPMQHLCD-NqmQewbyKY65y1SyKtbjX8bzw@mail.gmail.com>
 <C313FA75-BCBE-49AE-A3C5-5234F2E7D4E6@quantum.com>
 <CADRKj5Qd5oRhS4mvZCez1y0P5TmYHga8HrKM8KNJADGRigU=cw@mail.gmail.com>
 <5C4C9469-AE52-4A06-9AE0-9AB1899D279A@quantum.com>
 <142259027.38156942.1478910832531.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933192AbcKNQLr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 14 Nov 2016 11:11:47 -0500
Content-Disposition: inline
In-Reply-To: <142259027.38156942.1478910832531.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Bassam Tabbara <Bassam.Tabbara@quantum.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 11/11/2016, Matt Benjamin wrote:
> Well, I guess.  We had removed g_ceph_context, and apart from some duplication,
> it wasn't very noticeable pain.

The difference there was that I felt more free to throw out the most
painful cases of dout.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
