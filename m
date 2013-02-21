From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: pg stuck in peering
Date: Thu, 21 Feb 2013 11:43:53 +0100
Message-ID: <CAJH6TXizbuz-hoH-sxCe3H724BM2DDAuOuJduNwCiZAnK_txrw@mail.gmail.com>
References: <CAJH6TXiVQ8cqyL5Z-XKz8PqjyuVyg=wM67eg5830sMSp546ReA@mail.gmail.com>
	<CAD3n6hEzrMACSbFygh7=PM2z4zmXzKQ=n8oY7WiYy5JKUqMx2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:57854 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab3BUKnz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Feb 2013 05:43:55 -0500
Received: by mail-wi0-f169.google.com with SMTP id l13so562610wie.4
        for <ceph-devel@vger.kernel.org>; Thu, 21 Feb 2013 02:43:54 -0800 (PST)
In-Reply-To: <CAD3n6hEzrMACSbFygh7=PM2z4zmXzKQ=n8oY7WiYy5JKUqMx2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin B Nielsen <martin@unity3d.com>
Cc: ceph-devel@vger.kernel.org

2013/2/21 Martin B Nielsen <martin@unity3d.com>:
> Can you supply more information? You have some pgs down - seems like
> you have some osd down; can you list output of ceph osd tree and
> verify all your osd are actually running?

I have one osd down, but I'm unable to start it.
Running "service ceph restart" on the node doesn't restart anything.

Running "service ceph -a restart" from the main node, will restart all
services but that osd is always down and nothing is logged.
