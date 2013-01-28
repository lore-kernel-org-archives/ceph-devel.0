From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: can't download from radosgw
Date: Mon, 28 Jan 2013 22:03:31 +0100
Message-ID: <CAJH6TXhebCEigHntyRyD+M-QPtwoObn122u24RhRJidr9FDpFg@mail.gmail.com>
References: <CAJH6TXi90idR13oTxDQCfaSgJh3P8A4h44rHQZSt8uX9kLX02A@mail.gmail.com>
	<CAJH6TXg8fcdTPGHuqyOZvNyrUp1wVGA7AhNx_p+wquvViyowPQ@mail.gmail.com>
	<CAC-hyiELfdbjQQf6K8uFGMeHke9TSeHPbMHXipVZGwPYZENNQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:61664 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab3A1VDc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 16:03:32 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn14so1826940wib.10
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 13:03:31 -0800 (PST)
In-Reply-To: <CAC-hyiELfdbjQQf6K8uFGMeHke9TSeHPbMHXipVZGwPYZENNQw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

2013/1/28 Yehuda Sadeh <yehuda@inktank.com>:
> It looks like the connection is closed early by the client (chrome).
> Just a thought, maybe the content-type is not set correctly on the
> object?

How can I check content-type for the object from radosgw ?
