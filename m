From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: possible to recover a deleted RBD?
Date: Mon, 10 Sep 2012 13:59:54 -0700
Message-ID: <504E54CA.4010200@inktank.com>
References: <CACkq2moAQhOoSYw2+=d3G7xy-CuKdNFWMirH9KzuwRr7piefGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62816 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab2IJU75 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Sep 2012 16:59:57 -0400
Received: by pbbrr13 with SMTP id rr13so3036593pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Sep 2012 13:59:56 -0700 (PDT)
In-Reply-To: <CACkq2moAQhOoSYw2+=d3G7xy-CuKdNFWMirH9KzuwRr7piefGQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 09/10/2012 01:55 PM, Travis Rhoden wrote:
> I sheepishly must ask -- is there any way to recover a deleted RBD?
>
> The RBD was created using the Linux 3.2 kernel client, running 0.48.1.
>   Removed with "rbd rm -p rbd <name>".
>
> I expect the answer to be no, but wanted to check for sure!
>
> Thanks,
>
> Travis

Short answer: no

Long answer: it may be possible if your cluster was undergoing recovery
and extra copies of objects are around, but this is unreliable since
you don't know which objects should be there due to thin-provisioning.

Josh

