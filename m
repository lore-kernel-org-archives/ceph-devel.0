From: Casey Bodley <cbodley@redhat.com>
Subject: fio engine for ObjectStore
Date: Tue, 12 Jul 2016 15:17:19 -0400
Message-ID: <ca66f88b-2cb7-6bf6-b44f-671957aeeae1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35309 "EHLO
	mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbcGLTRW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jul 2016 15:17:22 -0400
Received: by mail-qt0-f169.google.com with SMTP id j35so13677212qtj.2
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jul 2016 12:17:21 -0700 (PDT)
Received: from [10.17.151.34] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id p83sm1207804qkh.49.2016.07.12.12.17.20
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2016 12:17:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi all,

I've rebased the fio objectstore work and reopened a pull request at 
https://github.com/ceph/ceph/pull/10267. I hope that it can be useful to 
the folks working on bluestore. You can find a README and examples in 
src/test/fio/.

Casey
