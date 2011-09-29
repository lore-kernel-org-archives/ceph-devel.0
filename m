From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Radosgw: multipart upload problem
Date: Thu, 29 Sep 2011 07:24:49 -0700
Message-ID: <CAC-hyiFUf0JVm04mGOVX8uRah2KvoR1E-0Z0dJgadayQ3+7zow@mail.gmail.com>
References: <CANExM-PqDrbWp7bPDh9NjJ-QwYC-yd2emh4aBNFf0HSgqS=9Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38964 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1I2OYv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2011 10:24:51 -0400
Received: by bkbzt4 with SMTP id zt4so712738bkb.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2011 07:24:50 -0700 (PDT)
In-Reply-To: <CANExM-PqDrbWp7bPDh9NjJ-QwYC-yd2emh4aBNFf0HSgqS=9Yg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

What version are you running?

On Thu, Sep 29, 2011 at 12:26 AM, Henry C Chang
<henry.cy.chang@gmail.com> wrote:
> Hi,
>
> I got errors while multipart uploading a large file to radosgw. Please
> check the attached log.
>
> The log shows:
> 1. "Initiate multipart upload" finished sucessfully.
> 2. "Upload part" failed with error 409.
> 3. "Complete multipart upload" failed with error 400.
>
> Henry
>
