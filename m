From: Oleg Kolosov <olekol@gmail.com>
Subject: Re: erasure_code_version() for a new erasure code
Date: Sun, 11 Jun 2017 00:32:15 +0300
Message-ID: <CAODUPsEzgwXH32CoyvuLe+JMdrOUnG6tjTD01WCdwfQvgMan-A@mail.gmail.com>
References: <CAODUPsEkkQ-bHzK6vy-AUjtRkvEZZEDNoRHc+E5WHhsrS+uJpA@mail.gmail.com>
 <ad68008d-59ab-2cd0-03c7-b7896ac955ea@dachary.org> <CAODUPsFQ+7Je-pahjaayrqy8+uDHFAc+2Atz6atjmROJ5hV+Mw@mail.gmail.com>
 <aa4efbd2-c28d-2255-a536-892ecc89157c@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35663 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbdFJVcR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Jun 2017 17:32:17 -0400
Received: by mail-oi0-f45.google.com with SMTP id e11so2125679oia.2
        for <ceph-devel@vger.kernel.org>; Sat, 10 Jun 2017 14:32:17 -0700 (PDT)
In-Reply-To: <aa4efbd2-c28d-2255-a536-892ecc89157c@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Hi Loic,
Thank you for your answer. There were indeed problems with
dependencies, but now these problems don't affect run-make-check.sh
and it seems to run without any problems. However, I still get this
error.
I've tried renaming lrc lib to the name of my code (I've edited
Makefile.am and CMakeLists.txt to match the new name), to see whether
it'll run, but again I got the same error.

Is there any other files that need to be edited outside erasure-code
dir when adding a new erasure code?

Thanks,
Oleg
