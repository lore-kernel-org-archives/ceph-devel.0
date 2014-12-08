From: Justin Erenkrantz <justin@erenkrantz.com>
Subject: Re: experimental features
Date: Sun, 7 Dec 2014 23:10:14 -0500
Message-ID: <CAOGLoJN2wSxMgtok6aATSW5o-Abqcv2bdVo+dVfaEbG4iyiQSw@mail.gmail.com>
References: <alpine.DEB.2.00.1412050927150.24079@cobra.newdream.net>
	<CAC6JEv8LVviFoNXB72gKBQ+seNVYphvpwm0QZeOwccPHr7Qatg@mail.gmail.com>
	<5481EF6B.4010901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:54434 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbaLHEKP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Dec 2014 23:10:15 -0500
Received: by mail-pd0-f179.google.com with SMTP id fp1so4020362pdb.24
        for <ceph-devel@vger.kernel.org>; Sun, 07 Dec 2014 20:10:15 -0800 (PST)
In-Reply-To: <5481EF6B.4010901@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mnelson@redhat.com
Cc: Gregory Farnum <greg@gregs42.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On Fri, Dec 5, 2014 at 12:46 PM, Mark Nelson <mark.nelson@inktank.com> wrote:
> I'm in favor of the "allow experimental features" but instead call it:
>
> "ALLOW UNRECOVERABLE DATA CORRUPTING FEATURES" which makes things a little
> more explicit. With great power comes great responsibility.

+1.

For Subversion, we utilize SVN_I_LOVE_CORRUPTED_XXX for a few options
that can cause data corruption.  -- justin
