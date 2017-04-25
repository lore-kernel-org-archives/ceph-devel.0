From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: jewel 10.2.8 last call
Date: Tue, 25 Apr 2017 22:47:25 +0200
Message-ID: <1ee6d36b-9b30-b7c7-a430-3e008383a5dd@suse.cz>
References: <18bf7357-dfbd-2def-ee9c-506e67fc24e0@suse.cz>
 <0015fa14-1baa-f79f-0a95-3a7a904b8c6b@objoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1176518AbdDYUr1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 25 Apr 2017 16:47:27 -0400
In-Reply-To: <0015fa14-1baa-f79f-0a95-3a7a904b8c6b@objoo.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <yd@objoo.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Yann:

> AFAICT, this one still isn't merged :
>
> https://github.com/ceph/ceph/commit/793ceac2f3d5a2c404ac50569c44a21de6001b62
>
>
>
> This is quite simple, but without it, tiering throttling isn't working
> the way it should.

OK, created http://tracker.ceph.com/issues/19773 and flagged for 
backport to jewel!

Nathan
