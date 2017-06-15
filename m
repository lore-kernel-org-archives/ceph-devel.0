From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Clang does not like constexpression
Date: Thu, 15 Jun 2017 14:55:05 +0200
Message-ID: <51a6a900-0b2f-71e8-7f8f-ea0d702c8c16@digiware.nl>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
 <alpine.LSU.2.21.1706140915130.5364@ancalagon.suse.de>
 <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:12042 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752101AbdFOMzN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Jun 2017 08:55:13 -0400
In-Reply-To: <alpine.LSU.2.21.1706140931320.5364@ancalagon.suse.de>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 14-6-2017 18:50, Jesse Williamson wrote:
> 
> Here's a C++11 version that might be useful to you (largely untested,
> and I'm only on my first cup of coffee, so... ;>).

The original author has submitted a PR, that works for Clang.

And I do enjoy the C++-technical discussion that followed, but I chosen
to focus on porting to FreeBSD. Which is time consuming as it is, next
to my daily job. So sometimes I only the bearer of Clang-errors.

And I'll take anything that goes into the tree, and will leave the beaty
of solutions to others.

--WjW




