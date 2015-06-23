From: Gregory Farnum <greg@gregs42.com>
Subject: Re: erasure pool with isa plugin
Date: Tue, 23 Jun 2015 11:06:32 +0100
Message-ID: <CAC6JEv-qmFCwf1rdE6KnzcE=qQNgZr3AYpHwZ0OBNj2wcteSog@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91669A9C09@SATLEXDAG01.amd.com>
	<55887F63.1000404@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:32798 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbbFWKGf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jun 2015 06:06:35 -0400
Received: by laka10 with SMTP id a10so3316212lak.0
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jun 2015 03:06:34 -0700 (PDT)
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com. [209.85.215.46])
        by mx.google.com with ESMTPSA id ba6sm3647387lab.26.2015.06.23.03.06.33
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 03:06:33 -0700 (PDT)
Received: by lagx9 with SMTP id x9so3293401lag.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jun 2015 03:06:32 -0700 (PDT)
In-Reply-To: <55887F63.1000404@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "Deneau, Tom" <tom.deneau@amd.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jun 22, 2015 at 10:34 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Tom,
>
> On 22/06/2015 17:10, Deneau, Tom wrote:
>> If one has a cluster with some nodes that can run with the ISA plugin
>> and some that cannot, is there a way to define a pool such that the
>> ISA-capable nodes can use the ISA plugin and the others can use say
>> the jerasure plugin?
>
> There is no way to do that, because there is no guarantee that an object encoded by jerasure can be decoded by isa and vice versa.

Shouldn't we be able to set up something that *does* guarantee that,
though? Either by combining them into a single plugin which
dynamically configures to the fastest possible for that machine, or by
running them against the same object corpus and requiring that they
produce the same output?
-Greg
