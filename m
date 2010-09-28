From: Takuya ASADA <syuu@dokukino.com>
Subject: Re: Usage of rbd
Date: Wed, 29 Sep 2010 04:19:25 +0900
Message-ID: <AANLkTi=b6AEiP2_tV32b9rHgkyNeMNgwu7ipTB8vt=df@mail.gmail.com>
References: <AANLkTikUMZiGmjF9xPhn-9UiknrnQWLLrMgFEFU83PF7@mail.gmail.com> <AANLkTi=mftr=1=KG18nBpKHycGO24QPvLT6FJvFjyh3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44699 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab0I1TTr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Sep 2010 15:19:47 -0400
Received: by wyb28 with SMTP id 28so5315460wyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Sep 2010 12:19:45 -0700 (PDT)
In-Reply-To: <AANLkTi=mftr=1=KG18nBpKHycGO24QPvLT6FJvFjyh3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

> The rbd class is loaded but not activated. You can run 'ceph class
> activate rbd 1.2', it should fix it (note that it takes a minute to
> propagate).

Oh I see.
I think we need to add this instruction to the wiki.
