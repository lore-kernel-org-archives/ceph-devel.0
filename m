From: Jeremy Hanmer <jeremy.hanmer@dreamhost.com>
Subject: Re: Would it make sense to require ntp
Date: Fri, 6 Nov 2015 09:44:45 -0800
Message-ID: <CAKRUTFDEDTn4CD5Av+btfwzbuw3cJye5HTut8JmZDVhq5gzkrQ@mail.gmail.com>
References: <563C7BB1.7030500@suse.cz>
	<CALe9h7eP-vabaMCYuLuEUO2pME-cRfUHVrOFgkzRcZNqxL2ZbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33749 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932340AbbKFRoq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Nov 2015 12:44:46 -0500
Received: by qgea14 with SMTP id a14so15553857qge.0
        for <ceph-devel@vger.kernel.org>; Fri, 06 Nov 2015 09:44:45 -0800 (PST)
In-Reply-To: <CALe9h7eP-vabaMCYuLuEUO2pME-cRfUHVrOFgkzRcZNqxL2ZbA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Nov 6, 2015 at 4:26 AM, John Spray <jspray@redhat.com> wrote:
> On Fri, Nov 6, 2015 at 10:06 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>> Hi Ceph:
>>
>>
>> Is there any reasonable Ceph cluster node configuration that does not
>> include running the NTP daemon?
>
> Only if there is some other time service replacing it.  I don't really
> know of anyone using alternative ntp daemons, but it's a possibility
> to consider before introducing a hard dependency on ntpd.
>

There's also the case of virtualization where the clock is managed by
the host OS
rather than the guest where the Ceph services are running. Anyone running a
virtualized test/dev cluster or simply using VMs to provide isolation between
services won't want to have a requirement on NTP.
