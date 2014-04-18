From: Alain Dechorgnat <dechorgnata@gmail.com>
Subject: RadosGW admin API
Date: Fri, 18 Apr 2014 11:36:56 +0200
Message-ID: <CAK7XC_k+4epfF81F4kDmq7tS_R39-xpJi69Skw-GcBPrf24exw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:37593 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387AbaDRJg6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Apr 2014 05:36:58 -0400
Received: by mail-la0-f42.google.com with SMTP id ec20so1220459lab.15
        for <ceph-devel@vger.kernel.org>; Fri, 18 Apr 2014 02:36:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I'm working on an administration GUI (Inkscope).
For this, I am using RadosGW admin API from python scripts and it's
working rather well.
I achieve to call getUserInfo for a user

But, in Radosgw admin ops API documentation, it's said for getUserInfo:
" If no user is specified returns the list of all users along with
suspension information."

But when I don't put the uid, I got a 403 Forbidden error.
In the radosgw.log file, I can see that signature is OK, op_mask is OK
but it return 403.
This happens on a Dumpling platform and an Emperor platform.

Is this a bug in the documentation or the code, or am I doing something wrong?

Best regards

Alain Dechorgnat
Orange Labs
