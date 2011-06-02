From: biyan chen <riby.chen@gmail.com>
Subject: write file problems
Date: Thu, 2 Jun 2011 17:35:59 +0800
Message-ID: <BANLkTimbwCo1yJ3vJ5qc6QbELAdZdwZGHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46228 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933137Ab1FBJf7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 05:35:59 -0400
Received: by yxs7 with SMTP id 7so257450yxs.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jun 2011 02:35:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ceph file systems, write file will be no reaction, namely dead state

For example:

Dd if = / a dev/zero of = MMM bs = 8k = 100 count


Will have been waiting!


And then other SSH window using command "ls -al" is no  reaction!


Thanks!
