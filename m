From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 09:39:25 +0100
Message-ID: <1395736765.2823.29.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:60178 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075AbaCYIpD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 04:45:03 -0400
Received: from local.plusdinfo.com ([82.232.160.30] helo=[192.168.0.10])
	by licorne.daevel.fr with esmtpsa (SSL3.0:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <ceph.list@daevel.fr>)
	id 1WSMtL-0001C7-6d
	for ceph-devel@vger.kernel.org; Tue, 25 Mar 2014 09:39:27 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

what can/should I do to help fix that problem ?

for now, RBD kernel client hang on : 
        Assertion failure in rbd_img_obj_callback() at line 2131:
           rbd_assert(which >= img_request->next_completion);

or on :
        Assertion failure in rbd_img_obj_callback() at line 2127:
            rbd_assert(img_request != NULL);


I have both case at least once per week, on latest 3.13.5 kernels.

It seems that the problem occurs only on more loaded servers (I have 4
near same servers, and crash occurs on two of them. If I move the VM,
crash follows...).

Olivier

