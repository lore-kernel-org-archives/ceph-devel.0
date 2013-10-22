From: Gregory Farnum <greg@inktank.com>
Subject: Re: Removing disks / OSDs
Date: Tue, 22 Oct 2013 10:26:32 -0700
Message-ID: <CAPYLRzgxWEi1s0=-EtcbhpdS8H96KDm-NhxhScKOn18Y72DY5Q@mail.gmail.com>
References: <52655309.8070500@dachary.org>
	<CAPYLRzjBmdewVvNVQd5JwnAAF2dv+q7Qk4qtzwQO7jVtpDGDRg@mail.gmail.com>
	<52661776.20803@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:43269 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab3JVR0d convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Oct 2013 13:26:33 -0400
Received: by mail-wi0-f173.google.com with SMTP id ey11so6083931wid.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Oct 2013 10:26:32 -0700 (PDT)
In-Reply-To: <52661776.20803@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Oct 21, 2013 at 11:13 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 21/10/2013 18:49, Gregory Farnum wrote:
>> I'm not quite sure what questions you're actually asking here...
>> In general, the OSD is not removed from the system without explicit
>> admin intervention. When it is removed, all traces of it should be
>> zapped (including its key), so it can't reconnect.
>> If it hasn't been removed, then indeed it will continue working
>> properly even if moved to a different box.
>
> If there is an external journal, the device containing the journal needs to be moved with the device containing the data. If I read ceph/src/upstart/ceph-osd.conf correctly, when the data device is plugged in the new machine it will fail to start because the journal is not there yet. When the journal device is plugged in, the ceph-osd.conf would be called because udev rule in ceph/udev/95-ceph-osd.rules call ceph-disk activate-journal.
>
> Is my understanding correct ?

Well, after being wrong last time I'm a little reluctant to make
pronouncements from memory, but that definitely sounds correct to me.
:) If I were doing an audit I'd want to look at what happens if there
is a wrong journal in the correct location, etc.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
