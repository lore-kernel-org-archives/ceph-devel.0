From: Yang Joseph <joseph.yang@xtaotech.com>
Subject: rgw: object header name looks strange
Date: Tue, 6 Sep 2016 18:01:07 +0800
Message-ID: <57CE93E3.5020302@xtaotech.com>
References: <57CE80CA.1070102@xtaotech.com> <57CE89A1.6090705@xtaotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr213139.mail.yeah.net ([223.252.213.139]:36952 "EHLO
        mr213139.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756099AbcIFKBN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2016 06:01:13 -0400
In-Reply-To: <57CE89A1.6090705@xtaotech.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: joseph.yang@xtaotech.com

hello,

I put/get a object named '_MMM' with my hammer version rgw. The put/get 
works well.

But the object header name is :

   rgwltt-rgwltt.154100.20___MMM rgwltt-rgwltt.154100.20__MMM

Question 1: Is this the expect result? Why its name not in this style:

${bucket id}_${object name}
Question 2: Why the first underscore is escaped into two underscores?

Your response will be greatly appreciated!

thx,

Yang Honggang

