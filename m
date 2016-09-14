From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: librbd diff_iterate question
Date: Wed, 14 Sep 2016 16:10:50 -0400
Message-ID: <CA+aFP1D19O5p3d8t1GW_EDAM5YBinDOb+A+uBnKPwjUgMs=5pw@mail.gmail.com>
References: <CAJDfisk8=HyE-Jf24vphowjeuJggcgRNu_O1eLpTLiEYO5-LkA@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33239 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756218AbcINUKw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Sep 2016 16:10:52 -0400
Received: by mail-pa0-f47.google.com with SMTP id cm16so8454527pac.0
        for <ceph-devel@vger.kernel.org>; Wed, 14 Sep 2016 13:10:51 -0700 (PDT)
In-Reply-To: <CAJDfisk8=HyE-Jf24vphowjeuJggcgRNu_O1eLpTLiEYO5-LkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Max Yehorov <myehorov@skytap.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 14, 2016 at 3:13 PM, Max Yehorov <myehorov@skytap.com> wrote:
> It appears that only
> fast-diff code path can set "exists" flag to false in the
> diff_iterate's callback. Is that the correct assumtion?

The fast-diff code path within diff_iterate can set the "exists" flag
to true (1) if the object exists and has been updated since the "from"
snapshot (i.e. there is a delta), otherwise it is set to false (0).

-- 
Jason
