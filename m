From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: OSD hardware suggestion
Date: Tue, 13 Nov 2012 15:13:27 +0100
Message-ID: <CAJH6TXj28F9994OyLWhz5yjECW3QUtMtZv5K4F6V-_vkwOoEPw@mail.gmail.com>
References: <CAJH6TXha_jTHocYATAHY_EYqo5zCT1rwtg9jxv6XkAg6mwPH-w@mail.gmail.com>
	<50A1FE92.1040007@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37385 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860Ab2KMON2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 09:13:28 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so4005809eek.19
        for <ceph-devel@vger.kernel.org>; Tue, 13 Nov 2012 06:13:27 -0800 (PST)
In-Reply-To: <50A1FE92.1040007@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

2012/11/13 Josh Durgin <josh.durgin@inktank.com>:
> You'll be better off with more nodes so that when 1 dies, 1/3 of your
> data doesn't need to be re-replicated.

Absolutely, 3 servers are just for startup.
