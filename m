From: Ning Yao <zay11022@gmail.com>
Subject: why keep and update rollback info for ReplicatedPG?
Date: Wed, 11 Nov 2015 10:55:51 +0800
Message-ID: <CALZt5jxtuTMHTrN89wPs==-wn7mAm7mkHGN7rxatyC+YVYLryg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36378 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbKKCzw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 21:55:52 -0500
Received: by wmww144 with SMTP id w144so142985375wmw.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 18:55:51 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

As I know, rollback is designed for ec-backend to rollback the partial
committed transaction like append, stash and attrs.
So why do we need to keep and update (can_rollback_to,
rollback_info_trimmed_to) every time in _write_log() for
ReplicatedBackend? Or it is related to other issues?
We may avoid frequently updating those information based on the pool types?

Regards
Ning Yao
