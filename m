From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Bug #630
Date: Thu, 24 Feb 2011 15:13:53 +0800
Message-ID: <AANLkTi=o9qXJr+SgPZmYtSZ0eZ6q5dyaZQd+eKmqbEVW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34885 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932535Ab1BXHNy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 02:13:54 -0500
Received: by gxk8 with SMTP id 8so127576gxk.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Feb 2011 23:13:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I want to confirm if the following problem is related to Bug #630.

Step 1. On client A, create a file of 10G by dd.
"ceph -w" shows the total data size increased by 10G.

Step 2. On client B, touch the file.

Step 3. On client A, remove the file.
"ceph -w" shows the total data size is NOT decreased.

Step 4. Umount ceph on client B.
"ceph -w" shows the total data size decreased by 10G.

-- 
Henry Chang
