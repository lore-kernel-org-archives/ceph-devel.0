From: kefu chai <tchaikov@gmail.com>
Subject: seastar temporary_buffer/packet and ceph::buffer
Date: Mon, 15 Jan 2018 23:49:54 +0800
Message-ID: <CAJE9aOPqAWTatC6sp-_00+w_MPVW52b+1TGL9LS0vc0y+iJq8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33318 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934911AbeAOPt4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jan 2018 10:49:56 -0500
Received: by mail-qt0-f177.google.com with SMTP id e2so14645806qti.0
        for <ceph-devel@vger.kernel.org>; Mon, 15 Jan 2018 07:49:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>, Casey Bodley <cbodley@redhat.com>

hey Casey,


i've been thinking about how to better integrate
seastar::temporary_buffer and seastar::packet into our denc and
messenger subsystems based on your wip-seastar-msg branch.

as you pointed out to me that

> the conversions between ceph::buffer::ptr and seastar::temporary_buffer in https://github.com/cbodley/ceph/tree/wip-seastar-msg/ work, but they cost an allocation in both directions (seastar::make_object_deleter() has to allocate for type erasure).

and just like ceph::buffer::ptr, seastar::temporary_buffer also
manages the life cycle of the underlying memory chunk using refcount.
it's a waste to do the refcounting for the same mem chunk twice in the
same application.

if we want to avoid the overhead of duplicated refcounting and
allocation in the conversion to and from ceph::buffer::ptr, i think,
we need to allocate the temporary_buffer along with buffer::ptr. in
other words, to include seastar::temporary_buffer as a member variable
in ceph::buffer:ptr.

i am preparing a change to prototype this approach. the downside of it is:

- we need to include a placeholder structure in buffer.h for
seastar::tempoary_buffer<char>. and cast it to
seastar::tempoary_buffer<char> in buffer.cc . otherwise we need to
include seastar headers in librados.

cheers,


-- 
Regards
Kefu Chai
