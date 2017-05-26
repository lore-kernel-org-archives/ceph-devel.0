From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Missing -lpython2.7 when linking ceph-dencoder
Date: Fri, 26 May 2017 16:37:17 +0200
Message-ID: <b9ae6bc8-1d1b-87e9-bfdb-96586e42bbfc@digiware.nl>
References: <8117b0fd-3c3d-c56b-490c-41772fdd2478@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:38265 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754800AbdEZOh0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 26 May 2017 10:37:26 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 460EB42414
        for <ceph-devel@vger.kernel.org>; Fri, 26 May 2017 16:37:19 +0200 (CEST)
In-Reply-To: <8117b0fd-3c3d-c56b-490c-41772fdd2478@digiware.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 26-5-2017 16:12, Willem Jan Withagen wrote:
> Hi Kefu,
> 
> This change has happend relatively early in my vacation because all the
> build that are left sort of hang on this. ceph-dencoder just misses out
> on a large number of Py object that it can not link. And that again
> comes from linking boost_python.
> 
> Now I remember we had this problem when we reworked the
> find_package(python) stuff.
> Any suggestions other than starting to bisect this?

Right,

It is the other way around....
Boost linking just always includes boost_python which in turn misses
-lpython to be successful.
So now the question is, why am I getting boost_python there?

--WjW

