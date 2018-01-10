From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: shuffle_random removed in C++17 on FreeBSD/Clang??
Date: Wed, 10 Jan 2018 09:58:53 +0100
Message-ID: <d0072085-afed-1bfa-875a-b1ee8f3ef40b@digiware.nl>
References: <478f46a2-3cd9-ab94-6437-8f6de05f2c25@digiware.nl>
 <alpine.LSU.2.21.1801091319520.27069@smaug>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:59106 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964809AbeAJI6z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 10 Jan 2018 03:58:55 -0500
In-Reply-To: <alpine.LSU.2.21.1801091319520.27069@smaug>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 09/01/2018 22:22, Jesse Williamson wrote:
> On Tue, 9 Jan 2018, Willem Jan Withagen wrote:
> 
> Hi Willem,
> 
>> As a consequence of the move to C++17 I'm running into this problem.
> 
> std::random_shuffle() was deprecated in C++14 and removed in C++17. Use 
> std::shuffle().
> 
> The process is:
> 
> 0) make a random device (ie. std::random_device)
> 1) make a distribution associated with that device (ie. std::mt19937)
> 2) shuffle!

Yup,
That was what I found as well.
PR was submitted.

--WjW


