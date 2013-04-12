From: Laurent Barbe <laurent@ksperis.com>
Subject: Re: [PATCH] rbd: revalidate_disk upon rbd resize
Date: Fri, 12 Apr 2013 15:59:17 +0200
Message-ID: <CADksbcp7ZrrVfhsJRFjN+6UU0JKnedUGN_mZYSV1Lm57zDarXQ@mail.gmail.com>
References: <1365774766-29899-1-git-send-email-laurent@ksperis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:43649 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850Ab3DLN7R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Apr 2013 09:59:17 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so3382231ieb.15
        for <ceph-devel@vger.kernel.org>; Fri, 12 Apr 2013 06:59:17 -0700 (PDT)
In-Reply-To: <1365774766-29899-1-git-send-email-laurent@ksperis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org, Laurent Barbe <laurent@ksperis.com>

Hello,

I have juste move revalidate_disk() in rbd_dev_refresh() outside the mutex.
It seems ok for me.
