From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Document and example for libceph, librbd and librados
Date: Wed, 04 May 2011 17:40:57 +0200
Message-ID: <1304523657.4036.110.camel@wido-laptop.pcextreme.nl>
References: <BANLkTinSe6i7TVY7gsncqxJQ_+p_yTz13A@mail.gmail.com>
	 <1304514803.4036.104.camel@wido-laptop.pcextreme.nl>
	 <BANLkTi=2kquZH-+SxsPy8MEGAk0nynP5mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:38070 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab1EDPlA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 11:41:00 -0400
In-Reply-To: <BANLkTi=2kquZH-+SxsPy8MEGAk0nynP5mA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tsk <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Wed, 2011-05-04 at 22:22 +0800, tsk wrote:
> 2011/5/4 Wido den Hollander <wido@widodh.nl>:
> > Hi,
> >
> > On Wed, 2011-05-04 at 20:36 +0800, tsk wrote:
> >> Hi folks,
> >>
> >>      Is there any document for libceph, librbd and librados, and where
> >> could I get some example for them?
> >
> > What kind of examples are you looking for? In the Ceph git repository
> > there is:
> >
> > * rados.cc (The rados tool)
> > * testradospp.cpp
> > * testrbdpp.cpp
> 
> Thx!
> I have run over these test code yet,  I think they are useful for me.
> 
> Hmm, Is there any simple application example for these library?

What kind of example are you looking for? I think everything you are
searching for is in the testradospp/testrbdpp files, those really show
what you can do.

Could you explain what you are trying to achieve/write?

Wido

> 
> 
> >
> > Those might give you some examples of the libraries?
> >
> > Wido
> >
> >>
> >> Thx!
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >


