From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: kraken
Date: Tue, 1 Nov 2016 18:08:34 +0100
Message-ID: <ec4ace86-c914-b470-2405-8c84ec960593@digiware.nl>
References: <alpine.DEB.2.11.1611011319120.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25530 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751613AbcKARIl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 1 Nov 2016 13:08:41 -0400
In-Reply-To: <alpine.DEB.2.11.1611011319120.20331@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 1-11-2016 14:20, Sage Weil wrote:
> Hey everyone,
> 
> I think we're about ready for a kraken feature freeze.  The main item we 
> were waiting for was the EC overwrites and Sam has a working branch for 
> review this week.  There are still a few odds and ends that I have on my 
> list to get in (like the new CRUSH tunable), but it's a short list.
> 
> How does next Monday (11/7) sound for an initial freeze?

Hi Sage,

I had hopes of having FreeBSD being close to working oke before Kraken
release. But I don't think it is going to make it.
Major pain/missing is ceph-disk, and I keep getting distracted...

One small PR that works around a Clang bug would be nice to get in, is:

msg/async/AsyncMessenger.cc: use explicit reference from my_inst. #11706

I'd say the code for itself is in an oke state, it is just the tests
now, that require more care.

--WjW



