From: Dan Mick <dan.mick@inktank.com>
Subject: Re: RBD layering design draft
Date: Mon, 18 Jun 2012 16:10:40 -0700
Message-ID: <4FDFB570.2040300@inktank.com>
References: <4FDB9FBB.9000807@inktank.com> <Pine.LNX.4.64.1206151742380.28086@cobra.newdream.net> <CADvuQREO95qJsd6netR+3RSjeddZR3U+B4++XJFsAiz3ZfomEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61490 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075Ab2FRXKn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 19:10:43 -0400
Received: by dady13 with SMTP id y13so7569282dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 16:10:43 -0700 (PDT)
In-Reply-To: <CADvuQREO95qJsd6netR+3RSjeddZR3U+B4++XJFsAiz3ZfomEA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 06/18/2012 09:25 AM, Tommi Virtanen wrote:
> On Fri, Jun 15, 2012 at 5:46 PM, Sage Weil<sage@inktank.com>  wrote:
>> Is 'preserve' and 'unpreserve' the verbiage we want to use here?  Not sure
>> I have a better suggestion, but preserve is unusual.
>
> protect/unprotect? The flag protects the image snapshot from being deleted.

unremovable/removable?

undeletable/deletable?

