From: =?gb2312?B?zNW2rLas?= <tdd21151186@gmail.com>
Subject: Message decode issue
Date: Tue, 23 Jan 2018 16:25:36 +0800
Message-ID: <1240D552-284C-4C9C-A114-BFAE7F537D95@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:37560 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeAWIZl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jan 2018 03:25:41 -0500
Received: by mail-io0-f172.google.com with SMTP id f89so53728ioj.4
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jan 2018 00:25:41 -0800 (PST)
Received: from [127.0.0.1] ([104.207.157.57])
        by smtp.gmail.com with ESMTPSA id z84sm9276949ioi.23.2018.01.23.00.25.38
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 00:25:40 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Dear Cephers,

below is a piece of code in Message::decode_message:
```
// m->header.version, if non-zero, should be populated with the
  // newest version of the encoding the code supports.  If set, check
  // it against compat_version.
  if (m->get_header().version &&
      m->get_header().version < header.compat_version) {
    if (cct) {
      ldout(cct, 0) << "will not decode message of type " << type
                    << " version " << header.version
                    << " because compat_version " << =
header.compat_version
                    << " > supported version " << =
m->get_header().version << dendl;
      if (cct->_conf->ms_die_on_bad_msg)
        ceph_abort();
    }  =20
    m->put();
    return 0;
  }
```
I know it=A1=AFs checking the compatibility of the incoming message.
but, i think it=A1=AFs not sufficient, it only checked if the coming =
message=A1=AFs compat_version is bigger than our version (if it=A1=AFs =
true, the message is not supported)
it should also check if the comming message=A1=AFs version  is smaller =
than our compat_version, right ?
please correct me if i=A1=AFm wrong.

Regards,
Dongdong=
