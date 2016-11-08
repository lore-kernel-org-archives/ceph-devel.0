From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Seeking help in getting run-tox-ceph-detect-init to work.
Date: Tue, 8 Nov 2016 23:57:23 +0100
Message-ID: <6a74274e-4134-183c-f8fa-a180b5a93783@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:64519 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752999AbcKHW5c (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 8 Nov 2016 17:57:32 -0500
Received: from [192.168.10.10] (asus [192.168.10.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 5CD8C27FD2
        for <ceph-devel@vger.kernel.org>; Tue,  8 Nov 2016 23:57:24 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I'm looking for a developer with more Python experience....
Especially with getting things thru tox.

I was able to add FreeBSD support to ceph-detect-init in #11829. But
then that is tested in run-tox-detect-init. Which now fails in a Linux
Jenkins run:
https://jenkins.ceph.com/job/ceph-pull-requests/13621/consoleFull#124607955c19247c4-fcb7-4c61-9a5d-7e2b9731c678

But that heavily depends on mock and variations on
platform.linux_distribution(), which is over my head.

Like:
    def test_get(self):
        g = ceph_detect_init.get
       with mock.patch('platform.linux_distribution',
                        lambda **kwargs: (('unknown', '', ''))):
            self.assertRaises(exc.UnsupportedPlatform, g)

Which hits the assert because linux_distribution() returns
	(' ', ' ', ' ')
and the system info needs to be extracted from other functions.

The brutal way would be to override this test, but the question then is
with what? Because there is no one function that returns the required
values. So the code would be a copy from what is in the _init_.py code.

And that feels like a butcher testing his own meat.

So help very much welcomed,
--WjW


