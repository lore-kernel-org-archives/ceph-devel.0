From: Mark Nelson <mnelson@redhat.com>
Subject: Re: rocksdb with jemalloc
Date: Mon, 11 May 2015 21:55:53 -0500
Message-ID: <55516BB9.6000709@redhat.com>
References: <CAFkUHxeqZGTiipGdb1voLzRGChDnumRnOgd50Ce8LjBm6eL0Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36402 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233AbbELCz7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 May 2015 22:55:59 -0400
In-Reply-To: <CAFkUHxeqZGTiipGdb1voLzRGChDnumRnOgd50Ce8LjBm6eL0Hg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kernel neophyte <neophyte.hacker001@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/11/2015 08:41 PM, kernel neophyte wrote:
> Hi,
>
>
> I am trying to use newstore + rocksdb + jemalloc. Currently rocksdb in
> ceph compiles only with tcmalloc and not with jemalloc.
>
> Is there any reason for this limitation ?

Heya, I'm guessing it's not by design, simply no one's tried doing it 
yet.  What are you running into?

>
> -Neo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
