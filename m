From: Oleg Kolosov <olekol@gmail.com>
Subject: erasure_code_version() for a new erasure code
Date: Fri, 9 Jun 2017 16:57:12 +0300
Message-ID: <CAODUPsEkkQ-bHzK6vy-AUjtRkvEZZEDNoRHc+E5WHhsrS+uJpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:35393 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdFIN5N (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jun 2017 09:57:13 -0400
Received: by mail-ot0-f180.google.com with SMTP id a2so39189684oth.2
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jun 2017 06:57:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I've written a new erasure code for my study purposes. The code has
compiled, but when trying to set a profile with it I get the following
error:

Error EXDEV: expected plugin
/home/ubuntu/ceph/build/lib/libec_optlrc.so version v10.2.2-9-g31e3fbb
but it claims to be an older version instead

I've traced the error to: ErasureCodePlugin.cc :
  if (erasure_code_version == NULL)
    erasure_code_version = an_older_version;
  if (erasure_code_version() != string(CEPH_GIT_NICE_VER)) {
    *ss << "expected plugin " << fname << " version " << CEPH_GIT_NICE_VER
        << " but it claims to be " << erasure_code_version() << " instead";

For some reason, my definition of erasure_code_version doesn't
propagate as it should.
The ErasureCodePlugin cc file of my code is similar to the other
erasure code. With this defined:
const char *__erasure_code_version() { return CEPH_GIT_NICE_VER; }

Can you think of any reason it should behave like this?
Is there any log or method to discover the reason for this issue?

I'd appreciate your help.

Thanks,
Oleg
