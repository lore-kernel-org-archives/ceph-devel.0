From: kefu chai <tchaikov@gmail.com>
Subject: Re: make check failures on arm64
Date: Tue, 6 Jun 2017 21:43:01 +0800
Message-ID: <CAJE9aOM4Z_NPLeq85P+b-DhwNbtAz5MR_cMuts8SdoNpJOisOw@mail.gmail.com>
References: <f30c77d2-76f6-5028-dca7-848b624acb70@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:36207 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbdFFNnD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jun 2017 09:43:03 -0400
Received: by mail-ua0-f173.google.com with SMTP id h39so38486194uaa.3
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jun 2017 06:43:03 -0700 (PDT)
In-Reply-To: <f30c77d2-76f6-5028-dca7-848b624acb70@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jun 6, 2017 at 12:33 PM, Dan Mick <dmick@redhat.com> wrote:
> Haven't looked into these yet; just in process of redoing the build to
> make sure it wasn't spurious.  Looks like some things crept in.

see https://github.com/ceph/ceph/pull/15515

>
> The following tests FAILED:
>          13 - unittest_bufferlist.sh (Failed)
>          31 - unittest_bufferlist (Failed)
>          62 - unittest_sloppy_crc_map (Failed)
>          68 - unittest_crc32c (Failed)
>          76 - unittest_bit_vector (Failed)
>         114 - unittest_journal (Failed)
>         140 - unittest_bluestore_types (Failed)
>
> https://jenkins.ceph.com/view/pull-requests/job/ceph-pull-requests-arm64/55/console
>
> --
> Dan Mick
> Red Hat, Inc.
> Ceph docs: http://ceph.com/docs
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
