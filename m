From: "Shu, Xinxin" <xinxin.shu@intel.com>
Subject: how to enable ENCODE_DUMP debug option for message
Date: Mon, 11 Aug 2014 00:56:27 +0000
Message-ID: <75674D092A819E4189E91166C74CB90D0141EA52@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:24715 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbaHKA4o convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Aug 2014 20:56:44 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Shu, Xinxin" <xinxin.shu@intel.com>


Hi all , 

I want to debug message and noticed that there is  ENCODE_DUMP debug options , I recompile ceph with the following command line :

./do_autogen.sh -d 1 -e /var/message/ -n && make && make install

then excecuted 'rbd ls', but in the /var/message/ directory , the message file did not get created .

any tip about this ? thanks in advance.

Cheers,
xinxin

