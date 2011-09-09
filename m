From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [RFC] rados perl bindings
Date: Thu, 8 Sep 2011 17:34:48 -0700
Message-ID: <CAF3hT9AGd_TNjxsa0w4iXA_h3Fr-ngb0oBBsECfuivGhhUbKwg@mail.gmail.com>
References: <CALFpzo6ioZYdY3cu2LhaKtywvQPt25-cOCmc2kbpW8f_2_ktHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:51901 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821Ab1IIAet convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2011 20:34:49 -0400
Received: by pzk37 with SMTP id 37so1871726pzk.1
        for <ceph-devel@vger.kernel.org>; Thu, 08 Sep 2011 17:34:48 -0700 (PDT)
In-Reply-To: <CALFpzo6ioZYdY3cu2LhaKtywvQPt25-cOCmc2kbpW8f_2_ktHw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

[Resend due to vger failing earlier]
I guess it's safe to say that nobody's concerned about this. :)
I'm with you that RADOS bindings shouldn't live under Filesys, so
unless anybody thinks that libceph is going to get Perl bindings as
well, and that that would need to go under Filesys (I don't know what
the namespace rules are), you should go for it! :)
-Greg

On Thu, Sep 1, 2011 at 8:22 PM, Marcus Sorensen <shadowsor@gmail.com> w=
rote:
> As mentioned earlier, I'm working on gluing perl onto the back of
> librados (or at least giving it a good duct-taping). As part of
> registering the namespace for the module in CPAN, I just need to get
> some feedback and show that others involved with Ceph development are
> aware and are ok with the namespace being used. =A0I was going to try=
 to
> register "Ceph::RADOS", not quite sure if it would fit under
> "Filesys::Ceph::RADOS" as it's not really anything to do with
> manipulating the filesystem per se, and did not see any other root
> namespaces that would be an obvious fit. Let me know what you think.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
