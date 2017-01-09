From: Alfredo Deza <adeza@redhat.com>
Subject: Jenkins went offline for 13 hours (repos are affected)
Date: Mon, 9 Jan 2017 08:09:05 -0500
Message-ID: <CAC-Np1yMqKO7NmUaQXMfJA1D7XXUfG4tJfqwOrGuJWnO3FsscA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33196 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939793AbdAINJG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2017 08:09:06 -0500
Received: by mail-qt0-f175.google.com with SMTP id v23so134787440qtb.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jan 2017 05:09:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The hosting provider for Jenkins had the main Jenkins instance shut
off late Sunday night. This was corrected today at about 1pm UTC.

What this means for you:

If you are waiting for repos/binaries from Sunday, it would be safer
to rebuild them if they don't show up in shaman.ceph.com/builds/ceph
or if what shows up doesn't correlate with the latest commits in the
branch.

Sorry for any issues this may have caused.


-Alfredo
