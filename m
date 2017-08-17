From: Dan Mick <dmick@redhat.com>
Subject: Re: docs: please use the :ref: directive instead of linking directly
 to documents
Date: Wed, 16 Aug 2017 19:29:13 -0700
Message-ID: <dfb781fd-723f-03bd-4a26-c6c4018e0ad6@redhat.com>
References: <CAC-Np1wS=i_FDPZ0xyL0tUyic=1Vu924omK1tMOMW4xnN7JYig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751461AbdHQC3N (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 16 Aug 2017 22:29:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BA9F72D75
        for <ceph-devel@vger.kernel.org>; Thu, 17 Aug 2017 02:29:13 +0000 (UTC)
In-Reply-To: <CAC-Np1wS=i_FDPZ0xyL0tUyic=1Vu924omK1tMOMW4xnN7JYig@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Thanks for fixing this, Alfredo.

On 08/14/2017 12:40 PM, Alfredo Deza wrote:
> While trying to update the dev section in the docs, found a lot of
> warnings for "unknown document" references.
> 
> This happens when using something like :doc:`/path/to/document`. The
> problem with that approach is that it isn't dynamic, if "document"
> moves then the link breaks.
> 
> A better approach is to rely on the :ref: directive which relies on
> labels. The caveat is that these labels must be unique, but as long as
> that is the case, one can reference it regardless of the location.
> 
> The Sphinx docs recommend using :ref:  (see [0]): "Using ref is
> advised over standard reStructuredText links to sections (like
> `Section title`_) because it works across files, when section headings
> are changed, and for all builders that support cross-references."
> 
> I'm going to go ahead and fix these:
> 
> /doc/rados/configuration/bluestore-config-ref.rst:184: WARNING:
> unknown document: /api/librados/#rados_set_alloc_hint
> /doc/rados/operations/health-checks.rst:164: WARNING: unknown
> document: /rados/operations/crush-map/#tunables
> /doc/rados/operations/health-checks.rst:176: WARNING: unknown
> document: /rados/operations/crush-map/#tunables
> /doc/rados/operations/health-checks.rst:330: WARNING: unknown
> document: placement-groups#Choosing-the-number-of-Placement-Groups
> /doc/rados/operations/health-checks.rst:351: WARNING: unknown
> document: placement-groups#Choosing-the-number-of-Placement-Groups
> /doc/rados/operations/health-checks.rst:404: WARNING: unknown
> document: pools.rst#associate-pool-to-application
> /doc/rados/operations/health-checks.rst:462: WARNING: unknown
> document: troubleshooting-pg#Unfound-objects
> /doc/release-notes.rst:440: WARNING: unknown document:
> /rados/operations/erasure-code/#erasure-code-profiles
> 
> Once that is fixed, I will enable "treat warnings as errors" in the
> docs build which will cause doc builds to fail, to prevent adding
> these unknowingly.
> 
> Thanks
> 
> [0] http://www.sphinx-doc.org/en/stable/markup/inline.html#role-ref
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
