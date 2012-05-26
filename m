From: Xiaopong Tran <xiaopong.tran@gmail.com>
Subject: Question regarding API doc
Date: Sat, 26 May 2012 11:08:31 +0800
Message-ID: <4FC0492F.3080901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43175 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab2EZDJ7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 May 2012 23:09:59 -0400
Received: by dady13 with SMTP id y13so1961650dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 25 May 2012 20:09:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm looking at the description in this API:

http://ceph.com/docs/master/api/librados/#rados_objects_list_next

For the parameters entry and key, the doc said "(caller must free)".
I looked up in the code, and found this statement in the doc
a bit misleading.

Is the doc outdated, or did I miss anything?

Cheers

xp
