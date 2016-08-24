From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 01/16] libceph: rename ceph_entity_name_encode() -> ceph_auth_entity_name_encode()
Date: Wed, 24 Aug 2016 22:15:23 +0200
Message-ID: <CAOi1vP9kWC6oNwDiLp8NrXOk5D+EsXF3nT_NcYix1=zndUoTfg@mail.gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
 <1472044720-29116-2-git-send-email-idryomov@gmail.com> <28e3c600-d042-bebc-31d4-2f5223a2de5c@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33222 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755637AbcHXVZk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 17:25:40 -0400
Received: by mail-ua0-f193.google.com with SMTP id u13so2330281uau.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 14:24:43 -0700 (PDT)
In-Reply-To: <28e3c600-d042-bebc-31d4-2f5223a2de5c@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 24, 2016 at 8:49 PM, Alex Elder <elder@ieee.org> wrote:
> On 08/24/2016 08:18 AM, Ilya Dryomov wrote:
>> Clear up EntityName vs entity_name_t confusion.
>
> If I understand what your code does, you're using
> "auth_entity_name" to represent whatever "EntityName"
> is.  (At this point I'm just looking at the code; I
> haven't gone to look at what an entity_name_t or
> EntitnyName are...)

Correct.  Those are two different types: EntityName is integer type
(osd, mds, etc) + string id ("0", "a", etc), while entity_name_t is
integer type + integer id.  One of Doug's patches indicated that he was
confused about the two and it took me a moment to disambiguate so
I went ahead and renamed the function.

Thanks,

                Ilya
