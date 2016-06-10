From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: A Transformation of our Global Context
Date: Fri, 10 Jun 2016 16:15:43 -0400
Message-ID: <20160610201543.GC29233@ultraspiritum.eng.arb.redhat.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com>
 <20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGaSyKN+_52-+CSKhFXsL2WE+5T_Z6egpbBNaJvGs4a-Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36420 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932571AbcFJUQR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jun 2016 16:16:17 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B286B72083
	for <ceph-devel@vger.kernel.org>; Fri, 10 Jun 2016 20:16:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAJ4mKGaSyKN+_52-+CSKhFXsL2WE+5T_Z6egpbBNaJvGs4a-Og@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 10/06/2016, Gregory Farnum wrote:
> So you want everything to stay with/go back to having a global member
> for the ProcessContext?

Precisely. I want a ProcessContext to handle dout and the like in
libcommon (since it doesn't vary by cluster I don't think there's any
reason to restrict it to libglobal/daemon/whatever) and let everything
else be passed in.

> I'm surprised it needs to find its way into so many random things;
> most objects have references to their parent that let them go back to
> the MDSRank/OSD/whatever main class there is.

A lot of them do have a link back to the main class but a lot
don't. A lot of 'light weight' data classes in the MDS for example
don't have a link back to anything but still need g_ceph_context to
tell time or dout something. A lot of callbacks do that, too. other
places they link back but the cct is protected (which I just switched
to public in my version, but it isn't ideal.)

After having tried to do it I think having a fairly minimal (process
specific) part that's global in libcommon and the rest that Isn't
Global Anywhere is much less disruptive.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
