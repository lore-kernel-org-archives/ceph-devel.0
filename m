From: Ken Dreyer <kdreyer@redhat.com>
Subject: switch "ms bind ipv6" default to "true"?
Date: Tue, 7 Feb 2017 12:33:28 -0700
Message-ID: <CALqRxCxqUP6V0enicL4EM=aeH1Qt5G0vvmcrqQrmAa9TirpLoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:33865 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754509AbdBGTd3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2017 14:33:29 -0500
Received: by mail-ua0-f170.google.com with SMTP id 35so92633037uak.1
        for <ceph-devel@vger.kernel.org>; Tue, 07 Feb 2017 11:33:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

In ceph-ansible we have to determine whether the user wants to bind to
IPv6 or not, and set "ms bind ipv6 = true".

Could we make this easier for users and simply have this as the
default option in Ceph? What is the downside to defaulting ms bind
ipv6 to true?

- Ken
