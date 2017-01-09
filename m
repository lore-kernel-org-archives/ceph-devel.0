From: Wido den Hollander <wido@42on.com>
Subject: Re: RADOS Object class capabilities
Date: Mon, 9 Jan 2017 09:58:17 +0100 (CET)
Message-ID: <1004503707.6221.1483952298347@ox.pcextreme.nl>
References: <26283_1480676624_58415510_26283_122_1_EBBC07637B509B40B2E594A11E62C54F022DA808@OPEXCLILM32.corporate.adroot.infra.ftgroup>
 <d8129d7a-af37-ad74-38c8-f5a9d59f183b@suse.de>
 <CAF-wwdHPXaX3fe+dk9ovdAfc00N5xQrzj2TaRAuBOjH77L4yDg@mail.gmail.com>
 <200977EA-767F-41DA-9912-143C403D5D7B@Teradata.com>
 <CAB2gnbVn0U_G12L8XV=hbznB2i_TMo40TpC5cVzJZKOr_MAQ7Q@mail.gmail.com>
 <64D605E0-8851-4F60-B0AB-864CBDA7B3F7@Teradata.com>
 <208C08FF-0104-425C-B7AA-B0930A76F46E@Teradata.com>
 <CAB2gnbUEeS6AynJ0AjdpJ+MbiGSq_HUkBS-KdnXrke1wiJYsyA@mail.gmail.com>
 <E41C6528-D51D-4165-87D5-0DBBDF6B9F5F@Teradata.com>
 <515514A8-CE49-48FD-8939-74BE82F30FDE@Teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:51722 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757403AbdAII6Y (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2017 03:58:24 -0500
In-Reply-To: <515514A8-CE49-48FD-8939-74BE82F30FDE@Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>, Noah Watkins <noahwatkins@gmail.com>
Cc: Joao Eduardo Luis <joao@suse.de>, nebil.benmabrouk@orange.com, Brad Hubbard <bhubbard@redhat.com>, ceph-devel@vger.kernel.org


> Op 9 januari 2017 om 3:52 schreef "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>:
> 
> 
> So far I am impressed to find out what the RADOS object class can do.
> Is it possible to override one of the RADOS basic functions or it’s behavior such as object 
> read/write for all/other clients, by implementing a RADOS object class?
> 

Afaik not. Using rados_exec() you can execute functions from the object class, but a object class don't override existing RADOS functionality.

Wido

> It will be quiet powerful and dangerous if is supported.
> 
> Thanks & Regards,
> Nitin
> 
> N�����r��y���b�X��ǧv�^�)޺{.n�+���z�]z���{ay�ʇڙ�,j��f���h���z��w������j:+v���w�j�m��������zZ+��ݢj"��!�i
