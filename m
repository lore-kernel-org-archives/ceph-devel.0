From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: unstable branch: you may need to re-run automake
Date: Tue, 26 Oct 2010 21:01:43 -0700
Message-ID: <AANLkTikYON2U4vUn8g8=-imskukAOUr4BcboZdRCQjbm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46211 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab0J0EBp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Oct 2010 00:01:45 -0400
Received: by fxm16 with SMTP id 16so284033fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Oct 2010 21:01:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I moved a file, and added anew GTK-related macro. So you may need to
re-run autogen.sh the next time you pull the unstable branch.

If you get an error about not being able to find ceph.o, you have hit this.

cheers,
Colin
