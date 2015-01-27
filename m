From: Dennis Chen <kernel.org.gnu@gmail.com>
Subject: [Questions]Can client know which OSDs are storing the data?
Date: Tue, 27 Jan 2015 15:07:12 +0800
Message-ID: <CA+U0gViDOis_9-46kp1GjED5Gq6NN98WeDpdJF2pbB9FOa3CzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:53879 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbbA0HHd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jan 2015 02:07:33 -0500
Received: by mail-pa0-f53.google.com with SMTP id kx10so16681535pab.12
        for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2015 23:07:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Dennis Chen <kernel.org.gnu@gmail.com>

Hello Guys,

My question is very rude and direct, a little bit stupid maybe ;-)

Question a: a client write a file to the cluster (supposing replica =
3), so the data will be stored in 3 OSDs within the cluster, can I get
the information of which OSDs storing the file data in client side?

Question b: can the object data still be replicated if I store a
object from client with RADOS API?

Thank you guys !
-- 
Den
