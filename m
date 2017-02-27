From: Dan van der Ster <dan@vanderster.com>
Subject: Fixed URL for latest branch shaman build?
Date: Mon, 27 Feb 2017 15:21:13 +0100
Message-ID: <CABZ+qqk+ni5ACoRaRqTd75G77sDMvXnzuSQT7pwyiM8z0tsnMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33795 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbdB0O2b (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2017 09:28:31 -0500
Received: by mail-wr0-f177.google.com with SMTP id l37so9340279wrc.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 06:28:30 -0800 (PST)
Received: from mail-wr0-f178.google.com (mail-wr0-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id q12sm14525358wmd.8.2017.02.27.06.21.54
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Feb 2017 06:21:54 -0800 (PST)
Received: by mail-wr0-f178.google.com with SMTP id u108so23322026wrb.3
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 06:21:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

tl;dr: Is there a fixed URL which points to the latest jewel build on shaman?

We used to use gitbuilder.ceph.com (via a caching proxy) to
occasionally run the latest build for a given branch. This was
convenient -- we'd just set a yum repo with url

   http://gitbuilder.ceph.com/ceph-rpm-centos7-x86_64-basic/ref/jewel/x86_64/

And it would always point to the build for the latest commit.

Now with shaman, unless I'm mistaken, we have a unique repo for each
build. E.g. here's the latest build's repo:

https://1.chacra.ceph.com/r/ceph/jewel/ac3ba2adcd21ac011ad556ac4506623e61fbe696/centos/7/flavors/default/x86_64/

So I think what I'm asking for is a symlink 'latest' which we can use like this:

  https://1.chacra.ceph.com/r/ceph/jewel/latest/centos/7/flavors/default/x86_64/

Is there someway to do this with shaman?

Cheers, Dan
