From: Ian Pye <ianpye@gmail.com>
Subject: Max Message Size For AIO calls
Date: Wed, 26 Sep 2012 15:28:25 -0700
Message-ID: <CAEVWPAXWhGBJoYN==vp_2uzuPemuVkv1Z3_VsqnYO0K0rGb7Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38437 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab2IZW20 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Sep 2012 18:28:26 -0400
Received: by obbuo13 with SMTP id uo13so1141909obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Sep 2012 15:28:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm periodically getting librados aio_operate() calls to fail on me
and return a code of -90: Message too long. Does anyone know how long
is too long of a message here?

Thanks,

Ian
