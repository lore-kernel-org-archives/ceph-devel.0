From: Tomoki BENIYA <beniya@bit-isle.co.jp>
Subject: Re: Build error in 0.44
Date: Wed, 28 Mar 2012 15:06:41 +0900
Message-ID: <20120328145730.1FE0.33BC0F0F@bit-isle.co.jp>
References: <20120327171741.D52F.33BC0F0F@bit-isle.co.jp> <CANExM-NJ2eK-e3vHxO9pbRyS1fPPeWG8ycFxu97ugbf8TxhGaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.bit-isle.co.jp ([61.117.207.4]:37171 "EHLO
	mail.bit-isle.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab2C1GGn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Mar 2012 02:06:43 -0400
In-Reply-To: <CANExM-NJ2eK-e3vHxO9pbRyS1fPPeWG8ycFxu97ugbf8TxhGaw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: henry.cy.chang@gmail.com
Cc: ceph-devel@vger.kernel.org

I could build it!
I didn't detect news page...

Thanks!


On Wed, 28 Mar 2012 10:40:11 +0800
Henry C Chang <henry.cy.chang@gmail.com> wrote:

> I guess you need to the following submodule initialization before you
> build the debs:
> git submodule init
> git submodule update
> 
> Henry
> 
> 在 2012年3月27日下午4:43，Tomoki BENIYA <beniya@bit-isle.co.jp> 寫道：
> > Hi all
> >
> > When I build ceph 0.44, it occured error and failed to build.
> > They said following error
> > ===================================
> > make: *** [build-stamp] Error 1
> > dpkg-buildpackage: error: debian/rules build gave error exit status 2
> > ===================================
> >
> > What should I do?
> >
> >
> > # cat /etc/debian_version
> > wheezy/sid
> >
> > # uname -a
> > Linux debian7 3.1.0-1-amd64 #1 SMP Tue Jan 10 05:01:58 UTC 2012 x86_64 GNU/Linux
> >
> > # dpkg-buildpackage
> > ......
> > autoreconf: running: /usr/bin/autoheader --force
> > autoreconf: running: automake --add-missing --copy --force-missing
> > Makefile.am:182: `lib/libgtest.a' is not a standard libtool library name
> > Makefile.am:182: did you mean `lib/libgtest.la'?
> > Makefile.am:182: `lib/libgtest_main.a' is not a standard libtool library name
> > Makefile.am:182: did you mean `lib/libgtest_main.la'?
> > autoreconf: Leaving directory `.'
> > autoreconf: `configure.ac' or `configure.in' is required
> > make: *** [build-stamp] Error 1
> > dpkg-buildpackage: error: debian/rules build gave error exit status 2
> >
> >
> > --
> > Tomoki BENIYA <beniya@bit-isle.co.jp>
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at ?http://vger.kernel.org/majordomo-info.html

-- 
Tomoki BENIYA <beniya@bit-isle.co.jp>

