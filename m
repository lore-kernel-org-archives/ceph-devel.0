From: ming zhang <ming.zhang.china@gmail.com>
Subject: how client handle the errors with OSD and MDS?
Date: Tue, 26 Jun 2012 13:28:12 -0400
Message-ID: <CAGffWzo65eSRSr05No8u6hAoJtUwZPDRft5Mj2CbGLF23yfa0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63616 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758499Ab2FZR2N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 13:28:13 -0400
Received: by wgbdr13 with SMTP id dr13so150049wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 10:28:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All

I am trying to read the code to understand this.

A scenario like this.

client opens the file and finishes the write with OSD. But for some
reason Client could not contact MDS and fails to update MDS. What will
client do now in order to maintain the rightness of metadata in MDS?

Wonder which code this error handling is implemented?

Thanks

Ming
