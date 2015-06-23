From: Gregory Farnum <greg@gregs42.com>
Subject: Re: rsyslogd
Date: Tue, 23 Jun 2015 11:18:55 +0100
Message-ID: <CAC6JEv-oiXF1n0XRwiuXV6Zd2+BEFDeH--tLcLy1JbPXVEcSrw@mail.gmail.com>
References: <55835083.9040908@redhat.com>
	<035B5A90-F494-42BF-9E80-49C347AD49EE@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:33843 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbbFWKS6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jun 2015 06:18:58 -0400
Received: by lagx9 with SMTP id x9so3476995lag.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jun 2015 03:18:57 -0700 (PDT)
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com. [209.85.215.43])
        by mx.google.com with ESMTPSA id fj10sm5411131lbc.29.2015.06.23.03.18.55
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 03:18:56 -0700 (PDT)
Received: by laka10 with SMTP id a10so3494523lak.0
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jun 2015 03:18:55 -0700 (PDT)
In-Reply-To: <035B5A90-F494-42BF-9E80-49C347AD49EE@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Did we end up creating a ticket for this? I saw this on one FS run as well.
-Greg

On Fri, Jun 19, 2015 at 8:03 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> Not that I'm aware of. I don't mess with services at all in the log rotation stuff I did (we already disabled generic log rotation when tests were running).
> -Greg
>
>> On Jun 19, 2015, at 12:13 AM, David Zafman <dzafman@redhat.com> wrote:
>>
>>
>> Greg,
>>
>> Have you changed anything (log rotation related?) that would uninstall or  cause rsyslog to not be able to start?
>>
>> I'm sometimes seeing machines fail with this error probably in teuthology/nuke.py reset_syslog_dir().
>>
>> CommandFailedError: Command failed on plana94 with status 1: 'sudo rm -f -- /etc/rsyslog.d/80-cephtest.conf && sudo service rsyslog restart'
>>
>>
>> David
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
