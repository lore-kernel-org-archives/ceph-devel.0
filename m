From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: can't download from radosgw
Date: Mon, 28 Jan 2013 12:55:24 +0100
Message-ID: <CAJH6TXg8fcdTPGHuqyOZvNyrUp1wVGA7AhNx_p+wquvViyowPQ@mail.gmail.com>
References: <CAJH6TXi90idR13oTxDQCfaSgJh3P8A4h44rHQZSt8uX9kLX02A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:42652 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab3A1Lz0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 06:55:26 -0500
Received: by mail-wi0-f182.google.com with SMTP id hn14so1335215wib.9
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 03:55:25 -0800 (PST)
In-Reply-To: <CAJH6TXi90idR13oTxDQCfaSgJh3P8A4h44rHQZSt8uX9kLX02A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

2013/1/28 Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>:
> 2013-01-28 12:22:27.759162 7fe8657c3700  0 NOTICE: failed to send
> response to client
> 2013-01-28 12:22:27.759186 7fe8657c3700  0 ERROR: s->cio->print()
> returned err=-1
> 2013-01-28 12:22:27.759206 7fe8657c3700  0 ERROR: s->cio->print()
> returned err=-1
> 2013-01-28 12:22:27.759211 7fe8657c3700  0 ERROR: s->cio->print()
> returned err=-1
> 2013-01-28 12:22:27.759216 7fe8657c3700  0 ERROR: s->cio->print()
> returned err=-1
> 2013-01-28 12:22:27.759268 7fe8657c3700  2 req 128:0.051384:s3:GET
> /public2/shared/9780470398661.pdf:get_obj:http status=403
> 2013-01-28 12:22:27.759336 7fe8657c3700  1 ====== req done
> req=0x3192980 http_status=403 ======


This happens only with Google Chrome.
Firefox, curl, wget and many other are able to download properly.
