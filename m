From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Radosgw: multipart upload problem
Date: Thu, 29 Sep 2011 10:12:32 -0700
Message-ID: <CAC-hyiHS=mMkw3roRH3PFf4CcyeC3E3i1KWxmYwJ6rB7Vtq7pw@mail.gmail.com>
References: <CANExM-PqDrbWp7bPDh9NjJ-QwYC-yd2emh4aBNFf0HSgqS=9Yg@mail.gmail.com>
	<CAC-hyiFUf0JVm04mGOVX8uRah2KvoR1E-0Z0dJgadayQ3+7zow@mail.gmail.com>
	<CANExM-N_nPkUFVhz_vOQo910zVyawcO4tGAHkFho53S2T4C8_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56207 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613Ab1I2RMe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2011 13:12:34 -0400
Received: by bkbzt4 with SMTP id zt4so889879bkb.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2011 10:12:33 -0700 (PDT)
In-Reply-To: <CANExM-N_nPkUFVhz_vOQo910zVyawcO4tGAHkFho53S2T4C8_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

I'm pretty sure I fixed a the same (or a similar) bug last week, but
probably on a different branch (wip-pool-sharing). Might have been
commit 5f951728b4bcad62aec92f23202affbc31bb3b5f, but I'm not around a
working dev environment to check that. We'll probably merge
wip-pool-sharing to the master branch soon enough, so you can test
that (though note that it breaks compatibility and will require wiping
your rgw data).


On Thu, Sep 29, 2011 at 7:48 AM, Henry C Chang <henry.cy.chang@gmail.com> wrote:
> master branch - commit aa20f0d6ca25fb9fda644657c8c693e8fa17b72c
>
> 2011/9/29 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
>> What version are you running?
>>
>> On Thu, Sep 29, 2011 at 12:26 AM, Henry C Chang
>> <henry.cy.chang@gmail.com> wrote:
>>> Hi,
>>>
>>> I got errors while multipart uploading a large file to radosgw. Please
>>> check the attached log.
>>>
>>> The log shows:
>>> 1. "Initiate multipart upload" finished sucessfully.
>>> 2. "Upload part" failed with error 409.
>>> 3. "Complete multipart upload" failed with error 400.
>>>
>>> Henry
>>>
>>
>
