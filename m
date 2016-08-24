From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: assert
Date: Wed, 24 Aug 2016 13:26:44 -0400
Message-ID: <20160824172644.GD22386@ultraspiritum.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to>
 <alpine.DEB.2.11.1606271642550.2844@piezo.us.to>
 <120706851.74131386.1472049260388.JavaMail.zimbra@redhat.com>
 <20160824154557.GA22386@ultraspiritum.eng.arb.redhat.com>
 <alpine.DEB.2.11.1608241621090.25681@piezo.us.to>
 <20160824162643.GB22386@ultraspiritum.eng.arb.redhat.com>
 <CADRKj5QOmD6FZukz1n_mGLz2feHaPRT0B=njhKLZXAYNGJ2J5A@mail.gmail.com>
 <20160824170959.GC22386@ultraspiritum.eng.arb.redhat.com>
 <549678475.74238167.1472059352713.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752054AbcHXR1s (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 13:27:48 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4835AE459
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 17:27:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <549678475.74238167.1472059352713.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>

On 24/08/2016, Matt Benjamin wrote:
> Ok, that's fair, I guess.  If a given C runtime lacks something compatible, do we then need to do for that environment exactly what we would otherwise do in general?

Maybe? I don't think there are any such. The alternative is to
open-code the error message printing and abort into the macro body and
I would be very surprised if anyone did that. So long as the macro
calls a function, we should be able to shim in an override for it.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
