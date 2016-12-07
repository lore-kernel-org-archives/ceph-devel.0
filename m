From: =?UTF-8?B?5YiY55WF?= <liuchang0812@gmail.com>
Subject: [SUGGESTION]Should we provide a method to get git's branch name and
 commit tag?
Date: Wed, 7 Dec 2016 21:09:57 +0800
Message-ID: <CACKY0b8Y1JFqu-qD-XXUx9ZtLitfFuEaSqamEGK4fD=SspoziA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36407 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbcLGNJ6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2016 08:09:58 -0500
Received: by mail-qk0-f194.google.com with SMTP id h201so48063138qke.3
        for <ceph-devel@vger.kernel.org>; Wed, 07 Dec 2016 05:09:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi, all

For example, we could register a command "build info" to
CephContext::_admin_sock. I would like to implement it if it's useful
and necessary.

Thanks.
