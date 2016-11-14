From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: A Transformation of our Global Context
Date: Mon, 14 Nov 2016 11:08:26 -0500
Message-ID: <20161114160826.GA13710@ultraspiritum.eng.arb.redhat.com>
References: <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com>
 <20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGaSyKN+_52-+CSKhFXsL2WE+5T_Z6egpbBNaJvGs4a-Og@mail.gmail.com>
 <alpine.DEB.2.11.1606101616210.6221@cpach.fuggernut.com>
 <20160610210433.GA16959@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1606101716180.6221@cpach.fuggernut.com>
 <CADRKj5S-wzkZztQvyPMQHLCD-NqmQewbyKY65y1SyKtbjX8bzw@mail.gmail.com>
 <C313FA75-BCBE-49AE-A3C5-5234F2E7D4E6@quantum.com>
 <CADRKj5Qd5oRhS4mvZCez1y0P5TmYHga8HrKM8KNJADGRigU=cw@mail.gmail.com>
 <BLUPR0301MB200478F7C6DC349474A0B5F8A7BB0@BLUPR0301MB2004.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752812AbcKNQJ6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 14 Nov 2016 11:09:58 -0500
Content-Disposition: inline
In-Reply-To: <BLUPR0301MB200478F7C6DC349474A0B5F8A7BB0@BLUPR0301MB2004.namprd03.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bassam Tabbara <bassamtabbara@hotmail.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 11/11/2016, Bassam Tabbara wrote:
> Yehuda, when I looked at this a few months ago, I thought there
> might be a way to make it less of an annoyance. If we can remove the
> clock_skew and figure out a way around dout/logging (i.e. make those
> process wide) then the number of classes we would need to pass the
> context to is greatly reduced. This is roughly the path we take for
> the clients (librados for example). I’ll try to prototype this over
> the next few weeks as we would love to be able to run multiple OSDs
> and MONs in the same process.

That was something like my original idea, that we coudl factor the
dout support out of CephContext and have it be a per-thread variable,
ideally set up as a fluid so we could annotate the call path. (So that
some function way down at the bottom of the call stack would log
things and still know that it was called by osd.3 or mds.5 or what
have you.)

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
