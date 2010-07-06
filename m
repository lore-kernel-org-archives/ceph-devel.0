From: Miguel F Mascarenhas Sousa Filipe <miguel.filipe@gmail.com>
Subject: doubt: inode_t->get_layout_size_increment() is signed.
Date: Tue, 6 Jul 2010 01:16:45 +0100
Message-ID: <AANLkTingtd5NZClFkNsiuzX3phcFTzCeLw4-MiBt_wA9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40537 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab0GFAQr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jul 2010 20:16:47 -0400
Received: by bwz1 with SMTP id 1so3090096bwz.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jul 2010 17:16:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi there,

I'm interested in this project and started now checking out the code
and make it compile...

I got hunting this signed comparison warning:

mds/Locker.cc: In member function =E2=80=98bool
Locker::_do_cap_update(CInode*, Capability*, int, snapid_t,
MClientCaps*, MClientCaps*)=E2=80=99:
mds/Locker.cc:1923: warning: comparison between signed and unsigned
integer expressions

that is related with inode_t->get_layout_size_increment() being signed.
This seems like a bug since it returns a size, but since I don't know
the implications of changing this to uint64_t.. I'm asking..

Is this the right fix?
--------


diff --git a/src/mds/mdstypes.h b/src/mds/mdstypes.h
index b7bfd1d..3054610 100644
--- a/src/mds/mdstypes.h
+++ b/src/mds/mdstypes.h
@@ -379,7 +379,7 @@ struct inode_t {

   bool is_truncating() const { return (truncate_pending > 0); }

-  int64_t get_layout_size_increment() {
+  uint64_t get_layout_size_increment() {
     return layout.fl_object_size * layout.fl_stripe_count;
   }

------

Kind regards,

--=20
Miguel Mascarenhas Filipe
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
