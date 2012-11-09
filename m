From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: ``rbd mv'' crash when no destination issued
Date: Fri, 09 Nov 2012 13:03:50 -0800
Message-ID: <509D6FB6.7070900@inktank.com>
References: <CABYiri_uQc0qRcg6ByhAO+dbt9+1=pAZ+pQPuB1XXgZBxgcd3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50895 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836Ab2KIVEP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 16:04:15 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so3086840pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 13:04:14 -0800 (PST)
In-Reply-To: <CABYiri_uQc0qRcg6ByhAO+dbt9+1=pAZ+pQPuB1XXgZBxgcd3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 11/09/2012 08:57 AM, Andrey Korolyov wrote:
> Hi,
>
> Please take a look, seems harmless:
>
>
> $ rbd mv vm0
> terminate called after throwing an instance of 'std::logic_error'

Thanks for the report, it's fixed in the next and master branches,
and is indeed harmless.

Josh
