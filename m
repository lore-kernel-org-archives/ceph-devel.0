From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: RGW: removal of support for fastcgi
Date: Fri, 5 May 2017 12:51:06 -0700
Message-ID: <CADRKj5SSio-vpfSBgJbEWTZC2HDqnWQsYd6K0auy-=F7PpBVeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33326 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdEETvH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 5 May 2017 15:51:07 -0400
Received: by mail-qk0-f174.google.com with SMTP id n4so14235172qkc.0
        for <ceph-devel@vger.kernel.org>; Fri, 05 May 2017 12:51:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

RGW has supported since forever. Originally it was the only supported
frontend, and nowadays it is the least preferred one.

Rgw was first developed over fastcgi + lighttpd, but there were some
issues with this setup, so we switched to fastcgi + apache as our main
supported configuration. This was also sub-optimal, as there wasn't a
good, supported, and mainained fastcgi module for apache that we could
find. At the time there were two modules: mod_fcgid, and mod_fastcgi.
The former had a major flaw, which it buffered all PUTs before sending
them to the backend (rgw). It also didn't really support 100-continue.
The latter was mostly unmaintained, and didn't quite support
100-continue either. We ended up maintaining a fork of mod_fastcgi for
quite a while, which was a pain. Later came mod-proxy-fcgi, which also
didn't fully support 100-continue (iirc), but it was maintained, and
was good enough to use out of the box, so we settled on it. At that
time we already had civetweb as a frontend, so we didn't really worry
about it.
Now, I'd like to know whether anyone actually uses and needs fastcgi.
I get an occasional request to remove it altogether, and I'd like to
have some more info before we go and do it. The requests for removal
usually cite security reasons, but I can also add 'we don't really
want to maintain it anymore'.
A valid replacement for fastcgi could be using civetweb directly, or
using mod-proxy (in apache, I'd expect similar solution in other
webservers) with civetweb as the rgw frontend.

TL;DR: Does anyone care if we remove support for fastcgi in rgw?

Yehuda
