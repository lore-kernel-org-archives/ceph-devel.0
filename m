From: Victor Denisov <vdenisov@mirantis.com>
Subject: Cinder doesn't work with the current rados python bindings
Date: Tue, 13 Dec 2016 12:29:06 -0800
Message-ID: <CA+hcxJS_wKucTUetNxPrHTn2j0V6vDUjCwKUTxp176xoCmSmVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:32914 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935849AbcLMU3m (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 15:29:42 -0500
Received: by mail-vk0-f53.google.com with SMTP id 137so79408283vkl.0
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2016 12:29:09 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

Who knows where pybind/rados/rados.pyx came from?
I talked to a guy in the cinder development team - he tried to build
his code against the latest python bindings from master.
It looks like the api's changed. Rados.conf_get('features') used to
return an integer.
It returns a string right now.

I looked into the git history and I see that pybind.pyx has been where
it's right now only since February this year. I presume cinder's using
an older version.

Can someone advise me on how I can track down the changes in python bindings.

Thank you in advance.

Victor.
