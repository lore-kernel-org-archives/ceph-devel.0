From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: rbd export speed limit
Date: Thu, 21 Feb 2013 10:53:23 +0300
Message-ID: <CABYiri88+iXrUxHL3FCVEdx85ww4-MhMnZugRVOxB=495rdpAg@mail.gmail.com>
References: <511AA47B.3020309@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:49148 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab3BUHxq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Feb 2013 02:53:46 -0500
Received: by mail-ob0-f176.google.com with SMTP id v19so8479808obq.21
        for <ceph-devel@vger.kernel.org>; Wed, 20 Feb 2013 23:53:44 -0800 (PST)
In-Reply-To: <511AA47B.3020309@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>

On Wed, Feb 13, 2013 at 12:22 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Hi,
>
> is there a speed limit option for rbd export? Right now i'm able to produce
> several SLOW requests from IMPORTANT valid requests while just exporting a
> snapshot which is not really important.
>
> rbd export runs with 2400MB/s and each OSD with 250MB/s so it seems to block
> valid normal read / write operations.
>
> Greets,
> Stefan
> --

Can confirm this in some specific case - when 0.56.2 and 0.56.3
coexist for a long time, nodes with newer running version can produce
such warnings at the beginning of export huge snapshots, not during
entire export. And there are real impact on clients - for example I
can see messages from watchdog in the KVM guests. For now, I will do
an input throttling on export as temporary workaround.
