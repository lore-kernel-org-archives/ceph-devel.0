From: Dan Mick <dan.mick@inktank.com>
Subject: Re: crush changes via cli
Date: Mon, 25 Mar 2013 11:38:46 -0700
Message-ID: <515099B6.3010904@inktank.com>
References: <alpine.DEB.2.00.1303221528240.18669@cobra.newdream.net> <CAPYLRzg2YUVBEL8oJ_N02w1dHwy7a9jpCAVkcRq8AhmyUMnuGw@mail.gmail.com> <alpine.DEB.2.00.1303221554130.32540@cobra.newdream.net> <43BCE0F438AB4C22AEEEFEDCD165068B@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34038 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932611Ab3CYSiw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 14:38:52 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so2670314pde.4
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 11:38:52 -0700 (PDT)
In-Reply-To: <43BCE0F438AB4C22AEEEFEDCD165068B@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


>> That's right. The "remove" versus "unlink" verbs make that pretty clear
>> to me, at least... Are you suggesting this be clarified in the docs, or
>> that the command set change? I think once we settle on the CLI, John can
>> make a pass through the crush docs and make sure these commands are
>> explained.
>
>
> That makes sense if you know the internal representation of the
> CRUSH  map; less so if you're thinking of it in terms from related fields like,
> say, a filesystem. ;) I admit I don't have any better suggestions and
> strong docs might be just fine, but the distinction is one that's very
> visible to users *afterwards* but not beforehand. I'm imagining a lot of
> crush maps with 5 unlinked parallel trees in our future.

I'm not saying it's better, but perhaps/possibly connect/disconnect?
