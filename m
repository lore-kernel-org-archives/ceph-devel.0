From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: rbd copy progress
Date: Fri, 12 Aug 2011 10:16:14 -0700
Message-ID: <4E455FDE.8080207@dreamhost.com>
References: <CAFtEh-dpiebifi31NXNoGYpzawvWNR0T5qc8DO-XLivXbw8HCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53579 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab1HLRQO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2011 13:16:14 -0400
In-Reply-To: <CAFtEh-dpiebifi31NXNoGYpzawvWNR0T5qc8DO-XLivXbw8HCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 08/12/2011 07:59 AM, Damien Churchill wrote:
> Hi,
>
> I was wondering if it's possible to get copy progress statistics some
> how when doing a rbd copy<image>  <dest>? I could check the disk usage
> for Ceph but that seems rather unclean and also prone to errors,
> especially if there are multiple copies going on at once.

Good point! It was an oversight. Added in 
361997af37620d80a95a969addd60f734748ac37.
