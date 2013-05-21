From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [ceph-users] mon IO usage
Date: Tue, 21 May 2013 17:52:49 +0200
Message-ID: <CAF6-1L4NHhtaaGGB4vBwWWqEa0pVR4T44-Xx_eTmkUEEXHsfgA@mail.gmail.com>
References: <CAF6-1L4oWCwNxywALb=cUNP_pbD=ND631MJqvCWyvAfvNdWauQ@mail.gmail.com>
	<519B6F28.9000400@scholarstack.com>
	<519B75B2.4070405@scholarstack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53783 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab3EUPwv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 11:52:51 -0400
Received: by mail-bk0-f46.google.com with SMTP id my13so515638bkb.33
        for <ceph-devel@vger.kernel.org>; Tue, 21 May 2013 08:52:50 -0700 (PDT)
In-Reply-To: <519B75B2.4070405@scholarstack.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mike.dawson@scholarstack.com>
Cc: ceph-users@lists.ceph.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

So, AFAICT, the bulk of the write would be writing out the pgmap to
disk every second or so.

Is it really needed to write it in full ? It doesn't change all that
much AFAICT, so writing incremental changes with only periodic flush
might be a better option ?

Cheers,

     Sylvain
