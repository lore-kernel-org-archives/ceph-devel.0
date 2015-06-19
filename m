From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: rsyslogd
Date: Fri, 19 Jun 2015 03:03:12 -0400 (EDT)
Message-ID: <035B5A90-F494-42BF-9E80-49C347AD49EE@redhat.com>
References: <55835083.9040908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:46043 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbbFSHDN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jun 2015 03:03:13 -0400
In-Reply-To: <55835083.9040908@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Not that I'm aware of. I don't mess with services at all in the log rotation stuff I did (we already disabled generic log rotation when tests were running).
-Greg

> On Jun 19, 2015, at 12:13 AM, David Zafman <dzafman@redhat.com> wrote:
> 
> 
> Greg,
> 
> Have you changed anything (log rotation related?) that would uninstall or  cause rsyslog to not be able to start?
> 
> I'm sometimes seeing machines fail with this error probably in teuthology/nuke.py reset_syslog_dir().
> 
> CommandFailedError: Command failed on plana94 with status 1: 'sudo rm -f -- /etc/rsyslog.d/80-cephtest.conf && sudo service rsyslog restart'
> 
> 
> David
> 
> 
> 
