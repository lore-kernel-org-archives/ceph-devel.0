From: Joe Buck <jbbuck@gmail.com>
Subject: Seeking review of a pull request in teuthology
Date: Wed, 24 Oct 2012 18:20:55 -0700
Message-ID: <508893F7.4070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36579 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178Ab2JYBU4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 21:20:56 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so762003pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Oct 2012 18:20:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I submitted a pull request for teuthology/task/workunit.py that uses the 
configured owner rather than using the hard-coded "ubuntu" username when 
creating a scratch directory in /tmp.

-Joe Buck
