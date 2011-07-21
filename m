From: Jojy Varghese <jojy.varghese@gmail.com>
Subject: Consistency vs efficiency
Date: Thu, 21 Jul 2011 09:36:46 -0700
Message-ID: <CAJD3hpW_WjumjD1P1bOhwXWPZieQxyay0HOCH8AFpXfQCT4HMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63667 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab1GUQgq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2011 12:36:46 -0400
Received: by gxk21 with SMTP id 21so734963gxk.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2011 09:36:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
  I just started looking at the ceph code in kernel and had a question
about performance considerations for lookup operations. I noticed that
for every operation (say copying a directory), the root dentry is
"looked" up multiple times and since they all go to MDS for the actual
lookup operation, it effects the performance. I am sure consistency is
the winner here. Is there any plan to improve this, maybe by having
MDS push the capability down to the clients when the dentry is
updated. So say from CAP_EXCL to CAP_SHARED when the dentry is
modified. This was the client node can cache the lookup operation and
does not have to make a round trip to the MDS.

thanks in advance,
Jojy
