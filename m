From: Alfredo Deza <adeza@redhat.com>
Subject: docs: please use the :ref: directive instead of linking directly to documents
Date: Mon, 14 Aug 2017 15:40:18 -0400
Message-ID: <CAC-Np1wS=i_FDPZ0xyL0tUyic=1Vu924omK1tMOMW4xnN7JYig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36708 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbdHNTkU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Aug 2017 15:40:20 -0400
Received: by mail-wr0-f178.google.com with SMTP id y41so13037520wrd.3
        for <ceph-devel@vger.kernel.org>; Mon, 14 Aug 2017 12:40:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

While trying to update the dev section in the docs, found a lot of
warnings for "unknown document" references.

This happens when using something like :doc:`/path/to/document`. The
problem with that approach is that it isn't dynamic, if "document"
moves then the link breaks.

A better approach is to rely on the :ref: directive which relies on
labels. The caveat is that these labels must be unique, but as long as
that is the case, one can reference it regardless of the location.

The Sphinx docs recommend using :ref:  (see [0]): "Using ref is
advised over standard reStructuredText links to sections (like
`Section title`_) because it works across files, when section headings
are changed, and for all builders that support cross-references."

I'm going to go ahead and fix these:

/doc/rados/configuration/bluestore-config-ref.rst:184: WARNING:
unknown document: /api/librados/#rados_set_alloc_hint
/doc/rados/operations/health-checks.rst:164: WARNING: unknown
document: /rados/operations/crush-map/#tunables
/doc/rados/operations/health-checks.rst:176: WARNING: unknown
document: /rados/operations/crush-map/#tunables
/doc/rados/operations/health-checks.rst:330: WARNING: unknown
document: placement-groups#Choosing-the-number-of-Placement-Groups
/doc/rados/operations/health-checks.rst:351: WARNING: unknown
document: placement-groups#Choosing-the-number-of-Placement-Groups
/doc/rados/operations/health-checks.rst:404: WARNING: unknown
document: pools.rst#associate-pool-to-application
/doc/rados/operations/health-checks.rst:462: WARNING: unknown
document: troubleshooting-pg#Unfound-objects
/doc/release-notes.rst:440: WARNING: unknown document:
/rados/operations/erasure-code/#erasure-code-profiles

Once that is fixed, I will enable "treat warnings as errors" in the
docs build which will cause doc builds to fail, to prevent adding
these unknowingly.

Thanks

[0] http://www.sphinx-doc.org/en/stable/markup/inline.html#role-ref
