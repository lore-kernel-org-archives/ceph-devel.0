From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: assert
Date: Wed, 24 Aug 2016 13:22:32 -0400 (EDT)
Message-ID: <549678475.74238167.1472059352713.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to> <alpine.DEB.2.11.1606271642550.2844@piezo.us.to> <120706851.74131386.1472049260388.JavaMail.zimbra@redhat.com> <20160824154557.GA22386@ultraspiritum.eng.arb.redhat.com> <alpine.DEB.2.11.1608241621090.25681@piezo.us.to> <20160824162643.GB22386@ultraspiritum.eng.arb.redhat.com> <CADRKj5QOmD6FZukz1n_mGLz2feHaPRT0B=njhKLZXAYNGJ2J5A@mail.gmail.com> <20160824170959.GC22386@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:57675 "EHLO
        mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbcHXRWd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 13:22:33 -0400
In-Reply-To: <20160824170959.GC22386@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>

Ok, that's fair, I guess.  If a given C runtime lacks something compatible, do we then need to do for that environment exactly what we would otherwise do in general?

Matt

----- Original Message -----
> From: "Adam C. Emerson" <aemerson@redhat.com>
> To: "Yehuda Sadeh-Weinraub" <ysadehwe@redhat.com>
> Cc: "Sage Weil" <sweil@redhat.com>, "Matt Benjamin" <mbenjamin@redhat.com>, "John Spray" <jspray@redhat.com>, "Ceph
> Development" <ceph-devel@vger.kernel.org>, "Mark Nelson" <mnelson@redhat.com>
> Sent: Wednesday, August 24, 2016 1:10:00 PM
> Subject: Re: assert
> 
> On 24/08/2016, Yehuda Sadeh-Weinraub wrote:
> > Will that work on any system we compile on?
> 
> Yes and no. As given it will work on GNU libc. For FreeBSD we would
> need to change the name of the function we chunk in to __assert and
> the order of arguments is different. So, to do it portably, we'd need
> a shim for each C library we're ported to. There aren't /that/ many C
> libraries in the world so it's not a difficult thing to make work, but
> it is a bit fiddly.
> 
> --
> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> IRC: Aemerson@{RedHat, OFTC, Freenode}
> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
