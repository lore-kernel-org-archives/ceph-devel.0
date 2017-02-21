From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Passing LUA script via python rados execute
Date: Tue, 21 Feb 2017 16:59:09 -0500
Message-ID: <CA+2bHPbYt4G=PmAWYRFJbhpMMx8A+WxNk=Q=moz3kn8xxySx0A@mail.gmail.com>
References: <1fa1fa7d.AEEAIBzI4F8AAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYpMPz@mailjet.com>
 <CAB2gnbXykgX42up7ZzT-e5UvZrRkpyzAnGP_D4CnH-AgFRW8qg@mail.gmail.com>
 <3177d648.AEQAH1DOmSwAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphEb@mailjet.com>
 <CAB2gnbVXVUiCgBFK2Q4+8N=RVf6KLGjH=_oibb+BJxx0B_FmtA@mail.gmail.com>
 <1cadb44c.ADsAAGb8C0gAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphQY@mailjet.com>
 <CAB2gnbW1_TLmYsszA7KTD18NdNhW5HR44bvCknTs9rqX007s7Q@mail.gmail.com>
 <3a5eb209.AEEAIECau6cAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYp3rL@mailjet.com>
 <CAB2gnbWXWcj=O1LKKMGCn2X6h_T46x9Ypaupy2u7wQHdBV2CJA@mail.gmail.com>
 <CA+2bHPYgFkRbNwc8b1aLcTX+0-=DecM1m3BV5ssjKFmBYBmo2w@mail.gmail.com>
 <10499347-8c11-83fb-9778-e95049668c6c@redhat.com> <c36e222c.AEEAIIaNAn4AAAAAAAAAAF3gdzkAADNJBWwAAAAAAACRXwBYrLT9@mailjet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:36049 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbdBUV7l (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2017 16:59:41 -0500
Received: by mail-io0-f176.google.com with SMTP id j13so32162867iod.3
        for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2017 13:59:40 -0800 (PST)
In-Reply-To: <c36e222c.AEEAIIaNAn4AAAAAAAAAAF3gdzkAADNJBWwAAAAAAACRXwBYrLT9@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: Josh Durgin <jdurgin@redhat.com>, Noah Watkins <noahwatkins@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On Tue, Feb 21, 2017 at 4:45 PM, Nick Fisk <nick@fisk.me.uk> wrote:
> I'm trying to put some examples together for a book and so wanted to try and come up with a more out of the box experience someone could follow. I'm guessing some basic examples in LUA and then come custom rados classes in C++ might be the best approach for this for now?

FYI, since you are writing a book: Lua is not an acronym:
https://www.lua.org/about.html#name

-- 
Patrick Donnelly
