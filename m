From: James Harper <james.harper@bendigoit.com.au>
Subject: libuuid vs boost uuid
Date: Sat, 9 Nov 2013 05:59:17 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B665E1FB8@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.bendigoit.com.au ([203.16.207.99]:38811 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721Ab3KIGWJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 01:22:09 -0500
Received: from bitcom1.int.sbss.com.au ([2002:cb10:e0fe:201:a5ca:4fd3:14f:ad5d])
	by smtp2.bendigoit.com.au with esmtp (Exim 4.80)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1Vf1Zm-0006UD-Ug
	for ceph-devel@vger.kernel.org; Sat, 09 Nov 2013 16:59:18 +1100
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Just out of curiosity (recent thread about windows port) I just had a quick go at compiling librados under mingw (win32 cross compile), and one of the errors that popped up was the lack of libuuid under mingw. Ceph appears to use libuuid, but I notice boost appears to include a uuid class too, and it seems that ceph already uses some of boost (which already builds under mingw).

Is there anything special about libuuid that would mean boost's uuid class couldn't replace it? And would it be better to still use ceph's uuid.h as a wrapper around the boost uuid class, or to modify ceph to use the boost uuid class directly?

Thanks

James
