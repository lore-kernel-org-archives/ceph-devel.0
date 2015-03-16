From: Xinze Chi <xmdxcxz@gmail.com>
Subject: crc error when decode_message?
Date: Mon, 16 Mar 2015 20:02:29 +0800
Message-ID: <CANE=7sWQaG8PZYEU9OsjkmU6GB6jKhcnSG1cm6o38EeMb65pGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33434 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbbCPMCa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Mar 2015 08:02:30 -0400
Received: by obcxo2 with SMTP id xo2so33576016obc.0
        for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2015 05:02:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all:

      I want to know what is the behavior of primary when
decode_message crc error , such as read

ack response message from remote peer?

      Thanks.
