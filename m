From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: A way to reduce compression overhead
Date: Tue, 15 Nov 2016 17:42:34 +0300
Message-ID: <27d0b2e2-b2d2-9cf9-5280-91fc5bc9ad7a@mirantis.com>
References: <828b8988-5c29-8ec3-be00-e6c45fa15ab0@mirantis.com>
 <alpine.DEB.2.11.1611082019530.29278@piezo.us.to>
 <a2381759-4f9b-97dc-53cb-279e51337056@mirantis.com>
 <alpine.DEB.2.11.1611112330530.29579@piezo.us.to>
 <a3f50c37-dfb1-a516-f768-2074204227d1@mirantis.com>
 <alpine.DEB.2.11.1611151431080.29579@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:38821 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbcKOOnL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Nov 2016 09:43:11 -0500
Received: by mail-it0-f43.google.com with SMTP id o1so2772325ito.1
        for <ceph-devel@vger.kernel.org>; Tue, 15 Nov 2016 06:43:10 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611151431080.29579@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

You mean removing GC stuff totally, right?

Will do.


On 15.11.2016 17:31, Sage Weil wrote:
>
> In the meantime, perhaps we should remove the blob_depth code for now so
> it doesn't end up in the on-disk format.
>
> sage

