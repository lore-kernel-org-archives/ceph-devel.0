From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Get IO request execution profile
Date: Mon, 23 Jan 2017 11:02:03 -0500
Message-ID: <CA+aFP1AR2wV4S_dJuoEjDFtBGcdW+5iX=jOC1-iLmV-5L-N89g@mail.gmail.com>
References: <CACxKWaxt5+9BiQEM-fG=iHkwHJsPYK9EukNoyPtPNQunq65adw@mail.gmail.com>
 <CALe9h7ePYu5_JYTU9NppGhsvUr5FQJJMTw5kcj1yb2kyF+MXHQ@mail.gmail.com>
 <CA+aFP1Av7jHmT4sFD4ysCeeFk_GwZSsAS2W8Zs-9nmcB3sCd4Q@mail.gmail.com> <CACxKWaz6FxPO2VcFJy1+coOewFCwF2=0+feR5sDb3DrnGgvW4A@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:32919 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbdAWQCF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 11:02:05 -0500
Received: by mail-lf0-f47.google.com with SMTP id x1so9222725lff.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 08:02:04 -0800 (PST)
In-Reply-To: <CACxKWaz6FxPO2VcFJy1+coOewFCwF2=0+feR5sDb3DrnGgvW4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Konstantin Danilov <kdanilov@mirantis.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 23, 2017 at 10:59 AM, Konstantin Danilov
<kdanilov@mirantis.com> wrote:
>> Have you looked at the Zipkin tracking PR [1]?
> Nope. Is there any plans to merge it?

Definitely! It was delayed due to Kraken feature freeze, so now that
Kraken is out I'd expect it to pick up steam again and hopefully land
in Luminous.


-- 
Jason
