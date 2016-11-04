From: kefu chai <tchaikov@gmail.com>
Subject: debug coredump on teuthology
Date: Fri, 4 Nov 2016 18:56:16 +0800
Message-ID: <CAJE9aOOy503R8HAjhqOKA0RCfZA9y67h0JQfFzcXaFSZr6Fs5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35544 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761309AbcKDK4S (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2016 06:56:18 -0400
Received: by mail-qt0-f176.google.com with SMTP id c47so45424880qtc.2
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2016 03:56:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Brad Hubbard <bhubbard@redhat.com>

hi ceph developers,

i just pulled together a simple script at
https://github.com/tchaikov/sepia-bt/blob/master/bt.sh for debugging
the coredump on teuthology. what it does is

1. download the ceph packages
2. extract them so we have the debugged executable and symbols
3. launch gdb and set the necessary paths

et voil=C3=A0!

the idea of this script comes from badone (Brad). i just translate it
into a shell script.

pull requests welcomed!


have a nice Friday!

--=20
Regards
Kefu Chai
