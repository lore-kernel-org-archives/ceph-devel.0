From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: ceph admin command: debuggging
Date: Thu, 8 Aug 2013 16:04:17 +0200
Message-ID: <20130808160417.3589315c@doppio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from port-212-202-108-184.static.qsc.de ([212.202.108.184]:42048
	"EHLO mail.itxperts.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965571Ab3HHOEU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Aug 2013 10:04:20 -0400
Received: from itxmail.itxperts.de (qgate_dmz.itxperts.de [192.168.160.1])
	by mail.itxperts.de (8.14.0/8.14.0) with ESMTP id r78E5xSP023975
	for <ceph-devel@vger.kernel.org>; Thu, 8 Aug 2013 16:05:59 +0200
Received: from doppio (doppio.itxperts.de [192.168.140.7])
	by itxmail.itxperts.de (Postfix) with ESMTP id E70FD13F02
	for <ceph-devel@vger.kernel.org>; Thu,  8 Aug 2013 17:07:24 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

maybe this is the wrong list - but I am looking for
logging support for the /usr/bin/ceph adminstration
comamand.

This is build from the same source as the ceph daemons are.

For the daemons, logging is controlled for the different
comoponents of a daemon on behalf of configuration file
directives (e.g. "debug ms" for the message I/O).

Can this be applied to the /usr/bin/ceph command, too?
And where would the log file go?


Thanks for any help

Andreas Bluemle

-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm
