From: TYLin <wooertim@gmail.com>
Subject: cephe-tier forward mode hang in luminous
Date: Tue, 30 Jan 2018 12:28:03 +0800
Message-ID: <CA2ECFED-FE6E-4A8D-B444-DDA613EF1A51@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.6\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36697 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752076AbeA3E2I (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jan 2018 23:28:08 -0500
Received: by mail-pf0-f176.google.com with SMTP id 23so7606107pfp.3
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jan 2018 20:28:08 -0800 (PST)
Received: from [192.168.80.71] (1-171-49-192.dynamic-ip.hinet.net. [1.171.49.192])
        by smtp.gmail.com with ESMTPSA id x64sm18705930pgb.79.2018.01.29.20.28.06
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jan 2018 20:28:07 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

We found that cache-tier forward mode is hanging in luminous 12.2.1. It =
seems that the client is keep sending request to cache-tier's osd and =
the osd always replied redirect to client. This seems due to this patch:

=
https://github.com/ceph/ceph/commit/9adb68f5e206c167b97ec89935cbdaeb462173=
d8#diff-847b3447bebb2f031678eef0a2aea60d

I added =E2=80=9CCEPH_OSD_FLAG_IGNORE_OVERLAY=E2=80=9D to the op to =
force it skips cache-tier when client got redirect reply and it seems to =
work. Is there any potential issue of adding this flag here?

in src/osdc/Objecter.cc
void Objecter::handle_osd_op_reply(MOSDOpReply *m)
{
  =E2=80=A6
  =E2=80=A6
  if (m->is_redirect_reply()) {
    =E2=80=A6
    op->target.flags |=3D (CEPH_OSD_FLAG_REDIRECTED | =
CEPH_OSD_FLAG_IGNORE_OVERLAY);
    ...
  }
}=20


Thanks,
TY Lin=
