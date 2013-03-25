From: Wido den Hollander <wido@42on.com>
Subject: Re: Set object mtime
Date: Mon, 25 Mar 2013 20:18:30 +0100
Message-ID: <5150A306.6030509@42on.com>
References: <CAFtEh-e6GWeU-hP==zPjcXDuxfWkmeZo0wDwY-R82SJR2JZnzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:48266 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758815Ab3CYTSc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 Mar 2013 15:18:32 -0400
In-Reply-To: <CAFtEh-e6GWeU-hP==zPjcXDuxfWkmeZo0wDwY-R82SJR2JZnzQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 03/25/2013 12:27 PM, Damien Churchill wrote:
> Does anyone know if it's possible to set an objects mtime at all in RADOS?
>

You mean with a specific operation while not modifying the content of 
the object?

I checked the rados API, but I couldn't find any method which allows you 
to do so.

Wido

> Regards,
> Damien
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
