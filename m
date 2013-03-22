From: Florian Haas <florian@hastexo.com>
Subject: Re: github pull requests
Date: Fri, 22 Mar 2013 19:47:29 +0100
Message-ID: <CAPUexz-F90hcr6SeJbrLEQ-MzYuurzMJg7=xaDcj_oxMc2wMhQ@mail.gmail.com>
References: <alpine.DEB.2.00.1303191550140.4850@cobra.newdream.net>
	<CAMQoE_3+Os=F75LE+7dLVK2LYamNbEqwk0wpTe5+b0UZvYnQzg@mail.gmail.com>
	<52FEF7AC-2E35-413D-A0E6-A69B2FB2271D@intel.com>
	<CAPYLRzjyLmtFHLTny4Ni1FzhaAPqmmqTNt3ztDBL-oCMZZ7m0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:50541 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686Ab3CVSrb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Mar 2013 14:47:31 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so5117737iee.11
        for <ceph-devel@vger.kernel.org>; Fri, 22 Mar 2013 11:47:30 -0700 (PDT)
In-Reply-To: <CAPYLRzjyLmtFHLTny4Ni1FzhaAPqmmqTNt3ztDBL-oCMZZ7m0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Mar 22, 2013 at 12:15 AM, Gregory Farnum <greg@inktank.com> wrote:
> I'm not sure that we handle enough incoming yet that the extra process
> weight of something like Gerrit or Launchpad is necessary over Github.
> What are you looking for in that system which Github doesn't provide?
> -Greg

Automated regression tests and gated commits come to mind. Gerrit
alone of course doesn't help with that, you'd probably want to
consider either running Jenkins, or hook the master merges up with
automatic teuthology runs.

Just my two cents, though.

Cheers,
Florian
