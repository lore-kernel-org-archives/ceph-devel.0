From: Alfredo Deza <adeza@redhat.com>
Subject: LUKS encryption in OSDs (ceph-volume)
Date: Tue, 12 Dec 2017 14:27:44 -0500
Message-ID: <CAC-Np1z_Kv1sSBzPXvsiQ7GubioSwQZnMMtuJL4Z3SUXR2L1fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:37116 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752134AbdLLT1p (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Dec 2017 14:27:45 -0500
Received: by mail-qt0-f171.google.com with SMTP id f2so50156867qtj.4
        for <ceph-devel@vger.kernel.org>; Tue, 12 Dec 2017 11:27:45 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

We have started looking into encryption support in ceph-volume, and
one of the unclear paths is if we really want to support both "plain"
and "LUKS".

According to the cryptsetup docs [0] :

    (LUKS) is now the preferred way to set up disk encryption with
dm-crypt using the cryptsetup utility


ceph-disk supports both plain and LUKS, but moving forward, I was
interested in understanding if anyone is really expecting the "plain"
type to be a choice?

The legacy support will mean that ceph-volume will have to deal with
"plain", but moving forward it might be easier if we are supporting a
single type of encryption with LUKS.
