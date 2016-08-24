From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: assert
Date: Wed, 24 Aug 2016 13:10:00 -0400
Message-ID: <20160824170959.GC22386@ultraspiritum.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to>
 <CALe9h7f+fCv73Si_1RoF7bQsSz24cWU0f7V2_rGE-nbzMWVjLA@mail.gmail.com>
 <alpine.DEB.2.11.1606271642550.2844@piezo.us.to>
 <120706851.74131386.1472049260388.JavaMail.zimbra@redhat.com>
 <20160824154557.GA22386@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1608241621090.25681@piezo.us.to>
 <20160824162643.GB22386@ultraspiritum.eng.arb.redhat.com>
 <CADRKj5QOmD6FZukz1n_mGLz2feHaPRT0B=njhKLZXAYNGJ2J5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932286AbcHXRLI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 13:11:08 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C19781138
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 17:11:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CADRKj5QOmD6FZukz1n_mGLz2feHaPRT0B=njhKLZXAYNGJ2J5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>

On 24/08/2016, Yehuda Sadeh-Weinraub wrote:
> Will that work on any system we compile on?

Yes and no. As given it will work on GNU libc. For FreeBSD we would
need to change the name of the function we chunk in to __assert and
the order of arguments is different. So, to do it portably, we'd need
a shim for each C library we're ported to. There aren't /that/ many C
libraries in the world so it's not a difficult thing to make work, but
it is a bit fiddly.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
