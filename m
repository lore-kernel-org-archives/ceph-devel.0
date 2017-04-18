From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Filestore directory splitting (ZFS/FreeBSD)
Date: Tue, 18 Apr 2017 12:12:32 +0200
Message-ID: <bc464b95-08f7-d627-df00-00e9200ff259@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:35065 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755359AbdDRKMh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Apr 2017 06:12:37 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 3EEA61D14A
        for <ceph-devel@vger.kernel.org>; Tue, 18 Apr 2017 12:12:34 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I'm running some alrger tests with ceph-fuse on FreeBSD, and noticed
that I start to run into directory splitting I think?
I just Rsynced my full src and ports tree into it, which is like >
1.000.000 small files.
At least I saw a rather large number of directories with relatively few
files in them.

I know from UFS that large directories used to be a problem, although
some of the issues on FreeBSD have been fixed long ago.

So can anybody explain the rationale behind this process and give a bit
of a feeling why we start splitting at 320 files??

FreeBSD's filestore runs of ZFS, and From waht I've seen thusfar is that
ZFS has a different (better) behaviour with large directories.
(I once ended up with > 1.000.000 security cam pictures in one
directory, and that still was sort of workable.)

So has there been any testing to quatify the settings? And how would I
be able to determine if ZFS deserves better/larger settings?

--WjW
