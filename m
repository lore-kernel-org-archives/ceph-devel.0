From: Ketor D <d.ketor@gmail.com>
Subject: [Ceph-Dokan] A Windows CephFS Client Project
Date: Wed, 7 Jan 2015 12:09:21 +0800
Message-ID: <CAM9_UU_4bnWVVf3bC8wnggNmF5O+HUshZn_xP-_ELiW3kqt=+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:48581 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbbAGEJw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jan 2015 23:09:52 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so1468889obc.1
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jan 2015 20:09:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi everyone,

A new project ceph-dokan (https://github.com/ceph/ceph-dokan) is
open-source to all now.
You can access the cephfs on Windows directly using ceph-dokan, not by
smb or whatever.
And you will get the full experience and performance of cephfs on Windows now.

Here is something about this project you may want to know.

     Overview.
         ceph-dokan is build on MinGW. It will provide ceph-dokan.exe
and libcephfs.dll.
         ceph-dokan.exe makes you use CephFS as a volume like your [C:] or [D:].
         libcephfs.dll is a lib you can write your own application using CephFS.

      Features:
         Support almost windows filesystem api's.
         Support ACL from Linux.
         Support CreateFile of temp file.
         Support Microsoft Office file edit and save.
         etc.

      Internal:
         ceph-dokan is ported from upstream Ceph. It was first ported
as a standalone Ceph Client and then portd to Cygwin. But Cygwin is
too slowly and not native code so it was ported to MinGW later. And
with dokan(like fuse), now ceph-dokan map cephfs as a volume on
windows.
         ceph-dokan is fully native win32 code and compiled by gcc. So
its performace is very good. Also it use winsock2 instead of linux
socket and select() instead of poll(). And etc....

Everyone who have experience on dokan, mingw, win32 can help to
improve ceph-dokan by pull request or using ceph-devel mailing list.

Thanks!
 Ketor
