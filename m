From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: assert
Date: Wed, 24 Aug 2016 11:45:57 -0400
Message-ID: <20160824154557.GA22386@ultraspiritum.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to>
 <CALe9h7f+fCv73Si_1RoF7bQsSz24cWU0f7V2_rGE-nbzMWVjLA@mail.gmail.com>
 <alpine.DEB.2.11.1606271642550.2844@piezo.us.to>
 <120706851.74131386.1472049260388.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754353AbcHXP4k (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 11:56:40 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD236C04D2B0
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 15:47:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <120706851.74131386.1472049260388.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>

On 24/08/2016, Matt Benjamin wrote:
> Mark Nelson called attention to this topic again yesterday in #ceph-devel.
>
> We favor retaining the ability to re-declare specific asserts such that they are, as with assert in general historically, compiled out.  I think it's reasonable if this is a marked case.
>
> That seems to imply that if ceph_assert is the unmarked case, it won't be compiled out, so is essentially ceph_assert_always, as below (or else that form should be used...it's a little long).

If we want to go for brevity, we could have ceph_assert() be the
unmarked case that functions just like assert macro.

Then we could use something like ceph_demand() (ceph_ultimatum?
ceph_blackmail?) to indicate the case that isn't compiled out.

Personally, I would just like to get rid of Ceph's assert.h and its
unending war with every other header file in the world. At one point
killed off the header and linked in an object that overrode
__assert_fail. This worked very well, though it would require handling
every C library implementation we're compiled against.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
