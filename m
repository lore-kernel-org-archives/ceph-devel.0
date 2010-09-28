From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Usage of rbd
Date: Tue, 28 Sep 2010 21:48:32 +0200
Message-ID: <1285703312.3394.4.camel@wido-laptop.pcextreme.nl>
References: <AANLkTikUMZiGmjF9xPhn-9UiknrnQWLLrMgFEFU83PF7@mail.gmail.com>
	 <AANLkTi=mftr=1=KG18nBpKHycGO24QPvLT6FJvFjyh3w@mail.gmail.com>
	 <AANLkTi=b6AEiP2_tV32b9rHgkyNeMNgwu7ipTB8vt=df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:52618 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756088Ab0I1Tsf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Sep 2010 15:48:35 -0400
In-Reply-To: <AANLkTi=b6AEiP2_tV32b9rHgkyNeMNgwu7ipTB8vt=df@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Takuya ASADA <syuu@dokukino.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

Hi,

I've added some instructions to the Wiki:
http://ceph.newdream.net/wiki/Rbd#Loading_RBD

Wido

On Wed, 2010-09-29 at 04:19 +0900, Takuya ASADA wrote:
> > The rbd class is loaded but not activated. You can run 'ceph class
> > activate rbd 1.2', it should fix it (note that it takes a minute to
> > propagate).
> 
> Oh I see.
> I think we need to add this instruction to the wiki.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

