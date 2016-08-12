From: Marcel Lauhoff <lauhoff@uni-mainz.de>
Subject: veintidos: Prototype of a content-addressed storage client for Ceph
Date: Fri, 12 Aug 2016 18:15:32 +0200
Message-ID: <87wpjm0xqz.fsf@uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgate-01.zdv.uni-mainz.de ([134.93.178.241]:60235 "EHLO
	mailgate-01.zdv.uni-mainz.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752433AbcHLQ1U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Aug 2016 12:27:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

I already introduced the current outcome of my work on Ceph
deduplication on the last CDM, but I thought it might be a good idea to
do so on the list as well :).

tl;dr:
There is now a client tool / library to use a Ceph pool as
content-addressed storage.
It writes data with object names equal to the data's hash.
Two times the same data therefore yields only one object with a reference count of 2.


More detailed design description and documentation is on github:
https://github.com/irq0/veintidos


Unfortunately / fortunatly I can't continue to work on bringing the
prototype to C++ or improving it otherwise, since i'll go on an extended
vacation till end of this year pretty soon..


In the long run, I think,  it could be nice for archives ( iRODS?) or as an
alternative to the Striper in RGW.


Please let me know what you think,

~marcel

--
Marcel Lauhoff
Mail: lauhoff@uni-mainz.de
XMPP: mlauhoff@jabber.uni-mainz.de
