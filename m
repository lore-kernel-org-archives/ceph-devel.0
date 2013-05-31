From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: caller_ops.size error messages upstream/cuttlefish
Date: Fri, 31 May 2013 14:32:56 +0200
Message-ID: <CAF6-1L4NYJ6kD=vbma1JB4Jh+h6PN53H1nUcPz=wOv66sj=5Gg@mail.gmail.com>
References: <51A88E04.5040405@profihost.ag>
	<51A89626.6040201@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:45994 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089Ab3EaMc6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 08:32:58 -0400
Received: by mail-bk0-f54.google.com with SMTP id it16so722825bkc.27
        for <ceph-devel@vger.kernel.org>; Fri, 31 May 2013 05:32:56 -0700 (PDT)
In-Reply-To: <51A89626.6040201@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Just as FYI, I also had a couple of those messages last night when
adding a couple new OSDs.

[ERR] 3.274 caller_ops.size 3002 > log size 3001

it eventually cleared and a deep scrub on that pg doesnt' show any
error so I'm not sure what it means ...


Cheers,

   Sylvain
