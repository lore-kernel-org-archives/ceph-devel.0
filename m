From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 21:42:45 -0500
Message-ID: <53323EA5.6010506@ieee.org>
References: <1395736765.2823.29.camel@localhost>	 <1395767705.9967.5.camel@localhost>		 <5331C05D.1060008@ieee.org> <1395773582.2076.10.camel@localhost>		 <5331D2E8.6060002@ieee.org>		 <CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>		 <1395778894.2076.12.camel@localhost> <1395780835.2076.15.camel@localhost>		 <1395781847.2076.21.camel@localhost>		 <CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>		 <1395782577.2076.23.camel@localhost>		 <CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>		 <1395783675.2076.26.camel@localhost>		 <CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>		 <1395784476.2076.28.camel@localhost> <1395785839.2076.30.camel@localhost>		 <5332075F.8080105@ieee.org> <1395788695.2076.35.camel@localhos
 t>		 <53321896.1080606@ieee.org> <1395797596.2076.43.camel@localhost>	 <1395798658.2076.45.camel@localhost> <5332339A.8030000@ieee.org> <1395801625.2076.52.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:42677 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209AbaCZCm0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 22:42:26 -0400
Received: by mail-qa0-f44.google.com with SMTP id f11so1594252qae.17
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 19:42:25 -0700 (PDT)
In-Reply-To: <1395801625.2076.52.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 03/25/2014 09:40 PM, Olivier Bonvalet wrote:
> Thanks again to took time to analyze that problem.
> 
> All my RBD images have daily snapshots, can this bug be related to
> snapshots ?
> 
> Maybe it's a stupid question, but is there a workaround that I could use
> to reduce that problem in production, until a proper fix is found ?

I don't believe this has anything to do with snapshots.

And I wish I knew a workaround, but unfortunately I
don't know of one.  Once I understand the problem (I'm
getting close) I might have one, but at that point I'll
probably have a fix.

I'll try to find a fix as soon as I can.

					-Alex

PS  I thought you said you were going to stop for the night!

