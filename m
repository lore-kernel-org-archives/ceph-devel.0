From: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Subject: Re: pg stuck in peering
Date: Thu, 21 Feb 2013 12:18:36 +0100
Message-ID: <5126028C.80008@risc-software.at>
References: <CAJH6TXiVQ8cqyL5Z-XKz8PqjyuVyg=wM67eg5830sMSp546ReA@mail.gmail.com> <CAD3n6hEzrMACSbFygh7=PM2z4zmXzKQ=n8oY7WiYy5JKUqMx2g@mail.gmail.com> <CAJH6TXizbuz-hoH-sxCe3H724BM2DDAuOuJduNwCiZAnK_txrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from email.edvz.uni-linz.ac.at ([140.78.3.65]:62766 "EHLO
	email.uni-linz.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab3BUL3i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Feb 2013 06:29:38 -0500
In-Reply-To: <CAJH6TXizbuz-hoH-sxCe3H724BM2DDAuOuJduNwCiZAnK_txrw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 02/21/2013 11:43 AM, Gandalf Corvotempesta wrote:

> I have one osd down, but I'm unable to start it.
> Running "service ceph restart" on the node doesn't restart anything.
> 
> Running "service ceph -a restart" from the main node, will restart all
> services but that osd is always down and nothing is logged.

try sevice ceph -a restart osd.X (where X is the osd number) - maybe
that helps. and check the kernel-logs, is the osd-directory mounted?
