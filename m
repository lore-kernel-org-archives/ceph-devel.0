From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: can't download from radosgw
Date: Mon, 28 Jan 2013 10:17:05 -0800
Message-ID: <CAC-hyiELfdbjQQf6K8uFGMeHke9TSeHPbMHXipVZGwPYZENNQw@mail.gmail.com>
References: <CAJH6TXi90idR13oTxDQCfaSgJh3P8A4h44rHQZSt8uX9kLX02A@mail.gmail.com>
	<CAJH6TXg8fcdTPGHuqyOZvNyrUp1wVGA7AhNx_p+wquvViyowPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:56299 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201Ab3A1SRG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 13:17:06 -0500
Received: by mail-ie0-f182.google.com with SMTP id k14so450289iea.13
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 10:17:05 -0800 (PST)
In-Reply-To: <CAJH6TXg8fcdTPGHuqyOZvNyrUp1wVGA7AhNx_p+wquvViyowPQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jan 28, 2013 at 3:55 AM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> 2013/1/28 Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>:
>> 2013-01-28 12:22:27.759162 7fe8657c3700  0 NOTICE: failed to send
>> response to client
>> 2013-01-28 12:22:27.759186 7fe8657c3700  0 ERROR: s->cio->print()
>> returned err=-1
>> 2013-01-28 12:22:27.759206 7fe8657c3700  0 ERROR: s->cio->print()
>> returned err=-1
>> 2013-01-28 12:22:27.759211 7fe8657c3700  0 ERROR: s->cio->print()
>> returned err=-1
>> 2013-01-28 12:22:27.759216 7fe8657c3700  0 ERROR: s->cio->print()
>> returned err=-1
>> 2013-01-28 12:22:27.759268 7fe8657c3700  2 req 128:0.051384:s3:GET
>> /public2/shared/9780470398661.pdf:get_obj:http status=403
>> 2013-01-28 12:22:27.759336 7fe8657c3700  1 ====== req done
>> req=0x3192980 http_status=403 ======
>
>
> This happens only with Google Chrome.
> Firefox, curl, wget and many other are able to download properly.

(resending to all)

It looks like the connection is closed early by the client (chrome).
Just a thought, maybe the content-type is not set correctly on the
object?

Yehuda
