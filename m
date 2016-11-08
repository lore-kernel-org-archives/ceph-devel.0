From: John Spray <jspray@redhat.com>
Subject: libcephfs ABI change in Kraken
Date: Tue, 8 Nov 2016 10:27:41 +0000
Message-ID: <CALe9h7cDc=qTV+XBy9aEh4AV=HJRPj27t5N_t9Y80RrBgpbfQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35192 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932185AbcKHK2D (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 05:28:03 -0500
Received: by mail-lf0-f48.google.com with SMTP id b14so135440496lfg.2
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 02:28:02 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

For anyone building software against the libcephfs interface, we have
a library version bump in Kraken[1].  This change was necessary
because the old interface was not sufficient to do permissions
checking correctly in some cases.

The libcephfs1 package has been replaced with the libcephfs2 package.
This will affect anyone who is building Samba or NFS-Ganesha packages
with the cephfs modules enabled.  Jeff has patches to switch Samba and
Ganesha to the new interface which should follow shortly.

Cheers,
John


1. https://github.com/ceph/ceph/pull/11647
