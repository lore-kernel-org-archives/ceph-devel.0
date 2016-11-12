From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: A Transformation of our Global Context
Date: Fri, 11 Nov 2016 21:37:07 -0500 (EST)
Message-ID: <1571282790.39542691.1478918227666.JavaMail.zimbra@redhat.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com> <alpine.DEB.2.11.1606101716180.6221@cpach.fuggernut.com> <CADRKj5S-wzkZztQvyPMQHLCD-NqmQewbyKY65y1SyKtbjX8bzw@mail.gmail.com> <C313FA75-BCBE-49AE-A3C5-5234F2E7D4E6@quantum.com> <CADRKj5Qd5oRhS4mvZCez1y0P5TmYHga8HrKM8KNJADGRigU=cw@mail.gmail.com> <5C4C9469-AE52-4A06-9AE0-9AB1899D279A@quantum.com> <142259027.38156942.1478910832531.JavaMail.zimbra@redhat.com> <C028B72E-7944-4708-BB1E-88E342CBC0C0@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:32779 "EHLO
        mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933519AbcKLChL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2016 21:37:11 -0500
In-Reply-To: <C028B72E-7944-4708-BB1E-88E342CBC0C0@quantum.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bassam Tabbara <Bassam.Tabbara@quantum.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Sage Weil <sweil@redhat.com>, "Adam C. Emerson" <aemerson@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi Bassam,

----- Original Message -----
> From: "Bassam Tabbara" <Bassam.Tabbara@quantum.com>
> To: "Matt Benjamin" <mbenjamin@redhat.com>
> Cc: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>, "Sage Weil" <sweil@redhat.com>, "Adam C. Emerson"
> <aemerson@redhat.com>, "Gregory Farnum" <gfarnum@redhat.com>, "The Sacred Order of the Squid Cybernetic"
> <ceph-devel@vger.kernel.org>
> Sent: Friday, November 11, 2016 7:40:18 PM
> Subject: Re: A Transformation of our Global Context
> 
> > Well, I guess.  We had removed g_ceph_context, and apart from some
> > duplication,
> > it wasn't very noticeable pain.
> 
> Matt, is this work you can put back upstream? Do you have a pointer to this
> work?

Of course, it's all out in github.  The actual code isn't that interesting.  Perhaps shows
where a couple of the pitfalls were, for a subset of an older Ceph.  Adam's email starting the
original thread points up where the old change is insufficient as written.

Matt

> 
> ----------------------------------------------------------------------
> The information contained in this transmission may be confidential. Any
> disclosure, copying, or further distribution of confidential information is
> not permitted unless such privilege is explicitly granted in writing by
> Quantum. Quantum reserves the right to have electronic communications,
> including email and attachments, sent across its networks filtered through
> anti virus and spam software programs and retain such messages in order to
> comply with applicable data security and retention requirements. Quantum is
> not responsible for the proper and complete transmission of the substance of
> this communication or for any delay in its receipt.
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
