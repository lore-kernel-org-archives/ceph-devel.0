From: Dan Mick <dan.mick@inktank.com>
Subject: Re: production ready?
Date: Mon, 29 Oct 2012 13:21:20 -0700
Message-ID: <508EE540.5060303@inktank.com>
References: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43205 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab2J2UVX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Oct 2012 16:21:23 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3682889pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Oct 2012 13:21:22 -0700 (PDT)
In-Reply-To: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org



On 10/26/2012 02:52 PM, Gandalf Corvotempesta wrote:
> Hi all,i'm new to ceph.
> Are RBD and REST API production ready?

There are sites using them in production now.

> Do you have any use case to share? we are looking for a distributed
> block storage for an HP C7000 blade with 16 dual processor X5675
> blades with 64/128GB ram each.

Ceph should certainly be able to handle that hardware.
