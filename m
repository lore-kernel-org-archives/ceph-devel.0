From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: common/Mutex.h:102: FAILED assert(nlock > 0)
Date: Fri, 22 Oct 2010 13:39:35 -0700
Message-ID: <AANLkTikW98mUnNh84QNdDcyiVFL78TzKVzSRiH_jz09Y@mail.gmail.com>
References: <1287773810.6806.74.camel@sale659.sandia.gov>
	<AANLkTikL=9eXGTGyMzs2b71kQfaEieayp-KFNUrLy2k2@mail.gmail.com>
	<1287779106.6806.78.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58599 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756861Ab0JVUjg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Oct 2010 16:39:36 -0400
Received: by gyg4 with SMTP id 4so983206gyg.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Oct 2010 13:39:35 -0700 (PDT)
In-Reply-To: <1287779106.6806.78.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Oct 22, 2010 at 1:25 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> Hi Greg,
>
> On Fri, 2010-10-22 at 13:40 -0600, Gregory Farnum wrote:
>> If you pull the newest unstable you'll find this fixed, it was a
>> short-lived error in the tree. :)
>
> What's the tip of the unstable branch for you?
>
> My latest pull as of 14:23:00 MDT has 242b5992f307 as
> the tip, and it's still showing this problem?
>
> Thanks -- Jim
Oh, there was a merge issue --- it's reverted now.
Sorry!
-Greg
