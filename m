From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: release v12.1.1?
Date: Tue, 18 Jul 2017 11:47:10 -0600
Message-ID: <CALqRxCzCu3dchCu30CEmirxAkpYhe2NuZ73zHWcsUT0eg_QeoA@mail.gmail.com>
References: <CALqRxCwq_qhLFuUnrNNLgM+qZ-oixDmaUgf9e6e+dP1EeXfKJQ@mail.gmail.com>
 <alpine.DEB.2.11.1707142012520.27271@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:33314 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbdGRRrL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jul 2017 13:47:11 -0400
Received: by mail-ua0-f172.google.com with SMTP id y47so17246975uag.0
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jul 2017 10:47:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1707142012520.27271@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 14, 2017 at 2:13 PM, Sage Weil <sage@newdream.net> wrote:
> Yes!  I was hoping to get the missing deletes in there but there is plenty
> to justify the next rc.

"git describe master" still thinks the latest tag for that branch is v12.1.0:

v12.1.0-1133-gd91f57c

What do we need to do to make that look right (12.1.1-something)?

- Ken
