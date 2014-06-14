From: Justin Erenkrantz <justin@erenkrantz.com>
Subject: Re: [Ceph] Managing crushmap
Date: Sat, 14 Jun 2014 08:40:34 -0400
Message-ID: <CAOGLoJMCK161NK6bLurNrDW59yaLu7oj7QJ7abXrX8i0jTZjZA@mail.gmail.com>
References: <31473_1402478241_53981EA1_31473_30_1_B9C8EFBF13B1354DB5FA000660D66DD00C122930@PEXCVZYM14.corporate.adroot.infra.ftgroup>
	<CAPYLRzjj7C2HhHtwFqBJ6zPUeF-pPnhVMmceZSYOgSy-cPOzwA@mail.gmail.com>
	<32657_1402562812_539968FC_32657_8172_1_B9C8EFBF13B1354DB5FA000660D66DD00C123181@PEXCVZYM14.corporate.adroot.infra.ftgroup>
	<539C1058.9010800@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34263 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643AbaFNMkf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jun 2014 08:40:35 -0400
Received: by mail-pd0-f169.google.com with SMTP id g10so343811pdj.14
        for <ceph-devel@vger.kernel.org>; Sat, 14 Jun 2014 05:40:34 -0700 (PDT)
In-Reply-To: <539C1058.9010800@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ghislain.chevalier@orange.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Jun 14, 2014 at 5:05 AM, Loic Dachary <loic@dachary.org> wrote:
> The error you see when you
>
>  ceph osd pool set data crush_ruleset 50
>
> has been fixed recently and is going to be backported ( http://tracker.ceph.com/issues/8599 ) Would you have time to check the backport once it's ready ?

We're running into this as well - I think we stumbled upon a
workaround without really knowing why.  This is a pretty brutal bug.
-- justin
