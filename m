From: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Subject: Re: pg stuck in peering
Date: Thu, 21 Feb 2013 13:23:52 +0100
Message-ID: <512611D8.6050203@risc-software.at>
References: <CAJH6TXiVQ8cqyL5Z-XKz8PqjyuVyg=wM67eg5830sMSp546ReA@mail.gmail.com> <CAD3n6hEzrMACSbFygh7=PM2z4zmXzKQ=n8oY7WiYy5JKUqMx2g@mail.gmail.com> <CAJH6TXizbuz-hoH-sxCe3H724BM2DDAuOuJduNwCiZAnK_txrw@mail.gmail.com> <5126028C.80008@risc-software.at> <CAJH6TXg_Kq=Mgk_PJVhG+sVZEp-kLsMAJw7d2bKM=YN1550F9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from email.edvz.uni-linz.ac.at ([140.78.3.65]:33442 "EHLO
	email.uni-linz.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3BUMXy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Feb 2013 07:23:54 -0500
In-Reply-To: <CAJH6TXg_Kq=Mgk_PJVhG+sVZEp-kLsMAJw7d2bKM=YN1550F9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org



On 02/21/2013 12:32 PM, Gandalf Corvotempesta wrote:

> all dirs are mounted.
> I have to manually restart many many time to get all osd up. Seems to be random.

this should not happen. unstable networking connection? have you checked
tail -f /var/log/syslog on your ceph-hosts?

> If ceph status is not in HELTH_OK, radosgw doesn't start at all. Is this ok?

what does ceph osd tree say?
what is the output of ceph health detail?

I don't have experience with radosgw, sorry.


-- 
DI (FH) Wolfgang Hennerbichler
Software Development
Unit Advanced Computing Technologies
RISC Software GmbH
A company of the Johannes Kepler University Linz

IT-Center
Softwarepark 35
4232 Hagenberg
Austria

Phone: +43 7236 3343 245
Fax: +43 7236 3343 250
wolfgang.hennerbichler@risc-software.at
http://www.risc-software.at
