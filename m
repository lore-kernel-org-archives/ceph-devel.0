From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: How to make systemd unit files work in all supported distros?
Date: Mon, 8 Feb 2016 23:51:12 +0100
Message-ID: <56B91BE0.1010508@suse.cz>
References: <56B86372.4020600@suse.cz>
 <alpine.DEB.2.11.1602080829060.28396@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56240 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755975AbcBHWvP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 8 Feb 2016 17:51:15 -0500
In-Reply-To: <alpine.DEB.2.11.1602080829060.28396@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 02/08/2016 02:30 PM, Sage Weil wrote:
> On Mon, 8 Feb 2016, Nathan Cutler wrote:
>> In master we currently have an issue with the systemd unit files in that they
>> contain hard-coded paths that are specific to RH/CentOS/Fedora. Other distros
>> can and do have the executables in different places.
>>
>> I opened a bug[1] for this, but before I go off trying to fix it I would like
>> to solicit your feedback on the following possible approaches I came up with
>> (and/or "turn me on" to a different approach):
>>
>> (1) Rely on PATH. Basically, instead of running executables directly, run them
>> by "/bin/sh -c", which summons the system PATH to help find the executables.
>> See https://github.com/ceph/ceph/pull/6803 for an example of this.
>>
>> (2) Set environment variables in /etc/sysconfig/ceph. Systemd has an
>> EnvironmentFile directive which reads environment variables from a file. If
>> this were pointed to /etc/sysconfig/ceph (as it is in several unit files
>> already), we could set the distro-specific parts of the paths there and write
>> the paths similar to how we do it in the spec file.
>>
>> (3) Generate unit files at build time. In this approach, the unit files would
>> exist in the source tree as templates (e.g. ceph-osd@.service.in) and these
>> would get transformed into the "real" unit files at build time. The
>> ceph-detect-init utility could be used to determine the distro and the
>> Makefile logic would then fill in the templates as needed for the distro.
>>
>> Of these three approaches, only (3) would seem to be general enough to work
>> nicely for all distros. (For example, EnvironmentFile will need to be set to
>> /etc/default/ceph on Debianesque systems and there is no obvious way to set
>> *this* path as an environment variable.)
>
> If (1) isn't enough to get us by, then I agree that (3) seems to be the
> cleanest.  But autoconf/automake at least should be able to feed these
> paths into the .in file without needed ceph-detect-init, right?  Which
> paths are you having problems with?

(1) is indeed tempting as a quick fix. But we still have at least one 
problematic path - the /usr/sbin/ceph-disk in:

https://github.com/ceph/ceph/blob/master/systemd/ceph-disk%40.service#L7

Because on SUSE ceph-disk is installed in /usr/bin.

(As for (3), I guess you're right that autoconf would be able to figure 
out the paths.)

Thanks

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
