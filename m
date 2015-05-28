From: Gregory Farnum <greg@gregs42.com>
Subject: Re: OSD-Based Object Stubs
Date: Wed, 27 May 2015 22:56:20 -0700
Message-ID: <CAC6JEv8KPsi1w37-XvNg00s4gC6hv=N5p5NWty56dFv3=e3eQA@mail.gmail.com>
References: <87a8wqct38.fsf@irq0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:34187 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbbE1F4W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 01:56:22 -0400
Received: by qcbhb1 with SMTP id hb1so13505453qcb.1
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2015 22:56:21 -0700 (PDT)
Received: from mail-qk0-f172.google.com (mail-qk0-f172.google.com. [209.85.220.172])
        by mx.google.com with ESMTPSA id 34sm626967qkr.47.2015.05.27.22.56.20
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 22:56:21 -0700 (PDT)
Received: by qkx62 with SMTP id 62so19094455qkx.3
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2015 22:56:20 -0700 (PDT)
In-Reply-To: <87a8wqct38.fsf@irq0.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcel Lauhoff <ml@irq0.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, May 27, 2015 at 1:39 AM, Marcel Lauhoff <ml@irq0.org> wrote:
> Hi,
>
> I wrote a prototype for an OSD-based object stub feature. An object stub
> being an object with it's data moved /elsewhere/. I hope to get some
> feedback, especially whether I'm on the right path here and if it
> is a feature you are interested in.
>
>
>
> Code is in my "osd-stubs" branch:
>  https://github.com/ceph/ceph/compare/master...irq0:osd-stubs
>  https://github.com/irq0/ceph/tree/osd-stubs
>
>  Tools to toy around with osd-stubs + web server to send stubs to:
>  https://github.com/irq0/ceph_osd-stub_tools
>
>
>
> Related:
> - https://wiki.ceph.com/Planning/Blueprints/%3CSIDEBOARD%3E/osd:_tiering:_object_redirects

Do you have a shorter summary than the code of how these stub and
unstub operations relate to the object redirects? We didn't make a
great deal of use of them but the basic data structures are mostly
present in the codebase, are interpreted in at least some of the right
places, and were definitely intended to cover this kind of use case.
:)
-Greg
