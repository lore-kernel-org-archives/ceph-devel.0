From: Xinze Chi <xmdxcxz@gmail.com>
Subject: Re: crc error when decode_message?
Date: Mon, 16 Mar 2015 21:19:22 +0800
Message-ID: <CANE=7sXX9mFuuFGJE7edXdE2q7pt+teOjXkCgb5aWjToAYM1MA@mail.gmail.com>
References: <CANE=7sWQaG8PZYEU9OsjkmU6GB6jKhcnSG1cm6o38EeMb65pGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34203 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbbCPNTX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Mar 2015 09:19:23 -0400
Received: by obbgg8 with SMTP id gg8so35196318obb.1
        for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2015 06:19:22 -0700 (PDT)
In-Reply-To: <CANE=7sWQaG8PZYEU9OsjkmU6GB6jKhcnSG1cm6o38EeMb65pGw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Such as, Client send write request to osd.0 (primary), osd.0 send
MOSDSubOp to osd.1 and osd.2

osd.1 send reply to osd.0 (primary), but accident happened:

1. decode_message crc error when decode reply msg
or
2. the reply msg is lost when send to osd.0, so osd.0 do not receive replay msg

Could anyone tell me what is the behavior if osd.0 (primary)?

Thanks

2015-03-16 20:02 GMT+08:00 Xinze Chi <xmdxcxz@gmail.com>:
> hi, all:
>
>       I want to know what is the behavior of primary when
> decode_message crc error , such as read
>
> ack response message from remote peer?
>
>       Thanks.
