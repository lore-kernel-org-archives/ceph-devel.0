From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: rbd and the next jewel release v10.2.3
Date: Tue, 23 Aug 2016 09:06:19 -0400
Message-ID: <CA+aFP1CzY1UFgzUcWnCDAhqKH+p95gkhSZ7k+XhsuStm_y0ZnQ@mail.gmail.com>
References: <57BC0D5F.5050006@dachary.org>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36838 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757844AbcHWNGV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2016 09:06:21 -0400
Received: by mail-pf0-f178.google.com with SMTP id h186so43619544pfg.3
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 06:06:20 -0700 (PDT)
In-Reply-To: <57BC0D5F.5050006@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

If at all possible, I would definitely like to see the following
included in 10.2.3 since users are hitting it in the field:

http://tracker.ceph.com/issues/16950

... and given that would require another RBD test run prior to merge,
I would also like to include the following which already have open
PRs:

https://github.com/ceph/ceph/pull/10791
https://github.com/ceph/ceph/pull/10790
https://github.com/ceph/ceph/pull/10792
https://github.com/ceph/ceph/pull/10646
https://github.com/ceph/ceph/pull/10647
https://github.com/ceph/ceph/pull/10786

I can create a PR for the high priority issue this morning.

On Tue, Aug 23, 2016 at 4:46 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Jason,
>
> The next jewel release as found at https://github.com/ceph/ceph/tree/jewel received (I think :-) enough rbd backports to cut the release. It was more challenging than usual and I'd like to thank you and Mykola for helping with the tricky parts.
>
> Do you think the jewel branch is ready for QE to start their own round of testing ?
>
> Cheers
>
> --
> Loïc Dachary, Artisan Logiciel Libre
>



-- 
Jason
