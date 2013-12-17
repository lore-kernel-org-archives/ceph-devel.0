From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: gitbuilder update request
Date: Tue, 17 Dec 2013 13:40:14 +0200
Message-ID: <CALFYKtABBHzkGYAjdKyMZ7J_UZMEogpyHqj04tgpDZmNkY_CSQ@mail.gmail.com>
References: <52B02C4C.90608@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:45110 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab3LQLkP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 06:40:15 -0500
Received: by mail-wi0-f182.google.com with SMTP id en1so3505528wid.9
        for <ceph-devel@vger.kernel.org>; Tue, 17 Dec 2013 03:40:14 -0800 (PST)
In-Reply-To: <52B02C4C.90608@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Whoever is going to be doing this should probably make sure that
https://github.com/ceph/autobuild-ceph/pull/5 is merged before rolling
stuff out.

(I have already installed libblkid-dev on pretty much all gitbuilders
by hand, but it wouldn't hurt to capture both pytest and libblkid-dev
in a single update.)

Thanks,

                Ilya
