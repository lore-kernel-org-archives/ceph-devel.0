From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 15:44:12 -0500
Message-ID: <5331EA9C.90004@ieee.org>
References: <1395736765.2823.29.camel@localhost>		 <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>		 <53316D18.7040103@ieee.org>		 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>		 <53317BC2.9010700@ieee.org>		 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>		 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>		 <5331853D.40408@ieee.org> <1395767705.9967.5.camel@localhost>		 <5331C05D.1060008@ieee.org> <1395773582.2076.10.camel@localhost>		 <5331D2E8.6060002@ieee.org>		 <CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>	 <1395778894.2076.12.camel@localhost> <5331E608.40206@ieee.org> <1395779358.2076.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:40405 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487AbaCYUny (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 16:43:54 -0400
Received: by mail-vc0-f169.google.com with SMTP id ik5so1295193vcb.14
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 13:43:53 -0700 (PDT)
In-Reply-To: <1395779358.2076.14.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

Olivier, it appears this is a layered image, i.e., the image
is a clone of another.  Can you tell us any more about the
way these images are organized?  Do you have one master image
and others are based on that?  Is there more than one layer to
the organization?  (Do these questions make sense?)

					-Alex
