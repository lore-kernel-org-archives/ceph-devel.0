From: John Spray <jspray@redhat.com>
Subject: Re: CephFS and the next jewel release v10.2.4
Date: Thu, 27 Oct 2016 14:10:24 +0100
Message-ID: <CALe9h7ekfGD+kDxu6isF29fHwmNcLMjeivs8anWs+Gk+X2oDcQ@mail.gmail.com>
References: <5811C932.3070505@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36235 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942593AbcJ0OVD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Oct 2016 10:21:03 -0400
Received: by mail-lf0-f54.google.com with SMTP id b75so32729748lfg.3
        for <ceph-devel@vger.kernel.org>; Thu, 27 Oct 2016 07:21:01 -0700 (PDT)
In-Reply-To: <5811C932.3070505@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

On Thu, Oct 27, 2016 at 10:30 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi John,
>
> The next jewel release as found at https://github.com/ceph/ceph/tree/jewel passed the fs suite (http://tracker.ceph.com/issues/17487#note-20 except for three valgrind failures and one java failure). Do you think the jewel branch is ready for QE to start their own round of testing ?

Yep, I don't think any of the outstanding PRs are high enough priority
to hold this up.  If for any reason we do have another round of
upstream jewel branch testing it would still be nice to pull in
https://github.com/ceph/ceph/pull/11656

John

>
> Cheers
>
> --
> Loïc Dachary, Artisan Logiciel Libre
