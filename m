From: Meyers Mark <markmeyers.mmy@gmail.com>
Subject: why mds sends a caps message of "zero" inode max size to client when
 finishing "open a new created file" ?
Date: Fri, 1 Sep 2017 21:22:22 +0800
Message-ID: <CACd4Yje4Ovmv=vvYq0LbeHJUkon+=pcSfqdsF2eDe8jbSf2SAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33279 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdIANWX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Sep 2017 09:22:23 -0400
Received: by mail-io0-f171.google.com with SMTP id b2so1321604iof.0
        for <ceph-devel@vger.kernel.org>; Fri, 01 Sep 2017 06:22:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi:
         I followed the open call of file to mds code. And I found
that when finishing open a new file(new created), mds will send a cap
message of inode max size(value of zero) to the client.

        The code in Locker::share_inode_max_size in ceph/src/mds/Server.cc:

        class C_MDS_openc_finish : public ServerLogContext {
        {
                ...
        public:
                void finish(int r) override {
                        ...

get_mds()->locker->share_inode_max_size(newi);//"inode max size" is
zero when opening new file//share_inode_max_size will call
send_message_client_counted to send caps message to client
                        ...
                }
                ...
        }

        The call code:
        void Server::handle_client_openc(MDRequestRef& mdr)//open new file here
        {
                ...
                C_MDS_openc_finish *fin = new C_MDS_openc_finish(this,
mdr, dn, in, follows);
                ...
                journal_and_reply(mdr, in, dn, le, fin);
                ...
        }

        My question is: is this caps message of max inode size(of
zero) redundant? Or is this message for other uses?

       Thanks for your reading, I really appreciate your rely. Thanks!

Best Regards!
Mark Meyers
