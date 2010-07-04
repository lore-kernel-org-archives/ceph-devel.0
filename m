From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Redundancy with Ceph
Date: Sun, 4 Jul 2010 13:41:14 -0700
Message-ID: <AANLkTimXBAtgOFYAoX3aoZN4mLhYlA4514CQcpzj_mQu@mail.gmail.com>
References: <201007042234.46732.cray@unix-ag.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54657 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757977Ab0GDUlQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Jul 2010 16:41:16 -0400
Received: by qwh6 with SMTP id 6so625137qwh.19
        for <ceph-devel@vger.kernel.org>; Sun, 04 Jul 2010 13:41:15 -0700 (PDT)
In-Reply-To: <201007042234.46732.cray@unix-ag.uni-kl.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Baun <cray@unix-ag.uni-kl.de>
Cc: ceph-devel@vger.kernel.org

On Sun, Jul 4, 2010 at 1:34 PM, Christian Baun <cray@unix-ag.uni-kl.de> wrote:
> Hi,
>
> Is it possible to tell Ceph that the user data is stored in a redundant way across the osds?
Could you clarify? What do you mean by "across the OSDs"?
Obviously Ceph is aware of how many copies it makes.
