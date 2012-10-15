From: Dan Mick <dan.mick@inktank.com>
Subject: Re: rbd command to display free space in a cluster ?
Date: Mon, 15 Oct 2012 13:09:08 -0700
Message-ID: <507C6D64.8000109@inktank.com>
References: <ec165b12-5d49-49d0-b5c9-cdb51bc2b442@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44843 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab2JOUJM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Oct 2012 16:09:12 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so5189939pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 13:09:11 -0700 (PDT)
In-Reply-To: <ec165b12-5d49-49d0-b5c9-cdb51bc2b442@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

Nothing like that exists at the moment; see
http://tracker.newdream.net/issues/3283 fpr the other side of it.

On 10/15/2012 12:52 AM, Alexandre DERUMIER wrote:
> Hi,
>
> I'm looking for a way to retrieve the free space from a rbd cluster with rbd command.
>
> Any hint ?
>
> (something like ceph -w status, but without need to parse the result)
>
> Regards,
>
> Alexandre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
