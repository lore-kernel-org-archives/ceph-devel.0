From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: OSD's journal size
Date: Tue, 7 Aug 2012 09:18:08 +0200
Message-ID: <CAOLwVU=SjpOAAYNohhMN4oYZqTXMEQkTrCjW7L+E+Dr5M=mNBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33940 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab2HGHSa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 03:18:30 -0400
Received: by lbbgm6 with SMTP id gm6so3277260lbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Aug 2012 00:18:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi everyone,

I did a couple of research about journal's size on the Internet but I
didn't find any good results.

How do you calculate the 'ideal/required' size of an OSD journal? I
suppose that the calculation is based on the disk size, but...

Thank you in advance.

Cheers!
