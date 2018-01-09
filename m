From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: shuffle_random removed in C++17 on FreeBSD/Clang??
Date: Tue, 9 Jan 2018 13:22:31 -0800 (PST)
Message-ID: <alpine.LSU.2.21.1801091319520.27069@smaug>
References: <478f46a2-3cd9-ab94-6437-8f6de05f2c25@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751690AbeAIVV7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 9 Jan 2018 16:21:59 -0500
In-Reply-To: <478f46a2-3cd9-ab94-6437-8f6de05f2c25@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 9 Jan 2018, Willem Jan Withagen wrote:

Hi Willem,

> As a consequence of the move to C++17 I'm running into this problem.

std::random_shuffle() was deprecated in C++14 and removed in C++17. Use 
std::shuffle().

The process is:

0) make a random device (ie. std::random_device)
1) make a distribution associated with that device (ie. std::mt19937)
2) shuffle!

I hope that helps,

-Jesse
