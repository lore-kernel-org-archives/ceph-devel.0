From: Ken Dreyer <kdreyer@redhat.com>
Subject: understanding Ubuntu's package version numbers for Ceph
Date: Mon, 22 May 2017 16:04:06 -0600
Message-ID: <CALqRxCxd=TVLumgwkRVeRBYOQr3m4mFsY4zd8026zvVJk9OZOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:35339 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934403AbdEVWEI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 May 2017 18:04:08 -0400
Received: by mail-ua0-f179.google.com with SMTP id y4so61466522uay.2
        for <ceph-devel@vger.kernel.org>; Mon, 22 May 2017 15:04:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: james.page@ubuntu.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi James,

The latest distro version of Ceph in Xenial is 10.2.7-0ubuntu0.16.04.1

Would you mind breaking down those version numbers for me?

I'm guessing it's like this?

"10.2.7": this is the upstream version from ceph.com

"0ubuntu":
 The "0" signifies that 10.2.7 is not yet in Debian, otherwise it would be "1"?
 The "ubuntu" signifies that it is not a clean copy from Debian?

"0.16.04"
 Why does this part start with "0."?
 16.04 seems simple enough :)

".1"
 Guessing this is a simple "release" number that you increment each
time you build and ship v10.2.7 for Xenial? Is there anything more to
it?


One of the reasons I'm asking is that historically we've tacked on
"trusty" or "xenial" to the ceph.com builds, so we have

  ceph_10.2.7-1trusty_amd64.deb
  ceph_10.2.7-1xenial_amd64.deb

...and Apt and do-release-upgrade would treat "1xenial" as higher than
"1trusty", so upgrades work. But when Artful Aardvark is available,
1artful will sort lower than 1xenial, so we should probably change our
strategy. What do you think?

- Ken
