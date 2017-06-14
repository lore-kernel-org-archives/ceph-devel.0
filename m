From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 09:15:49 -0700 (PDT)
Message-ID: <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752099AbdFNQPy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Jun 2017 12:15:54 -0400
In-Reply-To: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 14 Jun 2017, Willem Jan Withagen wrote:

> I guess that in Clang strlen is not evaluation to a constant.

This is an extension, the standard does not define strlen() as constexpr.

Some discussion:
https://reviews.llvm.org/D23692

-Jesse
